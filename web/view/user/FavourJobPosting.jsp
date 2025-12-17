<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.JobPostings" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Công việc yêu thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(to bottom, #f8f9fa 0%, #e9ecef 100%);
            color: #212529;
            min-height: 100vh;
            padding-bottom: 20px;
        }
        
        /* Sticky Header */
        body > *:first-child,
        header,
        nav,
        .header-area,
        [class*="header"] {
            position: sticky !important;
            top: 0 !important;
            z-index: 1000 !important;
            background-color: #fff !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1) !important;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);
            max-width: 1200px;
            margin: 30px auto;
        }

        h1 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 10px;
            text-align: center;
            letter-spacing: -0.5px;
            position: relative;
            padding-bottom: 20px;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }
        
        .page-subtitle {
            text-align: center;
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 40px;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            padding: 16px 20px;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #58151c;
        }
        
        .alert-success {
            background-color: #d1e7dd;
            color: #0a3622;
        }
        
        table {
            border-collapse: separate;
            border-spacing: 0;
            background-color: #fff;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
        }
        
        thead th {
            background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);
            color: #2c3e50;
            font-weight: 700;
            padding: 16px 18px;
            border-bottom: 2px solid #dee2e6;
            text-align: left;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        tbody tr {
            background-color: #ffffff;
            border-bottom: 1px solid #f1f3f5;
            transition: all 0.2s ease;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        tbody tr:last-child {
            border-bottom: none;
        }
        
        tbody td {
            padding: 16px 18px;
            vertical-align: middle;
            color: #495057;
            font-size: 0.95rem;
        }
        
        .job-title {
            font-weight: 600;
            color: #2c3e50;
            font-size: 1.05rem;
        }
        
        .btn {
            padding: 8px 16px;
            font-size: 0.875rem;
            border-radius: 6px;
            margin-right: 6px;
            font-weight: 500;
            transition: all 0.2s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }
        
        .btn-view {
            background-color: #0dcaf0;
            color: #000;
        }
        
        .btn-view:hover:not(:disabled) {
            background-color: #0aa2c0;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(13,202,240,0.3);
        }
        
        .btn-view:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .btn-unlike {
            background-color: #fff;
            color: #dc3545;
            border: 2px solid #dc3545;
        }
        
        .btn-unlike:hover {
            background-color: #dc3545;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(220,53,69,0.3);
        }
        
        .badge-warning {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 14px;
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffc107;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 6px;
        }
        
        .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        }
        
        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border-bottom: none;
            padding: 20px 24px;
            border-radius: 12px 12px 0 0;
        }
        
        .modal-title {
            font-weight: 600;
            font-size: 1.15rem;
        }
        
        .modal-body {
            padding: 24px;
            color: #495057;
        }
        
        .modal-footer {
            padding: 16px 24px;
            border-top: 1px solid #e9ecef;
        }
        
        .btn-close {
            filter: brightness(0) invert(1);
        }
        
        .btn-secondary {
            background-color: #f8f9fa;
            color: #495057;
            border: 2px solid #e9ecef;
        }
        
        .btn-secondary:hover {
            background-color: #e9ecef;
            color: #212529;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #bb2d3b 100%);
            color: #fff;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220,53,69,0.4);
        }
        
        .pagination-section {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .page-link {
            padding: 8px 16px;
            background-color: #f8f9fa;
            color: #495057;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            border: 2px solid #e9ecef;
            transition: all 0.2s ease;
        }
        
        .page-link:hover {
            background-color: #e9ecef;
            color: #212529;
            transform: translateY(-1px);
        }
        
        .page-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
            color: #fff;
            box-shadow: 0 2px 8px rgba(102,126,234,0.4);
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        
        .empty-state h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 10px;
        }
        
        .empty-state p {
            margin-bottom: 25px;
        }
        
        .empty-state .btn-view {
            padding: 12px 28px;
            font-size: 1rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            h1 {
                font-size: 1.75rem;
            }
            
            table {
                font-size: 0.85rem;
            }
            
            tbody td {
                padding: 12px;
            }
            
            .btn {
                padding: 6px 10px;
                font-size: 0.8rem;
                display: block;
                width: 100%;
                margin-bottom: 6px;
                justify-content: center;
            }
            
            .badge-warning {
                display: block;
                margin: 6px 0 0 0;
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container mt-5">
        <h1>💖 Công việc yêu thích</h1>
        <p class="page-subtitle">Quản lý danh sách các công việc bạn đã lưu</p>

        <!-- Alert Messages -->
        <c:if test="${not empty errorFavourJP}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorFavourJP}</span>
            </div>
        </c:if>

        <c:if test="${not empty successFavourJP}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successFavourJP}</span>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty favourJPs}">
                <table>
                    <thead>
                        <tr>
                            <th>Tiêu đề công việc</th>
                            <th style="text-align: center;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fjp" items="${favourJPs}">
                            <tr>
                                <td class="job-title">
                                    <i class="fa fa-briefcase"></i>
                                    <c:out value="${jobPostingMap[fjp.favourJPID]}" />
                                </td>
                                <td style="text-align: center;">
                                    <button type="button" class="btn btn-view"
                                        onclick="window.location.href='${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${fjp.jobPostingID}'"
                                        <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">disabled</c:if>>
                                        <i class="fas fa-eye"></i> Xem
                                    </button>

                                    <button type="button" class="btn btn-unlike"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#deleteFavourJPModal-${fjp.favourJPID}">
                                        <i class="fas fa-heart-broken"></i> Bỏ thích
                                    </button>

                                    <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">
                                        <span class="badge-warning">
                                            <i class="fas fa-exclamation-triangle"></i>
                                            Vi phạm
                                        </span>
                                    </c:if>
                                </td>
                            </tr>

                            <!-- Modal for Unlike Confirmation -->
                            <div class="modal fade" id="deleteFavourJPModal-${fjp.favourJPID}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">
                                                <i class="fa fa-heart-broken"></i> Bỏ thích công việc
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/FavourJobPosting" method="post">
                                            <div class="modal-body">
                                                <p>Bạn có chắc chắn muốn bỏ thích công việc này không?</p>
                                                <input type="hidden" name="action" value="delete-favourJP">
                                                <input type="hidden" name="favourJPId" value="${fjp.favourJPID}">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                    <i class="fa fa-times"></i> Hủy
                                                </button>
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fas fa-heart-broken"></i> Xác nhận
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <nav class="pagination-section">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage - 1}" class="page-link">
                            <i class="fa fa-chevron-left"></i> Trước
                        </a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${i}" 
                           class="page-link ${i == currentPage ? 'active' : ''}">
                            ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage + 1}" class="page-link">
                            Sau <i class="fa fa-chevron-right"></i>
                        </a>
                    </c:if>
                </nav>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-heart"></i>
                    <h3>Chưa có công việc yêu thích</h3>
                    <p>Bắt đầu tìm kiếm và lưu các công việc bạn quan tâm!</p>
                    <button class="btn btn-view" onclick="window.location.href='${pageContext.request.contextPath}/HomeSeeker'">
                        <i class="fas fa-search"></i> Tìm việc ngay
                    </button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
