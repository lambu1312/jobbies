package controller;

import dao.CvDAO;
import dao.CvSectionDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.util.*;

import model.Account;
import model.CV;
import model.CvSection;
import utils.AuthUtil;

import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.*;
import org.apache.pdfbox.pdmodel.graphics.image.*;
import org.apache.pdfbox.pdmodel.PDPageContentStream.AppendMode;

/**
 * Download / Preview CV PDF - /cv/download?cvid=38 => download -
 * /cv/download?cvid=38&preview=1 => preview (inline)
 *
 * Fixes included: - Build PDF bytes in memory BEFORE writing response to avoid:
 * IllegalStateException: Cannot call reset() after response has been committed
 * - Always call CvSectionDAO.listByCv(cvid, jobSeekerId) (match required:
 * int,int) - Underline lines are placed BELOW titles (no longer crossing text)
 * - Add small accent bar to headings for nicer highlight
 */
@WebServlet("/cv/download")
public class DownloadCVServlet extends HttpServlet {

    private static final String FONT_REGULAR_PATH = "/assets/fonts/DejaVuSans.ttf";
    // If you have bold font file, set path and enable.
    // private static final String FONT_BOLD_PATH = "/assets/fonts/DejaVuSans-Bold.ttf";

    // Theme
    private static final float[] COLOR_PRIMARY = rgb01(24, 120, 86);   // green
    private static final float[] COLOR_TEXT = rgb01(0, 0, 0);
    private static final float[] COLOR_LIGHTBG = rgb01(245, 245, 245);

    private static float[] rgb01(int r, int g, int b) {
        return new float[]{r / 255f, g / 255f, b / 255f};
    }

    // Layout constants
    private static final float PAGE_MARGIN = 50f;
    private static final float TOP_MARGIN = 60f;
    private static final float BOTTOM_MARGIN = 60f;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int cvid;
        try {
            cvid = Integer.parseInt(req.getParameter("cvid"));
        } catch (Exception e) {
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

        // Load custom sections (match DAO signature listByCv(int cvid, int jobSeekerId))
        List<CvSection> sections;
        try {
            sections = new CvSectionDAO().listByCv(cvid, jobSeekerId);
        } catch (Exception e) {
            sections = Collections.emptyList();
        }

        // Build PDF bytes first
        byte[] pdfBytes;
        try {
            pdfBytes = buildPdfBytes(req, acc, cv, sections);
        } catch (Exception ex) {
            resp.setStatus(500);
            resp.setContentType("text/plain; charset=UTF-8");
            resp.getWriter().println("Download PDF failed: " + ex.getMessage());
            return;
        }

        boolean preview = "1".equals(req.getParameter("preview"));

        if (cv.isUploaded()) {
            // stream file upload
            String path = cv.getFilePath();
            if (path == null || path.isBlank()) {
                resp.setStatus(404);
                resp.getWriter().println("Uploaded PDF not found.");
                return;
            }

            // path là dạng "/uploads/..." => lấy real path
            String real = getServletContext().getRealPath(path);
            if (real == null || !new File(real).exists()) {
                resp.setStatus(404);
                resp.getWriter().println("Uploaded PDF file missing on server.");
                return;
            }

            File f = new File(real);
            resp.setContentType("application/pdf");
            if (preview) {
                resp.setHeader("Content-Disposition", "inline; filename=\"CV_" + cvid + ".pdf\"");
            } else {
                resp.setHeader("Content-Disposition", "attachment; filename=\"CV_" + cvid + ".pdf\"");
            }
            resp.setContentLengthLong(f.length());

            try (InputStream in = new FileInputStream(f); OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
            }
            return;
        }

        String filename = "CV_" + cvid + ".pdf";
        String encoded = URLEncoder.encode(filename, StandardCharsets.UTF_8).replace("+", "%20");

        resp.setContentType("application/pdf");
        resp.setContentLength(pdfBytes.length);

        if (preview) {
            resp.setHeader("Content-Disposition",
                    "inline; filename=\"" + filename + "\"; filename*=UTF-8''" + encoded);
        } else {
            resp.setHeader("Content-Disposition",
                    "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + encoded);
        }

        try (OutputStream os = resp.getOutputStream()) {
            os.write(pdfBytes);
            os.flush();
        }
    }

    // =========================
    // Build PDF in memory
    // =========================
    public byte[] buildPdfBytes(HttpServletRequest req, Account acc, CV cv, List<CvSection> sections) throws Exception {
        try (PDDocument doc = new PDDocument()) {

            PDFont normal = loadFont(doc, FONT_REGULAR_PATH);
            PDFont bold = normal;

            // If you have bold font file:
            /*
            try { bold = loadFont(doc, FONT_BOLD_PATH); } catch (Exception ignored) { bold = normal; }
             */
            PDImageXObject avatar = loadAvatarImage(doc, req, acc);

            String template = safe(cv.getTemplateCode());
            if ("TEMPLATE_2".equalsIgnoreCase(template)) {
                renderTemplate2(doc, acc, cv, sections, normal, bold, avatar);
            } else {
                renderTemplate1(doc, acc, cv, sections, normal, bold, avatar);
            }

            try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
                doc.save(baos);
                return baos.toByteArray();
            }
        }
    }

