package controller.admin;

import dao.AccountDAO;
import dao.CompanyDAO;
import dao.JobPostingsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.JobPostings;

@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

    AccountDAO accDao = new AccountDAO();
    CompanyDAO companyDao = new CompanyDAO();
    JobPostingsDAO jobPostingDao = new JobPostingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy date filter parameters
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        
        // Kiểm tra xem có filter theo date không
        boolean hasDateFilter = (startDate != null && !startDate.isEmpty() && 
                                 endDate != null && !endDate.isEmpty());
        
        // Get seeker statistics with date filter
        int totalSeeker, totalSeekerActive, totalSeekerInactive;
        int totalRecruiter, totalRecruiterActive, totalRecruiterInactive;
        
        if (hasDateFilter) {
            // Lọc theo date range
            totalSeeker = accDao.findAllTotalRecordByDateRange(3, startDate, endDate);
            totalSeekerActive = accDao.findTotalRecordByStatusAndDateRange(true, 3, startDate, endDate);
            totalSeekerInactive = accDao.findTotalRecordByStatusAndDateRange(false, 3, startDate, endDate);
            
            totalRecruiter = accDao.findAllTotalRecordByDateRange(2, startDate, endDate);
            totalRecruiterActive = accDao.findTotalRecordByStatusAndDateRange(true, 2, startDate, endDate);
            totalRecruiterInactive = accDao.findTotalRecordByStatusAndDateRange(false, 2, startDate, endDate);
        } else {
            // Không lọc - lấy tất cả
            totalSeeker = accDao.findAllTotalRecord(3);
            totalSeekerActive = accDao.findTotalRecordByStatus(true, 3);
            totalSeekerInactive = accDao.findTotalRecordByStatus(false, 3);
            
            totalRecruiter = accDao.findAllTotalRecord(2);
            totalRecruiterActive = accDao.findTotalRecordByStatus(true, 2);
            totalRecruiterInactive = accDao.findTotalRecordByStatus(false, 2);
        }
        
        //set vao request
        request.setAttribute("totalSeeker", totalSeeker);
        request.setAttribute("totalSeekerActive", totalSeekerActive);
        request.setAttribute("totalSeekerInactive", totalSeekerInactive);
        request.setAttribute("totalRecruiter", totalRecruiter);
        request.setAttribute("totalRecruiterActive", totalRecruiterActive);
        request.setAttribute("totalRecruiterInactive", totalRecruiterInactive);

        // Lấy danh sách JobPostings - SỬ DỤNG DATE FILTER
        List<JobPostings> jobPostingsList;
        if (hasDateFilter) {
            jobPostingsList = jobPostingDao.findTop5Recruiter(startDate, endDate);
        } else {
            jobPostingsList = jobPostingDao.findTop5Recruiter();
        }

        // Tạo một Map để đếm số lượng bài đăng cho từng RecruiterID
        Map<Integer, Integer> recruiterPostCount = new HashMap<>();
        for (JobPostings posting : jobPostingsList) {
            int recruiterId = posting.getRecruiterID();
            recruiterPostCount.put(recruiterId, recruiterPostCount.getOrDefault(recruiterId, 0) + 1);
        }
        request.setAttribute("recruiterPostCount", recruiterPostCount);

        // Lấy job posting status - SỬ DỤNG DATE FILTER
        List<JobPostings> jobPostingsListFilter;
        if (hasDateFilter) {
            jobPostingsListFilter = jobPostingDao.filterJobPostingStatusForChart(startDate, endDate);
        } else {
            jobPostingsListFilter = jobPostingDao.filterJobPostingStatusForChart();
        }

        // Đếm số lượng job postings theo từng trạng thái
        Map<String, Integer> jobPostingStatusData = new HashMap<>();
        jobPostingStatusData.put("Open", 0);
        jobPostingStatusData.put("Closed", 0);
        jobPostingStatusData.put("Violate", 0);

        for (JobPostings jobPosting : jobPostingsListFilter) {
            String status = jobPosting.getStatus();
            jobPostingStatusData.put(status, jobPostingStatusData.getOrDefault(status, 0) + 1);
        }

        request.setAttribute("jobPostingStatusData", jobPostingStatusData);
        
        //chuyen trang
        request.getRequestDispatcher("view/admin/adminHome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST to GET to handle uniformly
        doGet(request, response);
    }
}