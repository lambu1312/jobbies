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

        // 1. Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/authen?action=login");
            return;
        }

        // Khởi tạo các danh sách mặc định là rỗng để tránh lỗi null
        List<JobPostings> jobPostings = new ArrayList<>();
        List<Interview> allInterviews = new ArrayList<>();

        try {
            RecruitersDAO recruitersDAO = new RecruitersDAO();
            Recruiters recruiter = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));

            // 2. Logic xử lý dữ liệu
            if (recruiter == null) {
                // TRƯỜNG HỢP: Tài khoản mới, chưa có profile Recruiter
                // Không redirect nữa, chỉ để danh sách rỗng và thông báo.
                request.setAttribute("message", "Chưa có dữ liệu nhà tuyển dụng hoặc chưa có cuộc phỏng vấn nào.");
            } else {
                // TRƯỜNG HỢP: Đã là Recruiter

                // Kiểm tra thông tin công ty (giữ lại logic này nếu bạn muốn bắt buộc có công ty mới xem được)
                if (recruiter.getCompanyID() <= 0) {
                    request.setAttribute("message", "Bạn cần phải đăng ký thông tin công ty trước khi thực hiện thao tác này.");
                    request.getRequestDispatcher("view/recruiter/createCompany.jsp").forward(request, response);
                    return;
                }

                JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
                ApplicationDAO applicationDAO = new ApplicationDAO();
                InterviewDAO interviewDAO = new InterviewDAO();

                // Lấy danh sách bài đăng
                jobPostings = jobPostingsDAO.findJobPostingbyRecruitersID(recruiter.getRecruiterID());

                // Lấy danh sách phỏng vấn
                for (JobPostings job : jobPostings) {
                    List<Interview> interviews = interviewDAO.getInterviewsByJobPostingId(job.getJobPostingID());
                    allInterviews.addAll(interviews);
                }

                // Lấy chi tiết Application cho từng cuộc phỏng vấn
                for (Interview interview : allInterviews) {
                    try {
                        Applications app = applicationDAO.getDetailApplication(interview.getApplicationID());
                        if (app != null) {
                            JobPostings jobPosting = jobPostingsDAO.findJobPostingById(app.getJobPostingID());
                            app.setJobPostings(jobPosting);
                            interview.setApplication(app);
                        }
                    } catch (Exception e) {
                        System.err.println("Error loading application details: " + e.getMessage());
                    }
                }
            }

            // 3. Logic Lọc (Filter) - Vẫn chạy bình thường dù list rỗng
            String statusFilter = request.getParameter("statusFilter");
            String searchName = request.getParameter("searchName");
            String dateFilter = request.getParameter("dateFilter");
            String jobFilter = request.getParameter("jobFilter");

            List<Interview> filteredInterviews = new ArrayList<>();

            // Nếu danh sách allInterviews rỗng (do recruiter null hoặc chưa có data), vòng lặp này sẽ không chạy
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
                    String interviewDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(interview.getInterviewDate());
                    if (!interviewDateStr.equals(dateFilter)) {
                        match = false;
                    }
                }

                if (match) {
                    filteredInterviews.add(interview);
                }
            }

            // 4. Phân trang
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
            // Nếu totalRecords = 0, totalPages sẽ là 0
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            if (totalPages == 0) {
                totalPages = 1; // Đảm bảo ít nhất là trang 1 để không lỗi giao diện
            }
            int startIndex = (page - 1) * recordsPerPage;
            int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

            List<Interview> paginatedInterviews = new ArrayList<>();
            if (startIndex < totalRecords) {
                paginatedInterviews = filteredInterviews.subList(startIndex, endIndex);
            }

            // Nếu chưa có phỏng vấn nào và chưa set message ở trên, set message mặc định
            if (paginatedInterviews.isEmpty() && request.getAttribute("message") == null) {
                request.setAttribute("message", "Chưa có cuộc phỏng vấn nào.");
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
            // Fallback an toàn nếu có lỗi hệ thống
            request.setAttribute("interviews", new ArrayList<>());
            request.setAttribute("message", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("view/recruiter/interviewManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
