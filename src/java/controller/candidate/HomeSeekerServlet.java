package controller.candidate;

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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.JobPostings;
import model.Job_Posting_Category;
import model.PageControl;

@WebServlet(name = "HomeSeekerServlet", urlPatterns = {"/HomeSeeker"})
public class HomeSeekerServlet extends HttpServlet {

    private final JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();
    private final Job_Posting_CategoryDAO jobCategoryDAO = new Job_Posting_CategoryDAO();

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

    private static String safe(String s) {
        return s == null ? "" : s.trim();
    }

    private static String enc(String s) {
        return URLEncoder.encode(s == null ? "" : s, StandardCharsets.UTF_8).replace("+", "%20");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PageControl pageControl = new PageControl();

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) {
                page = 1;
            }
        } catch (Exception ignored) {
            page = 1;
        }

        // categories active
        List<Job_Posting_Category> jobCategories = jobCategoryDAO.findAll();
        List<Job_Posting_Category> activeCategories = new ArrayList<>();
        for (Job_Posting_Category c : jobCategories) {
            if (c.isStatus()) {
                activeCategories.add(c);
            }
        }

        // params
        String minSalary = safe(request.getParameter("minSalary"));
        String maxSalary = safe(request.getParameter("maxSalary"));
        String filterCategory = safe(request.getParameter("filterCategory"));
        String filterCurrency = safe(request.getParameter("filterCurrency"));
        String search = safe(request.getParameter("search"));

        // NEW: location text input
        String filterLocation = safe(request.getParameter("filterLocation"));

        // NEW: date
        String dateFrom = safe(request.getParameter("dateFrom"));
        String dateTo = safe(request.getParameter("dateTo"));

        // Validate numeric salaries (nếu nhập bậy -> bỏ lọc)
        if (!minSalary.isEmpty()) {
            try {
                Long.parseLong(minSalary);
            } catch (Exception e) {
                minSalary = "";
            }
        }
        if (!maxSalary.isEmpty()) {
            try {
                Long.parseLong(maxSalary);
            } catch (Exception e) {
                maxSalary = "";
            }
        }

        // Validate date range: from <= to
        boolean dateOk = true;
        if (!dateFrom.isEmpty() && !dateTo.isEmpty()) {
            try {
                LocalDate from = LocalDate.parse(dateFrom);
                LocalDate to = LocalDate.parse(dateTo);
                if (from.isAfter(to)) {
                    dateOk = false;
                    request.setAttribute("dateError", "Từ ngày không được lớn hơn Đến ngày");
                }
            } catch (Exception e) {
                // parse lỗi -> bỏ lọc ngày nhưng không crash
                dateOk = false;
                request.setAttribute("dateError", "Ngày không hợp lệ");
            }
        }

        // Nếu date không ok thì bỏ filter date để vẫn ra job bình thường
        if (!dateOk) {
            dateFrom = "";
            dateTo = "";
        }

        // Query data
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

        int totalPage = (totalRecord + 11) / 12;

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);

        // URL pattern for pagination (giữ đủ params)
        String requestURL = request.getRequestURL().toString();
        String urlPattern = requestURL
                + "?minSalary=" + enc(minSalary)
                + "&maxSalary=" + enc(maxSalary)
                + "&filterCategory=" + enc(filterCategory)
                + "&filterCurrency=" + enc(filterCurrency)
                + "&filterLocation=" + enc(filterLocation)
                + "&dateFrom=" + enc(dateFrom)
                + "&dateTo=" + enc(dateTo)
                + "&search=" + enc(search)
                + "&";
        pageControl.setUrlPattern(urlPattern);

        request.setAttribute("jobPostingsList", jobPostingsList);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("activeCategories", activeCategories);

        request.getRequestDispatcher("view/user/userHome.jsp").forward(request, response);
    }
}
