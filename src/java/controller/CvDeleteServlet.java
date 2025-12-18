package controller;

import dao.CvDAO;
import dao.CvSectionDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import model.Account;
import model.CV;
import utils.AuthUtil;

@WebServlet("/cv/delete")
public class CvDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        int cvid;
        try { cvid = Integer.parseInt(req.getParameter("cvid")); }
        catch (Exception e) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        CvDAO cvDao = new CvDAO();
        CV cv = cvDao.getById(cvid, jobSeekerId);
        if (cv == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        // delete file if uploaded
        try {
            if (cv.getFilePath() != null && !cv.getFilePath().isBlank()) {
                String real = getServletContext().getRealPath(cv.getFilePath());
                if (real != null) {
                    File f = new File(real);
                    if (f.exists()) f.delete();
                }
            }
        } catch (Exception ignored) {}

        // delete custom sections (if any) then delete cv
        try {
            new CvSectionDAO().deleteByCv(cvid, jobSeekerId);
            cvDao.delete(cvid, jobSeekerId);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        resp.sendRedirect(req.getContextPath()+"/cv/list?deleted=1");
    }
}
