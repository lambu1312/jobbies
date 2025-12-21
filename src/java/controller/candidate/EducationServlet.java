package controller.candidate;

import constant.CommonConst;
import dao.EducationDAO;
import dao.JobSeekerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.Calendar;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Education;
import model.JobSeekers;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10MB - SỬA: maxFileSize phải lớn hơn 200KB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB - SỬA: maxRequestSize 
)
@WebServlet(name = "EducationServlet", urlPatterns = {"/education"})
public class EducationServlet extends HttpServlet {

    private final EducationDAO eduDAO = new EducationDAO();
    private final JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
    private static final long MAX_FILE_SIZE = 200 * 1024; // 200KB

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String error = request.getParameter("error") != null ? request.getParameter("error") : "";
        request.setAttribute("error", error);
        
        String errorEducation = request.getParameter("errorEducation") != null ? request.getParameter("errorEducation") : "";
        request.setAttribute("errorEducation", errorEducation);
        
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url = "view/user/Education.jsp";

        switch (action) {
            case "update-education":
                url = "view/user/Education.jsp";
                break;

            default: {
                HttpSession session = request.getSession();
                Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

                if (account == null) {
                    response.sendRedirect("view/authen/login.jsp");
                    return;
                }

                JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

                if (jobSeeker != null) {
                    try {
                        url = viewEducation(request, response);
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.getWriter().println("Database error.");
                        url = "view/user/Education.jsp";
                    }
                } else {
                    error = "You are not currently a member of Jobbies. Please join to use this function.";
                    request.setAttribute("errorJobSeeker", error);
                    url = "view/user/Education.jsp";
                }
                break;
            }
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "add-education":
                url = addEducation(request);
                break;
            case "update-education":
                url = updateEducation(request);
                break;
            case "delete-education":
                url = deleteEducation(request);
                break;
            default:
                url = "education";
        }