    private PDFont loadFont(PDDocument doc, String webPath) throws IOException {
        try (InputStream in = getServletContext().getResourceAsStream(webPath)) {
            if (in == null) {
                throw new IOException("Font not found in webapp: " + webPath);
            }
            return PDType0Font.load(doc, in, true);
        }
    }

    /**
     * Avatar supports: - stored path: /JobSeeker/images/xxx.jpg or
     * /images/xxx.jpg - URL: https://...
     */
    private PDImageXObject loadAvatarImage(PDDocument doc, HttpServletRequest req, Account acc) {
        try {
            String a = safe(acc.getAvatar());
            if (a.isEmpty()) {
                return null;
            }

            String ctx = req.getContextPath(); // /JobSeeker
            if (!ctx.isEmpty() && a.startsWith(ctx + "/")) {
                a = a.substring(ctx.length());
            }
            if (a.startsWith("/JobSeeker/")) {
                a = a.substring("/JobSeeker".length());
            }
            if (!a.startsWith("/") && !a.startsWith("http")) {
                a = "/" + a;
            }

            BufferedImage img = null;

            if (a.startsWith("http://") || a.startsWith("https://")) {
                URLConnection con = new URL(a).openConnection();
                con.setConnectTimeout(8000);
                con.setReadTimeout(8000);
                try (InputStream in = con.getInputStream()) {
                    img = ImageIO.read(in);
                }
            } else {
                // 1) resource
                try (InputStream in = getServletContext().getResourceAsStream(a)) {
                    if (in != null) {
                        img = ImageIO.read(in);
                    }
                }
                // 2) real path fallback
                if (img == null) {
                    String real = getServletContext().getRealPath(a);
                    if (real != null) {
                        File f = new File(real);
                        if (f.exists()) {
                            img = ImageIO.read(f);
                        }
                    }
                }
            }

            if (img == null) {
                return null;
            }
            return LosslessFactory.createFromImage(doc, img);

        } catch (Exception e) {
            return null;
        }
    }

    // =========================
    // Paging utilities
    // =========================
    private static class PageCtx {

        PDDocument doc;
        PDPage page;
        PDPageContentStream cs;

        float pageW, pageH;
        float y;

        PageCtx(PDDocument doc) {
            this.doc = doc;
        }

        void newPage() throws IOException {
            closeStreamQuietly();
            page = new PDPage(PDRectangle.A4);
            doc.addPage(page);

            pageW = page.getMediaBox().getWidth();
            pageH = page.getMediaBox().getHeight();

            cs = new PDPageContentStream(doc, page, AppendMode.OVERWRITE, true, true);
            y = pageH - TOP_MARGIN;
        }

        void closeStreamQuietly() {
            try {
                if (cs != null) {
                    cs.close();
                }
            } catch (Exception ignored) {
            }
            cs = null;
        }
    }

    private void ensureSpace(PageCtx p, float neededHeight) throws IOException {
        if (p.y - neededHeight < BOTTOM_MARGIN) {
            p.newPage();
        }
    }

