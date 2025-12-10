package controller.recruiter;

import dao.ApplicationDAO;
import dao.InterviewDAO;
import dao.JobPostingsDAO;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.internet.MimeUtility;
import model.Applications;
import model.Interview;
import model.JobPostings;
import utils.Email;

@WebServlet(name = "ScheduleInterviewServlet", urlPatterns = {"/scheduleInterview"})
public class ScheduleInterviewServlet extends HttpServlet {

    private final InterviewDAO interviewDAO = new InterviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createInterview(request, response);
                    break;
                case "update":
                    updateInterview(request, response);
                    break;
                case "updateStatus":
                    updateInterviewStatus(request, response);
                    break;
                case "delete":
                    deleteInterview(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    private void createInterview(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ParseException, ServletException {
        
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String interviewDateStr = request.getParameter("interviewDate");
        String interviewTime = request.getParameter("interviewTime");
        String location = request.getParameter("location");
        String interviewType = request.getParameter("interviewType");
        String meetingLink = request.getParameter("meetingLink");
        String notes = request.getParameter("notes");
        String jobPostId = request.getParameter("jobPostId");
        String returnTo = request.getParameter("returnTo");
        
        // Parse interview date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = dateFormat.parse(interviewDateStr);
        Timestamp interviewDate = new Timestamp(date.getTime());
        
        // Get recruiter ID to check conflicts
        ApplicationDAO applicationDAO = new ApplicationDAO();
        JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
        Applications application = applicationDAO.getDetailApplication(applicationId);
        if (application != null) {
            JobPostings jobPosting = jobPostingsDAO.findJobPostingById(application.getJobPostingID());
            if (jobPosting != null) {
                int recruiterId = jobPosting.getRecruiterID();
                
                // Use jobPostingId from application if jobPostId param is null or empty
                if (jobPostId == null || jobPostId.isEmpty() || jobPostId.equals("0")) {
                    jobPostId = String.valueOf(application.getJobPostingID());
                }
                
                System.out.println("DEBUG [createInterview] - Before conflict check: jobPostId=" + jobPostId + ", returnTo=" + returnTo);
                
                // Check for conflicting interviews
                if (interviewDAO.hasConflictingInterview(recruiterId, new java.sql.Date(date.getTime()), interviewTime, null)) {
                    System.out.println("DEBUG [createInterview] - Conflict detected! Redirecting with jobPostId=" + jobPostId);
                    request.getSession().setAttribute("errorMessage", "You already have an interview scheduled within 1 hour of this time. Please choose a time slot at least 1 hour apart.");
                    if ("management".equals(returnTo)) {
                        response.sendRedirect(request.getContextPath() + "/interviewManagement");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/applicationSeekers?jobPostId=" + jobPostId);
                    }
                    return;
                }
            }
        }
        
        // Create interview object
        Interview interview = new Interview();
        interview.setApplicationID(applicationId);
        interview.setInterviewDate(interviewDate);
        interview.setInterviewTime(interviewTime);
        interview.setLocation(location);
        interview.setInterviewType(interviewType);
        interview.setMeetingLink(meetingLink);
        interview.setNotes(notes);
        interview.setStatus("Scheduled");
        
        // Save to database
        boolean success = interviewDAO.createInterview(interview);
        
        if (success) {
            // Send email notification to job seeker
            try {
                // Re-fetch application for email notification
                application = applicationDAO.getDetailApplication(applicationId);
                if (application != null && application.getJobSeeker() != null && application.getJobSeeker().getAccount() != null) {
                    String seekerEmail = application.getJobSeeker().getAccount().getEmail();
                    String seekerName = application.getJobSeeker().getAccount().getFullName();
                    
                    // Get job posting details
                    int actualJobPostId = (jobPostId != null && !jobPostId.isEmpty() && !jobPostId.equals("0")) 
                        ? Integer.parseInt(jobPostId) 
                        : application.getJobPostingID();
                    JobPostings jobPosting = jobPostingsDAO.findJobPostingById(actualJobPostId);
                    String jobTitle = jobPosting != null ? jobPosting.getTitle() : "Job Position";
                    
                    // Format date for email
                    SimpleDateFormat emailDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    String formattedDate = emailDateFormat.format(date);
                    
                    // Build email content
                    StringBuilder emailBody = new StringBuilder();
                    emailBody.append("<html><body style='font-family: Arial, sans-serif;'>");
                    emailBody.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>");
                    emailBody.append("<h2 style='color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;'>");
                    emailBody.append("<i class='fas fa-calendar-check'></i> Thông Báo Lịch Phỏng Vấn</h2>");
                    
                    emailBody.append("<p style='color: #34495e; font-size: 16px;'>Xin chào <strong>").append(seekerName).append("</strong>,</p>");
                    emailBody.append("<p style='color: #34495e;'>Chúc mừng! Hồ sơ của bạn đã được chấp nhận. Chúng tôi xin thông báo lịch phỏng vấn cho vị trí <strong style='color: #3498db;'>").append(jobTitle).append("</strong>:</p>");
                    
                    emailBody.append("<div style='background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;'>");
                    emailBody.append("<table style='width: 100%; border-collapse: collapse;'>");
                    
                    emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold; width: 40%;'>");
                    emailBody.append("<i class='fas fa-calendar'></i> Ngày phỏng vấn:</td><td style='padding: 10px; color: #2c3e50;'>");
                    emailBody.append(formattedDate).append("</td></tr>");
                    
                    emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                    emailBody.append("<i class='fas fa-clock'></i> Thời gian:</td><td style='padding: 10px; color: #2c3e50;'>");
                    emailBody.append(interviewTime).append("</td></tr>");
                    
                    emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                    emailBody.append("<i class='fas fa-video'></i> Hình thức:</td><td style='padding: 10px; color: #2c3e50;'>");
                    emailBody.append("<span style='background-color: #3498db; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px;'>");
                    emailBody.append(interviewType).append("</span></td></tr>");
                    
                    if ("Online".equals(interviewType) && meetingLink != null && !meetingLink.isEmpty()) {
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                        emailBody.append("<i class='fas fa-link'></i> Link phỏng vấn:</td><td style='padding: 10px;'>");
                        emailBody.append("<a href='").append(meetingLink).append("' style='color: #3498db; text-decoration: none;'>");
                        emailBody.append(meetingLink).append("</a></td></tr>");
                    } else if (location != null && !location.isEmpty()) {
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                        emailBody.append("<i class='fas fa-map-marker-alt'></i> Địa điểm:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append(location).append("</td></tr>");
                    }
                    
                    if (notes != null && !notes.isEmpty()) {
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold; vertical-align: top;'>");
                        emailBody.append("<i class='fas fa-sticky-note'></i> Ghi chú:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append(notes).append("</td></tr>");
                    }
                    
                    emailBody.append("</table></div>");
                    
                    emailBody.append("<div style='background-color: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0;'>");
                    emailBody.append("<p style='margin: 0; color: #856404;'><strong>Lưu ý:</strong> Vui lòng có mặt đúng giờ và chuẩn bị đầy đủ giấy tờ cần thiết. Chúc bạn may mắn!</p>");
                    emailBody.append("</div>");
                    
                    emailBody.append("<p style='color: #7f8c8d; font-size: 14px; margin-top: 30px;'>Trân trọng,<br>");
                    emailBody.append("<strong style='color: #2c3e50;'>Đội ngũ tuyển dụng</strong></p>");
                    emailBody.append("</div></body></html>");
                    
                    // Encode subject with UTF-8
                    String subject = MimeUtility.encodeText("Thông Báo Lịch Phỏng Vấn - " + jobTitle, "UTF-8", "B");
                    Email.sendEmail(seekerEmail, subject, emailBody.toString());
                    System.out.println("Interview notification email sent to: " + seekerEmail);
                }
            } catch (Exception e) {
                System.err.println("Failed to send interview notification email: " + e.getMessage());
                e.printStackTrace();
                // Continue even if email fails - interview is already created
            }
            
            if ("management".equals(returnTo)) {
                response.sendRedirect(request.getContextPath() + "/interviewManagement?success=interview_scheduled");
            } else {
                response.sendRedirect(request.getContextPath() + "/applicationSeekers?success=interview_scheduled&jobPostId=" + jobPostId);
            }
        } else {
            if ("management".equals(returnTo)) {
                response.sendRedirect(request.getContextPath() + "/interviewManagement?error=interview_failed");
            } else {
                response.sendRedirect(request.getContextPath() + "/applicationSeekers?error=interview_failed&jobPostId=" + jobPostId);
            }
        }
    }

    private void updateInterview(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ParseException, ServletException {
        
        int interviewId = Integer.parseInt(request.getParameter("interviewId"));
        String interviewDateStr = request.getParameter("interviewDate");
        String interviewTime = request.getParameter("interviewTime");
        String location = request.getParameter("location");
        String interviewType = request.getParameter("interviewType");
        String meetingLink = request.getParameter("meetingLink");
        String notes = request.getParameter("notes");
        String status = request.getParameter("status");
        String jobPostId = request.getParameter("jobPostId");
        String returnTo = request.getParameter("returnTo");
        
        // Parse interview date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = dateFormat.parse(interviewDateStr);
        Timestamp interviewDate = new Timestamp(date.getTime());
        
        // Get existing interview
        Interview interview = interviewDAO.getInterviewById(interviewId);
        if (interview != null) {
            // Check for conflicting interviews (excluding current interview)
            ApplicationDAO applicationDAO = new ApplicationDAO();
            JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
            Applications application = applicationDAO.getDetailApplication(interview.getApplicationID());
            if (application != null) {
                JobPostings jobPosting = jobPostingsDAO.findJobPostingById(application.getJobPostingID());
                if (jobPosting != null) {
                    int recruiterId = jobPosting.getRecruiterID();
                    
                    // Use jobPostingId from application if jobPostId param is null or empty
                    if (jobPostId == null || jobPostId.isEmpty() || jobPostId.equals("0")) {
                        jobPostId = String.valueOf(application.getJobPostingID());
                    }
                    
                    System.out.println("DEBUG [updateInterview] - Before conflict check: jobPostId=" + jobPostId + ", returnTo=" + returnTo);
                    
                    if (interviewDAO.hasConflictingInterview(recruiterId, new java.sql.Date(date.getTime()), interviewTime, interviewId)) {
                        System.out.println("DEBUG [updateInterview] - Conflict detected! Redirecting with jobPostId=" + jobPostId);
                        request.getSession().setAttribute("errorMessage", "You already have an interview scheduled within 1 hour of this time. Please choose a time slot at least 1 hour apart.");
                        if ("management".equals(returnTo)) {
                            response.sendRedirect(request.getContextPath() + "/interviewManagement");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/applicationSeekers?jobPostId=" + jobPostId);
                        }
                        return;
                    }
                }
            }
            
            interview.setInterviewDate(interviewDate);
            interview.setInterviewTime(interviewTime);
            interview.setLocation(location);
            interview.setInterviewType(interviewType);
            interview.setMeetingLink(meetingLink);
            interview.setNotes(notes);
            interview.setStatus(status);
            
            boolean success = interviewDAO.updateInterview(interview);
            
            if (success) {
                // Send email notification about interview update
                try {
                    // Re-fetch application for email notification
                    application = applicationDAO.getDetailApplication(interview.getApplicationID());
                    if (application != null && application.getJobSeeker() != null && application.getJobSeeker().getAccount() != null) {
                        String seekerEmail = application.getJobSeeker().getAccount().getEmail();
                        String seekerName = application.getJobSeeker().getAccount().getFullName();
                        
                        // Get job posting for email
                        int jobPostingIdForEmail = (jobPostId != null && !jobPostId.isEmpty() && !jobPostId.equals("0")) 
                                                    ? Integer.parseInt(jobPostId) 
                                                    : application.getJobPostingID();
                        JobPostings jobPosting = jobPostingsDAO.findJobPostingById(jobPostingIdForEmail);
                        String jobTitle = jobPosting != null ? jobPosting.getTitle() : "Job Position";
                        
                        SimpleDateFormat emailDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                        String formattedDate = emailDateFormat.format(date);
                        
                        StringBuilder emailBody = new StringBuilder();
                        emailBody.append("<html><body style='font-family: Arial, sans-serif;'>");
                        emailBody.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>");
                        emailBody.append("<h2 style='color: #2c3e50; border-bottom: 2px solid #f39c12; padding-bottom: 10px;'>");
                        emailBody.append("<i class='fas fa-calendar-edit'></i> Cập Nhật Lịch Phỏng Vấn</h2>");
                        
                        emailBody.append("<p style='color: #34495e; font-size: 16px;'>Xin chào <strong>").append(seekerName).append("</strong>,</p>");
                        emailBody.append("<p style='color: #34495e;'>Lịch phỏng vấn của bạn cho vị trí <strong style='color: #f39c12;'>").append(jobTitle).append("</strong> đã được cập nhật:</p>");
                        
                        emailBody.append("<div style='background-color: #fff3cd; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #f39c12;'>");
                        emailBody.append("<table style='width: 100%; border-collapse: collapse;'>");
                        
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold; width: 40%;'>");
                        emailBody.append("<i class='fas fa-calendar'></i> Ngày phỏng vấn:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append(formattedDate).append("</td></tr>");
                        
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                        emailBody.append("<i class='fas fa-clock'></i> Thời gian:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append(interviewTime).append("</td></tr>");
                        
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                        emailBody.append("<i class='fas fa-video'></i> Hình thức:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append("<span style='background-color: #f39c12; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px;'>");
                        emailBody.append(interviewType).append("</span></td></tr>");
                        
                        emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                        emailBody.append("<i class='fas fa-info-circle'></i> Trạng thái:</td><td style='padding: 10px; color: #2c3e50;'>");
                        emailBody.append("<span style='background-color: ");
                        if ("Completed".equals(status)) emailBody.append("#28a745");
                        else if ("Cancelled".equals(status)) emailBody.append("#dc3545");
                        else if ("Rescheduled".equals(status)) emailBody.append("#ffc107");
                        else emailBody.append("#17a2b8");
                        emailBody.append("; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px;'>");
                        emailBody.append(status).append("</span></td></tr>");
                        
                        if ("Online".equals(interviewType) && meetingLink != null && !meetingLink.isEmpty()) {
                            emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                            emailBody.append("<i class='fas fa-link'></i> Link phỏng vấn:</td><td style='padding: 10px;'>");
                            emailBody.append("<a href='").append(meetingLink).append("' style='color: #f39c12; text-decoration: none;'>");
                            emailBody.append(meetingLink).append("</a></td></tr>");
                        } else if (location != null && !location.isEmpty()) {
                            emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold;'>");
                            emailBody.append("<i class='fas fa-map-marker-alt'></i> Địa điểm:</td><td style='padding: 10px; color: #2c3e50;'>");
                            emailBody.append(location).append("</td></tr>");
                        }
                        
                        if (notes != null && !notes.isEmpty()) {
                            emailBody.append("<tr><td style='padding: 10px; color: #7f8c8d; font-weight: bold; vertical-align: top;'>");
                            emailBody.append("<i class='fas fa-sticky-note'></i> Ghi chú:</td><td style='padding: 10px; color: #2c3e50;'>");
                            emailBody.append(notes).append("</td></tr>");
                        }
                        
                        emailBody.append("</table></div>");
                        
                        emailBody.append("<p style='color: #7f8c8d; font-size: 14px; margin-top: 30px;'>Trân trọng,<br>");
                        emailBody.append("<strong style='color: #2c3e50;'>Đội ngũ tuyển dụng</strong></p>");
                        emailBody.append("</div></body></html>");
                        
                        String subject = MimeUtility.encodeText("Cập Nhật Lịch Phỏng Vấn - " + jobTitle, "UTF-8", "B");
                        Email.sendEmail(seekerEmail, subject, emailBody.toString());
                        System.out.println("Interview update notification sent to: " + seekerEmail);
                    }
                } catch (Exception e) {
                    System.err.println("Failed to send interview update notification: " + e.getMessage());
                    e.printStackTrace();
                }
                
                if ("management".equals(returnTo)) {
                    response.sendRedirect("interviewManagement?success=interview_updated");
                } else {
                    response.sendRedirect("applicationSeekers?success=interview_updated&jobPostId=" + jobPostId);
                }
            } else {
                response.sendRedirect("applicationSeekers?error=interview_update_failed&jobPostId=" + jobPostId);
            }
        } else {
            response.sendRedirect("applicationSeekers?error=interview_not_found&jobPostId=" + jobPostId);
        }
    }

    private void updateInterviewStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int interviewId = Integer.parseInt(request.getParameter("interviewId"));
        String status = request.getParameter("status");
        String jobPostId = request.getParameter("jobPostId");
        
        boolean success = interviewDAO.updateInterviewStatus(interviewId, status);
        
        if (success) {
            response.sendRedirect("applicationSeekers?success=status_updated&jobPostId=" + jobPostId);
        } else {
            response.sendRedirect("applicationSeekers?error=status_update_failed&jobPostId=" + jobPostId);
        }
    }

    private void deleteInterview(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        int interviewId = Integer.parseInt(request.getParameter("interviewId"));
        String jobPostId = request.getParameter("jobPostId");
        
        // Get interview info before deleting for email notification
        Interview interview = interviewDAO.getInterviewById(interviewId);
        
        boolean success = interviewDAO.deleteInterview(interviewId);
        
        if (success && interview != null) {
            // Send email notification about interview cancellation
            try {
                ApplicationDAO applicationDAO = new ApplicationDAO();
                JobPostingsDAO jobPostingsDAO = new JobPostingsDAO();
                
                Applications application = applicationDAO.getDetailApplication(interview.getApplicationID());
                if (application != null && application.getJobSeeker() != null && application.getJobSeeker().getAccount() != null) {
                    String seekerEmail = application.getJobSeeker().getAccount().getEmail();
                    String seekerName = application.getJobSeeker().getAccount().getFullName();
                    
                    int actualJobPostId = (jobPostId != null && !jobPostId.isEmpty() && !jobPostId.equals("0")) 
                        ? Integer.parseInt(jobPostId) 
                        : application.getJobPostingID();
                    JobPostings jobPosting = jobPostingsDAO.findJobPostingById(actualJobPostId);
                    String jobTitle = jobPosting != null ? jobPosting.getTitle() : "Job Position";
                    
                    SimpleDateFormat emailDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    String formattedDate = emailDateFormat.format(interview.getInterviewDate());
                    
                    StringBuilder emailBody = new StringBuilder();
                    emailBody.append("<html><body style='font-family: Arial, sans-serif;'>");
                    emailBody.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>");
                    emailBody.append("<h2 style='color: #2c3e50; border-bottom: 2px solid #dc3545; padding-bottom: 10px;'>");
                    emailBody.append("<i class='fas fa-calendar-times'></i> Thông Báo Hủy Lịch Phỏng Vấn</h2>");
                    
                    emailBody.append("<p style='color: #34495e; font-size: 16px;'>Xin chào <strong>").append(seekerName).append("</strong>,</p>");
                    emailBody.append("<p style='color: #34495e;'>Chúng tôi xin thông báo lịch phỏng vấn ngày <strong style='color: #dc3545;'>");
                    emailBody.append(formattedDate).append(" lúc ").append(interview.getInterviewTime());
                    emailBody.append("</strong> cho vị trí <strong style='color: #dc3545;'>").append(jobTitle).append("</strong> đã bị hủy.</p>");
                    
                    emailBody.append("<div style='background-color: #f8d7da; border-left: 4px solid #dc3545; padding: 15px; margin: 20px 0;'>");
                    emailBody.append("<p style='margin: 0; color: #721c24;'><strong>Chúng tôi rất tiếc về sự bất tiện này.</strong></p>");
                    emailBody.append("<p style='margin: 10px 0 0 0; color: #721c24;'>Nếu có thắc mắc, vui lòng liên hệ với chúng tôi để được hỗ trợ.</p>");
                    emailBody.append("</div>");
                    
                    emailBody.append("<p style='color: #7f8c8d; font-size: 14px; margin-top: 30px;'>Trân trọng,<br>");
                    emailBody.append("<strong style='color: #2c3e50;'>Đội ngũ tuyển dụng</strong></p>");
                    emailBody.append("</div></body></html>");
                    
                    String subject = MimeUtility.encodeText("Thông Báo Hủy Lịch Phỏng Vấn - " + jobTitle, "UTF-8", "B");
                    Email.sendEmail(seekerEmail, subject, emailBody.toString());
                    System.out.println("Interview cancellation notification sent to: " + seekerEmail);
                }
            } catch (Exception e) {
                System.err.println("Failed to send interview cancellation notification: " + e.getMessage());
                e.printStackTrace();
            }
            
            String returnTo = request.getParameter("returnTo");
            if ("management".equals(returnTo)) {
                response.sendRedirect("interviewManagement?success=interview_deleted");
            } else {
                response.sendRedirect("applicationSeekers?success=interview_deleted&jobPostId=" + jobPostId);
            }
        } else {
            response.sendRedirect("applicationSeekers?error=interview_delete_failed&jobPostId=" + jobPostId);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            try {
                deleteInterview(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting interview: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
