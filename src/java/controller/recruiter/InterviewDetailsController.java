package controller.recruiter;

import dao.ApplicationDAO;
import dao.InterviewDAO;
import dao.JobPostingsDAO;
import java.io.IOException;
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

@WebServlet(name = "InterviewDetailsController", urlPatterns = {"/interviewDetails"})
public class InterviewDetailsController extends HttpServlet {

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
            String interviewIdParam = request.getParameter("interviewId");
            System.out.println("DEBUG: interviewId parameter = " + interviewIdParam);
            
            if (interviewIdParam == null || interviewIdParam.isEmpty()) {
                System.err.println("ERROR: interviewId parameter is null or empty");
                response.sendRedirect(request.getContextPath() + "/interviewManagement");
                return;
            }
            
            int interviewId = Integer.parseInt(interviewIdParam);
            System.out.println("DEBUG: Parsed interviewId = " + interviewId);
            
            InterviewDAO interviewDAO = new InterviewDAO();
            ApplicationDAO applicationDAO = new ApplicationDAO();
            JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
            
            // Get interview details
            Interview interview = interviewDAO.getInterviewById(interviewId);
            System.out.println("DEBUG: Interview from DB = " + (interview != null ? "Found" : "NULL"));
            
            if (interview == null) {
                System.err.println("ERROR: Interview not found for ID = " + interviewId);
                response.sendRedirect(request.getContextPath() + "/interviewManagement");
                return;
            }
            
            // Get application details
            Applications application = applicationDAO.getDetailApplication(interview.getApplicationID());
            if (application != null) {
                // Load job posting
                JobPostings jobPosting = jobPostingsDAO.findJobPostingById(application.getJobPostingID());
                application.setJobPostings(jobPosting);
                interview.setApplication(application);
            }
            
            request.setAttribute("interview", interview);
            System.out.println("DEBUG: Forwarding to interviewDetails.jsp");
            request.getRequestDispatcher("view/recruiter/interviewDetails.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid interviewId format - " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/interviewManagement");
        } catch (Exception e) {
            System.err.println("ERROR: Exception in InterviewDetailsController - " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/interviewManagement");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
