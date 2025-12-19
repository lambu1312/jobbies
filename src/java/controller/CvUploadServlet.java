package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import model.Account;
import utils.AuthUtil;

@WebServlet("/cv/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 12 * 1024 * 1024
)
public class CvUploadServlet extends HttpServlet {

    private String safeTitle(String t) {
        if (t == null) return "Uploaded CV";
        t = t.trim();
        return t.isEmpty() ? "Uploaded CV" : t;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath()+"/login"); return; }
        req.getRequestDispatcher("/view/user/cv_upload.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        String title = safeTitle(req.getParameter("title"));
        Part filePart = req.getPart("pdfFile");

        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "Bạn chưa chọn file PDF.");
            req.getRequestDispatcher("/view/user/cv_upload.jsp").forward(req, resp);
            return;
        }

        String ct = filePart.getContentType();
        if (ct == null || !ct.toLowerCase().contains("pdf")) {
            req.setAttribute("error", "File phải là PDF.");
            req.getRequestDispatcher("/view/user/cv_upload.jsp").forward(req, resp);
            return;
        }

        CvDAO dao = new CvDAO();

        int cvid;
        try {
            // Insert trước để lấy CVID (TemplateCode auto 'UPLOADED' trong DAO)
            cvid = dao.insertUploaded(jobSeekerId, title, null);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        String relDir = "/uploads/cv/" + jobSeekerId;
        String realDir = getServletContext().getRealPath(relDir);
        if (realDir == null) throw new ServletException("Cannot resolve upload directory real path.");
        new File(realDir).mkdirs();

        String relFile = relDir + "/cv_" + cvid + ".pdf";
        String realFile = getServletContext().getRealPath(relFile);

        try (InputStream in = filePart.getInputStream();
             OutputStream out = new FileOutputStream(realFile)) {
            in.transferTo(out);
        }

        try {
            dao.updateUploadedFile(cvid, jobSeekerId, title, relFile);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        resp.sendRedirect(req.getContextPath() + "/cv/list?uploaded=1");
    }
}