        response.sendRedirect(url);
    }

    public String addEducation(HttpServletRequest request) throws IOException, ServletException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(account.getId() + "");
        
        if (jobSeeker != null) {
            try {
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                Part degreeImgPart = request.getPart("degreeImg");

                // KIỂM TRA FILE SIZE TRƯỚC - QUAN TRỌNG!
                if (degreeImgPart == null || degreeImgPart.getSize() == 0) {
                    url = "education?errorEducation=" + URLEncoder.encode("Vui lòng chọn file ảnh bằng cấp.", "UTF-8");
                    saveFormData(session, institution, degree, fieldofstudy, startDateStr, endDateStr);
                    return url;
                }
                
                if (degreeImgPart.getSize() > MAX_FILE_SIZE) {
                    url = "education?errorEducation=" + URLEncoder.encode("Kích thước file vượt quá 200KB.", "UTF-8");
                    saveFormData(session, institution, degree, fieldofstudy, startDateStr, endDateStr);
                    return url;
                }

                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                // KIỂM TRA NGÀY
                if (!validateDateRange(startDate, endDate, degree)) {
                    url = "education?errorEducation=" + URLEncoder.encode("Ngày kết thúc phải sau ngày bắt đầu ít nhất 2 năm.", "UTF-8");
                    saveFormData(session, institution, degree, fieldofstudy, startDateStr, endDateStr);
                    return url;
                }

                // LÀM VIỆC VỚI FILE - UPLOAD
                String uploadDir = "uploads/degreeImgs";
                String degreeImgName = saveFile(degreeImgPart, uploadDir);

                // TẠO EDUCATION OBJECT
                Education eduAdd = new Education();
                eduAdd.setJobSeekerID(jobSeeker.getJobSeekerID());
                eduAdd.setInstitution(institution);
                eduAdd.setDegree(degree);
                eduAdd.setFieldOfStudy(fieldofstudy);
                eduAdd.setStartDate(startDate);
                eduAdd.setEndDate(endDate);
                eduAdd.setDegreeImg(degreeImgName);

                // XÓA SESSION DATA
                clearFormData(session);

                // INSERT VÀO DB
                eduDAO.insert(eduAdd);
                
                url = "education"; // SUCCESS - không có parameter error
                
            } catch (Exception e) {
                e.printStackTrace();
                url = "education?errorEducation=" + URLEncoder.encode("Đã xảy ra lỗi khi thêm học vấn. Vui lòng thử lại.", "UTF-8");
            }
        } else {
            url = "education?errorEducation=" + URLEncoder.encode("Bạn chưa phải thành viên của Jobbies.", "UTF-8");
        }

        return url;
    }

    public String updateEducation(HttpServletRequest request) throws IOException, ServletException {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));
        
        if (jobSeeker != null) {
            try {
                String educationIDStr = request.getParameter("educationID");
                String institution = request.getParameter("institution");
                String degree = request.getParameter("degree");
                String fieldofstudy = request.getParameter("fieldofstudy");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                Part degreeImgPart = request.getPart("degreeImg");

                int educationID = Integer.parseInt(educationIDStr);
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);

                // KIỂM TRA FILE SIZE NẾU CÓ FILE MỚI
                if (degreeImgPart != null && degreeImgPart.getSize() > 0) {
                    if (degreeImgPart.getSize() > MAX_FILE_SIZE) {
                        url = "education?errorEducation=" + URLEncoder.encode("Kích thước file vượt quá 200KB.", "UTF-8") 
                                + "&educationID=" + educationID;
                        return url;
                    }
                }

                // KIỂM TRA NGÀY
                if (!validateDateRange(startDate, endDate, degree)) {
                    url = "education?errorEducation=" + URLEncoder.encode("Ngày kết thúc phải sau ngày bắt đầu ít nhất 2 năm.", "UTF-8")
                            + "&educationID=" + educationID;
                    return url;
                }

                // UPLOAD FILE NẾU CÓ
                String degreeImgName = null;
                if (degreeImgPart != null && degreeImgPart.getSize() > 0) {
                    String uploadDir = "uploads/degreeImgs";
                    degreeImgName = saveFile(degreeImgPart, uploadDir);
                }

                // CẬP NHẬT EDUCATION
                Education edu = new Education();
                edu.setEducationID(educationID);
                edu.setInstitution(institution);
                edu.setDegree(degree);
                edu.setFieldOfStudy(fieldofstudy);
                edu.setStartDate(startDate);
                edu.setEndDate(endDate);
                if (degreeImgName != null) {
                    edu.setDegreeImg(degreeImgName);
                }

                eduDAO.updateEducation(edu);
                url = "education"; // SUCCESS
                
            } catch (Exception e) {
                e.printStackTrace();
                url = "education?errorEducation=" + URLEncoder.encode("Đã xảy ra lỗi khi cập nhật học vấn.", "UTF-8");
            }
        } else {
            url = "JobSeekerCheck";
        }

        return url;
    }

    private String viewEducation(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String url = null;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account == null) {
            return "view/authen/login.jsp";
        }

        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(account.getId() + "");

        if (jobSeeker == null) {
            url = "education?errorEducation=" + URLEncoder.encode("Bạn chưa phải thành viên của Jobbies.", "UTF-8");
            return url;
        }

        List<Education> educationList = eduDAO.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());

        if (educationList == null || educationList.isEmpty()) {
            request.setAttribute("errorEducation", "Không tìm thấy hồ sơ học vấn.");
        }

        request.setAttribute("edus", educationList);
        url = "view/user/Education.jsp";
        return url;
    }

    public String deleteEducation(HttpServletRequest request) throws IOException, ServletException {
        String url;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        JobSeekers jobSeeker = jobSeekerDAO.findJobSeekerIDByAccountID(String.valueOf(account.getId()));

        if (jobSeeker != null) {
            try {
                String educationIDStr = request.getParameter("educationID");
                int educationID = Integer.parseInt(educationIDStr);

                eduDAO.deleteEducation(educationID);
                request.setAttribute("successEducation", "Xóa học vấn thành công.");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorEducation", "Đã xảy ra lỗi khi xóa học vấn.");
            }
        } else {
            url = "JobSeekerCheck";
            return url;
        }

        url = "education";
        return url;
    }

    private String saveFile(Part filePart, String uploadDir) throws IOException {
        Path uploadPath = Paths.get(getServletContext().getRealPath("/") + uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        Path filePath = uploadPath.resolve(fileName);
        
        if (Files.exists(filePath)) {
            String fileExtension = "";
            int dotIndex = fileName.lastIndexOf('.');

            if (dotIndex > 0) {
                fileExtension = fileName.substring(dotIndex);
                fileName = fileName.substring(0, dotIndex);
            }

            fileName = fileName + "_" + System.currentTimeMillis() + fileExtension;
            filePath = uploadPath.resolve(fileName);
        }

        Files.copy(filePart.getInputStream(), filePath);
        return uploadDir + "/" + fileName;
    }

    // HELPER METHODS
    
    /**
     * Validate date range - endDate phải sau startDate ít nhất 2 năm
     */
    private boolean validateDateRange(Date startDate, Date endDate, String degree) {
        Calendar startCal = Calendar.getInstance();
        startCal.setTime(startDate);

        Calendar endCal = Calendar.getInstance();
        endCal.setTime(endDate);

        boolean isCertificate = "Certificate".equals(degree);
        int yearsDiff = endCal.get(Calendar.YEAR) - startCal.get(Calendar.YEAR);
        int monthsDiff = endCal.get(Calendar.MONTH) - startCal.get(Calendar.MONTH);
        int totalMonths = yearsDiff * 12 + monthsDiff;

        // Nếu là Certificate thì không cần kiểm tra 2 năm
        if (isCertificate) {
            return true;
        }

        return totalMonths >= 24;
    }

    /**
     * Lưu form data vào session khi có lỗi
     */
    private void saveFormData(HttpSession session, String institution, String degree, 
                             String fieldofstudy, String startDateStr, String endDateStr) {
        session.setAttribute("institution", institution);
        session.setAttribute("degree", degree);
        session.setAttribute("fieldofstudy", fieldofstudy);
        session.setAttribute("startDateStr", startDateStr);
        session.setAttribute("endDateStr", endDateStr);
    }

    /**
     * Xóa form data khỏi session
     */
    private void clearFormData(HttpSession session) {
        session.removeAttribute("institution");
        session.removeAttribute("degree");
        session.removeAttribute("fieldofstudy");
        session.removeAttribute("startDateStr");
        session.removeAttribute("endDateStr");
    }
}