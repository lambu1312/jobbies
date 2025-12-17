package controller;

import dao.CvDAO;
import dao.CvSectionDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import model.Account;
import model.CV;
import model.CvSection;
import utils.AuthUtil;

@WebServlet("/cv/edit")
public class CvEditServlet extends HttpServlet {

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            // nếu bạn có luồng auto tạo JobSeeker thì gọi ở đây; hiện tại: quay về list
            resp.sendRedirect(req.getContextPath()+"/cv/list");
            return;
        }

        int cvid = parseInt(req.getParameter("cvid"), -1);

        CvDAO cvDao = new CvDAO();
        CV cv = null;

        if (cvid > 0) {
            cv = cvDao.getById(cvid, jobSeekerId);
            if (cv == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

            // Uploaded CV => trang edit upload
            if (cv.getFilePath() != null && !cv.getFilePath().isBlank()) {
                req.setAttribute("cv", cv);
                req.getRequestDispatcher("/view/user/cv_edit_upload.jsp").forward(req, resp);
                return;
            }

            // Builder => load sections
            List<CvSection> sections;
            try {
                sections = new CvSectionDAO().listByCv(cvid, jobSeekerId);
            } catch (Exception e) {
                sections = Collections.emptyList();
            }
            req.setAttribute("sections", sections);
        } else {
            // create new builder CV
            cv = new CV();
            cv.setJobSeekerId(jobSeekerId);
            cv.setTemplateCode("TEMPLATE_1");
            req.setAttribute("sections", Collections.emptyList());
        }

        req.setAttribute("cv", cv);
        req.getRequestDispatcher("/view/user/cv_edit.jsp").forward(req, resp);
    }
}
