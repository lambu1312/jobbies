package controller.recruiter;

import dao.Job_Posting_CategoryDAO;
import dao.JobPostingsDAO;
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
import constant.CommonConst;
import model.Account;
import model.JobPostings;
import model.Job_Posting_Category;
import model.Recruiters;
import dao.RecruitersDAO;
import dao.CompanyDAO;
import model.Company;

@WebServlet(name = "AddJobPosting", urlPatterns = {"/AddJobPosting"})
public class AddJobPosting extends HttpServlet {
    Job_Posting_CategoryDAO categoryDAO = new Job_Posting_CategoryDAO();
    JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
    RecruitersDAO recruitersDAO = new RecruitersDAO();
    CompanyDAO companyDAO = new CompanyDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục từ cơ sở dữ liệu
        List<Job_Posting_Category> categories = categoryDAO.findAll();
        // Đặt danh sách này vào attribute để JSP có thể truy cập
        request.setAttribute("jobCategories", categories);
        // Chuyển hướng tới trang JSP
        request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ✅ NHẬN LƯƠNG DƯỚI DẠNG STRING - KHÔNG PARSE THÀNH DOUBLE/FLOAT
        String minSalaryStr = request.getParameter("minSalary");
        String maxSalaryStr = request.getParameter("maxSalary");
        Long minSalary = null;
        Long maxSalary = null;
        
        // Các field khác
        String jobTitle = request.getParameter("jobTitle");
        String jobDescription = request.getParameter("jobDescription");
        String jobRequirements = request.getParameter("jobRequirements");
        String currency = request.getParameter("currency");
        String jobLocation = request.getParameter("jobLocation");
        String jobStatus = request.getParameter("jobStatus");
        String postedDate = request.getParameter("postedDate");
        String closingDate = request.getParameter("closingDate");
        String jobCategoryId = request.getParameter("jobCategory");
        String jobPathAgreement = request.getParameter("jobPathAgreement");
        
        // Danh sách lỗi
        List<String> errors = new ArrayList<>();
        
        // ===== VALIDATE LƯƠNG =====
        if (minSalaryStr == null || minSalaryStr.trim().isEmpty()) {
            errors.add("Lương tối thiểu không được để trống");
        } else if (!minSalaryStr.matches("\\d+")) {
            errors.add("Lương tối thiểu chỉ được chứa số");
        } else {
            try {
                minSalary = Long.parseLong(minSalaryStr);
            } catch (NumberFormatException e) {
                errors.add("Lương tối thiểu không hợp lệ");
            }
        }
        
        if (maxSalaryStr == null || maxSalaryStr.trim().isEmpty()) {
            errors.add("Lương tối đa không được để trống");
        } else if (!maxSalaryStr.matches("\\d+")) {
            errors.add("Lương tối đa chỉ được chứa số");
        } else {
            try {
                maxSalary = Long.parseLong(maxSalaryStr);
            } catch (NumberFormatException e) {
                errors.add("Lương tối đa không hợp lệ");
            }
        }
        
        // Kiểm tra minSalary <= maxSalary
        if (minSalary != null && maxSalary != null && minSalary > maxSalary) {
            errors.add("Lương tối thiểu không được vượt quá lương tối đa");
        }
        
        // ===== VALIDATE CÁC FIELD KHÁC =====
        if (jobTitle == null || jobTitle.trim().isEmpty()) {
            errors.add("Tiêu đề công việc không được để trống");
        }
        
        if (jobDescription == null || jobDescription.trim().isEmpty()) {
            errors.add("Mô tả công việc không được để trống");
        }
        
        if (jobRequirements == null || jobRequirements.trim().isEmpty()) {
            errors.add("Yêu cầu công việc không được để trống");
        }
        
        if (jobLocation == null || jobLocation.trim().isEmpty()) {
            errors.add("Địa điểm không được để trống");
        }
        
        if (jobCategoryId == null || jobCategoryId.trim().isEmpty()) {
            errors.add("Danh mục công việc không được để trống");
        }
        
        if (jobPathAgreement == null) {
            errors.add("Bạn phải đồng ý với điều khoản dịch vụ");
        }
        
