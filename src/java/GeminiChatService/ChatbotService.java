package GeminiChatService;

import dao.JobPostingsDAO;
import dao.CompanyDAO;
import dao.AccountDAO;
import model.JobPostings;
import model.Company;
import java.util.List;
import java.util.stream.Collectors;

public class ChatbotService {
    private JobPostingsDAO jobPostingsDAO;
    private CompanyDAO companyDAO;
    private AccountDAO accountDAO;

    public ChatbotService() {
        this.jobPostingsDAO = new JobPostingsDAO();
        this.companyDAO = new CompanyDAO();
        this.accountDAO = new AccountDAO();
    }

    /**
     * Tìm kiếm công việc dựa trên từ khóa
     */
    public String searchJobs(String keyword) {
        try {
            List<JobPostings> allJobs = jobPostingsDAO.findAll();
            
            List<JobPostings> results = allJobs.stream()
                .filter(job -> job.getTitle() != null && 
                       (job.getTitle().toLowerCase().contains(keyword.toLowerCase()) ||
                        (job.getDescription() != null && job.getDescription().toLowerCase().contains(keyword.toLowerCase()))))
                .limit(5)
                .collect(Collectors.toList());

            if (results.isEmpty()) {
                return "Không tìm thấy công việc nào phù hợp với từ khóa: " + keyword;
            }

            StringBuilder sb = new StringBuilder("Các công việc phù hợp:\n");
            for (JobPostings job : results) {
                sb.append("• ").append(job.getTitle())
                  .append(" - ").append(job.getLocation())
                  .append(" (").append(job.getMinSalary()).append("-").append(job.getMaxSalary())
                  .append(" ").append(job.getCurrency()).append(")\n");
            }
            return sb.toString();
        } catch (Exception e) {
            return "Lỗi khi tìm kiếm công việc: " + e.getMessage();
        }
    }

    /**
     * Lấy thông tin công ty
     */
    public String getCompanyInfo(String companyName) {
        try {
            List<Company> allCompanies = companyDAO.findAll();
            
            Company company = allCompanies.stream()
                .filter(c -> c.getName() != null && c.getName().toLowerCase().contains(companyName.toLowerCase()))
                .findFirst()
                .orElse(null);

            if (company == null) {
                return "Không tìm thấy thông tin công ty: " + companyName;
            }

            return "Công ty: " + company.getName() + "\n" +
                   "Địa điểm: " + company.getLocation() + "\n" +
                   "Mô tả: " + (company.getDescription() != null ? company.getDescription() : "Không có thông tin");
        } catch (Exception e) {
            return "Lỗi khi lấy thông tin công ty: " + e.getMessage();
        }
    }

    /**
     * Lấy context từ database để train chatbot
     */
    public String getTrainingContext() {
        try {
            StringBuilder context = new StringBuilder();
            
            // Lấy danh sách công việc
            List<JobPostings> jobs = jobPostingsDAO.findAll();
            context.append("Danh sách công việc hiện có:\n");
            for (JobPostings job : jobs.stream().limit(10).collect(Collectors.toList())) {
                context.append("- ").append(job.getTitle()).append(" tại ").append(job.getLocation()).append("\n");
            }
            
            // Lấy danh sách công ty
            List<Company> companies = companyDAO.findAll();
            context.append("\nDanh sách công ty:\n");
            for (Company company : companies.stream().limit(10).collect(Collectors.toList())) {
                context.append("- ").append(company.getName()).append(" (").append(company.getLocation()).append(")\n");
            }
            
            return context.toString();
        } catch (Exception e) {
            return "Lỗi khi lấy context: " + e.getMessage();
        }
    }

    /**
     * Xử lý câu hỏi và tìm context liên quan
     */
    public String getContextForQuestion(String question) {
        StringBuilder context = new StringBuilder();
        
        // Nếu hỏi về công việc
        if (question.toLowerCase().contains("công việc") || 
            question.toLowerCase().contains("job") ||
            question.toLowerCase().contains("tuyển")) {
            context.append(getTrainingContext());
        }
        
        // Nếu hỏi về công ty cụ thể
        if (question.toLowerCase().contains("công ty")) {
            String[] words = question.split(" ");
            for (String word : words) {
                if (word.length() > 3) {
                    context.append(getCompanyInfo(word)).append("\n");
                }
            }
        }
        
        return context.toString();
    }
}
