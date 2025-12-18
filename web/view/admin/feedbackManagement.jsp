<%-- 
    Document   : adminHome
    Created on : Sep 15, 2024, 4:26:38 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<%@page import="model.JobPostings"%>
<%@page import="dao.JobPostingsDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/vaugmbxpwey72le9o04xzdbx0pb0cgxv4ysvnlmu1qnlmngd/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <!-- Add custom styles -->
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* Stars Background */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1 !important;
                display: none;
            }

            .star {
                position: absolute;
                width: 2px;
                height: 2px;
                background: #fff;
                border-radius: 50%;
                animation: twinkle 3s infinite;
            }

            @keyframes twinkle {
                0%, 100% {
                    opacity: 0.3;
                }
                50% {
                    opacity: 1;
                }
            }

            /* Floating Decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 5 !important;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 {
                top: 20%;
                left: 10%;
            }
            
            .deco-2 {
                top: 60%;
                right: 15%;
                animation-delay: 2s;
            }
            
            .deco-3 {
                bottom: 15%;
                left: 20%;
                animation-delay: 1s;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            /* Main layout using flexbox */
            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                position: relative;
                z-index: 10;
            }

            /* Main content layout */
            .feedback-container {
                flex: 1;
                padding: 2rem 3rem;
                margin-left: 25px;
                padding-top: 100px;
                display: flex;
                flex-direction: column;
                position: relative;
                z-index: 10;
                width: calc(100% - 25px);
            }

            /* Ensure table takes available space */
            .table-wrapper {
                flex: 1;
            }

            /* Header section */
            .header-section {
                display: flex;
                justify-content: center;
                margin-bottom: 3rem;
                padding: 1rem 0;
                margin-top: 0;
            }

            .header-section h2 {
                font-size: 3rem;
                background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
                line-height: 1.2;
                animation: fadeInUp 0.8s ease;
                letter-spacing: -0.5px;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Search bar and Filter positioning */
            .controls-container {
                display: flex;
                justify-content: flex-start;
                align-items: center;
                gap: 1.5rem;
                width: 100%;
                margin-bottom: 2.5rem;
                flex-wrap: wrap;
                margin-left: 0;
            }

            /* Filter dropdown styling */
            .filter-group {
                display: flex;
                align-items: center;
                gap: 0;
                width: 100%;
            }

            .filter-select {
                background-color: rgba(255, 255, 255, 0.9);
                border: 1.5px solid #c471f5;
                color: #1a1a1a;
                padding: 12px 16px;
                border-radius: 8px 0 0 8px;
                font-size: 15px;
                outline: none;
                transition: all 0.3s ease;
                cursor: pointer;
                font-weight: 600;
                min-width: 200px;
            }

            .filter-select:focus {
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                border-color: #c471f5;
            }

            /* Search bar styling */
            .search-container {
                display: flex;
                gap: 0;
                flex: 1;
            }

            .search-box {
                flex: 1;
                min-width: 300px;
                padding: 12px 16px;
                border: 1.5px solid #c471f5;
                border-right: none;
                border-radius: 0;
                font-size: 15px;
                outline: none;
                background-color: rgba(255, 255, 255, 0.9);
                color: #1a1a1a;
                transition: all 0.3s ease;
            }

            .search-box::placeholder {
                color: #999;
            }

            .search-box:focus {
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                background-color: rgba(255, 255, 255, 0.15);
                border-color: #c471f5;
            }

            .search-button {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                padding: 12px 20px;
                border-radius: 0 8px 8px 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: auto;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .search-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
            }

            .search-button i {
                color: white;
                font-size: 16px;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                background: rgba(255, 255, 255, 0.95);
                border: 1px solid rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            }

            table thead th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 15px;
                font-weight: 600;
                border: none;
            }

            table tbody td {
                padding: 14px 15px;
                border-bottom: 1px solid #e5e5e5;
                text-align: center;
                font-size: 14px;
                color: #333;
            }

            table tbody tr {
                transition: all 0.3s ease;
            }

            table tbody tr:hover {
                background-color: rgba(196, 113, 245, 0.05);
            }

            table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Status badge styling */
            .status-badge {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 13px;
            }

            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-resolved {
                background-color: #d4edda;
                color: #155724;
            }

            .status-reject {
                background-color: #f8d7da;
                color: #721c24;
            }

            .status-deleted {
                background-color: #e2e3e5;
                color: #383d41;
            }

            /* Action buttons styling */
            .btn-action {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-right: 8px;
                background-color: transparent;
                color: #0da5c0;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s ease;
                width: 32px;
                height: 32px;
                border-radius: 6px;
                border: none;
            }

            .btn-action:last-child {
                margin-right: 0;
            }

            .btn-action:hover {
                color: #fff;
                background-color: #0da5c0;
                transform: scale(1.1);
            }

            .btn-action.btn-success {
                color: #28a745;
            }

            .btn-action.btn-success:hover {
                background-color: #28a745;
            }

            .btn-action.btn-warning {
                color: #ffc107;
            }

            .btn-action.btn-warning:hover {
                background-color: #ffc107;
                color: #fff;
            }

            .btn-action:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            /* Card styling for feedback details */
            .card {
                border: none;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.95);
            }

            .card:hover {
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important;
            }

            .feedback-content {
                transition: all 0.3s ease;
            }

            .feedback-content:hover {
                transform: translateY(-2px);
            }

            .bg-light {
                background-color: #f8f9fa !important;
            }

            /* Hiệu ứng hover cho icons */
            .rounded-circle {
                transition: all 0.3s ease;
            }

            .rounded-circle:hover {
                transform: scale(1.1);
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 2rem;
                padding-bottom: 2rem;
                gap: 8px;
            }

            .pagination a,
            .pagination span {
                padding: 10px 14px;
                border: 1.5px solid #c471f5;
                font-size: 14px;
                cursor: pointer;
                border-radius: 8px;
                text-decoration: none;
                color: #1a1a1a;
                transition: all 0.3s ease;
                font-weight: 600;
                background-color: rgba(255, 255, 255, 0.8);
            }

            .pagination a:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border-color: transparent;
                transform: translateY(-2px);
            }

            .pagination .page-link.active,
            .pagination .active a {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border-color: transparent;
            }

            /* Modal styling */
            .modal-header.bg-success {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
            }

            .modal-header.bg-warning {
                background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%) !important;
                color: #1a1a1a !important;
            }

            .modal-body {
                color: #333;
            }

            .form-label {
                color: #333;
                font-weight: 600;
            }

            .form-control {
                border: 1.5px solid #dee2e6;
                color: #333;
            }

            .form-control:focus {
                border-color: #c471f5;
                box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.25);
            }

            /* Toast notification styling */
            .toast-container {
                z-index: 9999;
            }

            .toast {
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
            }

            /* Footer container */
            .footer-container {
                margin-top: auto;
            }

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .feedback-container {
                    margin-left: 0;
                    padding-top: 60px;
                }
            }

            @media (max-width: 768px) {
                .controls-container {
                    flex-direction: column;
                    align-items: stretch;
                    margin-left: 0;
                }

                .filter-group,
                .search-container {
                    width: 100%;
                }

                .filter-select {
                    width: 100%;
                    border-radius: 8px;
                }

                .search-box {
                    width: 100%;
                }

                table {
                    font-size: 12px;
                }

                table thead th,
                table tbody td {
                    padding: 10px 8px;
                }

                .btn-action {
                    margin-right: 5px;
                    width: 28px;
                    height: 28px;
                    font-size: 14px;
                }

                .header-section h2 {
                    font-size: 1.8rem;
                }

                .pixel-decoration {
                    display: none;
                }
            }

            @media (max-width: 480px) {
                .feedback-container {
                    padding: 1rem;
                    padding-top: 60px;
                }

                .header-section h2 {
                    font-size: 1.5rem;
                }

                table {
                    font-size: 11px;
                }

                table thead th,
                table tbody td {
                    padding: 8px 5px;
                }

                .btn-action {
                    width: 24px;
                    height: 24px;
                    font-size: 12px;
                }
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <div class="stars" id="stars"></div>

        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        

        <!-- content area -->
        <div class="page-container">
            <div style="display: flex; width: 100%; margin: 0;">
                <div style="width: 240px;">
                    <!--Side bar-->
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                    <!--side bar-end-->
                </div>

                <div style="flex: 1; padding: 0;">
                    <!--content-main can fix-->
                    <div class="feedback-container">
                        <!-- Centered Header section -->
                        <div class="header-section">
                            <h2>Quản Lý Phản Hồi</h2>
                        </div>

                        <!-- Filter and Search -->
                        <div class="controls-container">
                            <!-- Dropdown filter by status -->
                            <div class="filter-group">
                                <form action="feedback" method="GET" id="filterSearchForm" style="display: flex; gap: 0;">
                                    <select class="filter-select" name="filter" id="status" onchange="document.getElementById('filterSearchForm').submit()">
                                        <option value="0" ${param.filter == null || param.filter == '' ? 'selected' : ''}>Tất Cả Trạng Thái</option>
                                        <option value="1" ${param.filter == '1' ? 'selected' : ''}>Đang Chờ Xử Lý</option>
                                        <option value="2" ${param.filter == '2' ? 'selected' : ''}>Đã Giải Quyết</option>
                                        <option value="3" ${param.filter == '3' ? 'selected' : ''}>Từ Chối</option>
                                    </select>

                                    <!-- Search input and button in the same input group -->
                                    <input type="text" name="search" class="search-box" placeholder="Tìm kiếm phản hồi..." value="${param.search != null ? param.search : ''}">
                                    <button class="search-button" type="submit">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Filter and Search end -->

                        <div class="seeker-list">
                            <!--notification-->
                            <div class="toast-container position-fixed top-0 end-0 p-3">
                                <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                                    <div class="toast-header bg-success text-white">
                                        <strong class="me-auto">Thành Công</strong>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                                    </div>
                                    <div class="toast-body" id="successToastBody"></div>
                                </div>

                                <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                                    <div class="toast-header bg-danger text-white">
                                        <strong class="me-auto">Lỗi</strong>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                                    </div>
                                    <div class="toast-body" id="errorToastBody"></div>
                                </div>
                            </div>
                            <!--notification-end-->
                            
                            <div class="table-wrapper">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Phản Hồi Từ</th>
                                            <th>Tiêu Đề Công Việc</th>
                                            <th>Trạng Thái</th>
                                            <th>Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                           Account account = new Account();
                                           AccountDAO accDao = new AccountDAO();
                                           JobPostings jobPost = new JobPostings();
                                           JobPostingsDAO jobPostDao = new JobPostingsDAO();
                                        %>
                                        <c:forEach items="${listFeedback}" var="feedback">
                                            <c:set var="accountId" value="${feedback.getAccountID()}"/>
                                            <c:set var="jobPostId" value="${feedback.getJobPostingID()}"/>
                                            <tr>
                                                <!-- Full Name Column -->
                                                <td>
                                                    <%
                                                        int accountId = (Integer) pageContext.getAttribute("accountId");
                                                        account = accDao.findUserById(accountId);
                                                        String name = "";
                                                        if(account != null){
                                                            name = account.getFullName();
                                                        }
                                                    %>
                                                    <%= name%>
                                                </td>
                                                <td>
                                                    <%
                                                        int jobPostId = (Integer) pageContext.getAttribute("jobPostId");
                                                        jobPost = jobPostDao.findJobPostingById(jobPostId);
                                                            String title = "";
                                                        if(jobPost != null){
                                                            title = jobPost.getTitle();
                                                           }
                                                    %>
                                                    <form action="${pageContext.request.contextPath}/job_posting" method="POST" style="display: inline;">
                                                        <input type="hidden" name="action" value="view">
                                                        <input type="hidden" name="jobPostID" value="${feedback.getJobPostingID()}">
                                                        <button type="submit" class="btn btn-link text-decoration-none" style="padding: 0; color: #c471f5; font-weight: 600;">
                                                            <%= title %>
                                                        </button>
                                                    </form>
                                                </td>

                                                <!-- Status Column -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${feedback.getStatus() == 1}">
                                                            <span class="status-badge status-pending">Đang Chờ Xử Lý</span>
                                                        </c:when>
                                                        <c:when test="${feedback.getStatus() == 2}">
                                                            <span class="status-badge status-resolved">Đã Giải Quyết</span>
                                                        </c:when>
                                                        <c:when test="${feedback.getStatus() == 3}">
                                                            <span class="status-badge status-reject">Từ Chối</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-deleted">Đã Xóa</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- Action Column -->
                                                <td>
                                                    <button 
                                                        class="btn-action" 
                                                        type="button" 
                                                        onclick="toggleDetails(${feedback.getFeedbackID()})"
                                                        title="Xem chi tiết"
                                                        <c:if test="${feedback.getStatus() == 4}">disabled</c:if>>
                                                        <i class="fa fa-eye"></i> 
                                                    </button>

                                                    <!-- Resolved button -->
                                                    <button 
                                                        class="btn-action btn-success" 
                                                        type="button" 
                                                        onclick="openResolvedModal(${feedback.getFeedbackID()})" 
                                                        title="Đã Giải Quyết"
                                                        <c:if test="${feedback.getStatus() == 4}">disabled</c:if>>
                                                        <i class="fa-solid fa-check-circle"></i>
                                                    </button>

                                                    <!-- Reject button -->
                                                    <button 
                                                        class="btn-action btn-warning" 
                                                        type="button" 
                                                        onclick="openRejectModal(${feedback.getFeedbackID()})" 
                                                        title="Từ Chối"
                                                        <c:if test="${feedback.getStatus() == 4}">disabled</c:if>>
                                                        <i class="fa-solid fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>

                                            <!-- Row for Feedback Details -->
                                            <tr id="details-${feedback.getFeedbackID()}" style="display: none;">
                                                <td colspan="4">
                                                    <div class="card shadow-sm">
                                                        <div class="card-body">
                                                            <!-- Header with title -->
                                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                                <h5 class="card-title mb-0" style="color: #c471f5;">
                                                                    <i class="fas fa-comment-dots me-2"></i>Chi Tiết Phản Hồi
                                                                </h5>
                                                            </div>

                                                            <!-- Info row -->
                                                            <div class="row mb-3 pb-2 border-bottom">
                                                                <div class="col-md-6">
                                                                    <div class="d-flex align-items-center">
                                                                        <div>
                                                                            <small class="text-muted">Phản Hồi Từ</small>
                                                                            <p class="mb-0 fw-bold" style="color: #1a1a1a;"><%= name %></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%); color: white;">
                                                                            <i class="fas fa-calendar"></i>
                                                                        </div>
                                                                        <div class="ms-3">
                                                                            <small class="text-muted">Ngày Tạo</small>
                                                                            <p class="mb-0 fw-bold" style="color: #1a1a1a;">${feedback.getCreatedAt()}</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Content section -->
                                                            <div class="feedback-content">
                                                                <h6 class="text-muted mb-2">
                                                                    <i class="fas fa-comment-alt me-2"></i>Nội Dung
                                                                </h6>
                                                                <div class="p-3 bg-light rounded">
                                                                    <p class="mb-0 text-start" style="white-space: pre-line; color: #333;">${feedback.getContentFeedback()}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!--modal for resolved-reject button-->
                            <!-- Modal for Resolved Action -->
                            <div class="modal fade" id="resolvedModal" tabindex="-1" aria-labelledby="resolvedModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header bg-success text-white">
                                            <h5 class="modal-title" id="resolvedModalLabel">Giải Quyết Phản Hồi</h5>
                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="feedback" method="POST">
                                            <div class="modal-body">
                                                <input type="hidden" id="resolved-feedback-id" name="feedback-id" value="">
                                                <input type="hidden" name="action" value="resolved">
                                                <div class="mb-3">
                                                    <label for="resolved-response" class="form-label">Nhập phản hồi của bạn để giải quyết phản hồi này:</label>
                                                    <textarea class="form-control" id="resolved-response" name="response" rows="4" required></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-success">Giải Quyết</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>