    // =========================
    // TEMPLATE 1 (1 column) + paging
    // =========================
    private void renderTemplate1(PDDocument doc,
            Account acc, CV cv, List<CvSection> sections,
            PDFont normal, PDFont bold,
            PDImageXObject avatar) throws IOException {

        PageCtx p = new PageCtx(doc);
        p.newPage();

        float contentW = p.pageW - PAGE_MARGIN * 2;

        // Header card
        float headerH = 110;
        ensureSpace(p, headerH + 10);

        float headerX = PAGE_MARGIN;
        float headerY = p.y - headerH;

        drawRect(p.cs, headerX, headerY, contentW, headerH, true);

        // Avatar
        float avatarSize = 72;
        float ax = headerX + 15;
        float ay = headerY + (headerH - avatarSize) / 2f;

        if (avatar != null) {
            p.cs.drawImage(avatar, ax, ay, avatarSize, avatarSize);
        } else {
            drawRect(p.cs, ax, ay, avatarSize, avatarSize, false);
        }

        float infoX = ax + avatarSize + 15;
        float titleY = headerY + headerH - 28;

        // Title (green + bigger)
        setNonStroke(p.cs, COLOR_PRIMARY);
        writeText(p.cs, bold, 20, infoX, titleY, safe(cv.getTitle(), "My CV"));
        setNonStroke(p.cs, COLOR_TEXT);

        String fullName = (safe(acc.getFirstName()) + " " + safe(acc.getLastName())).trim();
        if (fullName.isEmpty()) {
            fullName = "Unknown";
        }

        writeText(p.cs, normal, 11, infoX, titleY - 24, fullName);
        writeText(p.cs, normal, 11, infoX, titleY - 40,
                "Email: " + safe(acc.getEmail()) + "    Phone: " + safe(acc.getPhone()));

        // divider
        setStroke(p.cs, rgb01(0, 0, 0));
        drawLine(p.cs, headerX, headerY + 12, headerX + contentW, headerY + 12);

        p.y = headerY - 18;

        // Core blocks
        p.y = sectionBlockPaged(p, "SUMMARY", safe(cv.getSummary()), contentW, normal, bold);
        p.y = sectionBlockPaged(p, "SKILLS", safe(cv.getSkills()), contentW, normal, bold);
        p.y = sectionBlockPaged(p, "LINKS", safe(cv.getLinks()), contentW, normal, bold);

        // Custom Sections
        if (sections != null && !sections.isEmpty()) {
            for (CvSection s : sections) {
                String t = safe(s.getTitle());
                String c = safe(s.getContent());
                if (t.isEmpty() && c.isEmpty()) {
                    continue;
                }
                p.y = sectionBlockPaged(p, t.isEmpty() ? "SECTION" : t, c, contentW, normal, bold);
            }
        }

        p.closeStreamQuietly();
    }

