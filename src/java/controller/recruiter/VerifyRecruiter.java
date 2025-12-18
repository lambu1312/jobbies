package controller.recruiter;

import constant.CommonConst;
import dao.CompanyDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Company;
import model.Recruiters;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import utils.CloudinaryUploadUtil;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
@WebServlet(name = "VerifyRecruiter", urlPatterns = {"/verifyRecruiter"})
public class VerifyRecruiter extends HttpServlet {

    RecruitersDAO reDAO = new RecruitersDAO();
    CompanyDAO companyDao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        List<Company> companies = companyDao.findAll();
        request.setAttribute("companyList", companies);
        request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        String businessCode = request.getParameter("businessCode");
        String position = request.getParameter("position");

        try {
            // Check if a verification request has already been submitted
            Recruiters existingRecruiter = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
            if (existingRecruiter != null && !existingRecruiter.isIsVerify()) {
                request.setAttribute("error", "Your verification request is already pending approval.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }
            
            // Check if the businessCode belongs to the recruiter's own company
            if (!companyDao.doesBusinessCodeExist(businessCode, account.getId())) {
                request.setAttribute("error", "Invalid Business Code.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            // Check if the company is active
            if (!companyDao.isCompanyActive(businessCode)) {
request.setAttribute("error", "Company is not active.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            // Retrieve CompanyID based on BusinessCode
            int companyId = companyDao.getCompanyIdByBusinessCode(businessCode);

            // Get citizen ID image parts
            Part frontCitizenIDPart = request.getPart("frontCitizenID");
            Part backCitizenIDPart = request.getPart("backCitizenID");

            // Validate that files are uploaded
            if (frontCitizenIDPart == null || frontCitizenIDPart.getSubmittedFileName() == null || 
                frontCitizenIDPart.getSubmittedFileName().trim().isEmpty()) {
                request.setAttribute("error", "Please upload Front Citizen ID image.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            if (backCitizenIDPart == null || backCitizenIDPart.getSubmittedFileName() == null || 
                backCitizenIDPart.getSubmittedFileName().trim().isEmpty()) {
                request.setAttribute("error", "Please upload Back Citizen ID image.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            // Check if same file uploaded for both
            if (frontCitizenIDPart.getSubmittedFileName().equals(backCitizenIDPart.getSubmittedFileName())) {
                request.setAttribute("error", "You cannot upload the same file for both Front and Back Citizen ID.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            // Upload images to Cloudinary
            String frontCitizenIDUrl = uploadCitizenImage(frontCitizenIDPart, "frontCitizenID");
            String backCitizenIDUrl = uploadCitizenImage(backCitizenIDPart, "backCitizenID");

            // Check if upload was successful
            if (frontCitizenIDUrl == null || backCitizenIDUrl == null) {
                request.setAttribute("error", "Failed to upload citizen ID images. Please try again.");
                request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
                return;
            }

            // Create new recruiter entry
            Recruiters recruiter = new Recruiters();
            recruiter.setAccountID(account.getId());
            recruiter.setCompanyID(companyId);
            recruiter.setPosition(position);
            recruiter.setIsVerify(false);
            recruiter.setFrontCitizenImage(frontCitizenIDUrl);
            recruiter.setBackCitizenImage(backCitizenIDUrl);

            reDAO.insert(recruiter);

            request.setAttribute("verify", "Your verification request has been sent.");
request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    /**
     * Upload citizen ID image to Cloudinary
     * @param part File part from the request
     * @param folder Folder name in Cloudinary
     * @return Cloudinary URL or null if failed
     */
    private String uploadCitizenImage(Part part, String folder) {
        String imageUrl = null;
        try {
            System.out.println("=== UPLOADING CITIZEN ID IMAGE ===");
            System.out.println("Part name: " + part.getName());
            System.out.println("File name: " + part.getSubmittedFileName());
            System.out.println("File size: " + part.getSize());
            
            if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                System.out.println("No file provided");
                return null;
            }
            
            System.out.println("Uploading to Cloudinary folder: " + folder);
            imageUrl = CloudinaryUploadUtil.uploadImage(part, folder);
            System.out.println("Upload successful! URL: " + imageUrl);
            
        } catch (Exception e) {
            System.out.println("Error uploading citizen ID image: " + e.getMessage());
            e.printStackTrace();
            imageUrl = null;
        }
        return imageUrl;
    }
}