        // Nếu có lỗi, trả về form với thông báo lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("erMess", errors);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("minSalary", minSalaryStr);      // ✅ String
            request.setAttribute("maxSalary", maxSalaryStr);      // ✅ String
            request.setAttribute("currency", currency);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("jobStatus", jobStatus);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("selectedJobCategory", jobCategoryId);
            
            List<Job_Posting_Category> categories = categoryDAO.findAll();
            request.setAttribute("jobCategories", categories);
            
            request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
            return;
        }
        
        // ===== LƯỚI DỮ LIỆU VÀO DATABASE =====
        try {
            // Lấy account từ session
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
            
            if (account == null) {
                errors.add("Vui lòng đăng nhập");
                request.setAttribute("erMess", errors);
                request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
                return;
            }
            
            // Lấy recruiter info
            Recruiters recruiter = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
            
            if (recruiter == null) {
                errors.add("Không tìm thấy thông tin tuyển dụng viên");
                request.setAttribute("erMess", errors);
                request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
                return;
            }
            
            // Tạo JobPosting object
            JobPostings jobPosting = new JobPostings();
            jobPosting.setRecruiterID(recruiter.getRecruiterID());
            jobPosting.setTitle(jobTitle);
            jobPosting.setDescription(jobDescription);
            jobPosting.setRequirements(jobRequirements);
            jobPosting.setMinSalary(minSalary);      // ✅ Long
            jobPosting.setMaxSalary(maxSalary);      // ✅ Long
            jobPosting.setCurrency(currency != null && !currency.isEmpty() ? currency : "USD");
            jobPosting.setLocation(jobLocation);
            jobPosting.setStatus(jobStatus != null && !jobStatus.isEmpty() ? jobStatus : "Open");
            jobPosting.setPostedDate(Date.valueOf(postedDate));
            jobPosting.setClosingDate(Date.valueOf(closingDate));
            jobPosting.setJob_Posting_CategoryID(Integer.parseInt(jobCategoryId));
            
            // Lưu vào database
            int result = jobPostingsDAO.insert(jobPosting);
            
            if (result > 0) {
                request.setAttribute("successPost", "✅ Bài đăng công việc được thêm thành công!");
                
                // Lấy danh sách categories để hiển thị lại
                List<Job_Posting_Category> categories = categoryDAO.findAll();
                request.setAttribute("jobCategories", categories);
                
                // Reset form
                request.setAttribute("jobTitle", "");
                request.setAttribute("jobDescription", "");
                request.setAttribute("jobRequirements", "");
                request.setAttribute("minSalary", "");
                request.setAttribute("maxSalary", "");
                request.setAttribute("currency", "VND");
                request.setAttribute("jobLocation", "");
                request.setAttribute("jobStatus", "Open");
                request.setAttribute("postedDate", "");
                request.setAttribute("closingDate", "");
                request.setAttribute("selectedJobCategory", "");
            } else {
                errors.add("❌ Lỗi khi lưu dữ liệu vào database");
                request.setAttribute("erMess", errors);
            }
            
            request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
            
        } catch (IllegalArgumentException e) {
            errors.add("❌ Định dạng ngày tháng không hợp lệ. Vui lòng kiểm tra lại");
            request.setAttribute("erMess", errors);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("minSalary", minSalaryStr);
            request.setAttribute("maxSalary", maxSalaryStr);
            request.setAttribute("currency", currency);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("jobStatus", jobStatus);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("selectedJobCategory", jobCategoryId);
            
            List<Job_Posting_Category> categories = categoryDAO.findAll();
            request.setAttribute("jobCategories", categories);
            
            request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            errors.add("❌ Lỗi lưu dữ liệu: " + e.getMessage());
            request.setAttribute("erMess", errors);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("jobRequirements", jobRequirements);
            request.setAttribute("minSalary", minSalaryStr);
            request.setAttribute("maxSalary", maxSalaryStr);
            request.setAttribute("currency", currency);
            request.setAttribute("jobLocation", jobLocation);
            request.setAttribute("jobStatus", jobStatus);
            request.setAttribute("postedDate", postedDate);
            request.setAttribute("closingDate", closingDate);
            request.setAttribute("selectedJobCategory", jobCategoryId);
            
            List<Job_Posting_Category> categories = categoryDAO.findAll();
            request.setAttribute("jobCategories", categories);
            
            request.getRequestDispatcher("view/recruiter/addJobPosting.jsp").forward(request, response);
        }
    }
}