    // =========================
    // TEMPLATE 2 (2 columns: sidebar + main) + paging
    // =========================
    // =========================
    // TEMPLATE 2 (Fixed: Sidebar flow & No repetition)
    // =========================
    private void renderTemplate2(PDDocument doc,
            Account acc, CV cv, List<CvSection> sections,
            PDFont normal, PDFont bold,
            PDImageXObject avatar) throws IOException {

        float sidebarW = 180;
        float gap = 18;

        // Chuẩn bị nội dung Main (bên phải)
        List<SectionBlock> blocks = new ArrayList<>();
        blocks.add(new SectionBlock("SUMMARY", safe(cv.getSummary())));
        if (sections != null) {
            for (CvSection s : sections) {
                String t = safe(s.getTitle());
                String c = safe(s.getContent());
                if (t.isEmpty() && c.isEmpty()) {
                    continue;
                }
                blocks.add(new SectionBlock(t.isEmpty() ? "SECTION" : t, c));
            }
        }

        int blockIndex = 0;
        boolean isFirstPage = true; // Cờ đánh dấu trang đầu tiên

        // Chuẩn bị nội dung Sidebar (để xử lý tràn trang)
        String remainingSkills = safe(cv.getSkills());
        String remainingLinks = safe(cv.getLinks());

        while (blockIndex < blocks.size()) {

            PageCtx p = new PageCtx(doc);
            p.newPage();

            float leftX = PAGE_MARGIN;
            float mainX = PAGE_MARGIN + sidebarW + gap;
            float leftW = sidebarW;
            float mainW = p.pageW - mainX - PAGE_MARGIN;
            float topY = p.pageH - TOP_MARGIN;
            float bottomY = BOTTOM_MARGIN;

            // ==== 1. Vẽ nền Sidebar (Vẽ ở mọi trang để giữ layout cột dọc)
            drawRect(p.cs, leftX, bottomY, leftW, topY - bottomY, true);

            float yLeft = topY - 15;

            // ==== 2. Chỉ vẽ Avatar & Contact ở trang đầu tiên
            if (isFirstPage) {
                // Avatar
                float avatarSize = 86;
                float avatarX = leftX + (leftW - avatarSize) / 2f;
                float avatarY = yLeft - avatarSize;
                if (avatar != null) {
                    p.cs.drawImage(avatar, avatarX, avatarY, avatarSize, avatarSize);
                } else {
                    drawRect(p.cs, avatarX, avatarY, avatarSize, avatarSize, false);
                }

                yLeft = avatarY - 15;

                // Contact Info
                yLeft = sidebarTitle(p.cs, bold, leftX + 12, yLeft, "CONTACT");
                String fullName = (safe(acc.getFirstName()) + " " + safe(acc.getLastName())).trim();
                if (fullName.isEmpty()) {
                    fullName = "Unknown";
                }

                yLeft = wrapTextPaged_SIDEBAR(p, normal, 10, leftX + 12, yLeft, leftW - 24, "Name: " + fullName);
                yLeft = wrapTextPaged_SIDEBAR(p, normal, 10, leftX + 12, yLeft, leftW - 24, "Email: " + safe(acc.getEmail()));
                yLeft = wrapTextPaged_SIDEBAR(p, normal, 10, leftX + 12, yLeft, leftW - 24, "Phone: " + safe(acc.getPhone()));
                yLeft -= 8;
            }

            // ==== 3. Vẽ Skills (Có xử lý tràn trang)
            if (!remainingSkills.isEmpty()) {
                // Chỉ vẽ tiêu đề SKILLS ở trang đầu
                if (isFirstPage) {
                    yLeft = sidebarTitle(p.cs, bold, leftX + 12, yLeft, "SKILLS");
                }
                // Vẽ nội dung, trả về vị trí y mới và phần văn bản chưa vẽ hết
                Object[] res = wrapTextSidebarFlow(p, normal, 10, leftX + 12, yLeft, leftW - 24, remainingSkills);
                yLeft = (float) res[0];
                remainingSkills = (String) res[1]; // Cập nhật phần còn lại
                yLeft -= 8;
            }

            // ==== 4. Vẽ Links (Có xử lý tràn trang)
            if (!remainingLinks.isEmpty()) {
                // Chỉ vẽ tiêu đề LINKS ở trang đầu (hoặc nếu trang 1 còn chỗ sau skill)
                if (isFirstPage) {
                    yLeft = sidebarTitle(p.cs, bold, leftX + 12, yLeft, "LINKS");
                }
                Object[] res = wrapTextSidebarFlow(p, normal, 10, leftX + 12, yLeft, leftW - 24, remainingLinks);
                yLeft = (float) res[0];
                remainingLinks = (String) res[1];
            }

            // ==== 5. Xử lý nội dung chính (Main Column) - Giữ nguyên logic cũ
            float yMain = topY - 5;
            if (isFirstPage) {
                setNonStroke(p.cs, COLOR_PRIMARY);
                writeText(p.cs, bold, 22, mainX, yMain, safe(cv.getTitle(), "My CV"));
                setNonStroke(p.cs, COLOR_TEXT);
                yMain -= 18;
                setStroke(p.cs, COLOR_PRIMARY);
                drawLine(p.cs, mainX, yMain, mainX + mainW, yMain);
                yMain -= 18;
            }
            p.y = yMain;

            while (blockIndex < blocks.size()) {
                SectionBlock b = blocks.get(blockIndex);
                ensureSpace(p, 28);
                p.y = mainTitle(p, bold, mainX, p.y, b.title);
                p.y = wrapTextPaged_MAIN(p, normal, 11, mainX, p.y, mainW, b.body);
                p.y -= 10;
                blockIndex++;
                if (p.y < BOTTOM_MARGIN + 90) {
                    break; // Hết giấy, sang trang mới
                }
            }

            p.closeStreamQuietly();
            isFirstPage = false; // Đã xong trang 1, các vòng lặp sau là trang 2, 3...
        }
    }

    private static class SectionBlock {

        String title;
        String body;

        SectionBlock(String t, String b) {
            title = t;
            body = b;
        }
    }

