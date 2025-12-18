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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PageControl pageControl = new PageControl();

        /* ================= PAGE ================= */
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (Exception e) {
            page = 1;
        }

        int pageSize = 12;

        /* ================= CATEGORY ================= */
        List<Job_Posting_Category> jobCategories = jobCategoryDAO.findAll();
        List<Job_Posting_Category> activeCategories = new ArrayList<>();
        for (Job_Posting_Category c : jobCategories) {
            if (c.isStatus()) {
                activeCategories.add(c);
            }
        }

        /* ================= FILTER PARAMS ================= */
        String minSalary   = getParam(request, "minSalary");
        String maxSalary   = getParam(request, "maxSalary");
        String search      = getParam(request, "search");
        String currency    = getParam(request, "currency");
        String postedDate  = getParam(request, "postedDate");
        String closingDate = getParam(request, "closingDate");
        String location    = getParam(request, "location");

        /* ================= QUERY DATA ================= */
        List<JobPostings> jobPostingsList =
                jobPostingsDAO.filterJobPostingsHome(
                        minSalary,
                        maxSalary,
                        search,
                        currency,
                        postedDate,
                        closingDate,
                        location,
                        page,
                        pageSize
                );

        int totalRecord =
                jobPostingsDAO.countFilterJobPostingsHome(
                        minSalary,
                        maxSalary,
                        search,
                        currency,
                        postedDate,
                        closingDate,
                        location
                );

        /* ================= PAGINATION ================= */
        int totalPage = (int) Math.ceil((double) totalRecord / pageSize);

        String requestURL = request.getRequestURL().toString();
        pageControl.setUrlPattern(
                requestURL
                + "?minSalary=" + minSalary
                + "&maxSalary=" + maxSalary
                + "&search=" + search
                + "&currency=" + currency
                + "&postedDate=" + postedDate
                + "&closingDate=" + closingDate
                + "&location=" + location
                + "&"
        );

        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);

        /* ================= SET ATTRIBUTE ================= */
        request.setAttribute("jobPostingsList", jobPostingsList);
        request.setAttribute("pageControl", pageControl);
        request.setAttribute("activeCategories", activeCategories);

        /* ================= FORWARD ================= */
        request.getRequestDispatcher("view/user/userHome.jsp").forward(request, response);
    }

    /* ================= HELPER ================= */
    private String getParam(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value == null ? "" : value.trim();
    }
}
