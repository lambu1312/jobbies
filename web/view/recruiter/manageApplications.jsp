<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.JobPostings"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản Lý Ứng Tuyển</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
        <style>
            /* Tông màu Tím Hồng chủ đạo */
            :root {
                --primary-purple: #a855f7;
                --primary-pink: #ec4899;
                --gradient-bg: linear-gradient(90deg, #c084fc 0%, #f472b6 100%);
                --gradient-header: linear-gradient(90deg, #be54e3, #e863b8);
                --text-color: #6b21a8;
            }

            /* Center the table container and make it full width */
            .container {
                max-width: 95%;
                margin: auto;
            }

            /* Row and cell styling */
            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            /* Header styling without borders - Tone Tím Hồng */
            .table thead th {
                background: var(--gradient-header);
                color: white;
                text-align: center;
                padding: 18px;
                font-size: 16px;
                font-weight: 600;
                border: none;
                text-transform: uppercase;
            }

            .table tbody td {
                padding: 15px;
                text-align: center;
                font-size: 15px;
                color: #333;
                border-bottom: 1px solid #f0f0f0;
                vertical-align: middle;
            }

            /* Alternating row colors */
            .table tbody tr:nth-child(even) {
                background-color: #faf5ff; /* Màu tím rất nhạt */
            }
            .table tbody tr:nth-child(odd) {
                background-color: #fff;
            }

            /* Hover effect */
            .table tbody tr:hover {
                background-color: #fce7f3; /* Màu hồng phấn nhạt khi hover */
            }

            /* Badge styling */
            .badge {
                padding: 8px 12px;
                font-size: 13px;
                border-radius: 20px;
                color: white;
                font-weight: 500;
            }

            .badge.bg-warning {
                background-color: #f59e0b !important; /* Pending - Cam */
                color: white;
            }
            .badge.bg-success {
                background: linear-gradient(45deg, #10b981, #34d399) !important; /* Agree - Xanh ngọc */
            }
            .badge.bg-danger {
                background-color: #ef4444 !important; /* Reject - Đỏ */
            }

            /* Action button styling */
            .btn-action {
                margin-right: 5px;
                color: #9333ea; /* Tím đậm */
                font-size: 16px;
                text-decoration: none;
                transition: all 0.3s ease;
                background: none;
                border: none;
                padding: 5px;
            }

            .btn-action:hover {
                color: #db2777; /* Hồng đậm */
                transform: scale(1.1);
            }

            /* Các nút bấm chính (Search, Filter, Schedule) */
            .btn-primary, .btn-outline-primary {
                border-color: #d946ef;
                color: #d946ef;
            }
            
            .btn-primary {
                background: var(--gradient-bg);
                border: none;
                color: white;
            }

            .btn-primary:hover {
                background: linear-gradient(90deg, #a855f7, #ec4899);
                color: white;
                box-shadow: 0 4px 10px rgba(236, 72, 153, 0.4);
            }

            .btn-outline-primary:hover {
                background: var(--gradient-bg);
                border-color: transparent;
                color: white;
            }

            /* Nút "Confirm" (Xác nhận) trong bảng */
            .btn-confirm-custom {
                background: var(--gradient-bg);
                color: white;
                border: none;
                padding: 6px 15px;
                border-radius: 8px;
                font-size: 14px;
                transition: 0.3s;
            }
            .btn-confirm-custom:hover {
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                color: white;
            }

            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #fdfbff;
            }

            .job-posting-container {
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .content-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 80vh; 
            }

            .table-responsive {
                flex-grow: 1; 
                margin-bottom: 20px;
            }

            .pagination-container {
                margin-top: auto; 
                padding-bottom: 20px; 
            }
            
            .pagination .page-link {
                color: #9333ea;
                border-radius: 5px;
                margin: 0 2px;
            }
            
            .pagination .page-item.active .page-link {
                background: var(--gradient-bg);
                border-color: transparent;
                color: white;
            }

            .table-title {
                font-size: 28px;
                font-weight: 700;
                background: -webkit-linear-gradient(#c026d3, #7e22ce);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                padding-top: 30px; 
                margin-bottom: 30px; 
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            /* Custom Scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
            }
            ::-webkit-scrollbar-track {
                background: #f1f1f1; 
            }
            ::-webkit-scrollbar-thumb {
                background: #d8b4fe; 
                border-radius: 4px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #c084fc; 
            }
            
            /* Inputs */
            .form-control, .form-select {
                border: 1px solid #e9d5ff;
                border-radius: 8px;
            }
            .form-control:focus, .form-select:focus {
                border-color: #d8b4fe;
                box-shadow: 0 0 0 0.25rem rgba(216, 180, 254, 0.25);
            }

        </style>
    </head>
    <body>
        <div class="page-container d-flex flex-column min-vh-100">
            <%@ include file="../recruiter/sidebar-re.jsp" %>

            <%@ include file="../recruiter/header-re.jsp" %>

            <div class="job-posting-container flex-grow-1">
                <div class="container content-wrapper">
                    <h2 class="table-title">${jobPostingTitle}</h2>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session"/>
                    </c:if>

                    <c:if test="${param.success != null}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> 
                            <c:choose>
                                <c:when test="${param.success == 'interview_scheduled'}">Đã lên lịch phỏng vấn thành công!</c:when>
                                <c:when test="${param.success == 'interview_updated'}">Cập nhật lịch phỏng vấn thành công!</c:when>
                                <c:when test="${param.success == 'status_updated'}">Cập nhật trạng thái thành công!</c:when>
                                <c:when test="${param.success == 'interview_deleted'}">Đã xóa lịch phỏng vấn!</c:when>
                                <c:otherwise>Thao tác thành công!</c:otherwise>
                            </c:choose>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="row align-items-center mb-4">
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/jobPost" class="btn btn-secondary" style="border-radius: 8px;"><i class="fas fa-arrow-left"></i> Quay lại</a>
                        </div>

                        <div class="col-auto ms-auto">
                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="text" name="searchName" value="${searchName}" placeholder="Tìm kiếm theo tên..." class="form-control d-inline-block" style="width: 220px;">
                                <button type="submit" class="btn btn-outline-primary"><i class="fas fa-search"></i> Tìm kiếm</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline ms-2">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <select name="statusFilter" class="form-select d-inline-block" style="width: 160px;">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="3" ${statusFilter == '3' ? 'selected' : ''}>Đang chờ</option>
                                    <option value="2" ${statusFilter == '2' ? 'selected' : ''}>Chấp nhận</option>
                                    <option value="1" ${statusFilter == '1' ? 'selected' : ''}>Từ chối</option>
                                    <option value="0" ${statusFilter == '0' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                                <button type="submit" class="btn btn-outline-primary">Lọc trạng thái</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline ms-2">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="date" name="dateFilter" value="${dateFilter}" class="form-control d-inline-block" style="width: 160px;">
                                <button type="submit" class="btn btn-outline-primary">Lọc theo ngày</button>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tên Ứng Viên</th>
                                    <th>Ngày Ứng Tuyển</th>
                                    <th>Trạng Thái</th>
                                    <th>Chi Tiết & CV</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="application" items="${applications}">
                                    <tr>
                                        <td class="fw-bold text-secondary">${application.jobSeeker.account.firstName} ${application.jobSeeker.account.lastName}</td>

                                        <td>
                                            <fmt:formatDate value="${application.getAppliedDate()}" pattern="dd-MM-yyyy" />
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">
                                                    <span class="badge bg-warning">Đang chờ</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 2}">
                                                    <span class="badge bg-success">Chấp nhận</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 1}">
                                                    <span class="badge bg-danger">Từ chối</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 0}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 1 || application.getStatus() == 0}">
                                                    <span class="text-muted">Không có thông tin</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewCV&id=${application.getCVID()}" class="btn-action" title="Xem CV">
                                                        <i class="fas fa-file-pdf fa-lg"></i> Xem CV
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
                                                    <button type="button" class="btn-confirm-custom <%= isViolate ? "disabled opacity-50" : "" %>" 
                                                            data-bs-toggle="modal" data-bs-target="#changeStatusModal" 
                                                            onclick="openModal(${application.getApplicationID()})" 
                                                            <%= isViolate ? "disabled" : "" %>>
                                                        <i class="fas fa-edit"></i> Xét duyệt
                                                    </button>

                                                    <% if (isViolate) { %>
                                                    <span class="text-danger small d-block mt-1"> (Bị chặn)</span>
                                                    <% } %>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 2}">
                                                    <c:set var="hasInterview" value="false" />
                                                    <c:forEach var="interview" items="${interviews}">
                                                        <c:if test="${interview.applicationID == application.applicationID}">
                                                            <c:set var="hasInterview" value="true" />
                                                            <c:set var="currentInterview" value="${interview}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <c:choose>
                                                        <c:when test="${hasInterview}">
                                                            <button type="button" class="btn btn-outline-primary btn-sm rounded-pill" 
                                                                    data-bs-toggle="modal" data-bs-target="#viewInterviewModal" 
                                                                    onclick="viewInterview(${currentInterview.interviewID}, ${application.applicationID}, '${currentInterview.interviewDate}', '${currentInterview.interviewTime}', '${currentInterview.location}', '${currentInterview.interviewType}', '${currentInterview.meetingLink}', '${currentInterview.notes}', '${currentInterview.status}')">
                                                                <i class="fas fa-calendar-check"></i> Xem lịch PV
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-primary btn-sm rounded-pill" 
                                                                    data-bs-toggle="modal" data-bs-target="#scheduleInterviewModal" 
                                                                    onclick="setApplicationId(${application.applicationID})">
                                                                <i class="fas fa-calendar-plus"></i> Hẹn PV
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted"><small>Đã hoàn tất</small></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container mt-auto">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage - 1}"><i class="fas fa-chevron-left"></i> Trước</a></li>
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
                                    <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage + 1}">Sau <i class="fas fa-chevron-right"></i></a></li>
                                    </c:if>
                            </ul>
                        </nav>
                    </div>

                    <c:if test="${empty applications}">
                        <div class="text-center mt-5 text-muted">
                            <i class="fas fa-inbox fa-3x mb-3" style="color: #d8b4fe;"></i>
                            <p>Chưa có đơn ứng tuyển nào cho công việc này.</p>
                        </div>
                    </c:if>
                </div>

                <div class="modal fade" id="changeStatusModal" tabindex="-1" aria-labelledby="changeStatusModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-gradient-custom text-white" style="background: var(--gradient-bg);">
                                <h5 class="modal-title" id="changeStatusModalLabel">Thay Đổi Trạng Thái Ứng Tuyển</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="changeStatusForm" action="${pageContext.request.contextPath}/applicationSeekers" method="post">
                                    <input type="hidden" name="applicationId" id="applicationId" value="">
                                    <div class="mb-3">
                                        <label for="status" class="form-label fw-bold text-secondary">Chọn trạng thái mới:</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="2">Chấp nhận</option>
                                            <option value="1">Từ chối</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="emailContent" class="form-label fw-bold text-secondary">Nội dung Email gửi ứng viên:</label>
                                        <textarea class="form-control" id="emailContent" name="emailContent" rows="4" placeholder="Nhập nội dung thông báo..." required></textarea>
                                    </div>
                                    <div class="text-end">
                                        <button type="button" class="btn btn-secondary me-2" onclick="resetForm()">Làm mới</button>
                                        <button type="submit" class="btn btn-primary">Xác nhận gửi</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="scheduleInterviewModal" tabindex="-1" aria-labelledby="scheduleInterviewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header text-white" style="background: var(--gradient-header);">
                                <h5 class="modal-title" id="scheduleInterviewModalLabel">
                                    <i class="fas fa-calendar-plus"></i> Lên Lịch Phỏng Vấn
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
                                            <label for="interviewDate" class="form-label">Ngày phỏng vấn <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="interviewDate" name="interviewDate" 
                                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="interviewTime" class="form-label">Giờ phỏng vấn <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="interviewTime" name="interviewTime" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="interviewType" class="form-label">Hình thức phỏng vấn <span class="text-danger">*</span></label>
                                        <select class="form-select" id="interviewType" name="interviewType" onchange="toggleMeetingLink()" required>
                                            <option value="">-- Chọn hình thức --</option>
                                            <option value="Online">Online (Trực tuyến)</option>
                                            <option value="Offline">Offline (Tại văn phòng)</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3" id="locationField">
                                        <label for="location" class="form-label">Địa điểm</label>
                                        <input type="text" class="form-control" id="location" name="location" 
                                               placeholder="Nhập địa điểm phỏng vấn">
                                    </div>
                                    
                                    <div class="mb-3" id="meetingLinkField" style="display: none;">
                                        <label for="meetingLink" class="form-label">Link cuộc họp (Meeting Link) <span class="text-danger">*</span></label>
                                        <input type="url" class="form-control" id="meetingLink" name="meetingLink" 
                                               placeholder="Ví dụ: https://zoom.us/j/123456789">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="notes" class="form-label">Ghi chú / Hướng dẫn</label>
                                        <textarea class="form-control" id="notes" name="notes" rows="3" 
                                                  placeholder="Nhập thêm thông tin hoặc hướng dẫn cho ứng viên..."></textarea>
                                    </div>
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            <i class="fas fa-times"></i> Hủy
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Lưu lịch
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="viewInterviewModal" tabindex="-1" aria-labelledby="viewInterviewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header text-white" style="background: linear-gradient(90deg, #3b82f6, #8b5cf6);">
                                <h5 class="modal-title" id="viewInterviewModalLabel">
                                    <i class="fas fa-calendar-check"></i> Chi Tiết Phỏng Vấn
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
                                            <label for="viewInterviewDate" class="form-label">Ngày phỏng vấn <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="viewInterviewDate" name="interviewDate" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="viewInterviewTime" class="form-label">Giờ phỏng vấn <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="viewInterviewTime" name="interviewTime" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="viewInterviewType" class="form-label">Hình thức <span class="text-danger">*</span></label>
                                        <select class="form-select" id="viewInterviewType" name="interviewType" onchange="toggleMeetingLinkView()" required>
                                            <option value="Online">Online</option>
                                            <option value="Offline">Offline</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3" id="viewLocationField">
                                        <label for="viewLocation" class="form-label">Địa điểm</label>
                                        <input type="text" class="form-control" id="viewLocation" name="location">
                                    </div>
                                    
                                    <div class="mb-3" id="viewMeetingLinkField">
                                        <label for="viewMeetingLink" class="form-label">Link cuộc họp</label>
                                        <input type="url" class="form-control" id="viewMeetingLink" name="meetingLink">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="viewNotes" class="form-label">Ghi chú</label>
                                        <textarea class="form-control" id="viewNotes" name="notes" rows="3"></textarea>
                                    </div>
                                    
                                    <input type="hidden" id="viewStatus" name="status" value="Scheduled">
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" onclick="deleteInterview()">
                                            <i class="fas fa-trash"></i> Xóa Lịch
                                        </button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            <i class="fas fa-times"></i> Đóng
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Cập Nhật
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <%@ include file="../recruiter/footer-re.jsp" %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    function openModal(applicationId) {
                                        document.getElementById("applicationId").value = applicationId;
                                    }
        </script>
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
                                        if (confirm('Bạn có chắc chắn muốn xóa lịch phỏng vấn này không?')) {
                                            const interviewId = document.getElementById('viewInterviewId').value;
                                            const jobPostId = '${param.jobPostId}';
                                            window.location.href = '${pageContext.request.contextPath}/scheduleInterview?action=delete&interviewId=' + interviewId + '&jobPostId=' + jobPostId;
                                        }
                                    }
        </script>
    </body>
</html>