    // =========================
    // Section rendering (paged) - underline BELOW text + accent bar
    // =========================
    // =========================
    // Section rendering (paged) - Fixed alignment
    // =========================
    private float sectionBlockPaged(PageCtx p, String title, String body,
            float width, PDFont normal, PDFont bold) throws IOException {

        final int titleSize = 12;
        final float x = PAGE_MARGIN;

        // Ensure space for title + spacing
        ensureSpace(p, titleSize + 12);

        // 1. Accent bar (Thanh màu xanh bên trái)
        float barH = 13f; // Chiều cao thanh
        float barW = 4f;  // Chiều rộng thanh
        // Đặt đáy thanh thấp hơn dòng chữ 2 đơn vị để căn giữa đẹp hơn với chữ in hoa
        float barY = p.y - 2;

        setNonStroke(p.cs, COLOR_PRIMARY);
        p.cs.addRect(x, barY, barW, barH);
        p.cs.fill();

        // 2. Title (Chữ tiêu đề)
        // Viết chữ tại tọa độ p.y (baseline)
        writeText(p.cs, bold, titleSize, x + barW + 8, p.y, title);

        // 3. Underline (Dòng kẻ dưới)
        // Đặt dòng kẻ cách chân chữ 6 đơn vị (thay vì 18 như cũ)
        float lineY = p.y - 6;
        setStroke(p.cs, COLOR_PRIMARY);
        // Kẻ từ sau thanh xanh đến hết chiều rộng quy định
        drawLine(p.cs, x + barW + 8, lineY, x + (width * 0.62f), lineY);

        // 4. Body starts below line (Nội dung bắt đầu dưới dòng kẻ)
        setNonStroke(p.cs, COLOR_TEXT);
        p.y = lineY - 14; // Cách dòng kẻ 14 đơn vị
        p.y = wrapTextPaged_MAIN(p, normal, 11, x, p.y, width, body);

        return p.y - 12;
    }

    // Main title style (green + underline) - underline BELOW text + accent bar
    // Main title style (green + underline) - Fixed alignment
    private float mainTitle(PageCtx p, PDFont bold, float x, float y, String t) throws IOException {
        final int titleSize = 12;

        // 1. Accent bar
        float barH = 13f;
        float barW = 4f;
        float barY = y - 2; // Căn chỉnh đáy thanh xanh thấp hơn chân chữ 2pt

        setNonStroke(p.cs, COLOR_PRIMARY);
        p.cs.addRect(x, barY, barW, barH);
        p.cs.fill();

        // 2. Title
        writeText(p.cs, bold, titleSize, x + barW + 8, y, t);

        // 3. Underline below title
        float lineY = y - 6; // Đưa dòng kẻ lại gần chữ hơn
        setStroke(p.cs, COLOR_PRIMARY);
        drawLine(p.cs, x + barW + 8, lineY, x + 240, lineY);

        setNonStroke(p.cs, COLOR_TEXT);
        return lineY - 12; // Trả về vị trí Y mới để viết nội dung tiếp theo
    }

    private float sidebarTitle(PDPageContentStream cs, PDFont bold, float x, float y, String t) throws IOException {
        final int titleSize = 12;

        // 1. Accent bar
        float barH = 13f;
        float barW = 4f;
        float barY = y - 2;

        setNonStroke(cs, COLOR_PRIMARY);
        cs.addRect(x, barY, barW, barH);
        cs.fill();

        // 2. Title
        writeText(cs, bold, titleSize, x + barW + 8, y, t);

        // 3. Underline below title
        float lineY = y - 6;
        setStroke(cs, COLOR_PRIMARY);
        drawLine(cs, x + barW + 8, lineY, x + 135, lineY);

        setNonStroke(cs, COLOR_TEXT);
        return lineY - 10;
    }

