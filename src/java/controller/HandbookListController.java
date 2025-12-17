package controller;

import static constant.CommonConst.RECORD_PER_PAGE;
import dao.HandbookPostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import model.HandbookPosts;
import model.PageControl;

@WebServlet(name = "HandbookListController", urlPatterns = {"/handbook"})
public class HandbookListController extends HttpServlet {

    private final HandbookPostsDAO handbookDao = new HandbookPostsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        List<HandbookPosts> posts = handbookDao.findPublished(search, page);
        int totalRecord = handbookDao.countPublished(search);

        String requestURL = request.getRequestURL().toString();
        pageControl.setUrlPattern(requestURL + "?search=" + URLEncoder.encode(search, "UTF-8") + "&");

        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0 ? (totalRecord / RECORD_PER_PAGE) : (totalRecord / RECORD_PER_PAGE) + 1;

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);

        request.setAttribute("posts", posts);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("search", search);

        request.getRequestDispatcher("view/handbook/handbookList.jsp").forward(request, response);
    }
}
