package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

import model.Account;
import model.CV;
import utils.AuthUtil;

import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.*;
import org.apache.pdfbox.pdmodel.graphics.image.*;

@WebServlet("/cv/download")
public class DownloadCVServlet extends HttpServlet {

    private static final String FONT_REGULAR_PATH = "/assets/fonts/DejaVuSans.ttf";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1) Auth
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2) Validate cvid
        int cvid;
        try {
            cvid = Integer.parseInt(req.getParameter("cvid"));
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        // 3) Resolve jobSeekerId
        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        // 4) Load CV and ensure ownership
        CV cv = new CvDAO().getById(cvid, jobSeekerId);
        if (cv == null) {
            resp.sendRedirect(req.getContextPath() + "/cv/list");
            return;
        }

        // 5) Response headers
        resp.reset();
        resp.setContentType("application/pdf");

        String filename = "CV_" + cvid + ".pdf";
        String encoded = URLEncoder.encode(filename, StandardCharsets.UTF_8).replace("+", "%20");
        resp.setHeader("Content-Disposition",
                "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + encoded);

        try (PDDocument doc = new PDDocument()) {

            PDPage page = new PDPage(PDRectangle.A4);
            doc.addPage(page);

            PDFont normal = loadFont(doc, FONT_REGULAR_PATH);
            PDFont bold = normal; // Nếu có font bold riêng thì load thêm

            // Load avatar (nếu có)
            PDImageXObject avatarImg = loadAvatarImage(doc, req, acc);

            try (PDPageContentStream cs = new PDPageContentStream(doc, page)) {
                String template = safe(cv.getTemplateCode());
                if ("TEMPLATE_2".equalsIgnoreCase(template)) {
                    renderTemplate2(cs, page, acc, cv, normal, bold, avatarImg);
                } else {
                    renderTemplate1(cs, page, acc, cv, normal, bold, avatarImg);
                }
}

            doc.save(resp.getOutputStream());
            resp.getOutputStream().flush();

        } catch (Exception ex) {
            // Tránh ERR_INVALID_RESPONSE
            resp.reset();
            resp.setContentType("text/plain; charset=UTF-8");
            resp.setStatus(500);
            resp.getWriter().println("Download PDF failed: " + ex.getMessage());
        }
    }

    // =========================
    // TEMPLATE 1
    // =========================
    private void renderTemplate1(PDPageContentStream cs, PDPage page,
                                 Account acc, CV cv,
                                 PDFont normal, PDFont bold,
                                 PDImageXObject avatar) throws IOException {

        float margin = 50;
        float pageW = page.getMediaBox().getWidth();
        float pageH = page.getMediaBox().getHeight();
        float contentW = pageW - margin * 2;

        float yTop = pageH - 60;

        // Header box
        float headerH = 110;
        float headerY = yTop - headerH + 10;
        drawRect(cs, margin, headerY, contentW, headerH, true);

        float x = margin + 15;
        float yTextTop = yTop - 20;

        // Avatar
        float avatarSize = 72;
        float avatarX = x;
        float avatarY = yTop - 90; // bottom y for drawImage
        if (avatar != null) {
            cs.drawImage(avatar, avatarX, avatarY, avatarSize, avatarSize);
        } else {
            drawRect(cs, avatarX, avatarY, avatarSize, avatarSize, false);
        }

        float infoX = x + avatarSize + 15;

        writeText(cs, bold, 18, infoX, yTextTop, safe(cv.getTitle(), "My CV"));

        String fullName = (safe(acc.getFirstName()) + " " + safe(acc.getLastName())).trim();
        if (fullName.isEmpty()) fullName = "Unknown";

        writeText(cs, normal, 11, infoX, yTextTop - 22, fullName);
        writeText(cs, normal, 11, infoX, yTextTop - 38,
                "Email: " + safe(acc.getEmail()) + "    Phone: " + safe(acc.getPhone()));

        // line
        drawLine(cs, margin, headerY + 12, margin + contentW, headerY + 12);

        float y = headerY - 15;

        y = sectionBlock(cs, bold, normal, margin, y, contentW, "SUMMARY", safe(cv.getSummary()));
        y = sectionBlock(cs, bold, normal, margin, y, contentW, "SKILLS", safe(cv.getSkills()));
        sectionBlock(cs, bold, normal, margin, y, contentW, "LINKS", safe(cv.getLinks()));
    }

    // =========================
    // TEMPLATE 2 (Sidebar + Main)
    // =========================
    private void renderTemplate2(PDPageContentStream cs, PDPage page,
                                 Account acc, CV cv,
                                 PDFont normal, PDFont bold,
                                 PDImageXObject avatar) throws IOException {

        float margin = 50;
        float pageW = page.getMediaBox().getWidth();
        float pageH = page.getMediaBox().getHeight();

        float topY = pageH - 60;
        float bottomY = 60;
float sidebarW = 180;
        float gap = 18;

        float leftX = margin;
        float mainX = margin + sidebarW + gap;

        float leftW = sidebarW;
        float mainW = pageW - mainX - margin;

        // Sidebar background
        drawRect(cs, leftX, bottomY, leftW, topY - bottomY, true);

        float yLeft = topY - 15;

        // Avatar
        float avatarSize = 86;
        float avatarX = leftX + (leftW - avatarSize) / 2f;
        float avatarY = yLeft - avatarSize;
        if (avatar != null) cs.drawImage(avatar, avatarX, avatarY, avatarSize, avatarSize);
        else drawRect(cs, avatarX, avatarY, avatarSize, avatarSize, false);

        yLeft = avatarY - 15;

        yLeft = writeBlockTitle(cs, bold, leftX + 12, yLeft, "CONTACT");

        String fullName = (safe(acc.getFirstName()) + " " + safe(acc.getLastName())).trim();
        if (fullName.isEmpty()) fullName = "Unknown";

        yLeft = wrapText(cs, normal, 10, leftX + 12, yLeft, leftW - 24, "Name: " + fullName);
        yLeft = wrapText(cs, normal, 10, leftX + 12, yLeft, leftW - 24, "Email: " + safe(acc.getEmail()));
        yLeft = wrapText(cs, normal, 10, leftX + 12, yLeft, leftW - 24, "Phone: " + safe(acc.getPhone()));

        yLeft -= 8;
        yLeft = writeBlockTitle(cs, bold, leftX + 12, yLeft, "SKILLS");
        yLeft = wrapText(cs, normal, 10, leftX + 12, yLeft, leftW - 24, safe(cv.getSkills()));

        yLeft -= 8;
        yLeft = writeBlockTitle(cs, bold, leftX + 12, yLeft, "LINKS");
        wrapText(cs, normal, 10, leftX + 12, yLeft, leftW - 24, safe(cv.getLinks()));

        // Main
        float yMain = topY - 5;

        writeText(cs, bold, 20, mainX, yMain, safe(cv.getTitle(), "My CV"));
        yMain -= 18;
        drawLine(cs, mainX, yMain, mainX + mainW, yMain);
        yMain -= 18;

        yMain = writeBlockTitle(cs, bold, mainX, yMain, "SUMMARY");
        wrapText(cs, normal, 11, mainX, yMain, mainW, safe(cv.getSummary()));
    }

    // =========================
    // Font
    // =========================
    private PDFont loadFont(PDDocument doc, String webPath) throws IOException {
        InputStream is = getServletContext().getResourceAsStream(webPath);
        if (is == null) throw new IOException("Font not found in webapp: " + webPath);
        try (InputStream in = is) {
            return PDType0Font.load(doc, in, true);
        }
    }

    // =========================
    // Avatar load (FIX CHUẨN DB /JobSeeker/images/..)
    // =========================
    private PDImageXObject loadAvatarImage(PDDocument doc, HttpServletRequest req, Account acc) {
        try {
            String a = safe(acc.getAvatar());
            if (a.isEmpty()) return null;

            // Nếu DB lưu /JobSeeker/images/.. => strip context
            String ctx = req.getContextPath(); // /JobSeeker
            if (!ctx.isEmpty() && a.startsWith(ctx + "/")) {
                a = a.substring(ctx.length()); // -> /images/xxx.jpg
            }
if (a.startsWith("/JobSeeker/")) { // fallback nếu lỡ hardcode
                a = a.substring("/JobSeeker".length()); // -> /images/xxx.jpg
            }

            // URL
            if (a.startsWith("http://") || a.startsWith("https://")) {
                URLConnection con = new URL(a).openConnection();
                con.setConnectTimeout(8000);
                con.setReadTimeout(8000);
                try (InputStream in = con.getInputStream()) {
                    BufferedImage img = ImageIO.read(in);
                    if (img == null) return null;
                    return LosslessFactory.createFromImage(doc, img);
                }
            }

            // đảm bảo dạng /images/xxx.jpg
            if (!a.startsWith("/")) a = "/" + a;

            // 1) try resource stream
            try (InputStream in = getServletContext().getResourceAsStream(a)) {
                if (in != null) {
                    BufferedImage img = ImageIO.read(in);
                    if (img != null) return LosslessFactory.createFromImage(doc, img);
                }
            }

            // 2) fallback real path
            String real = getServletContext().getRealPath(a);
            if (real != null) {
                File f = new File(real);
                if (f.exists()) {
                    BufferedImage img = ImageIO.read(f);
                    if (img != null) return LosslessFactory.createFromImage(doc, img);
                }
            }

            return null;

        } catch (Exception e) {
            return null; // không để avatar làm fail pdf
        }
    }

    // =========================
    // Layout helpers
    // =========================
    private float sectionBlock(PDPageContentStream cs, PDFont bold, PDFont normal,
                               float x, float y, float w,
                               String title, String body) throws IOException {
        y = writeBlockTitle(cs, bold, x, y, title);
        y = wrapText(cs, normal, 11, x, y, w, body);
        return y - 10;
    }

    private float writeBlockTitle(PDPageContentStream cs, PDFont bold, float x, float y, String t) throws IOException {
        writeText(cs, bold, 12, x, y, t);
        return y - 16;
    }

    private void writeText(PDPageContentStream cs, PDFont font, int size,
                           float x, float y, String text) throws IOException {
        cs.beginText();
        cs.setFont(font, size);
        cs.newLineAtOffset(x, y);
        cs.showText(text == null ? "" : text);
        cs.endText();
    }

    private float wrapText(PDPageContentStream cs, PDFont font, int size,
                           float x, float y, float width, String text) throws IOException {

        if (text == null || text.isBlank()) return y;

        String[] paragraphs = text.replace("\r", "").split("\n");
        for (String p : paragraphs) {
            if (p.isBlank()) { y -= (size + 3); continue; }
String[] words = p.trim().split("\\s+");
            StringBuilder line = new StringBuilder();

            for (String w : words) {
                String test = line + w + " ";
                float testWidth = font.getStringWidth(test) / 1000f * size;

                if (testWidth > width) {
                    writeText(cs, font, size, x, y, line.toString().trim());
                    y -= (size + 3);
                    line = new StringBuilder(w).append(" ");
                } else {
                    line.append(w).append(" ");
                }
            }

            if (!line.isEmpty()) {
                writeText(cs, font, size, x, y, line.toString().trim());
                y -= (size + 3);
            }
        }
        return y;
    }

    private void drawLine(PDPageContentStream cs, float x1, float y1, float x2, float y2) throws IOException {
        cs.moveTo(x1, y1);
        cs.lineTo(x2, y2);
        cs.stroke();
    }

    /**
     * FIX lỗi màu: dùng float 0..1 (an toàn mọi version PDFBox)
     */
    private void drawRect(PDPageContentStream cs, float x, float y, float w, float h, boolean fillLight) throws IOException {
        if (fillLight) {
            cs.setNonStrokingColor(245f/255f, 245f/255f, 245f/255f);
            cs.addRect(x, y, w, h);
            cs.fill();

            cs.setNonStrokingColor(0f, 0f, 0f);
        }
        cs.addRect(x, y, w, h);
        cs.stroke();
    }

    private String safe(String s) {
        return (s == null) ? "" : s.trim();
    }

    private String safe(String s, String def) {
        String v = safe(s);
        return v.isEmpty() ? def : v;
    }
}