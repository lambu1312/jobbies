package controller;

import static constant.CommonConst.RECORD_PER_PAGE;
import dao.HandbookPostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import model.HandbookPosts;
import model.PageControl;
import model.Account;

@WebServlet(name = "HandbookListController", urlPatterns = {"/handbook"})
public class HandbookListController extends HttpServlet {

    private final HandbookPostsDAO handbookDao = new HandbookPostsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra role của user từ session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        String userRole = "guest"; // Mặc định là guest (chưa đăng nhập)
        int roleID = 0;

        if (account != null) {
            roleID = account.getRoleId();

            // Phân loại theo roleID
            switch (roleID) {
                case 2:
                    userRole = "recruiter";
                    break;
                case 3:
                    userRole = "seeker";
                    break;
                default:
                    userRole = "user";
                    break;
            }
        }

        // Set userRole và roleID vào request để JSP sử dụng
        request.setAttribute("userRole", userRole);
        request.setAttribute("roleID", roleID);

        // Logic phân trang
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

        // Lấy dữ liệu posts
        List<HandbookPosts> posts = handbookDao.findPublished(search, page);
        int totalRecord = handbookDao.countPublished(search);

        // Setup pagination
        String requestURL = request.getRequestURL().toString();
        pageControl.setUrlPattern(requestURL + "?search=" + URLEncoder.encode(search, "UTF-8") + "&");
        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0
                ? (totalRecord / RECORD_PER_PAGE)
                : (totalRecord / RECORD_PER_PAGE) + 1;

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);
// Set attributes
        request.setAttribute("posts", posts);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("search", search);

        // Forward đến view
        request.getRequestDispatcher("view/handbook/handbookList.jsp").forward(request, response);
    }
}
