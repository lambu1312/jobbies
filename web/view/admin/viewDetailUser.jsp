<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="model.Education" %>
            <%@page import="model.WorkExperience" %>
                <%@page import="model.JobSeekers" %>
                    <%@page import="dao.EducationDAO" %>
                        <%@page import="dao.WorkExperienceDAO" %>
                            <%@page import="dao.JobSeekerDAO" %>
                                <%@page import="java.util.List" %>
                                    <!DOCTYPE html>
                                    <html lang="en">

                                    <head>
                                        <meta charset="UTF-8">
                                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                        <title>Profile Detail - Jobbies</title>

                                        <!--css-->
                                        <link
                                            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                                            rel="stylesheet">
                                        <link rel="stylesheet"
                                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

                                        <!-- Custom styles -->
                                        <style>
                                            * {
                                                margin: 0;
                                                padding: 0;
                                                box-sizing: border-box;
                                            }

                                            body {
                                                font-family: 'Segoe UI', system-ui, sans-serif;
                                                background: #f8f9fa !important;
                                                color: #212529;
                                                overflow-x: hidden;
                                                min-height: 100vh;
                                            }

                                            /* Column Layout */
                                            .col-md-3 {
                                                padding: 0;
                                            }

                                            .col-md-9 {
                                                padding: 2rem;
                                                background: #ffffff;
                                                min-height: 100vh;
                                            }

                                            /* Page Title */
                                            h4.fs-2 {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                                                -webkit-background-clip: text;
                                                -webkit-text-fill-color: transparent;
                                                font-weight: 900;
                                                margin-bottom: 2rem;
                                                text-align: center;
                                            }

                                            /* Profile Form Container */
                                            .bg-light {
                                                background: #ffffff !important;
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 20px !important;
                                                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
                                            }

                                            /* Avatar Styling */
                                            .rounded-circle {
                                                border: 3px solid #c471f5 !important;
                                                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3) !important;
                                                object-fit: cover;
                                            }

                                            /* Form Labels */
                                            .form-label {
                                                color: #495057;
                                                font-weight: 600;
                                                font-size: 0.9rem;
                                                margin-bottom: 0.5rem;
                                            }

                                            /* Form Inputs */
                                            .form-control {
                                                background: #f8f9fa !important;
                                                border: 1px solid #dee2e6 !important;
                                                border-radius: 10px !important;
                                                color: #212529 !important;
                                                padding: 0.75rem 1rem !important;
                                                font-size: 0.95rem;
                                                transition: all 0.3s;
                                            }

                                            .form-control:focus {
                                                background: #ffffff !important;
                                                border-color: #c471f5 !important;
                                                box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.15) !important;
                                                outline: none;
                                            }

                                            .form-control:read-only {
                                                background: #e9ecef !important;
                                                cursor: not-allowed;
                                            }

                                            /* Buttons */
                                            .btn-success {
                                                background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
                                                border: none !important;
                                                border-radius: 12px !important;
                                                padding: 0.6rem 1.5rem !important;
                                                font-weight: 700 !important;
                                                color: #ffffff !important;
                                                transition: all 0.3s !important;
                                                box-shadow: 0 3px 12px rgba(40, 167, 69, 0.3) !important;
                                                width: 100%;
                                            }

                                            .btn-success:hover {
                                                transform: translateY(-2px) !important;
                                                box-shadow: 0 5px 18px rgba(40, 167, 69, 0.4) !important;
                                            }

                                            .btn-info {
                                                background: linear-gradient(135deg, #7ee8fa 0%, #5ec9db 100%) !important;
                                                border: none !important;
                                                border-radius: 12px !important;
                                                padding: 0.7rem 2rem !important;
                                                font-weight: 700 !important;
                                                color: #000000 !important;
                                                transition: all 0.3s !important;
                                                box-shadow: 0 3px 12px rgba(126, 232, 250, 0.3) !important;
                                            }

                                            .btn-info:hover {
                                                transform: translateY(-2px) !important;
                                                box-shadow: 0 5px 18px rgba(126, 232, 250, 0.4) !important;
                                            }

                                            .btn-secondary {
                                                background: #6c757d !important;
                                                border: none !important;
                                                border-radius: 10px !important;
                                                padding: 0.6rem 1.5rem !important;
                                                font-weight: 600 !important;
                                                transition: all 0.3s !important;
                                            }

                                            .btn-secondary:hover {
                                                background: #5a6268 !important;
                                                transform: translateY(-2px) !important;
                                            }

                                            .btn-primary {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                border: none !important;
                                                color: #ffffff !important;
                                            }

                                            /* Modal Styling */
                                            .modal-content {
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 20px !important;
                                                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15) !important;
                                            }

                                            .modal-header {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                color: #ffffff !important;
                                                border-radius: 18px 18px 0 0 !important;
                                                border-bottom: none !important;
                                            }

                                            .modal-title {
                                                font-weight: 700;
                                                font-size: 1.3rem;
                                                color: #ffffff !important;
                                            }

                                            .modal-body {
                                                padding: 2rem;
                                                background: #ffffff;
                                            }

                                            .modal-footer {
                                                border-top: 1px solid #dee2e6 !important;
                                                padding: 1.5rem;
                                            }

                                            .btn-close {
                                                filter: brightness(0) invert(1);
                                            }

                                            /* Table in Modal */
                                            .table {
                                                margin-bottom: 0;
                                            }

                                            .table-bordered {
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 12px !important;
                                                overflow: hidden;
                                            }

                                            .table-light th {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                color: #ffffff !important;
                                                font-weight: 700;
                                                text-transform: uppercase;
                                                font-size: 0.85rem;
                                                letter-spacing: 0.5px;
                                                padding: 1rem;
                                                border: none !important;
                                            }

                                            .table tbody td {
                                                color: #212529 !important;
                                                padding: 1rem;
                                                vertical-align: middle;
                                                border-color: #dee2e6 !important;
                                            }

                                            .table tbody tr:hover {
                                                background: #f8f4ff;
                                            }

                                            /* Certificate Image in Table */
                                            .table img {
                                                max-width: 100px !important;
                                                height: auto !important;
                                                border-radius: 8px;
                                                border: 2px solid #dee2e6;
                                                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                                transition: all 0.3s;
                                                cursor: pointer;
                                            }

                                            .table img:hover {
                                                transform: scale(1.1);
                                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                                                z-index: 10;
                                            }

                                            /* Back to Top Button */
                                            #rts-back-to-top {
                                                position: fixed !important;
                                                bottom: 20px !important;
                                                right: 20px !important;
                                                background: linear-gradient(135deg, #c471f5, #fa71cd) !important;
                                                border: none !important;
                                                border-radius: 50% !important;
                                                width: 50px !important;
                                                height: 50px !important;
                                                display: flex !important;
                                                align-items: center !important;
                                                justify-content: center !important;
                                                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4) !important;
                                                cursor: pointer !important;
                                                transition: all 0.3s !important;
                                                z-index: 999 !important;
                                                color: #ffffff !important;
                                            }

                                            #rts-back-to-top:hover {
                                                transform: translateY(-5px) !important;
                                                box-shadow: 0 6px 20px rgba(196, 113, 245, 0.5) !important;
                                            }

                                            /* Loading Animation */
                                            .loader-wrapper {
                                                position: fixed;
                                                top: 0;
                                                left: 0;
                                                width: 100%;
                                                height: 100%;
                                                background: #ffffff;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                z-index: 9999;
                                            }

                                            .loader {
                                                width: 50px;
                                                height: 50px;
                                                border: 4px solid #f3f3f3;
                                                border-top-color: #c471f5;
                                                border-radius: 50%;
                                                animation: spin 1s linear infinite;
                                            }

                                            @keyframes spin {
                                                to {
                                                    transform: rotate(360deg);
                                                }
                                            }

                                            /* Profile Info Section */
                                            .d-flex.align-items-start {
                                                gap: 2rem;
                                            }

                                            .me-4 {
                                                min-width: 150px;
                                            }

                                            /* Custom Scrollbar */
                                            ::-webkit-scrollbar {
                                                width: 10px;
                                            }

                                            ::-webkit-scrollbar-track {
                                                background: #f1f1f1;
                                            }

                                            ::-webkit-scrollbar-thumb {
                                                background: linear-gradient(135deg, #c471f5, #fa71cd);
                                                border-radius: 10px;
                                            }

                                            ::-webkit-scrollbar-thumb:hover {
                                                background: linear-gradient(135deg, #fa71cd, #c471f5);
                                            }

                                            /* Empty State */
                                            .table tbody tr td[colspan] {
                                                color: #6c757d !important;
                                                font-style: italic;
                                                padding: 2rem;
                                            }

                                            /* Responsive Design */
                                            @media (max-width: 768px) {
                                                .col-md-9 {
                                                    padding: 1rem;
                                                }

                                                .d-flex.align-items-start {
                                                    flex-direction: column;
                                                }

                                                .me-4 {
                                                    width: 100%;
                                                    text-align: center;
                                                    margin-bottom: 1.5rem;
                                                }

                                                .rounded-circle {
                                                    width: 120px !important;
                                                    height: 120px !important;
                                                }

                                                h4.fs-2 {
                                                    font-size: 1.5rem !important;
                                                }

                                                .btn-success,
                                                .btn-info {
                                                    width: 100%;
                                                    margin-bottom: 0.5rem;
                                                }
                                            }
                                        </style>
                                    </head>

                                    <body>
                                        <!-- content area -->
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <!--Side bar-->
                                                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                                                    <!--side bar-end-->
                                                </div>

                                                <div class="col-md-9">
                                                    <!--content-main-->
                                                    <div class="tab-pane fade show active" id="profile" role="tabpanel">
                                                        <c:if test="${requestScope.accountView.getRoleId() == 3}">
                                                            <h4 class="mb-3 text-center fs-2">Profile Candidate</h4>
                                                        </c:if>
                                                        <c:if test="${requestScope.accountView.getRoleId() == 2}">
                                                            <h4 class="mb-3 text-center fs-2">Profile Recruiter</h4>
                                                        </c:if>

                                                        <form class="p-4 rounded shadow-sm bg-light">
                                                            <!-- Avatar và Thông tin người dùng -->
                                                            <div class="d-flex align-items-start">
                                                                <!-- Avatar -->
                                                                <div class="me-4 text-start">
                                                                    <c:if
                                                                        test="${empty requestScope.accountView.avatar}">
                                                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png"
                                                                            alt="Avatar" class="rounded-circle"
                                                                            width="150" height="150">
                                                                    </c:if>
                                                                    <c:if
                                                                        test="${!empty requestScope.accountView.avatar}">
                                                                        <img src="${requestScope.accountView.avatar}"
                                                                            alt="Avatar" class="rounded-circle"
                                                                            width="150" height="150">
                                                                    </c:if>

                                                                    <!-- Nút Xem Chi Tiết -->
                                                                    <c:if
                                                                        test="${requestScope.accountView.getRoleId() == 3}">
                                                                        <div class="mt-3">
                                                                            <button type="button"
                                                                                class="btn btn-success"
                                                                                data-bs-toggle="modal"
                                                                                data-bs-target="#educationModal">
                                                                                <i
                                                                                    class="fas fa-graduation-cap me-2"></i>Detail
                                                                                Education
                                                                            </button>
                                                                        </div>
                                                                        <div class="mt-2">
                                                                            <button type="button"
                                                                                class="btn btn-success"
                                                                                data-bs-toggle="modal"
                                                                                data-bs-target="#experienceModal">
                                                                                <i
                                                                                    class="fas fa-briefcase me-2"></i>Detail
                                                                                Experience
                                                                            </button>
                                                                        </div>
                                                                    </c:if>
                                                                </div>

                                                                <!-- Thông tin người dùng -->
                                                                <div class="w-100">
                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="lastName"
                                                                                class="form-label">Last Name</label>
                                                                            <input type="text" id="lastName"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.lastName}">
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="firstName"
                                                                                class="form-label">First Name</label>
                                                                            <input type="text" id="firstName"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.firstName}">
                                                                        </div>
                                                                    </div>

                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="phone" class="form-label">Phone
                                                                                Number</label>
                                                                            <input type="text" id="phone"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.phone}">
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="dob" class="form-label">Date of
                                                                                Birth</label>
                                                                            <input type="date" id="dob"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.dob}">
                                                                        </div>
                                                                    </div>

                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="genderDisplay"
                                                                                class="form-label">Gender</label>
                                                                            <input type="text" id="genderDisplay"
                                                                                class="form-control"
                                                                                value="${requestScope.accountView.gender == true ? 'Male' : 'Female'}"
                                                                                readonly>
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="address"
                                                                                class="form-label">Address</label>
                                                                            <input type="text" id="address"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.address}">
                                                                        </div>
                                                                    </div>

                                                                    <div class="row">
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="email"
                                                                                class="form-label">Email</label>
                                                                            <input type="email" id="email"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.email}">
                                                                        </div>
                                                                        <div class="col-md-6 mb-3">
                                                                            <label for="createAt"
                                                                                class="form-label">Create At</label>
                                                                            <input type="text" id="createAt"
                                                                                class="form-control" readonly
                                                                                value="${requestScope.accountView.createAt}">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Back Button -->
                                                            <div class="text-center mt-4">
                                                                <c:if test="${requestScope.accountView.roleId == 3}">
                                                                    <button type="button" class="btn btn-info"
                                                                        onclick="location.href = '${pageContext.request.contextPath}/candidates'">
                                                                        <i class="fas fa-arrow-left me-2"></i>Back
                                                                    </button>
                                                                </c:if>
                                                                <c:if test="${requestScope.accountView.roleId == 2}">
                                                                    <button type="button" class="btn btn-info"
                                                                        onclick="location.href = '${pageContext.request.contextPath}/recruiters'">
                                                                        <i class="fas fa-arrow-left me-2"></i>Back
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                        </form>
                                                    </div>

                                                    <!-- Education Modal -->
                                                    <div class="modal fade" id="educationModal" tabindex="-1"
                                                        aria-labelledby="educationModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="educationModalLabel">
                                                                        <i
                                                                            class="fas fa-graduation-cap me-2"></i>Education
                                                                        Details
                                                                    </h5>
                                                                    <button type="button" class="btn-close"
                                                                        data-bs-dismiss="modal"
                                                                        aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <c:set var="accountId"
                                                                        value="${requestScope.accountView.getId()}" />
                                                                    <% Education education=new Education(); EducationDAO
                                                                        educationDao=new EducationDAO(); JobSeekers
                                                                        jobSeeker=new JobSeekers(); JobSeekerDAO
                                                                        jobSeekerDao=new JobSeekerDAO(); %>
                                                                        <table class="table table-bordered text-center">
                                                                            <thead class="table-light">
                                                                                <tr>
                                                                                    <th>Institution</th>
                                                                                    <th>Degree</th>
                                                                                    <th>Field Of Study</th>
                                                                                    <th>Start Date</th>
                                                                                    <th>End Date</th>
                                                                                    <th>Certificate</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <% int accountId=(Integer)
                                                                                    pageContext.getAttribute("accountId");
                                                                                    jobSeeker=jobSeekerDao.findJobSeekerIDByAccountID(String.valueOf(accountId));
                                                                                    if(jobSeeker !=null){
                                                                                    List<Education> listEdu =
                                                                                    educationDao.findEducationbyJobSeekerID(jobSeeker.getJobSeekerID());
                                                                                    for(Education edu: listEdu){
                                                                                    %>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <%= edu.getInstitution()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= edu.getDegree()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= edu.getFieldOfStudy()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= edu.getStartDate()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= edu.getEndDate()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <img src="<%= edu.getDegreeImg() %>"
                                                                                                alt="Certificate">
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } }else{ %>
                                                                                        <tr>
                                                                                            <td colspan="6">No education
                                                                                                found.</td>
                                                                                        </tr>
                                                                                        <%}%>
                                                                            </tbody>
                                                                        </table>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">Close</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Experience Modal -->
                                                    <div class="modal fade" id="experienceModal" tabindex="-1"
                                                        aria-labelledby="experienceModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="experienceModalLabel">
                                                                        <i class="fas fa-briefcase me-2"></i>Experience
                                                                        Details
                                                                    </h5>
                                                                    <button type="button" class="btn-close"
                                                                        data-bs-dismiss="modal"
                                                                        aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <c:set var="accountId"
                                                                        value="${requestScope.accountView.getId()}" />
                                                                    <% WorkExperience experience=new WorkExperience();
                                                                        WorkExperienceDAO experienceDao=new
                                                                        WorkExperienceDAO(); %>
                                                                        <table class="table table-bordered text-center">
                                                                            <thead class="table-light">
                                                                                <tr>
                                                                                    <th>Company</th>
                                                                                    <th>Job Title</th>
                                                                                    <th>Start Date</th>
                                                                                    <th>End Date</th>
                                                                                    <th>Description</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <% jobSeeker=jobSeekerDao.findJobSeekerIDByAccountID(String.valueOf(accountId));
                                                                                    if(jobSeeker !=null){
                                                                                    List<WorkExperience> listExperience
                                                                                    =
                                                                                    experienceDao.findWorkExperiencesbyJobSeekerID(jobSeeker.getJobSeekerID());
                                                                                    for(WorkExperience ex:
                                                                                    listExperience){
                                                                                    %>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <%= ex.getCompanyName()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= ex.getJobTitle()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= ex.getStartDate()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= ex.getEndDate()%>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= ex.getDescription()%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } }else{ %>
                                                                                        <tr>
                                                                                            <td colspan="5">No
                                                                                                experience found.</td>
                                                                                        </tr>
                                                                                        <%}%>
                                                                            </tbody>
                                                                        </table>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">Close</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Back to Top Button -->
                                                    <button type="button" class="btn btn-primary" id="rts-back-to-top">
                                                        <i class="fas fa-arrow-up"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- THEME PRELOADER -->
                                        <div class="loader-wrapper">
                                            <div class="loader"></div>
                                        </div>

                                        <!-- Scripts -->
                                        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
                                        <script
                                            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
                                        <script
                                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

                                        <script>
                                            // Hide loader when page loads
                                            window.addEventListener('load', function () {
                                                document.querySelector('.loader-wrapper').style.display = 'none';
                                            });

                                            // Back to top button
                                            document.getElementById('rts-back-to-top').addEventListener('click', function () {
                                                window.scrollTo({ top: 0, behavior: 'smooth' });
                                            });
                                        </script>
                                    </body>

                                    </html>