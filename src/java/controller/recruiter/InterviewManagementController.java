package controller.recruiter;

import dao.InterviewDAO;
import dao.ApplicationDAO;
import dao.JobPostingsDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Applications;
import model.Interview;
import model.JobPostings;
import model.Recruiters;

@WebServlet(name = "InterviewManagementController", urlPatterns = {"/interviewManagement"})
public class InterviewManagementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        try {
            RecruitersDAO recruitersDAO = new RecruitersDAO();
            Recruiters recruiter = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));

            if (recruiter == null) {
                System.err.println("Recruiter not found for account ID: " + account.getId());
                response.sendRedirect(request.getContextPath() + "/recruiterDashboard");
                return;
            }

            // --- ĐOẠN CODE THÊM MỚI KIỂM TRA CÔNG TY ---
            // Kiểm tra xem recruiter đã thuộc về công ty nào chưa (giả sử trường là getCompanyID())
            if (recruiter.getCompanyID() <= 0) {
                request.setAttribute("message", "Bạn cần phải đăng ký thông tin công ty trước khi thực hiện thao tác này.");
                request.getRequestDispatcher("view/recruiter/createCompany.jsp").forward(request, response);
                return;
            }

            JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
            ApplicationDAO applicationDAO = new ApplicationDAO();
            InterviewDAO interviewDAO = new InterviewDAO();

            // Get all job postings by recruiter
            List<JobPostings> jobPostings = jobPostingsDAO.findJobPostingbyRecruitersID(recruiter.getRecruiterID());

            // Get all interviews for recruiter's job postings
            List<Interview> allInterviews = new ArrayList<>();

            for (JobPostings job : jobPostings) {
                List<Interview> interviews = interviewDAO.getInterviewsByJobPostingId(job.getJobPostingID());
                allInterviews.addAll(interviews);
            }

            // Get application details for each interview
            for (Interview interview : allInterviews) {
                try {
                    Applications app = applicationDAO.getDetailApplication(interview.getApplicationID());
                    if (app != null) {
                        // Load job posting for the application
                        JobPostings jobPosting = jobPostingsDAO.findJobPostingById(app.getJobPostingID());
                        app.setJobPostings(jobPosting);
                        interview.setApplication(app);
                    }
                } catch (Exception e) {
                    System.err.println("Error loading application details for interview " + interview.getInterviewID() + ": " + e.getMessage());
                    // Continue with next interview
                }
            }

            // Filter parameters
            String statusFilter = request.getParameter("statusFilter");
            String searchName = request.getParameter("searchName");
            String dateFilter = request.getParameter("dateFilter");
            String jobFilter = request.getParameter("jobFilter");

            // Apply filters
            List<Interview> filteredInterviews = new ArrayList<>();
            for (Interview interview : allInterviews) {
                Applications app = interview.getApplication();
                if (app == null || app.getJobSeeker() == null || app.getJobSeeker().getAccount() == null) {
                    continue;
                }

                boolean match = true;

                // Job Position filter
                if (jobFilter != null && !jobFilter.isEmpty() && !jobFilter.equals("all")) {
                    try {
                        int jobPostingId = Integer.parseInt(jobFilter);
                        if (app.getJobPostingID() != jobPostingId) {
                            match = false;
                        }
                    } catch (NumberFormatException e) {
                        // Invalid job filter, skip this filter
                    }
                }

                // Status filter
                if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
                    if (!interview.getStatus().equalsIgnoreCase(statusFilter)) {
                        match = false;
                    }
                }

                // Name search
                if (searchName != null && !searchName.trim().isEmpty()) {
                    String seekerName = app.getJobSeeker().getAccount().getFullName().toLowerCase();
                    if (!seekerName.contains(searchName.toLowerCase().trim())) {
                        match = false;
                    }
                }

                // Date filter
                if (dateFilter != null && !dateFilter.isEmpty()) {
                    String interviewDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd")
                            .format(interview.getInterviewDate());
                    if (!interviewDateStr.equals(dateFilter)) {
                        match = false;
                    }
                }

                if (match) {
                    filteredInterviews.add(interview);
                }
            }

            // Pagination
            int page = 1;
            int recordsPerPage = 10;
            try {
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }

            int totalRecords = filteredInterviews.size();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            int startIndex = (page - 1) * recordsPerPage;
            int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

            List<Interview> paginatedInterviews = new ArrayList<>();
            if (startIndex < totalRecords) {
                paginatedInterviews = filteredInterviews.subList(startIndex, endIndex);
            }

            request.setAttribute("interviews", paginatedInterviews);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("allJobPostings", jobPostings);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchName", searchName);
            request.setAttribute("dateFilter", dateFilter);
            request.setAttribute("jobFilter", jobFilter);

            request.getRequestDispatcher("view/recruiter/interviewManagement.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in InterviewManagementController: " + e.getMessage());
            request.setAttribute("interviews", new ArrayList<>());
            request.setAttribute("allJobPostings", new ArrayList<>());
            request.getRequestDispatcher("view/recruiter/interviewManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
