/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import dao.ApplicationDAO;
import dao.CvDAO;
import dao.JobPostingsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import model.Account;
import model.Applications;
import model.CV;

@WebServlet("/recruiter/cv/preview")
public class RecruiterCvPreviewServlet extends HttpServlet {

    private Integer parseIntOrNull(String s) {
        try {
            if (s == null || s.isBlank()) {
                return null;
            }
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isRecruiter(Account acc) {
        // roleId recruiter = 2 (theo bảng Role bạn gửi)
        return acc != null && acc.getRoleId() == 2;
        // Nếu model bạn là acc.getRole().getId() thì đổi theo đúng code của bạn.
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Account acc = (session != null) ? (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT) : null;

        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (!isRecruiter(acc)) {
            resp.sendError(403, "Only recruiter can view candidate CV.");
            return;
        }

        Integer applicationId = parseIntOrNull(req.getParameter("applicationId"));
        if (applicationId == null) {
            resp.sendError(400, "Missing applicationId");
            return;
        }

        ApplicationDAO appDao = new ApplicationDAO();
        JobPostingsDAO jpDao = new JobPostingsDAO();
        CvDAO cvDao = new CvDAO();

        Applications app = appDao.getDetailApplication(applicationId);
        if (app == null) {
            resp.sendError(404, "Application not found");
            return;
        }

        int jobPostingId = app.getJobPostingID();

        // Check quyền sở hữu JobPost
        boolean isOwner = jpDao.isRecruiterOwnerOfJobPosting(jobPostingId, acc.getId());
        if (!isOwner) {
            resp.sendError(403, "You are not allowed to view this CV.");
            return;
        }

        int cvid = app.getCVID();
        CV cv = cvDao.findCVbyCVID(cvid);
        if (cv == null) {
            resp.sendError(404, "CV not found");
            return;
        }

        // Uploaded -> stream PDF
        if (cv.isUploaded()) {
            String rel = cv.getFilePath(); // ví dụ: /uploads/cv/1/cv_38.pdf
            if (rel == null || rel.isBlank()) {
                resp.sendError(404, "Uploaded PDF path is empty.");
                return;
            }

            String real = getServletContext().getRealPath(rel);
            if (real == null) {
                resp.sendError(404, "Cannot resolve real path for: " + rel);
                return;
            }

            File f = new File(real);
            if (!f.exists()) {
                resp.sendError(404, "PDF file not found: " + rel);
                return;
            }

            resp.setContentType("application/pdf");
            resp.setContentLengthLong(f.length());
            resp.setHeader("Content-Disposition", "inline; filename=\"cv_" + cvid + ".pdf\"");

            try (InputStream in = new FileInputStream(f); OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
                out.flush();
            }
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/cv/download?cvid=" + cvid + "&preview=1");
    }
}
