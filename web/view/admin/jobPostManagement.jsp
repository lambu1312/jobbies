<%-- 
    Admin Job Posting Management Page
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<%@page import="model.Recruiters"%>
<%@page import="dao.RecruitersDAO"%>
<%@page import="model.Job_Posting_Category"%>
<%@page import="dao.Job_Posting_CategoryDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Bài Đăng Công Việc - Admin</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE -->
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background-color: #f5f7fa;
                color: #1a1a1a;
            }

            /* Tab Navigation */
            .nav-tabs {
                border-bottom: 2px solid #e0e0e0;
            }

            .nav-tabs .nav-link {
                color: #666;
                font-weight: 600;
                border: none;
                border-bottom: 3px solid transparent;
                padding: 12px 20px;
                transition: all 0.3s ease;
            }

            .nav-tabs .nav-link:hover {
                color: #c471f5;
                border-bottom-color: #c471f5;
            }

            .nav-tabs .nav-link.active {
                color: #c471f5;
                border-bottom-color: #c471f5;
                background-color: transparent;
            }

            /* Section Headers */
            h6.fw-medium {
                color: #1a1a1a;
                font-weight: 700 !important;
                margin-bottom: 30px !important;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Form Labels */
            .form-label {
                font-weight: 600;
                color: #333;
                font-size: 14px;
            }

            /* Select/Input Fields */
            .form-select,
            .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
                padding: 10px 12px;
                background-color: #f8f9fa;
                color: #1a1a1a;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-select:focus,
            .form-control:focus {
                border-color: #c471f5;
                background-color: #fff;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
            }

            .form-select option {
                background-color: #fff;
                color: #1a1a1a;
            }

            /* Search Button */
            .btn-primary {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(196, 113, 245, 0.3);
            }

            /* Tables */
            .table {
                color: #1a1a1a;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                overflow: hidden;
            }

            .table thead th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                font-weight: 600;
                border: none;
                padding: 15px;
            }

            .table tbody td {
                padding: 12px 15px;
                border-color: #e0e0e0;
                color: #333;
            }

            .table tbody tr:hover {
                background-color: rgba(196, 113, 245, 0.05);
            }

            /* Badges */
            .badge {
                padding: 8px 12px;
                font-weight: 600;
                border-radius: 6px;
            }

            .bg-success {
                background-color: #28a745 !important;
            }

            .bg-danger {
                background-color: #dc3545 !important;
            }

            .bg-warning {
                background-color: #ffc107 !important;
                color: #000 !important;
            }

            /* Buttons */
            .btn-sm {
                padding: 6px 12px;
                font-size: 13px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .btn-info {
                background-color: #0da5c0;
                border-color: #0da5c0;
                color: white;
            }

            .btn-info:hover {
                background-color: #0a8fa5;
                transform: translateY(-2px);
            }

            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #000;
            }

            .btn-warning:hover {
                background-color: #e0a800;
                transform: translateY(-2px);
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background-color: #c82333;
                transform: translateY(-2px);
            }

            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
                color: white;
            }

            .btn-success:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }

            /* Add Button */
            .btn-success.btn-lg {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                font-weight: 600;
                padding: 10px 20px;
            }

            .btn-success.btn-lg:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(196, 113, 245, 0.3);
            }

            /* Pagination */
            .pagination {
                gap: 8px;
            }

            .page-link {
                background-color: #fff;
                border: 1.5px solid #e0e0e0;
                color: #c471f5;
                font-weight: 600;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .page-link:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border-color: transparent;
            }

            .page-item.active .page-link {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border-color: transparent;
                color: white;
            }

            /* Modal Styling */
            .modal-header {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border: none;
            }

            .modal-header .btn-close {
                filter: brightness(0) invert(1);
            }

            .modal-body {
                color: #1a1a1a;
            }

            /* Toast */
            .toast-header {
                font-weight: 600;
                border: none;
            }

            .toast-body {
                color: #1a1a1a;
            }

            /* Input Group */
            .input-group .form-control {
                border-right: none;
            }

            .input-group .btn-primary {
                border-radius: 0 8px 8px 0;
            }

            /* Text Right */
            .text-right {
                text-align: right;
                margin-bottom: 20px;
            }

            /* Add Category Button */
            .text-right .btn-success {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                color: white;
                font-weight: 600;
                padding: 10px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .text-right .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
                color: white;
                text-decoration: none;
            }

            /* Danh Mục Section */
            .table thead.table-primary th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                color: white !important;
            }

            /* Modal Improvements */
            .modal-content {
                border: 1px solid rgba(196, 113, 245, 0.2);
                border-radius: 12px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                border-bottom: 2px solid rgba(255, 255, 255, 0.2);
            }

            .modal-footer {
                border-top: 1px solid #e0e0e0;
            }

            .modal-title {
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            /* Form Group in Modal */
            .modal-body .form-group {
                margin-bottom: 20px;
            }

            .modal-body .form-label {
                margin-bottom: 8px;
                color: #333;
                font-weight: 600;
            }

            .modal-body .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
                padding: 10px 12px;
                color: #1a1a1a;
                transition: all 0.3s ease;
            }

            .modal-body .form-control:focus {
                border-color: #c471f5;
                background-color: #fff;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
            }

            /* Modal Buttons */
            .modal-footer .btn-secondary {
                background-color: #e0e0e0;
                color: #333;
                border: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .modal-footer .btn-secondary:hover {
                background-color: #d0d0d0;
                transform: translateY(-2px);
            }

            .modal-footer .btn-success {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .modal-footer .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(196, 113, 245, 0.3);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .form-label {
                    font-size: 13px;
                }

                .table {
                    font-size: 12px;
                }

                .btn-sm {
                    padding: 5px 10px;
                    font-size: 12px;
                }

                h6.fw-medium {
                    font-size: 1.3rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2">
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-10">
                        <div class="container-fluid p-4">
                            <!-- Tab Navigation -->
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link active" id="jobPostingTab" data-bs-toggle="tab" href="#jobPostingContent" role="tab">
                                        <i class="fas fa-briefcase me-2"></i>Quản Lý Bài Đăng
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="categoryTab" data-bs-toggle="tab" href="#categoryContent" role="tab">
                                        <i class="fas fa-list me-2"></i>Danh Mục
                                    </a>
                                </li>
                            </ul>

                            <div class="tab-content" id="myTabContent">
                                <!-- Job Posting Tab -->
                                <div class="tab-pane fade show active" id="jobPostingContent" role="tabpanel">
                                    <div class="container-fluid p-4">
                                        <h6 class="fw-medium mb-30 text-center fs-2">QUẢN LÝ BÀI ĐĂNG CÔNG VIỆC</h6>

                                        <!-- Filter Section -->
                                        <!-- Filter Section -->
                                        <form action="job_posting" method="get" id="filterForm" class="mb-4">
                                            <div class="row g-3">
                                                <div class="col-md-2">
                                                    <label class="form-label">Trạng Thái</label>
                                                    <select class="form-select" name="filterStatus" onchange="document.getElementById('filterForm').submit();">
                                                        <option value="all" ${param.filterStatus == 'all' || param.filterStatus == null || param.filterStatus == '' ? 'selected' : ''}>Tất Cả</option>
                                                    <option value="Open" ${param.filterStatus == 'Open' ? 'selected' : ''}>Mở</option>
                                                    <option value="Closed" ${param.filterStatus == 'Closed' ? 'selected' : ''}>Đóng</option>
                                                    <option value="Violate" ${param.filterStatus == 'Violate' ? 'selected' : ''}>Vi Phạm</option>
                                                </select>
                                            </div>

                                            <div class="col-md-2">
                                                <label class="form-label">Loại Tiền</label>
                                                <select class="form-select" name="filterCurrency" onchange="document.getElementById('filterForm').submit();">
                                                    <option value="all" ${param.filterCurrency == 'all' || param.filterCurrency == null || param.filterCurrency == '' ? 'selected' : ''}>Tất Cả</option>
                                                    <option value="VND" ${param.filterCurrency == 'VND' ? 'selected' : ''}>VND (₫)</option>
                                                    <option value="USD" ${param.filterCurrency == 'USD' ? 'selected' : ''}>USD ($)</option>
                                                    <option value="EUR" ${param.filterCurrency == 'EUR' ? 'selected' : ''}>EUR (€)</option>
                                                    <option value="GBP" ${param.filterCurrency == 'GBP' ? 'selected' : ''}>GBP (£)</option>
                                                    <option value="JPY" ${param.filterCurrency == 'JPY' ? 'selected' : ''}>JPY (¥)</option>
                                                    <option value="AUD" ${param.filterCurrency == 'AUD' ? 'selected' : ''}>AUD (A$)</option>
                                                    <option value="CAD" ${param.filterCurrency == 'CAD' ? 'selected' : ''}>CAD (C$)</option>
                                                </select>
                                            </div>

                                            <div class="col-md-2">
                                                <label class="form-label">Lương tối thiểu</label>
                                                <input type="number"
                                                       class="form-control"
                                                       name="minSalary"
                                                       value="${param.minSalary}">
                                            </div>

                                            <div class="col-md-2">
                                                <label class="form-label">Lương tối đa</label>
                                                <input type="number"
                                                       class="form-control"
                                                       name="maxSalary"
                                                       value="${param.maxSalary}">
                                            </div>


                                            <div class="col-md-2">
                                                <label class="form-label">Ngày Đăng</label>
                                                <input type="date" class="form-control" name="filterDate" value="${param.filterDate}" onchange="document.getElementById('filterForm').submit();">
                                            </div>

                                            <div class="col-md-4">
                                                <label class="form-label">Tìm Kiếm</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" name="search" placeholder="Tìm theo người tạo..." value="${param.search}">
                                                    <button class="btn btn-primary" type="submit">
                                                        <i class="fas fa-search"></i> Tìm
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- Notifications -->
                                    <div class="toast-container position-fixed top-0 end-0 p-3">
                                        <div id="successToast" class="toast" role="alert">
                                            <div class="toast-header bg-success text-white">
                                                <strong class="me-auto">Thành Công</strong>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                                            </div>
                                            <div class="toast-body" id="successToastBody"></div>
                                        </div>

                                        <div id="errorToast" class="toast" role="alert">
                                            <div class="toast-header bg-danger text-white">
                                                <strong class="me-auto">Lỗi</strong>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                                            </div>
                                            <div class="toast-body" id="errorToastBody"></div>
                                        </div>
                                    </div>

                                    <!-- Table -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Người Tạo</th>
                                                    <th>Tiêu Đề</th>
                                                    <th>Lương</th>
                                                    <th>Địa Điểm</th>
                                                    <th>Danh Mục</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Ngày Đăng</th>
                                                    <th>Hành Động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    Account account = new Account();
                                                    Recruiters recruiters = new Recruiters();
                                                    Job_Posting_Category jobCate = new Job_Posting_Category();
                                                    AccountDAO accDao = new AccountDAO();
                                                    RecruitersDAO reDao = new RecruitersDAO();
                                                    Job_Posting_CategoryDAO jobCateDao = new Job_Posting_CategoryDAO();
                                                %>
                                                <c:forEach items="${jobPostingsList}" var="jobPost">
                                                    <c:set var="recruiterId" value="${jobPost.getRecruiterID()}"/>
                                                    <c:set var="cateId" value="${jobPost.getJob_Posting_CategoryID()}"/>
                                                    <tr>
                                                        <td>
                                                            <%
                                                                int recruiterId = (Integer) pageContext.getAttribute("recruiterId");
                                                                recruiters = reDao.findById(String.valueOf(recruiterId));
                                                                account = accDao.findUserById(recruiters.getAccountID());
                                                                String accountName = account != null ? account.getFullName() : "N/A";
                                                            %>
                                                            <%= accountName%>
                                                        </td>
                                                        <td>${jobPost.getTitle()}</td>
                                                        <td>
                                                            ${jobPost.getMinSalary()} - ${jobPost.getMaxSalary()} ${jobPost.getCurrency()}
                                                        </td>
                                                        <td>${jobPost.getLocation()}</td>
                                                        <td>
                                                            <%
                                                                int cateId = (Integer) pageContext.getAttribute("cateId");
                                                                jobCate = jobCateDao.findJob_Posting_CategoryByID(cateId);
                                                                String cateName = jobCate != null ? jobCate.getName() : "N/A";
                                                            %>
                                                            <%= cateName%>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${jobPost.getStatus() == 'Open'}">
                                                                    <span class="badge bg-success">Mở</span>
                                                                </c:when>
                                                                <c:when test="${jobPost.getStatus() == 'Closed'}">
                                                                    <span class="badge bg-danger">Đóng</span>
                                                                </c:when>
                                                                <c:when test="${jobPost.getStatus() == 'Violate'}">
                                                                    <span class="badge bg-warning">Vi Phạm</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${jobPost.getStatus()}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${jobPost.getPostedDate()}</td>
                                                        <td>
                                                            <form action="job_posting" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="view">
                                                                <input type="hidden" name="jobPostID" value="${jobPost.getJobPostingID()}">
                                                                <button type="submit" class="btn btn-info btn-sm" title="Xem Chi Tiết">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                            </form>

                                                            <button type="button" class="btn btn-warning btn-sm" 
                                                                    onclick="openResolvedModal(${jobPost.getJobPostingID()})"
                                                                    <c:if test="${jobPost.getStatus() == 'Violate'}">disabled</c:if>
                                                                        title="Báo Vi Phạm">
                                                                        <i class="fas fa-exclamation-triangle"></i>
                                                                    </button>
                                                            </td>
                                                        </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Pagination -->
                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">
                                            <c:if test="${pageControl.getPage() > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}">
                                                        <i class="fas fa-chevron-left"></i> Trước
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                                            <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                                            <c:if test="${startPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${startPage-1}">...</a>
                                                </li>
                                            </c:if>

                                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test="${endPage < pageControl.getTotalPages()}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${endPage + 1}">...</a>
                                                </li>
                                            </c:if>

                                            <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                                <li class="page-item">
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}">
                                                        Sau <i class="fas fa-chevron-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>

                            <!-- Category Tab -->
                            <div class="tab-pane fade" id="categoryContent" role="tabpanel">
                                <div class="container-fluid p-4">
                                    <h6 class="fw-medium mb-30 text-center fs-2">QUẢN LÝ DANH MỤC</h6>

                                    <!-- Add Category Button -->
                                    <div class="text-right mb-3">
                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                            <i class="fas fa-plus me-2"></i>Thêm Danh Mục
                                        </button>
                                    </div>

                                    <!-- Notifications -->
                                    <div class="toast-container position-fixed top-0 end-0 p-3">
                                        <div id="duplicateToast" class="toast" role="alert">
                                            <div class="toast-header bg-danger text-white">
                                                <strong class="me-auto">Lỗi</strong>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                                            </div>
                                            <div class="toast-body" id="duplicateToastBody">${duplicate}</div>
                                        </div>

                                        <div id="duplicateEditToast" class="toast" role="alert">
                                            <div class="toast-header bg-danger text-white">
                                                <strong class="me-auto">Lỗi</strong>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                                            </div>
                                            <div class="toast-body" id="duplicateEditToastBody">${duplicateEdit}</div>
                                        </div>
                                    </div>

                                    <!-- Table -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Tên Danh Mục</th>
                                                    <th>Hành Động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${categoryList}" var="category">
                                                    <c:if test="${category.isStatus() == true}">
                                                        <tr>
                                                            <td>${category.getName()}</td>
                                                            <td>
                                                                <button type="button" class="btn btn-warning btn-sm" 
                                                                        onclick="openEditCategoryModal(${category.getId()}, '${category.getName()}')">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                                <form action="job_posting" method="POST" style="display:inline;">
                                                                    <input type="hidden" name="action" value="deleteCate">
                                                                    <input type="hidden" name="categoryId" value="${category.getId()}">
                                                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xóa?')">
                                                                        <i class="fas fa-trash-alt"></i>
                                                                    </button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chỉnh Sửa Danh Mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="job_posting" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="editCate">
                            <input type="hidden" name="categoryId" id="editCategoryId">
                            <div class="form-group">
                                <label for="newCategoryName" class="form-label">Tên Danh Mục Mới</label>
                                <input type="text" name="newCategoryName" class="form-control" id="newCategoryName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-success">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Danh Mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="job_posting" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="addCate">
                            <div class="form-group">
                                <label for="cateName" class="form-label">Tên Danh Mục</label>
                                <input type="text" name="cateName" class="form-control" id="cateName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-success">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Violate Modal -->
        <div class="modal fade" id="resolvedModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Báo Vi Phạm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="job_posting" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="violate">
                            <input type="hidden" name="jobPostID" id="resolved-feedback-id">
                            <div class="form-group">
                                <label for="resolved-response" class="form-label">Nội Dung Thông Báo Vi Phạm</label>
                                <textarea class="form-control" id="resolved-response" name="response" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-success">Gửi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

        <script>
                                                                        function openResolvedModal(jobPostId) {
                                                                            document.getElementById('resolved-feedback-id').value = jobPostId;
                                                                            new bootstrap.Modal(document.getElementById('resolvedModal')).show();
                                                                        }

                                                                        function openEditCategoryModal(categoryId, categoryName) {
                                                                            document.getElementById('editCategoryId').value = categoryId;
                                                                            document.getElementById('newCategoryName').value = categoryName;
                                                                            new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
                                                                        }

                                                                        document.getElementById('resolvedModal').addEventListener('hidden.bs.modal', function () {
                                                                            document.getElementById('resolved-response').value = '';
                                                                        });

                                                                        function showSuccessToast(message) {
                                                                            const successToastBody = document.getElementById('successToastBody');
                                                                            successToastBody.textContent = message;
                                                                            new bootstrap.Toast(document.getElementById('successToast')).show();
                                                                        }

                                                                        function showErrorToast(message) {
                                                                            const errorToastBody = document.getElementById('errorToastBody');
                                                                            errorToastBody.textContent = message;
                                                                            new bootstrap.Toast(document.getElementById('errorToast')).show();
                                                                        }

                                                                        document.addEventListener('DOMContentLoaded', function () {
                                                                            const successMessage = '${success}';
                                                                            const errorMessage = '${error}';
                                                                            const duplicateMessage = '${duplicate}';
                                                                            const duplicateEditMessage = '${duplicateEdit}';

                                                                            if (successMessage && successMessage.trim() !== '') {
                                                                                showSuccessToast(successMessage);
                                                                            }

                                                                            if (errorMessage && errorMessage.trim() !== '') {
                                                                                showErrorToast(errorMessage);
                                                                            }

                                                                            if (duplicateMessage && duplicateMessage.trim() !== '') {
                                                                                document.getElementById('duplicateToastBody').innerHTML = duplicateMessage;
                                                                                new bootstrap.Toast(document.getElementById('duplicateToast')).show();
                                                                            }

                                                                            if (duplicateEditMessage && duplicateEditMessage.trim() !== '') {
                                                                                document.getElementById('duplicateEditToastBody').innerHTML = duplicateEditMessage;
                                                                                new bootstrap.Toast(document.getElementById('duplicateEditToast')).show();
                                                                            }

                                                                            // Restore active tab
                                                                            const activeTab = localStorage.getItem('activeTab');
                                                                            if (activeTab) {
                                                                                const tabElement = document.getElementById(activeTab);
                                                                                if (tabElement) {
                                                                                    new bootstrap.Tab(tabElement).show();
                                                                                }
                                                                            }
                                                                        });

                                                                        // Save active tab
                                                                        document.querySelectorAll('[data-bs-toggle="tab"]').forEach(tab => {
                                                                            tab.addEventListener('shown.bs.tab', function (event) {
                                                                                localStorage.setItem('activeTab', event.target.id);
                                                                            });
                                                                        });

                                                                        // Initialize TinyMCE
                                                                        tinymce.init({
                                                                            selector: 'textarea',
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
        </script>
    </body>
</html>