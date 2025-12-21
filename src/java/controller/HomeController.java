package controller;

import dao.CompanyDAO;
import dao.JobPostingsDAO;
import dao.Job_Posting_CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.JobPostings;
import model.Job_Posting_Category;
import model.PageControl;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private final JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    private final CompanyDAO companyDAO = new CompanyDAO(); // giữ nguyên nếu bạn đang dùng chỗ khác
    private final Job_Posting_CategoryDAO jobCategoryDAO = new Job_Posting_CategoryDAO();

    private static String safe(String s) {
        return s == null ? "" : s.trim();
    }

    private static String enc(String s) {
        return URLEncoder.encode(s == null ? "" : s, StandardCharsets.UTF_8).replace("+", "%20");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PageControl pageControl = new PageControl();

        // ===== Page =====
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) {
                page = 1;
            }
        } catch (Exception ignored) {
            page = 1;
        }

        // ===== Categories (active only) =====
        List<Job_Posting_Category> jobCategories = jobCategoryDAO.findAll();
        List<Job_Posting_Category> activeCategories = new ArrayList<>();
        for (Job_Posting_Category c : jobCategories) {
            if (c.isStatus()) {
                activeCategories.add(c);
            }
        }

        // ===== Filters =====
        String minSalaryParam = request.getParameter("minSalary");
        String maxSalaryParam = request.getParameter("maxSalary");
        String filterCategory = safe(request.getParameter("filterCategory"));
        String filterCurrency = safe(request.getParameter("filterCurrency"));
        String search = safe(request.getParameter("search"));

        // ✅ NEW: Location search text
        String filterLocation = safe(request.getParameter("filterLocation"));

        // Date filters from <input type="date"> => yyyy-MM-dd
        String dateFromParam = safe(request.getParameter("dateFrom"));
        String dateToParam = safe(request.getParameter("dateTo"));

        // ===== Salary parse (keep as String like your DAO) =====
        String minSalary = "";
        String maxSalary = "";

        if (minSalaryParam != null && !minSalaryParam.trim().isEmpty()) {
            try {
                Integer.parseInt(minSalaryParam.trim());
                minSalary = minSalaryParam.trim();
            } catch (NumberFormatException ignored) {
            }
        }

        if (maxSalaryParam != null && !maxSalaryParam.trim().isEmpty()) {
            try {
                Integer.parseInt(maxSalaryParam.trim());
                maxSalary = maxSalaryParam.trim();
            } catch (NumberFormatException ignored) {
            }
        }

        // ===== Date parse =====
        Date dateFrom = null;
        Date dateTo = null;

        try {
            if (!dateFromParam.isEmpty()) {
                dateFrom = Date.valueOf(dateFromParam);
            }
        } catch (Exception ignored) {
        }

        try {
            if (!dateToParam.isEmpty()) {
                dateTo = Date.valueOf(dateToParam);
            }
        } catch (Exception ignored) {
        }

        // ✅ Validate date range: from <= to
        if (dateFrom != null && dateTo != null && dateFrom.after(dateTo)) {
            request.setAttribute("dateError", "Từ ngày không được lớn hơn Đến ngày");

            // Bỏ lọc ngày để trang vẫn chạy + vẫn có data
            dateFrom = null;
            dateTo = null;

            // Giữ lại param để user thấy họ nhập gì (không bắt buộc)
            // (nếu bạn muốn reset input về rỗng thì set dateFromParam/dateToParam = "")
        }

        // ===== Query =====
        List<JobPostings> jobPostingsList = jobPostingsDAO.findAndfilterJobPostingsHome(
                minSalary, maxSalary,
                filterCategory, filterCurrency,
                search, filterLocation,
                dateFrom, dateTo,
                page
        );

        int totalRecord = jobPostingsDAO.findAndfilterAllHomeRecord(
                minSalary, maxSalary,
                filterCategory, filterCurrency,
                search, filterLocation,
                dateFrom, dateTo
        );

        // ===== Pagination urlPattern (keep ALL params incl dates + location) =====
        String requestURL = request.getRequestURL().toString();
        pageControl.setUrlPattern(
                requestURL
                + "?minSalary=" + enc(minSalary)
                + "&maxSalary=" + enc(maxSalary)
                + "&filterCategory=" + enc(filterCategory)
                + "&filterCurrency=" + enc(filterCurrency)
                + "&filterLocation=" + enc(filterLocation)
                + "&search=" + enc(search)
                + "&dateFrom=" + enc(dateFromParam)
                + "&dateTo=" + enc(dateToParam)
                + "&"
        );

        int totalPage = (totalRecord + 11) / 12;

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);

        // ===== Attributes =====
        request.setAttribute("jobPostingsList", jobPostingsList);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("activeCategories", activeCategories);

        // Optional: nếu JSP muốn dùng attribute thay vì param.*
        request.setAttribute("dateFrom", dateFromParam);
        request.setAttribute("dateTo", dateToParam);
        request.setAttribute("filterLocation", filterLocation);

        request.getRequestDispatcher("view/home.jsp").forward(request, response);
    }
}
