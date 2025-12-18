package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import model.Account;
import model.CV;
import utils.AuthUtil;

@WebServlet("/cv/preview")
public class CvPreviewServlet extends HttpServlet {

    private Integer parseIntOrNull(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            return Integer.parseInt(s.trim());
        } catch (Exception e) { return null; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer cvid = parseIntOrNull(req.getParameter("cvid"));
        if (cvid == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        CV cv = new CvDAO().getById(cvid, jobSeekerId);
        if (cv == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        // Nếu là Uploaded CV => stream file PDF trực tiếp
        if (cv.isUploaded()) {
            String rel = cv.getFilePath(); // ví dụ: /uploads/cv/1/cv_38.pdf
            if (rel == null || rel.isBlank()) {
                resp.setStatus(404);
                resp.setContentType("text/plain; charset=UTF-8");
                resp.getWriter().println("Uploaded PDF not found (FilePath is empty).");
                return;
            }

            String real = getServletContext().getRealPath(rel);
            if (real == null) {
                resp.setStatus(404);
                resp.setContentType("text/plain; charset=UTF-8");
                resp.getWriter().println("Cannot resolve PDF real path.");
                return;
            }

            File f = new File(real);
            if (!f.exists()) {
                resp.setStatus(404);
                resp.setContentType("text/plain; charset=UTF-8");
                resp.getWriter().println("PDF file not found: " + rel);
                return;
            }

            resp.setContentType("application/pdf");
            resp.setContentLengthLong(f.length());
            resp.setHeader("Content-Disposition", "inline; filename=\"uploaded_cv_" + cvid + ".pdf\"");

            try (InputStream in = new FileInputStream(f);
                 OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
                out.flush();
            }
            return;
        }

        // Builder CV => dùng download preview cho chuẩn (DownloadCVServlet đã build PDF)
        resp.sendRedirect(req.getContextPath() + "/cv/download?cvid=" + cvid + "&preview=1");
    }
}
