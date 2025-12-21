/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Company;
import utils.CloudinaryUploadUtil;
import validate.Validation;

@MultipartConfig
@WebServlet(name = "CompanyController", urlPatterns = {"/company"})
public class CompanyController extends HttpServlet {

    Validation validate = new Validation();
    CompanyDAO companyDao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "create":
                url = "view/recruiter/createCompany.jsp";
                break;
            case "edit":
                url = editCompany(request);
                break;
            default:
                url = "view/recruiter/createCompany.jsp";
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        switch (action) {
            case "create":
                url = createCompany(request, response);
                break;
            case "edit":
                url = editCompanyDoPost(request, response);
                break;
            default:
                throw new AssertionError();
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String createCompany(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        String url = "";

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String businessCode = request.getParameter("businessCode");
        String businessLicense = getBusinessLicenseImg("businessLicense", request);

        Company company = new Company();
        company.setName(name);
        company.setDescription(description);
        company.setLocation(location);
        company.setBusinessCode(businessCode);
        company.setBusinessLicenseImage(businessLicense);
        company.setAccountId(account.getId());

        request.setAttribute("company", company);

        boolean check = companyDao.checkCompanyByAccountId(company);
        if (check) {
            // Check valid business code (Updated to 10 digits)
            // Replaced validate.checkCode with direct regex check for 10 digits
            if (!businessCode.matches("\\d{10}")) {
                String error = "Business code must be exactly 10 digits!!";
                request.setAttribute("errorCode", error);
                url = "view/recruiter/createCompany.jsp";
                return url;
            } else if (companyDao.checkExistBusinessCode(company.getAccountId(), businessCode)) {
                request.setAttribute("duplicateCode", "Business code is existed !!");
                url = "view/recruiter/createCompany.jsp";
                return url;
            }
            String notice = "Create successfully!!";
            request.setAttribute("notice", notice);
            companyDao.insert(company);
            url = "view/recruiter/createCompany.jsp";

        } else {
            String error = "You have registered your company information, please edit here";
            url = "view/recruiter/createCompany.jsp";
            request.setAttribute("error", error);
        }

        return url;
    }

    private String getBusinessLicenseImg(String businessLicense, HttpServletRequest request) {
        String imagePath = null;
        try {
            Part part = request.getPart(businessLicense);

            if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                imagePath = null;
            } else {
                imagePath = CloudinaryUploadUtil.uploadImage(part, "businessLicense");
            }
        } catch (Exception e) {
            e.printStackTrace();
            imagePath = null;
        }
        return imagePath;
    }

    private String editCompany(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        Company company = companyDao.findCompanyByAccountId(account.getId());
        if (company == null) {
            request.setAttribute("error", "You must fill the company information firts!!");
        } else {
            request.setAttribute("company", company);
        }
        return "view/recruiter/editCompany.jsp";
    }

    private String editCompanyDoPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("companyId"));
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String businessCode = request.getParameter("businessCode");

            Company company = companyDao.findCompanyById(id);

            // Validate business code if changed
            if (!businessCode.equals(company.getBusinessCode())) {
                // Check 10 digits regex
                if (!businessCode.matches("\\d{10}")) {
                    String error = "Business code must be exactly 10 digits!!";
                    request.setAttribute("errorCode", error);
                    request.setAttribute("company", company);
                    return "view/recruiter/editCompany.jsp";
                } else if (companyDao.checkExistBusinessCode(company.getAccountId(), businessCode)) {
                    request.setAttribute("duplicateCode", "Business code is existed !!");
                    request.setAttribute("company", company);
                    return "view/recruiter/editCompany.jsp";
                }
            }

            String newBusinessLicense = getBusinessLicenseImg("businessLicense", request);

            if (newBusinessLicense != null && !newBusinessLicense.trim().isEmpty()) {
                company.setBusinessLicenseImage(newBusinessLicense);
            }

            company.setName(name);
            company.setLocation(location);
            company.setDescription(description);
            company.setBusinessCode(businessCode);

            companyDao.updateCompany(company);

            company = companyDao.findCompanyById(id);

            request.setAttribute("company", company);
            request.setAttribute("success", "Edit successfully!!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Update failed: " + e.getMessage());
        }

        return "view/recruiter/editCompany.jsp";
    }

}
