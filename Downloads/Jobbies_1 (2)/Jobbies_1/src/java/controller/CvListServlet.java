package controller;

import dao.CvDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.CV;
import utils.AuthUtil;

@WebServlet("/cv/list")
public class CvListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập
        Account acc = AuthUtil.getLoggedAccount(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Lấy JobSeekerId
        Integer jobSeekerId = new JobSeekerDAO().findJobSeekerIdByAccountId(acc.getId());
        if (jobSeekerId == null) {
            req.setAttribute("error", "Bạn chưa có JobSeeker profile.");
            req.getRequestDispatcher("/view/user/cv_list.jsp").forward(req, resp);
            return;
        }

        // 3. Đọc các tham số Search, Sort, Paging từ Request
        String q = req.getParameter("q"); // keyword tìm kiếm
        if (q == null) q = "";
        
        String sort = req.getParameter("sort"); // cột sắp xếp: title, updated
        if (sort == null || sort.isEmpty()) sort = "updated";
        
        String dir = req.getParameter("dir"); // hướng: asc, desc
        if (dir == null || dir.isEmpty()) dir = "desc";

        int page = 1; // trang hiện tại
        try {
            String p = req.getParameter("page");
            if (p != null) page = Integer.parseInt(p);
        } catch (Exception e) { page = 1; }

        int size = 5; // số lượng bản ghi mỗi trang
        try {
            String s = req.getParameter("size");
            if (s != null) size = Integer.parseInt(s);
        } catch (Exception e) { size = 5; }

        int offset = (page - 1) * size;

        CvDAO cvDao = new CvDAO();
        try {
            // 4. Lấy dữ liệu từ DAO
            int totalRecords = cvDao.count(jobSeekerId, q);
            int totalPages = (int) Math.ceil((double) totalRecords / size);
            List<CV> list = cvDao.list(jobSeekerId, q, sort, dir, offset, size);

            // 5. Đẩy dữ liệu ra JSP
            req.setAttribute("cvs", list);
            req.setAttribute("total", totalRecords);
            req.setAttribute("page", page);
            req.setAttribute("size", size);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("q", q);
            req.setAttribute("sort", sort);
            req.setAttribute("dir", dir);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        req.getRequestDispatcher("/view/user/cv_list.jsp").forward(req, resp);
    }
}