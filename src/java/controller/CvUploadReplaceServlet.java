package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import model.Account;
import model.CV;
import utils.AuthUtil;

@WebServlet("/cv/uploadReplace")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 12 * 1024 * 1024
)
public class CvUploadReplaceServlet extends HttpServlet {

    private String safeTitle(String t) {
        if (t == null) return "Uploaded CV";
        t = t.trim();
        return t.isEmpty() ? "Uploaded CV" : t;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath()+"/login"); return; }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        int cvid;
        try { cvid = Integer.parseInt(req.getParameter("cvid")); }
        catch (Exception e) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        CvDAO dao = new CvDAO();
        CV cv = dao.getById(cvid, jobSeekerId);
        if (cv == null) { resp.sendRedirect(req.getContextPath()+"/cv/list"); return; }

        String title = safeTitle(req.getParameter("title"));
        Part filePart = req.getPart("pdfFile");

        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "Bạn chưa chọn file PDF.");
            req.setAttribute("cv", cv);
            req.getRequestDispatcher("/view/user/cv_edit_upload.jsp").forward(req, resp);
            return;
        }

        String ct = filePart.getContentType();
        if (ct == null || !ct.toLowerCase().contains("pdf")) {
            req.setAttribute("error", "File phải là PDF.");
            req.setAttribute("cv", cv);
            req.getRequestDispatcher("/view/user/cv_edit_upload.jsp").forward(req, resp);
            return;
        }

        // xóa file cũ (nếu có)
        try {
            if (cv.getFilePath() != null && !cv.getFilePath().isBlank()) {
                String oldReal = getServletContext().getRealPath(cv.getFilePath());
                if (oldReal != null) {
                    File f = new File(oldReal);
                    if (f.exists()) f.delete();
                }
            }
        } catch (Exception ignored) {}

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

        resp.sendRedirect(req.getContextPath() + "/cv/edit?cvid=" + cvid + "&saved=1");
    }
}
