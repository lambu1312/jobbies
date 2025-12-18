package controller;

import constant.CommonConst;
import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.sql.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.Account;
import model.CvExtract;
import utils.GeminiCvApi;
import utils.PdfTextUtil;

@WebServlet(name = "CvAiServlet", urlPatterns = {"/cv-ai"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class CvAiServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    // session keys
    private static final String S_DRAFT    = "CV_AI_DRAFT_PROFILE";
    private static final String S_EXTRACT  = "CV_AI_EXTRACT";
    private static final String S_TEMP_ABS = "CV_AI_TEMP_ABS";
    private static final String S_PDF_URL  = "CV_AI_PDF_URL";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = getLoginAccount(request);
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        HttpSession session = request.getSession();
        DraftProfile draft = (DraftProfile) session.getAttribute(S_DRAFT);
        CvExtract ex = (CvExtract) session.getAttribute(S_EXTRACT);
        String pdfUrl = (String) session.getAttribute(S_PDF_URL);

        if (draft != null) {
            request.setAttribute("draft", draft);
            request.setAttribute("extract", ex);
            request.setAttribute("pdfUrl", pdfUrl);
            request.getRequestDispatcher("view/user/cv_ai_preview.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account acc = getLoginAccount(request);
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        String action = request.getParameter("action");

        if ("save".equalsIgnoreCase(action)) {
            doSaveProfile(request, response, acc);
            return;
        }

        if ("discard".equalsIgnoreCase(action)) {
            cleanupDraft(request.getSession());
            response.sendRedirect(request.getContextPath() + "/cv-ai");
            return;
        }

        doAnalyze(request, response, acc);
    }

    // =========================
    // ANALYZE PDF -> AI -> DraftProfile
    // =========================
    private void doAnalyze(HttpServletRequest request, HttpServletResponse response, Account acc)
            throws ServletException, IOException {

        Part part = request.getPart("pdfFile"); // name trong cv_ai_upload.jsp
        if (part == null || part.getSize() == 0) {
            request.setAttribute("error", "Bạn chưa chọn file PDF.");
            request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
            return;
        }

        String fileName = part.getSubmittedFileName();
        if (fileName == null || !fileName.toLowerCase().endsWith(".pdf")) {
            request.setAttribute("error", "File không hợp lệ. Vui lòng upload PDF.");
            request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
            return;
        }

        // save temp file into web root folder tempUploads (để iframe view được)
        String dirPath = request.getServletContext().getRealPath("tempUploads");
        File dir = new File(dirPath);
        if (!dir.exists()) dir.mkdirs();

        File pdf = new File(dir, System.currentTimeMillis() + "_" + sanitizeFileName(fileName));
        part.write(pdf.getAbsolutePath());

        // URL để browser view
        String pdfUrl = request.getContextPath() + "/tempUploads/" + pdf.getName();

        try {
            String text = PdfTextUtil.extractText(pdf);
            if (text == null || text.trim().isEmpty()) {
                safeDelete(pdf);
                request.setAttribute("error", "Không đọc được nội dung PDF (có thể PDF scan ảnh).");
                request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
                return;
            }

            // regex hints: bắt chắc email/phone
            Hints hints = extractHints(text);

            CvExtract ex = GeminiCvApi.checkAndExtract(text);

            if (ex == null) {
                safeDelete(pdf);
                request.setAttribute("error", "AI không trả kết quả.");
                request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
                return;
            }

            if (!ex.isCv()) {
                String m = safe(ex.getMessage());
                if (looksLikeOverload(m)) {
                    safeDelete(pdf);
                    request.setAttribute("error", "Hệ thống AI đang bận (503/UNAVAILABLE). Vui lòng thử lại sau.");
                    request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
                    return;
                }
                safeDelete(pdf);
                request.setAttribute("error", "AI xác định: không phải CV. " + m);
                request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
                return;
            }

            // ===== MERGE: ƯU TIÊN AI, profile là fallback =====
            DraftProfile draft = new DraftProfile();

            String fullNameProfile = joinName(acc.getLastName(), acc.getFirstName());
            String dobProfile = (acc.getDob() != null) ? acc.getDob().toString() : "";

            String dobAi = normalizeDob(ex.getDob());

            draft.setFullName(pick(ex.getFullName(), fullNameProfile));
            draft.setEmail(pick(hints.email, pick(ex.getEmail(), acc.getEmail())));
            draft.setPhone(pick(hints.phone, pick(ex.getPhone(), acc.getPhone())));
            draft.setDob(pick(dobAi, dobProfile));
            draft.setAddress(pick(ex.getAddress(), acc.getAddress()));

            HttpSession session = request.getSession();
            cleanupDraft(session); // clear old

            session.setAttribute(S_DRAFT, draft);
            session.setAttribute(S_EXTRACT, ex);
            session.setAttribute(S_TEMP_ABS, pdf.getAbsolutePath());
            session.setAttribute(S_PDF_URL, pdfUrl);

            request.setAttribute("draft", draft);
            request.setAttribute("extract", ex);
            request.setAttribute("pdfUrl", pdfUrl);

            request.getRequestDispatcher("view/user/cv_ai_preview.jsp").forward(request, response);

        } catch (Exception e) {
            safeDelete(pdf);
            String m = safe(e.getMessage());

            if (looksLikeOverload(m)) {
                request.setAttribute("error", "Hệ thống AI đang bận (503/UNAVAILABLE). Vui lòng thử lại sau.");
            } else if (m.contains("429")) {
                request.setAttribute("error", "Bạn đang gọi AI quá nhanh (429). Vui lòng thử lại.");
            } else {
                request.setAttribute("error", "Lỗi khi gọi AI: " + m);
            }

            request.getRequestDispatcher("view/user/cv_ai_upload.jsp").forward(request, response);
        }
    }

    // =========================
    // SAVE: update Account only
    // =========================
    private void doSaveProfile(HttpServletRequest request, HttpServletResponse response, Account acc)
        throws IOException, ServletException {

    HttpSession session = request.getSession();
    DraftProfile draft = (DraftProfile) session.getAttribute(S_DRAFT);
    CvExtract ex = (CvExtract) session.getAttribute(S_EXTRACT);
    String pdfUrl = (String) session.getAttribute(S_PDF_URL);

    if (draft == null) {
        request.setAttribute("error", "Không có dữ liệu AI để lưu.");
        request.getRequestDispatcher("view/user/cv_ai_preview.jsp")
               .forward(request, response);
        return;
    }

    // ===== lấy dữ liệu user đã chỉnh =====
    String fullName = safe(request.getParameter("fullName"));
    String email    = safe(request.getParameter("email"));
    String phone    = safe(request.getParameter("phone"));
    String dobStr   = safe(request.getParameter("dob"));
    String address  = safe(request.getParameter("address"));

    // split name
    String[] name = splitName(fullName);
    acc.setFirstName(name[0]);
    acc.setLastName(name[1]);
    acc.setEmail(email);
    acc.setPhone(phone);
    acc.setAddress(address);

    if (!dobStr.isEmpty()) {
        try { acc.setDob(Date.valueOf(dobStr)); } catch (Exception ignored) {}
    }

    // ===== update DB =====
    accountDAO.updateAccount(acc);
    session.setAttribute(CommonConst.SESSION_ACCOUNT, acc);

    // ===== cập nhật lại draft để hiển thị =====
    draft.setFullName(fullName);
    draft.setEmail(email);
    draft.setPhone(phone);
    draft.setDob(dobStr);
    draft.setAddress(address);

    session.setAttribute(S_DRAFT, draft);

    // ===== THÔNG BÁO THÀNH CÔNG =====
    request.setAttribute("success", "Lưu thông tin thành công ✔");

    // forward lại preview (KHÔNG redirect)
    request.setAttribute("draft", draft);
    request.setAttribute("extract", ex);
    request.setAttribute("pdfUrl", pdfUrl);

    request.getRequestDispatcher("view/user/cv_ai_preview.jsp")
           .forward(request, response);
}


    // =========================
    // Helpers
    // =========================
    private Account getLoginAccount(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
    }

    private void cleanupDraft(HttpSession session) {
        String tempAbs = (String) session.getAttribute(S_TEMP_ABS);
        if (tempAbs != null) {
            try { Files.deleteIfExists(new File(tempAbs).toPath()); } catch (Exception ignored) {}
        }
        session.removeAttribute(S_TEMP_ABS);
        session.removeAttribute(S_DRAFT);
        session.removeAttribute(S_EXTRACT);
        session.removeAttribute(S_PDF_URL);
    }

    private void safeDelete(File f) {
        try { Files.deleteIfExists(f.toPath()); } catch (Exception ignored) {}
    }

    private String sanitizeFileName(String s) {
        if (s == null) return "cv.pdf";
        return s.replaceAll("[^a-zA-Z0-9._-]", "_");
    }

    private boolean looksLikeOverload(String msg) {
        msg = safe(msg).toLowerCase();
        return msg.contains("503") || msg.contains("overloaded") || msg.contains("unavailable") || msg.contains("\"code\":503");
    }

    private String encode(String s) {
        try { return URLEncoder.encode(s, "UTF-8"); } catch (Exception e) { return ""; }
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }

    // pick preferred if not blank, else fallback
    private String pick(String preferred, String fallback) {
        preferred = safe(preferred);
        if (!preferred.isEmpty()) return preferred;
        return safe(fallback);
    }

    private String joinName(String lastName, String firstName) {
        String ln = safe(lastName);
        String fn = safe(firstName);
        if (ln.isEmpty() && fn.isEmpty()) return "";
        if (ln.isEmpty()) return fn;
        if (fn.isEmpty()) return ln;
        return ln + " " + fn;
    }

    // return [firstName, lastName]
    private String[] splitName(String fullName) {
        String f = safe(fullName);
        if (f.isEmpty()) return new String[]{"", ""};
        String[] arr = f.split("\\s+");
        if (arr.length == 1) return new String[]{arr[0], ""};
        String firstName = arr[arr.length - 1];
        StringBuilder last = new StringBuilder();
        for (int i = 0; i < arr.length - 1; i++) {
            if (i > 0) last.append(" ");
            last.append(arr[i]);
        }
        return new String[]{firstName, last.toString()};
    }

    // normalize DOB to yyyy-MM-dd if possible, else ""
    private String normalizeDob(String dob) {
        dob = safe(dob);
        if (dob.isEmpty()) return "";
        if (dob.matches("\\d{4}-\\d{2}-\\d{2}")) return dob;

        Matcher m = Pattern.compile("(\\d{1,2})[/-](\\d{1,2})[/-](\\d{4})").matcher(dob);
        if (m.find()) {
            int d = Integer.parseInt(m.group(1));
            int mo = Integer.parseInt(m.group(2));
            int y = Integer.parseInt(m.group(3));
            return String.format("%04d-%02d-%02d", y, mo, d);
        }
        return "";
    }

    // ===== regex hints =====
    private static class Hints {
        String email = "";
        String phone = "";
    }

    private Hints extractHints(String text) {
        Hints h = new Hints();
        if (text == null) return h;

        Matcher em = Pattern.compile("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}").matcher(text);
        if (em.find()) h.email = em.group();

        Matcher pm = Pattern.compile("(\\+?84|0)\\s*\\d[\\d\\s.\\-]{7,}\\d").matcher(text);
        if (pm.find()) {
            String raw = pm.group();
            String digits = raw.replaceAll("[^0-9]", "");
            if (digits.length() >= 9) h.phone = digits.startsWith("84") ? ("+" + digits) : digits;
        }

        return h;
    }

    // =========================
    // DraftProfile (JavaBean) - để JSP ${draft.fullName} không lỗi
    // =========================
    public static class DraftProfile implements java.io.Serializable {
        private String fullName;
        private String email;
        private String phone;
        private String dob;     // yyyy-MM-dd
        private String address;

        public DraftProfile() {}

        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }

        public String getDob() { return dob; }
        public void setDob(String dob) { this.dob = dob; }

        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
    }
}
