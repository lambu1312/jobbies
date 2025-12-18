<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.JobPostings"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Applications Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
        <style>
            /* Center the table container and make it full width */
            .container {
                max-width: 90%;
                margin: auto;
            }

            /* Row and cell styling */
            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Header styling without borders */
            .table thead th {
                background-color: #007b5e;
                color: white;
                text-align: center;
                padding: 15px;
                font-size: 16px;
                border: none; /* Remove border from header */
            }

            .table tbody td {
                padding: 12px;
                text-align: center;
                font-size: 15px;
                color: #333;
                border-top: 1px solid #e0e0e0; /* Retain border for body cells */
                border-left: 1px solid #e0e0e0;
            }

            .table tbody tr td:last-child {
                border-right: 1px solid #e0e0e0;
            }

            /* Alternating row colors */
            .table tbody tr:nth-child(odd) {
                background-color: #f9f9f9;
            }

            /* Hover effect */
            .table tbody tr:hover {
                background-color: #e6f2f1;
            }

            /* Badge styling */
            .badge {
                padding: 8px 12px;
                font-size: 14px;
                border-radius: 12px;
                color: white;
            }

            .badge.bg-warning {
                background-color: #ffc107;
                color: black;
            }
            .badge.bg-success {
                background-color: #28a745;
            }
            .badge.bg-danger {
                background-color: #dc3545;
            }
            .badge.bg-secondary {
                background-color: #6c757d;
            }
            .badge.bg-dark {
                background-color: #343a40;
            }

            /* Action button styling */
            .btn-action {
                margin-right: 8px;
                color: #007b5e;
                font-size: 16px;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .btn-action:hover {
                color: #005f46;
            }

            .btn-success {
                background-color: #28a745;
                color: white;
                padding: 6px 12px;
                font-size: 14px;
                border: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .btn-action i {
                margin-right: 5px;
            }
            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .job-posting-container {
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .content-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 80vh; /* Giúp giữ chiều cao của nội dung */
            }

            .table-responsive {
                flex-grow: 1; /* Đẩy bảng chiếm không gian còn lại */
            }

            .pagination-container {
                margin-top: auto; /* Đẩy phân trang xuống đáy */
                padding-bottom: 20px; /* Thêm khoảng trống phía dưới */
            }

            .table-title {
                font-size: 24px;
                font-weight: bold;
                color: #007b5e;
                padding-top: 40px; /* Khoảng cách cố định giữa tiêu đề và header */
                margin-bottom: 20px; /* Khoảng cách giữa tiêu đề và bảng */
                text-align: center;
            }

        </style>
    </head>
    <body>
        <div class="page-container d-flex flex-column min-vh-100">
            <!-- Include Sidebar -->
            <%@ include file="../recruiter/sidebar-re.jsp" %>

            <!-- Include Header -->
            <%@ include file="../recruiter/header-re.jsp" %>

            <!-- Main content for Applications Management -->
            <div class="job-posting-container flex-grow-1">
                <div class="container content-wrapper">
                    <!-- Title Section -->
                    <h2 class="table-title mt-4 mb-4">${jobPostingTitle}</h2>

                    <!-- Error Message Alert -->
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session"/>
                    </c:if>

                    <!-- Success Message Alert -->
                    <c:if test="${param.success != null}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> 
                            <c:choose>
                                <c:when test="${param.success == 'interview_scheduled'}">Interview scheduled successfully!</c:when>
                                <c:when test="${param.success == 'interview_updated'}">Interview updated successfully!</c:when>
                                <c:when test="${param.success == 'status_updated'}">Interview status updated successfully!</c:when>
                                <c:when test="${param.success == 'interview_deleted'}">Interview deleted successfully!</c:when>
                                <c:otherwise>Operation completed successfully!</c:otherwise>
                            </c:choose>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- Row for Back Button, Filter Buttons, and Search Box -->
                    <div class="row align-items-center mb-3">
                        <!-- Back Button -->
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/jobPost" class="btn btn-secondary">Back</a>
                        </div>

                        <!-- Filter Buttons -->
                        <div class="col-auto">
                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="text" name="searchName" value="${searchName}" placeholder="Search by name" class="form-control d-inline-block" style="width: 200px;">
                                <button type="submit" class="btn btn-outline-primary">Search</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <select name="statusFilter" class="form-control d-inline-block" style="width: 150px;">
                                    <option value="">All status</option>
                                    <option value="3" ${statusFilter == '3' ? 'selected' : ''}>Pending</option>
                                    <option value="2" ${statusFilter == '2' ? 'selected' : ''}>Agree</option>
                                    <option value="1" ${statusFilter == '1' ? 'selected' : ''}>Reject</option>
                                    <option value="0" ${statusFilter == '0' ? 'selected' : ''}>Cancel</option>
                                </select>
                                <button type="submit" class="btn btn-outline-primary">Filter by Status</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="date" name="dateFilter" value="${dateFilter}" class="form-control d-inline-block" style="width: 200px;">
                                <button type="submit" class="btn btn-outline-primary">Filter by Applied Date</button>
                            </form>
                        </div>
                    </div>

                    <!-- Table Container -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Applicant Name</th>
                                    <th>Applied Date</th>
                                    <th>Status</th>
                                    <th>Seeker Details</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="application" items="${applications}">
                                    <tr>
                                        <td>${application.jobSeeker.account.firstName} ${application.jobSeeker.account.lastName}</td>

                                        <td>
                                            <fmt:formatDate value="${application.getAppliedDate()}" pattern="dd-MM-yyyy" />
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">
                                                    <span class="badge bg-warning">Pending</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 2}">
                                                    <span class="badge bg-success">Agree</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 1}">
                                                    <span class="badge bg-danger">Reject</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 0}">
                                                    <span class="badge bg-danger">Cancel</span>
                                                </c:when>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 1 || application.getStatus() == 0}">
                                                    No information
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewCV&id=${application.getCVID()}" class="btn-action text-primary">
                                                        <i class="fas fa-file-pdf"></i>CV
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewEducation&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-secondary">
                                                        <i class="fas fa-graduation-cap"></i>Education
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewWorkExperience&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-warning">
                                                        <i class="fas fa-briefcase"></i>Work Experience
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <%

                                            String jobPostingStatus = (String) request.getAttribute("jobPostingStatus");
                                            boolean isViolate = "Violate".equals(jobPostingStatus);
                                        %>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">

                                                    <button type="button" class="btn btn-success btn-action <%= isViolate ? "text-danger" : "" %>" 
                                                            data-bs-toggle="modal" data-bs-target="#changeStatusModal" 
                                                            onclick="openModal(${application.getApplicationID()})" 
                                                            <%= isViolate ? "disabled" : "" %>>
                                                        <i class="fas fa-edit"></i> Confirm
                                                    </button>

                                                    <% if (isViolate) { %>

                                                    <span class="text-danger"> (Not allowed)</span>
                                                    <% } %>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 2}">
                                                    <!-- Check if interview exists for this application -->
                                                    <c:set var="hasInterview" value="false" />
                                                    <c:forEach var="interview" items="${interviews}">
                                                        <c:if test="${interview.applicationID == application.applicationID}">
                                                            <c:set var="hasInterview" value="true" />
                                                            <c:set var="currentInterview" value="${interview}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <c:choose>
                                                        <c:when test="${hasInterview}">
                                                            <button type="button" class="btn btn-info btn-sm" 
                                                                    data-bs-toggle="modal" data-bs-target="#viewInterviewModal" 
                                                                    onclick="viewInterview(${currentInterview.interviewID}, ${application.applicationID}, '${currentInterview.interviewDate}', '${currentInterview.interviewTime}', '${currentInterview.location}', '${currentInterview.interviewType}', '${currentInterview.meetingLink}', '${currentInterview.notes}', '${currentInterview.status}')">
                                                                <i class="fas fa-calendar-check"></i> View Interview
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-primary btn-sm" 
                                                                    data-bs-toggle="modal" data-bs-target="#scheduleInterviewModal" 
                                                                    onclick="setApplicationId(${application.applicationID})">
                                                                <i class="fas fa-calendar-plus"></i> Schedule Interview
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not yet</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination Container at the bottom -->
                    <div class="pagination-container mt-auto">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage - 1}">Previous</a></li>
                                    </c:if>
                                    <c:set var="startPage" value="${currentPage > 3 ? currentPage - 2 : 1}" />
                                    <c:set var="endPage" value="${startPage + 4}" />
                                    <c:if test="${endPage > totalPages}">
                                        <c:set var="endPage" value="${totalPages}" />
                                        <c:set var="startPage" value="${endPage - 4 > 0 ? endPage - 4 : 1}" />
                                    </c:if>

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?jobPostId=${param.jobPostId}&page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage + 1}">Next</a></li>
                                    </c:if>
                            </ul>
                        </nav>
                    </div>

                    <!-- Error message if no applications found -->
                    <c:if test="${empty applications}">
                        <div class="error-message text-center mt-3">No applications found for this job posting.</div>
                    </c:if>
                </div>

                <!-- Change Status Modal -->
                <div class="modal fade" id="changeStatusModal" tabindex="-1" aria-labelledby="changeStatusModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="changeStatusModalLabel">Change Application Status</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="changeStatusForm" action="${pageContext.request.contextPath}/applicationSeekers" method="post">
                                    <input type="hidden" name="applicationId" id="applicationId" value="">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Select New Status:</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="2">Agree</option>
                                            <option value="1">Reject</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="emailContent" class="form-label">Email Content:</label>
                                        <textarea class="form-control" id="emailContent" name="emailContent" rows="4" placeholder="Enter your message here..." required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                    <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button> <!-- Nút reset -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Schedule Interview Modal -->
                <div class="modal fade" id="scheduleInterviewModal" tabindex="-1" aria-labelledby="scheduleInterviewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="scheduleInterviewModalLabel">
                                    <i class="fas fa-calendar-plus"></i> Schedule Interview
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="scheduleInterviewForm" action="${pageContext.request.contextPath}/scheduleInterview" method="post">
                                    <input type="hidden" name="action" value="create">
                                    <input type="hidden" name="applicationId" id="scheduleApplicationId" value="">
                                    <input type="hidden" name="jobPostId" value="${param.jobPostId}">
                                    <input type="hidden" name="status" value="Scheduled">
                                    <input type="hidden" name="returnTo" value="applications">
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="interviewDate" class="form-label">Interview Date <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="interviewDate" name="interviewDate" 
                                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="interviewTime" class="form-label">Interview Time <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="interviewTime" name="interviewTime" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="interviewType" class="form-label">Interview Type <span class="text-danger">*</span></label>
                                        <select class="form-select" id="interviewType" name="interviewType" onchange="toggleMeetingLink()" required>
                                            <option value="">-- Select Type --</option>
                                            <option value="Online">Online</option>
                                            <option value="Offline">Offline</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3" id="locationField">
                                        <label for="location" class="form-label">Location</label>
                                        <input type="text" class="form-control" id="location" name="location" 
                                               placeholder="Enter interview location">
                                    </div>
                                    
                                    <div class="mb-3" id="meetingLinkField" style="display: none;">
                                        <label for="meetingLink" class="form-label">Meeting Link <span class="text-danger">*</span></label>
                                        <input type="url" class="form-control" id="meetingLink" name="meetingLink" 
                                               placeholder="https://zoom.us/j/123456789">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="notes" class="form-label">Notes / Instructions</label>
                                        <textarea class="form-control" id="notes" name="notes" rows="3" 
                                                  placeholder="Enter additional information or instructions for the candidate..."></textarea>
                                    </div>
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Schedule Interview
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- View Interview Modal -->
                <div class="modal fade" id="viewInterviewModal" tabindex="-1" aria-labelledby="viewInterviewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-info text-white">
                                <h5 class="modal-title" id="viewInterviewModalLabel">
                                    <i class="fas fa-calendar-check"></i> Interview Details
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateInterviewForm" action="${pageContext.request.contextPath}/scheduleInterview" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="interviewId" id="viewInterviewId" value="">
                                    <input type="hidden" name="jobPostId" value="${param.jobPostId}">
                                    <input type="hidden" name="returnTo" value="applications">
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="viewInterviewDate" class="form-label">Interview Date <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="viewInterviewDate" name="interviewDate" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="viewInterviewTime" class="form-label">Interview Time <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="viewInterviewTime" name="interviewTime" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="viewInterviewType" class="form-label">Interview Type <span class="text-danger">*</span></label>
                                        <select class="form-select" id="viewInterviewType" name="interviewType" onchange="toggleMeetingLinkView()" required>
                                            <option value="Online">Online</option>
                                            <option value="Offline">Offline</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3" id="viewLocationField">
                                        <label for="viewLocation" class="form-label">Location</label>
                                        <input type="text" class="form-control" id="viewLocation" name="location">
                                    </div>
                                    
                                    <div class="mb-3" id="viewMeetingLinkField">
                                        <label for="viewMeetingLink" class="form-label">Meeting Link</label>
                                        <input type="url" class="form-control" id="viewMeetingLink" name="meetingLink">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="viewNotes" class="form-label">Notes</label>
                                        <textarea class="form-control" id="viewNotes" name="notes" rows="3"></textarea>
                                    </div>
                                    
                                    <input type="hidden" id="viewStatus" name="status" value="Scheduled">
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" onclick="deleteInterview()">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            <i class="fas fa-times"></i> Close
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Update Interview
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Include Footer -->
            <%@ include file="../recruiter/footer-re.jsp" %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        function openModal(applicationId) {
                                            document.getElementById("applicationId").value = applicationId;
                                        }
        </script>
        <!-- TinyMCE và mã JavaScript cho nút Reset -->
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
                                        // Khởi tạo TinyMCE cho textarea với id là 'emailContent'
                                        tinymce.init({
                                            selector: 'textarea#emailContent',
                                            plugins: 'advlist autolink lists link image charmap print preview anchor',
                                            toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                                            branding: false,
                                            height: 300,
                                            setup: function (editor) {
                                                editor.on('change', function () {
                                                    tinymce.triggerSave();
                                                });
                                            }
                                        });

                                        // Hàm reset để xóa nội dung trong TinyMCE
                                        function resetForm() {
                                            // Reset nội dung của TinyMCE editor
                                            tinymce.get('emailContent').setContent('');

                                            // Reset các trường khác trong form nếu cần
                                            document.getElementById('status').selectedIndex = 0; // Đặt lại giá trị đầu tiên của dropdown
                                            document.getElementById('changeStatusForm').reset(); // Reset form nếu cần
                                        }
                                        
                                        // Interview scheduling functions
                                        function setApplicationId(applicationId) {
                                            document.getElementById('scheduleApplicationId').value = applicationId;
                                        }
                                        
                                        function toggleMeetingLink() {
                                            const interviewType = document.getElementById('interviewType').value;
                                            const meetingLinkField = document.getElementById('meetingLinkField');
                                            const meetingLinkInput = document.getElementById('meetingLink');
                                            const locationField = document.getElementById('locationField');
                                            
                                            if (interviewType === 'Online') {
                                                meetingLinkField.style.display = 'block';
                                                meetingLinkInput.required = true;
                                                locationField.style.display = 'none';
                                            } else {
                                                meetingLinkField.style.display = 'none';
                                                meetingLinkInput.required = false;
                                                locationField.style.display = 'block';
                                            }
                                        }
                                        
                                        function toggleMeetingLinkView() {
                                            const interviewType = document.getElementById('viewInterviewType').value;
                                            const meetingLinkField = document.getElementById('viewMeetingLinkField');
                                            const locationField = document.getElementById('viewLocationField');
                                            
                                            if (interviewType === 'Online') {
                                                meetingLinkField.style.display = 'block';
                                                locationField.style.display = 'none';
                                            } else {
                                                meetingLinkField.style.display = 'none';
                                                locationField.style.display = 'block';
                                            }
                                        }
                                        
                                        function viewInterview(interviewId, applicationId, interviewDate, interviewTime, location, interviewType, meetingLink, notes, status) {
                                            document.getElementById('viewInterviewId').value = interviewId;
                                            
                                            // Parse datetime if needed (format: 2024-12-09 00:00:00.0)
                                            if (interviewDate && interviewDate.includes(' ')) {
                                                interviewDate = interviewDate.split(' ')[0];
                                            }
                                            
                                            document.getElementById('viewInterviewDate').value = interviewDate;
                                            document.getElementById('viewInterviewTime').value = interviewTime || '';
                                            document.getElementById('viewLocation').value = location || '';
                                            document.getElementById('viewInterviewType').value = interviewType || 'Offline';
                                            document.getElementById('viewMeetingLink').value = meetingLink || '';
                                            document.getElementById('viewNotes').value = notes || '';
                                            document.getElementById('viewStatus').value = status || 'Scheduled';
                                            
                                            // Toggle fields based on interview type
                                            toggleMeetingLinkView();
                                        }
                                        
                                        function deleteInterview() {
                                            if (confirm('Are you sure you want to delete this interview?')) {
                                                const interviewId = document.getElementById('viewInterviewId').value;
                                                const jobPostId = '${param.jobPostId}';
                                                window.location.href = '${pageContext.request.contextPath}/scheduleInterview?action=delete&interviewId=' + interviewId + '&jobPostId=' + jobPostId;
                                            }
                                        }
        </script>
    </body>
</html>