    /**
     * Wrap text for MAIN: if overflow -> new page.
     */
    private float wrapTextPaged_MAIN(PageCtx p, PDFont font, int size,
            float x, float y, float width, String text) throws IOException {

        if (text == null || text.isBlank()) {
            return y;
        }

        String[] paragraphs = text.replace("\r", "").split("\n");

        for (String para : paragraphs) {
            if (para.isBlank()) {
                y -= (size + 4);
                continue;
            }

            String[] words = para.trim().split("\\s+");
            StringBuilder line = new StringBuilder();

            for (String w : words) {
                if (w.isEmpty()) {
                    continue;
                }

                // HARD WRAP word too long
                if (textWidth(font, size, w) > width) {
                    if (line.length() > 0) {
                        p.y = y;
                        ensureSpace(p, size + 6);
                        y = p.y;
                        writeText(p.cs, font, size, x, y, line.toString().trim());
                        y -= (size + 4);
                        line.setLength(0);
                    }

                    for (String part : breakLongWord(font, size, width, w)) {
                        p.y = y;
                        ensureSpace(p, size + 6);
                        y = p.y;
                        writeText(p.cs, font, size, x, y, part);
                        y -= (size + 4);
                    }
                    continue;
                }

                String test = line.toString() + w + " ";
                if (textWidth(font, size, test) > width) {
                    p.y = y;
                    ensureSpace(p, size + 6);
                    y = p.y;
                    writeText(p.cs, font, size, x, y, line.toString().trim());
                    y -= (size + 4);
                    line.setLength(0);
                }
                line.append(w).append(" ");
            }

            if (line.length() > 0) {
                p.y = y;
                ensureSpace(p, size + 6);
                y = p.y;
                writeText(p.cs, font, size, x, y, line.toString().trim());
                y -= (size + 4);
            }
        }
        return y;
    }

    /**
     * Wrap text for SIDEBAR: does not create new page (truncate if too long)
     */
    private float wrapTextPaged_SIDEBAR(PageCtx p, PDFont font, int size,
            float x, float y, float width, String text) throws IOException {

        if (text == null || text.isBlank()) {
            return y;
        }

        float minY = BOTTOM_MARGIN + 10;
        String[] paragraphs = text.replace("\r", "").split("\n");

        for (String para : paragraphs) {
            if (y < minY) {
                return y;
            }
            if (para.isBlank()) {
                y -= (size + 3);
                continue;
            }

            String[] words = para.trim().split("\\s+");
            StringBuilder line = new StringBuilder();

            for (String w : words) {
                if (w.isEmpty()) {
                    continue;
                }

                if (textWidth(font, size, w) > width) {
                    if (line.length() > 0) {
                        if (y < minY) {
                            return y;
                        }
                        writeText(p.cs, font, size, x, y, line.toString().trim());
                        y -= (size + 3);
                        line.setLength(0);
                    }

                    for (String part : breakLongWord(font, size, width, w)) {
                        if (y < minY) {
                            return y;
                        }
                        writeText(p.cs, font, size, x, y, part);
                        y -= (size + 3);
                    }
                    continue;
                }

                String test = line.toString() + w + " ";
                if (textWidth(font, size, test) > width) {
                    if (y < minY) {
                        return y;
                    }
                    writeText(p.cs, font, size, x, y, line.toString().trim());
                    y -= (size + 3);
                    line.setLength(0);
                }
                line.append(w).append(" ");
            }

            if (line.length() > 0) {
                if (y < minY) {
                    return y;
                }
                writeText(p.cs, font, size, x, y, line.toString().trim());
                y -= (size + 3);
            }
        }
        return y;
    }

    // =========================
    // Drawing helpers
    // =========================
    private void writeText(PDPageContentStream cs, PDFont font, int size,
            float x, float y, String text) throws IOException {
        cs.beginText();
        cs.setFont(font, size);
        cs.newLineAtOffset(x, y);
        cs.showText(text == null ? "" : text);
        cs.endText();
    }

    private void drawLine(PDPageContentStream cs, float x1, float y1, float x2, float y2) throws IOException {
        cs.moveTo(x1, y1);
        cs.lineTo(x2, y2);
        cs.stroke();
    }

    private void drawRect(PDPageContentStream cs, float x, float y, float w, float h, boolean fillLight) throws IOException {
        if (fillLight) {
            setNonStroke(cs, COLOR_LIGHTBG);
            cs.addRect(x, y, w, h);
            cs.fill();
            setNonStroke(cs, COLOR_TEXT);
        }
        setStroke(cs, rgb01(0, 0, 0));
        cs.addRect(x, y, w, h);
        cs.stroke();
    }

    private void setNonStroke(PDPageContentStream cs, float[] rgb01) throws IOException {
        cs.setNonStrokingColor(rgb01[0], rgb01[1], rgb01[2]);
    }

