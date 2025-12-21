<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Bài Viết - Handbook</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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

            .bg-secondary {
                background-color: #6c757d !important;
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
                    <div class="col-md-2">
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                    </div>

                    <div class="col-md-10">
                        <div class="container-fluid p-4">
                            <h6 class="fw-medium mb-30 text-center fs-2">QUẢN LÝ BÀI VIẾT HANDBOOK</h6>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${success}
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <form action="${pageContext.request.contextPath}/handbook_admin" method="GET" class="d-flex align-items-center" style="gap: 8px;">
                                <select class="form-select" name="status" style="width: 200px;">
                                    <option value="">Tất Cả</option>
                                    <option value="Draft" ${status == 'Draft' ? 'selected' : ''}>Nháp</option>
                                    <option value="Published" ${status == 'Published' ? 'selected' : ''}>Đã Xuất Bản</option>
                                </select>
                                <input class="form-control" type="text" name="search" placeholder="Tìm theo tiêu đề..." value="${search}" style="width: 360px;">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i> Tìm
                                </button>
                            </form>

                            <a class="btn btn-success btn-lg" href="${pageContext.request.contextPath}/handbook_admin?action=create">
                                <i class="fas fa-plus me-2"></i>Thêm Bài Viết
                            </a>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tiêu Đề</th>
                                        <th>Trạng Thái</th>
                                        <th>Cập Nhật</th>
                                        <th>Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${posts}" var="p">
                                        <tr>
                                            <td>${p.handbookPostID}</td>
                                            <td style="text-align: left;">${p.title}</td>
                                            <td>
                                                <span class="badge ${p.status == 'Published' ? 'bg-success' : 'bg-secondary'}">
                                                    ${p.status == 'Published' ? 'Đã Xuất Bản' : 'Nháp'}
                                                </span>
                                            </td>
                                            <td>${p.updatedAt}</td>
                                            <td>
                                                <a class="btn btn-sm btn-info" href="${pageContext.request.contextPath}/handbook_admin?action=edit&id=${p.handbookPostID}">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/handbook_admin" method="POST" style="display: inline;" onsubmit="return confirm('Xác nhận xóa bài viết này?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${p.handbookPostID}">
                                                    <button class="btn btn-sm btn-danger" type="submit">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <c:if test="${pageControl.totalPages > 1}">
                            <nav aria-label="Phân trang" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${pageControl.page > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page-1}">
                                                <i class="fas fa-chevron-left"></i> Trước
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:set var="startPage" value="${pageControl.page - 2 > 0 ? pageControl.page - 2 : 1}" />
                                    <c:set var="endPage" value="${startPage + 4 <= pageControl.totalPages ? startPage + 4 : pageControl.totalPages}" />

                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${startPage-1}">...</a>
                                        </li>
                                    </c:if>

                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == pageControl.page ? 'active' : ''}">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${endPage < pageControl.totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${endPage + 1}">...</a>
                                        </li>
                                    </c:if>

                                    <c:if test="${pageControl.page < pageControl.totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page+1}">
                                                Sau <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>