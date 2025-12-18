package controller;

import dao.CvDAO;
import dao.CvSectionDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Collections;
import java.util.List;

import model.Account;
import model.CV;
import model.CvSection;
import utils.AuthUtil;

@WebServlet("/cv/save")
public class CvSaveServlet extends HttpServlet {

    private Integer parseIntOrNull(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }

    // TemplateCode DB NOT NULL => luôn có default
    private String safeTemplate(String t) {
        t = safe(t);
        return t.isEmpty() ? "TEMPLATE_1" : t;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        CvDAO cvDao = new CvDAO();
        CvSectionDAO secDao = new CvSectionDAO();

        Integer cvIdParam = parseIntOrNull(req.getParameter("cvid"));

        // ====== Nếu update: kiểm tra CV tồn tại & không phải UPLOADED ======
        if (cvIdParam != null) {
            CV existing = cvDao.getById(cvIdParam, jobSeekerId);
            if (existing == null) {
                resp.sendRedirect(req.getContextPath() + "/cv/list");
                return;
            }
            // Uploaded CV => không save kiểu builder
            if ("UPLOADED".equalsIgnoreCase(safe(existing.getTemplateCode()))) {
                resp.sendRedirect(req.getContextPath() + "/cv/edit?cvid=" + existing.getCvId());
                return;
            }
        }

        // ====== Build CV from form (BUILDER) ======
        CV cv = new CV();
        cv.setJobSeekerId(jobSeekerId);
        cv.setTitle(safe(req.getParameter("title")));
        cv.setTemplateCode(safeTemplate(req.getParameter("template")));
        cv.setSummary(req.getParameter("summary"));
        cv.setSkills(req.getParameter("skills"));
        cv.setLinks(req.getParameter("links"));

        int cvId;

        try {
            // ====== 1) INSERT / UPDATE trước để có cvId ======
            if (cvIdParam == null) {
                cv.setIsDefault(false);
                cvId = cvDao.insert(cv); // phải return generated key
                if (cvId <= 0) {
                    resp.setStatus(500);
                    resp.setContentType("text/plain; charset=UTF-8");
                    resp.getWriter().println("Insert CV failed.");
                    return;
                }
            } else {
                cvId = cvIdParam;
                cv.setCvId(cvId);
                cvDao.update(cv);
            }

            // ====== 2) Save Custom Sections (builder) ======
            String[] titles = req.getParameterValues("sectionTitle");
            String[] contents = req.getParameterValues("sectionContent");

            // Xóa sections cũ rồi insert lại
            secDao.deleteByCv(cvId, jobSeekerId);

            if (titles != null && contents != null) {
                int n = Math.min(titles.length, contents.length);
                int order = 1;
                for (int i = 0; i < n; i++) {
                    String t = titles[i] == null ? "" : titles[i].trim();
                    String c = contents[i] == null ? "" : contents[i].trim();
                    if (t.isEmpty() && c.isEmpty()) continue;
                    if (t.isEmpty()) t = "SECTION";
                    secDao.insert(cvId, jobSeekerId, t, c, order++);
                }
            }

            // ====== 3) Generate PDF + save file + update FilePath (builder) ======
            CV savedCv = cvDao.getById(cvId, jobSeekerId);
            List<CvSection> savedSections;
            try {
                savedSections = secDao.listByCv(cvId, jobSeekerId);
            } catch (Exception e) {
                savedSections = Collections.emptyList();
            }

            DownloadCVServlet pdfBuilder = new DownloadCVServlet();
            pdfBuilder.init(getServletConfig()); // để getServletContext() dùng được trong DownloadCVServlet

            byte[] pdfBytes = pdfBuilder.buildPdfBytes(req, acc, savedCv, savedSections);

            String relDir = "/uploads/cv/" + jobSeekerId;
            String realDir = getServletContext().getRealPath(relDir);
            if (realDir == null) throw new ServletException("Cannot resolve upload directory real path: " + relDir);
            new File(realDir).mkdirs();

            String relFile = relDir + "/cv_" + cvId + ".pdf";
            String realFile = getServletContext().getRealPath(relFile);

            try (OutputStream out = new FileOutputStream(realFile)) {
                out.write(pdfBytes);
            }

            // Update FilePath => builder cũng có FilePath, không còn NULL
            cvDao.updateFilePath(cvId, jobSeekerId, relFile);

            // ====== Done ======
            resp.sendRedirect(req.getContextPath() + "/cv/edit?cvid=" + cvId + "&saved=1");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