    private void setStroke(PDPageContentStream cs, float[] rgb01) throws IOException {
        cs.setStrokingColor(rgb01[0], rgb01[1], rgb01[2]);
    }

    // =========================
    // safe
    // =========================
    private String safe(String s) {
        return (s == null) ? "" : s.trim();
    }

    private String safe(String s, String def) {
        String v = safe(s);
        return v.isEmpty() ? def : v;
    }

    /**
     * Wrap text cho Sidebar có khả năng tràn trang (Flow). Trả về Object[]{
     * float currentY, String remainingText }
     */
    private Object[] wrapTextSidebarFlow(PageCtx p, PDFont font, int size,
            float x, float y, float width, String text) throws IOException {

        if (text == null || text.isBlank()) {
            return new Object[]{y, ""};
        }

        float minY = BOTTOM_MARGIN + 10;
        if (y < minY) {
            return new Object[]{y, text};
        }

        String[] paragraphs = text.replace("\r", "").split("\n");
        StringBuilder remaining = new StringBuilder();

        for (int pi = 0; pi < paragraphs.length; pi++) {
            String para = paragraphs[pi];

            if (para.isBlank()) {
                y -= (size + 3);
                if (y < minY) {
                    remaining.append("\n");
                    for (int k = pi + 1; k < paragraphs.length; k++) {
                        remaining.append(paragraphs[k]).append("\n");
                    }
                    return new Object[]{y, remaining.toString().trim()};
                }
                continue;
            }

            String[] words = para.trim().split("\\s+");
            StringBuilder line = new StringBuilder();

            for (int wi = 0; wi < words.length; wi++) {
                String w = words[wi];
                if (w.isEmpty()) {
                    continue;
                }

                if (textWidth(font, size, w) > width) {
                    if (line.length() > 0) {
                        if (y < minY) {
                            remaining.append(line).append(" ").append(w).append(" ");
                            for (int k = wi + 1; k < words.length; k++) {
                                remaining.append(words[k]).append(" ");
                            }
                            return new Object[]{y, remaining.toString().trim()};
                        }
                        writeText(p.cs, font, size, x, y, line.toString().trim());
                        y -= (size + 3);
                        line.setLength(0);
                    }

                    for (String part : breakLongWord(font, size, width, w)) {
                        if (y < minY) {
                            remaining.append(part).append(" ");
                            return new Object[]{y, remaining.toString().trim()};
                        }
                        writeText(p.cs, font, size, x, y, part);
                        y -= (size + 3);
                    }
                    continue;
                }

                String test = line.toString() + w + " ";
                if (textWidth(font, size, test) > width) {
                    if (y < minY) {
                        remaining.append(line).append(" ").append(w).append(" ");
                        for (int k = wi + 1; k < words.length; k++) {
                            remaining.append(words[k]).append(" ");
                        }
                        return new Object[]{y, remaining.toString().trim()};
                    }
                    writeText(p.cs, font, size, x, y, line.toString().trim());
                    y -= (size + 3);
                    line.setLength(0);
                }
                line.append(w).append(" ");
            }

            if (line.length() > 0) {
                if (y < minY) {
                    remaining.append(line);
                    return new Object[]{y, remaining.toString().trim()};
                }
                writeText(p.cs, font, size, x, y, line.toString().trim());
                y -= (size + 3);
            }
        }

        return new Object[]{y, ""};
    }

    // =========================
// Text measuring & hard-wrap helpers
// =========================
    private float textWidth(PDFont font, int size, String s) throws IOException {
        if (s == null) {
            return 0f;
        }
        return font.getStringWidth(s) / 1000f * size;
    }

    /**
     * Break a very long word (URL/email/ID) into chunks that fit width
     */
    private List<String> breakLongWord(PDFont font, int size, float width, String word) throws IOException {
        List<String> parts = new ArrayList<>();
        if (word == null || word.isBlank()) {
            return parts;
        }

        StringBuilder cur = new StringBuilder();
        for (int i = 0; i < word.length(); i++) {
            char ch = word.charAt(i);
            String test = cur.toString() + ch;
            if (textWidth(font, size, test) > width) {
                if (cur.length() > 0) {
                    parts.add(cur.toString());
                    cur.setLength(0);
                }
                cur.append(ch);
            } else {
                cur.append(ch);
            }
        }
        if (cur.length() > 0) {
            parts.add(cur.toString());
        }
        return parts;
    }

}
