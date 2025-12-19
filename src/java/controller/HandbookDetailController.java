package controller;

import dao.HandbookPostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import model.HandbookPosts;

@WebServlet(name = "HandbookDetailController", urlPatterns = {"/handbook-detail"})
public class HandbookDetailController extends HttpServlet {

    private final HandbookPostsDAO handbookDao = new HandbookPostsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("handbook?error=" + URLEncoder.encode("Invalid post id", "UTF-8"));
            return;
        }

        HandbookPosts post = handbookDao.findPublishedById(id);
        if (post == null) {
            response.sendRedirect("handbook?error=" + URLEncoder.encode("Post not found", "UTF-8"));
            return;
        }

        request.setAttribute("post", post);
        request.getRequestDispatcher("view/handbook/handbookDetail.jsp").forward(request, response);
    }
}
