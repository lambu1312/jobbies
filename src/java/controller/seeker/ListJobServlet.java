/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.seeker;

import constant.CommonConst;
import dao.JobPostingsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.JobPostings;

@WebServlet(name = "ListJobServlet", urlPatterns = {"/listJob"})
public class ListJobServlet extends HttpServlet {

    private final JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số tìm kiếm và phân trang từ request
        String filter = request.getParameter("filter");

        String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
        String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;  // Số lượng bản ghi trên mỗi trang

        List<JobPostings> jobList;
        int totalRecords;

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        List<JobPostings> list = jobPostingsDAO.getJobPostingsByOpen();
        // Kiểm tra nếu có từ khóa tìm kiếm
        if (!searchJP.isEmpty()) {
            // Gọi DAO method để tìm kiếm và phân trang
            jobList = jobPostingsDAO.searchJobPostingByTitle(searchJP, page);
            totalRecords = jobPostingsDAO.findTotalRecordByTitle(searchJP);  // Đếm tổng kết quả tìm kiếm
            if (jobList.isEmpty()) {
                request.setAttribute("NoJP", "No found");
            }
        } else {
            // Nếu không có từ khóa tìm kiếm, lấy tất cả dữ liệu và phân trang
            jobList = jobPostingsDAO.findJobPostingsWithFilter(sortField, page, pageSize);
            totalRecords = jobPostingsDAO.countTotalJobPostings();  // Đếm tổng số bản ghi
        }

        // Tính toán tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Gửi các thông tin cần thiết về JSP
        request.setAttribute("listJobPosting", jobList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("sortField", sortField);
        request.setAttribute("searchJP", searchJP);  // Để giữ lại từ khóa tìm kiếm khi phân trang

        // Chuyển hướng đến trang quản lý Job Posting
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/user/ListJob.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListJobServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
