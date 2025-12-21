package controller.recruiter;

import constant.CommonConst;
import dao.ApplicationDAO;
import dao.CompanyDAO;
import dao.JobPostingsDAO;
import dao.JobSeekerDAO;
import dao.Job_Posting_CategoryDAO;
import dao.RecruitersDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Company;
import model.JobPostings;
import model.Job_Posting_Category;
import model.Recruiters;
import validate.Validation;

@WebServlet(name = "JobPost", urlPatterns = {"/jobPost"})
public class JobPost extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    RecruitersDAO recruitersDAO = new RecruitersDAO();
    Validation valid = new Validation();
    Job_Posting_CategoryDAO category = new Job_Posting_CategoryDAO();
    CompanyDAO cdao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        if (account == null) {
            response.sendRedirect("view/authen/login.jsp");
            return;
        }

        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiters == null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/verifyRecruiter.jsp");
            dispatcher.forward(request, response);
        } else {
            Company company = cdao.findCompanyById(recruiters.getCompanyID());
            if (company == null || !company.isVerificationStatus() || !recruiters.isIsVerify()) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/verifyRecruiter.jsp");
                dispatcher.forward(request, response);
            } else {
                String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
                String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 10;
                List jobList;
                int totalRecords;

                if (!searchJP.isEmpty()) {
                    jobList = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
                    totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());
                    if (jobList.isEmpty()) {
                        request.setAttribute("NoJP", "Không tìm thấy");
                    }
                } else {
                    jobList = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
                    totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());
                }

                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                request.setAttribute("listJobPosting", jobList);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", page);
                request.setAttribute("sortField", sortField);
                request.setAttribute("searchJP", searchJP);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/recruiter/jobPost-manager.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "add-jp":
                url = addJobPosting(request, response);
                break;
            case "updateJobPost":
                url = updateJP(request, response);
                break;
            default:
                url = "view/recruiter/jobPost-manager.jsp";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String addJobPosting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        if (account == null) {
            return "view/authen/login.jsp";
        }

        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiters == null) {
            return "view/authen/login.jsp";
        }

        try {
            String jobTitle = request.getParameter("jobTitle");
            String jobDescription = request.getParameter("jobDescription");
            String jobRequirements = request.getParameter("jobRequirements");
            String jobLocation = request.getParameter("jobLocation");
            String minSalaryStr = request.getParameter("minSalary");
            String maxSalaryStr = request.getParameter("maxSalary");
            Long minSalary = null;
            Long maxSalary = null;
            String currency = request.getParameter("currency");
            String jobStatus = request.getParameter("jobStatus");
            String jobCategory = request.getParameter("jobCategory");

            Date postedDate = null;
            Date closingDate = null;
            try {
                postedDate = Date.valueOf(request.getParameter("postedDate"));
                closingDate = Date.valueOf(request.getParameter("closingDate"));
            } catch (IllegalArgumentException e) {
                // Để xử lý lỗi date sau
            }

            request.setAttribute("selectedJobCategory", jobCategory);
            List jobCategories = category.findAll();
            request.setAttribute("jobCategories", jobCategories);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("minSalary", minSalaryStr);
            request.setAttribute("maxSalary", maxSalaryStr);
            request.setAttribute("currency", currency);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("jobStatus", jobStatus);

            List erMess = new ArrayList<>();

            if (jobCategory == null || jobCategory.trim().isEmpty()) {
                erMess.add("Vui lòng chọn danh mục công việc");
            }

            if (!valid.checkAtLeast30Chars(jobDescription)) {
                erMess.add("Mô tả quá ngắn");
            }

            if (!valid.checkAtLeast30Chars(jobRequirements)) {
                erMess.add("Yêu cầu quá ngắn");
            }

            if (!valid.isValidDateRange(postedDate) || !valid.isValidDateRange(closingDate)) {
                erMess.add("Ngày phải nằm trong khoảng từ 1990 đến 2500");
            }

            if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
                erMess.add("Ngày đóng phải sau ngày đăng");
            }

            if (!valid.isToday(postedDate)) {
                erMess.add("Ngày đăng phải là ngày hiện tại");
            }

            // KIỂM TRA LƯƠNG
            if (minSalaryStr == null || minSalaryStr.trim().isEmpty()) {
                erMess.add("Mức lương tối thiểu là bắt buộc");
            } else if (!minSalaryStr.matches("\\d+")) {
                erMess.add("Mức lương tối thiểu phải là một số");
            } else {
                try {
                    minSalary = Long.parseLong(minSalaryStr);
                } catch (NumberFormatException e) {
                    erMess.add("Mức lương tối thiểu không hợp lệ");
                }
            }

            if (maxSalaryStr == null || maxSalaryStr.trim().isEmpty()) {
                erMess.add("Mức lương tối đa là bắt buộc");
            } else if (!maxSalaryStr.matches("\\d+")) {
                erMess.add("Mức lương tối đa phải là một số");
            } else {
                try {
                    maxSalary = Long.parseLong(maxSalaryStr);
                } catch (NumberFormatException e) {
                    erMess.add("Mức lương tối đa không hợp lệ");
                }
            }

            if (minSalary != null && maxSalary != null && minSalary > maxSalary) {
                erMess.add("Mức lương tối thiểu không thể vượt quá mức lương tối đa");
            }

            if (!erMess.isEmpty()) {
                request.setAttribute("erMess", erMess);
                url = "view/recruiter/addJobPosting.jsp";
            } else {
                JobPostings jobPost = new JobPostings();
                int jobCategoryId = Integer.parseInt(jobCategory);
                jobPost.setJob_Posting_CategoryID(jobCategoryId);
                jobPost.setRecruiterID(recruiters.getRecruiterID());
                jobPost.setTitle(jobTitle);
                jobPost.setDescription(jobDescription);
                jobPost.setRequirements(jobRequirements);
                jobPost.setLocation(jobLocation);
                jobPost.setMinSalary(minSalary);
                jobPost.setMaxSalary(maxSalary);
                jobPost.setCurrency(currency != null && !currency.isEmpty() ? currency : "USD");
                jobPost.setStatus(jobStatus);
                jobPost.setPostedDate(postedDate);
                jobPost.setClosingDate(closingDate);
                dao.insert(jobPost);

                String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
                String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 10;
                List jobList;
                int totalRecords;

                if (!searchJP.isEmpty()) {
                    jobList = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
                    totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());
                } else {
                    jobList = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
                    totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());
                }

                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                request.setAttribute("listJobPosting", jobList);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", page);
                request.setAttribute("sortField", sortField);
                request.setAttribute("searchJP", searchJP);
                url = "view/recruiter/jobPost-manager.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            List erMess = new ArrayList<>();
            erMess.add("Đã xảy ra lỗi khi thêm bài đăng công việc: " + e.getMessage());
            request.setAttribute("erMess", erMess);
            url = "view/recruiter/addJobPosting.jsp";
        }
        return url;
    }

    private String updateJP(HttpServletRequest request, HttpServletResponse response) {
        String url;
        int idJP = Integer.parseInt(request.getParameter("JobPostingID"));
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        if (account == null) {
            return "view/authen/login.jsp";
        }

        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiters == null) {
            return "view/authen/login.jsp";
        }

        JobPostings jobPost = dao.findJobPostingById(idJP);
        request.setAttribute("selectedJobCategory", jobPost.getJob_Posting_CategoryID());

        String jobTitle = request.getParameter("jobTitle");
        String jobDescription = request.getParameter("jobDescription");
        String jobRequirements = request.getParameter("jobRequirements");
        String jobLocation = request.getParameter("jobLocation");
        String minSalaryStr = request.getParameter("minSalary");
        String maxSalaryStr = request.getParameter("maxSalary");
        Long minSalary = null;
        Long maxSalary = null;
        String currency = request.getParameter("currency");
        String jobStatus = request.getParameter("jobStatus");
        Date postedDate = Date.valueOf(request.getParameter("postedDate"));
        Date closingDate = Date.valueOf(request.getParameter("closingDate"));
        String jobCategoryIdStr = request.getParameter("jobCategory");
        int jobCategoryId = Integer.parseInt(jobCategoryIdStr);
        jobPost.setJob_Posting_CategoryID(jobCategoryId);

        List jobCategories = category.findAll();
        request.setAttribute("jobCategories", jobCategories);
        request.setAttribute("selectedJobCategory", jobCategoryIdStr);

        try {
            if (minSalaryStr != null && !minSalaryStr.isEmpty()) {
                minSalary = Long.parseLong(minSalaryStr);
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi
        }

        try {
            if (maxSalaryStr != null && !maxSalaryStr.isEmpty()) {
                maxSalary = Long.parseLong(maxSalaryStr);
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi
        }

        jobPost.setRecruiterID(recruiters.getRecruiterID());
        jobPost.setTitle(jobTitle);
        jobPost.setDescription(jobDescription);
        jobPost.setRequirements(jobRequirements);
        jobPost.setLocation(jobLocation);
        jobPost.setMinSalary(minSalary);
        jobPost.setMaxSalary(maxSalary);
        jobPost.setCurrency(currency != null && !currency.isEmpty() ? currency : "USD");
        jobPost.setStatus(jobStatus);
        jobPost.setPostedDate(postedDate);
        jobPost.setClosingDate(closingDate);

        List erMess = new ArrayList<>();

        if (!valid.checkAtLeast30Chars(jobDescription)) {
            erMess.add("Mô tả quá ngắn");
        }

        if (!valid.checkAtLeast30Chars(jobRequirements)) {
            erMess.add("Yêu cầu quá ngắn");
        }

        if (!valid.isValidDateRange(postedDate) || !valid.isValidDateRange(closingDate)) {
            erMess.add("Ngày phải nằm trong khoảng từ 1990 đến 2500");
        }

        if (!valid.isStartDateBeforeEndDate(postedDate, closingDate)) {
            erMess.add("Ngày đóng phải sau ngày đăng");
        }

        if (minSalary != null && maxSalary != null && minSalary > maxSalary) {
            erMess.add("Khoảng lương không hợp lệ");
        }

        if (!valid.isToday(postedDate)) {
            erMess.add("Ngày đăng phải là ngày hiện tại");
        }

        if (!erMess.isEmpty()) {
            request.setAttribute("eM", erMess);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("minSalary", minSalaryStr);
            request.setAttribute("maxSalary", maxSalaryStr);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("jobStatus", jobStatus);
            url = "view/recruiter/editJP.jsp";
        } else {
            dao.updateJobPosting(jobPost);
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            String sortField = request.getParameter("sort") != null ? request.getParameter("sort") : "JobPostingID";
            String searchJP = request.getParameter("searchJP") != null ? request.getParameter("searchJP") : "";
            int pageSize = 10;
            List listJobPosting;
            int totalRecords;

            if (!searchJP.isEmpty()) {
                listJobPosting = dao.searchJobPostingByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID(), page);
                totalRecords = dao.findTotalRecordByTitleAndRecruiterID(searchJP, recruiters.getRecruiterID());
            } else {
                listJobPosting = dao.findJobPostingsWithFilterAndRecruiterID(sortField, recruiters.getRecruiterID(), page, pageSize);
                totalRecords = dao.countTotalJobPostingsByRecruiterID(recruiters.getRecruiterID());
            }

            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            request.setAttribute("listJobPosting", listJobPosting);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("sortField", sortField);
            request.setAttribute("searchJP", searchJP);
            url = "view/recruiter/jobPost-manager.jsp";
        }
        return url;
    }
}
