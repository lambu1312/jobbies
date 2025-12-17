package controller.admin;

import static constant.CommonConst.RECORD_PER_PAGE;
import dao.HandbookPostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import model.HandbookPosts;
import model.PageControl;

@MultipartConfig
@WebServlet(name = "HandbookAdminController", urlPatterns = {"/handbook_admin"})
public class HandbookAdminController extends HttpServlet {

    private final HandbookPostsDAO handbookDao = new HandbookPostsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action") != null ? request.getParameter("action") : "";

        switch (action) {
            case "create":
                request.getRequestDispatcher("view/admin/handbookForm.jsp").forward(request, response);
                return;
            case "edit": {
                int id;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    response.sendRedirect("handbook_admin?error=" + URLEncoder.encode("Invalid post id", "UTF-8"));
                    return;
                }
                HandbookPosts post = handbookDao.findById(id);
                if (post == null) {
                    response.sendRedirect("handbook_admin?error=" + URLEncoder.encode("Post not found", "UTF-8"));
                    return;
                }
                request.setAttribute("post", post);
                request.getRequestDispatcher("view/admin/handbookForm.jsp").forward(request, response);
                return;
            }
            default:
                break;
        }

        PageControl pageControl = new PageControl();

        int page;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : "";

        List<HandbookPosts> posts = handbookDao.adminList(search, status, page);
        int totalRecord = handbookDao.adminCount(search, status);

        String requestURL = request.getRequestURL().toString();
        pageControl.setUrlPattern(requestURL + "?status=" + URLEncoder.encode(status, "UTF-8") + "&search=" + URLEncoder.encode(search, "UTF-8") + "&");

        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0 ? (totalRecord / RECORD_PER_PAGE) : (totalRecord / RECORD_PER_PAGE) + 1;

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);

        request.setAttribute("posts", posts);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        String success = request.getParameter("success") != null ? request.getParameter("success") : "";
        String error = request.getParameter("error") != null ? request.getParameter("error") : "";
        request.setAttribute("success", success);
        request.setAttribute("error", error);

        request.getRequestDispatcher("view/admin/handbookManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action") != null ? request.getParameter("action") : "";

        switch (action) {
            case "create":
                response.sendRedirect(handleCreate(request));
                return;
            case "update":
                response.sendRedirect(handleUpdate(request));
                return;
            case "delete":
                response.sendRedirect(handleDelete(request));
                return;
            default:
                response.sendRedirect("handbook_admin");
        }
    }

    private String handleCreate(HttpServletRequest request) throws IOException, ServletException {
        String title = request.getParameter("title") != null ? request.getParameter("title").trim() : "";
        String content = request.getParameter("content") != null ? request.getParameter("content").trim() : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : "Draft";

        String thumbnail = saveThumbnail(request, "thumbnail");

        if (title.isEmpty() || content.isEmpty()) {
            return "handbook_admin?error=" + URLEncoder.encode("Title and content are required", "UTF-8");
        }

        HandbookPosts post = new HandbookPosts();
        post.setTitle(title);
        post.setContent(content);
        post.setThumbnail(thumbnail);
        post.setStatus(status);

        handbookDao.insert(post);

        return "handbook_admin?success=" + URLEncoder.encode("Created successfully", "UTF-8");
    }

    private String handleUpdate(HttpServletRequest request) throws IOException, ServletException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            return "handbook_admin?error=" + URLEncoder.encode("Invalid post id", "UTF-8");
        }

        HandbookPosts existing = handbookDao.findById(id);
        if (existing == null) {
            return "handbook_admin?error=" + URLEncoder.encode("Post not found", "UTF-8");
        }

        String title = request.getParameter("title") != null ? request.getParameter("title").trim() : "";
        String content = request.getParameter("content") != null ? request.getParameter("content").trim() : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : existing.getStatus();

        String newThumbnail = saveThumbnail(request, "thumbnail");
        if (newThumbnail != null) {
            existing.setThumbnail(newThumbnail);
        }

        if (title.isEmpty() || content.isEmpty()) {
            return "handbook_admin?action=edit&id=" + id + "&error=" + URLEncoder.encode("Title and content are required", "UTF-8");
        }

        existing.setTitle(title);
        existing.setContent(content);
        existing.setStatus(status);

        handbookDao.update(existing);

        return "handbook_admin?success=" + URLEncoder.encode("Updated successfully", "UTF-8");
    }

    private String handleDelete(HttpServletRequest request) throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            return "handbook_admin?error=" + URLEncoder.encode("Invalid post id", "UTF-8");
        }

        handbookDao.delete(id);
        return "handbook_admin?success=" + URLEncoder.encode("Deleted successfully", "UTF-8");
    }

    private String saveThumbnail(HttpServletRequest request, String partName) {
        try {
            Part part = request.getPart(partName);
            if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                return null;
            }

            String path = request.getServletContext().getRealPath("images");
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File image = new File(dir, part.getSubmittedFileName());
            part.write(image.getAbsolutePath());

            return request.getContextPath() + "/" + "/images/" + image.getName();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
