<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách CV của tôi</title>
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
            max-width: 1400px;
        }

        h2 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 10px;
            text-align: center;
            letter-spacing: -0.5px;
            position: relative;
            padding-bottom: 20px;
        }
        
        h2::after {
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
        
        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .btn-create {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 8px rgba(102,126,234,0.3);
        }
        
        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102,126,234,0.4);
            color: #fff;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex: 1;
            max-width: 500px;
        }
        
        .search-input {
            flex: 1;
            padding: 10px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.15);
        }
        
        .btn-search {
            padding: 10px 20px;
            background-color: #495057;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .btn-search:hover {
            background-color: #343a40;
            transform: translateY(-1px);
        }
        
        .filter-section {
            background-color: #f8f9fa;
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #e9ecef;
            display: flex;
            gap: 20px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-section strong {
            color: #495057;
            font-weight: 600;
        }
        
        .filter-section a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 4px 8px;
            border-radius: 4px;
            transition: all 0.2s ease;
        }
        
        .filter-section a:hover {
            background-color: #e9ecef;
            color: #5568d3;
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
        
        tbody td:first-child {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .badge {
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 6px;
            display: inline-block;
        }
        
        .badge-uploaded {
            background-color: #d1e7dd;
            color: #0a3622;
        }
        
        .badge-builder {
            background-color: #cfe2ff;
            color: #052c65;
        }
        
        .action-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            margin: 0 4px;
            transition: all 0.2s ease;
        }
        
        .action-link:hover {
            color: #5568d3;
            text-decoration: underline;
        }
        
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            background-color: #f8f9fa;
            color: #495057;
        }
        
        .btn-action:hover {
            background-color: #e9ecef;
            transform: translateY(-1px);
        }
        
        .btn-delete {
            color: #dc3545;
            background-color: #f8d7da;
        }
        
        .btn-delete:hover {
            background-color: #f1aeb5;
        }
        
        .pagination-section {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .pagination-info {
            color: #6c757d;
            font-weight: 500;
        }
        
        .pagination-links {
            display: flex;
            gap: 10px;
            align-items: center;
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
        
        .page-current {
            color: #667eea;
            font-weight: 600;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            padding: 16px 20px;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #58151c;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            h2 {
                font-size: 1.75rem;
            }
            
            .top-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-form {
                max-width: 100%;
            }
            
            table {
                font-size: 0.85rem;
            }
            
            tbody td {
                padding: 12px;
            }
            
            .action-link {
                display: block;
                margin: 4px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>
    <!-- Header Area End -->

    <div class="container mt-5 mb-5">
        <h2>Danh sách CV của tôi</h2>
        <p class="page-subtitle">Quản lý và chỉnh sửa các CV của bạn</p>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fa fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <!-- Top Actions -->
        <div class="top-actions">
            <a href="${pageContext.request.contextPath}/cv/create" class="btn-create">
                <i class="fa fa-plus"></i> Tạo CV mới
            </a>
            
            <form method="get" action="${pageContext.request.contextPath}/cv/list" class="search-form">
                <input type="text" name="q" value="${q}" placeholder="Tìm kiếm theo tiêu đề, kỹ năng..." class="search-input" />
                <input type="hidden" name="sort" value="${sort}" />
                <input type="hidden" name="dir" value="${dir}" />
                <input type="hidden" name="size" value="${size}" />
                <button type="submit" class="btn-search">
                    <i class="fa fa-search"></i> Tìm kiếm
                </button>
            </form>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <div>
                <strong><i class="fa fa-sort"></i> Sắp xếp:</strong>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=title&dir=${dir}&page=1&size=${size}">Tiêu đề</a>
                <span>|</span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=updated&dir=${dir}&page=1&size=${size}">Cập nhật gần nhất</a>
            </div>
            <div>
                <strong><i class="fa fa-filter"></i> Thứ tự:</strong>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=asc&page=1&size=${size}">Tăng dần</a>
                <span>/</span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=desc&page=1&size=${size}">Giảm dần</a>
            </div>
        </div>
        
        <!-- CV Table -->
        <table>
            <thead>
                <tr>
                    <th>Tiêu đề</th>
                    <th>Loại</th>
                    <th>Mẫu</th>
                    <th>Mặc định</th>
                    <th>Cập nhật</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cvs}" var="cv">
                    <tr>
                        <td>${cv.title}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty cv.filePath}">
                                    <span class="badge badge-uploaded">📄 PDF</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-builder">✏️ Builder</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${cv.templateCode}</td>
                        <td>
                            <c:if test="${cv.isDefault}">
                                <span style="font-size: 1.2rem;">✅</span>
                            </c:if>
                        </td>
                        <td>
                            <fmt:formatDate value="${cv.lastUpdated}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td style="white-space: nowrap;">
                            <a href="${pageContext.request.contextPath}/cv/edit?cvid=${cv.cvId}" class="action-link">
                                <i class="fa fa-edit"></i> Sửa
                            </a>
                            <span>|</span>
                            <a target="_blank" href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}&preview=1" class="action-link">
                                <i class="fa fa-eye"></i> Xem
                            </a>
                            <span>|</span>
                            <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" class="action-link">
                                <i class="fa fa-download"></i> Tải
                            </a>
                            <span>|</span>
                            <form action="${pageContext.request.contextPath}/cv/default" method="post" style="display:inline">
                                <input type="hidden" name="cvid" value="${cv.cvId}"/>
                                <button type="submit" class="btn-action">
                                    <i class="fa fa-star"></i> Đặt mặc định
                                </button>
                            </form>
                            <span>|</span>
                            <form action="${pageContext.request.contextPath}/cv/delete" method="post" style="display:inline"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa CV này?');">
                                <input type="hidden" name="cvid" value="${cv.cvId}"/>
                                <button type="submit" class="btn-action btn-delete">
                                    <i class="fa fa-trash"></i> Xóa
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <div class="pagination-section">
            <div class="pagination-info">
                <i class="fa fa-list"></i> Tổng số: <strong>${total}</strong> CV
            </div>
            
            <div class="pagination-links">
                <c:set var="prev" value="${page - 1}"/>
                <c:set var="next" value="${page + 1}"/>
                
                <c:if test="${page > 1}">
                    <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=${dir}&page=${prev}&size=${size}" class="page-link">
                        <i class="fa fa-chevron-left"></i> Trước
                    </a>
                </c:if>
                
                <span class="page-current">
                    Trang ${page} / ${totalPages}
                </span>
                
                <c:if test="${page < totalPages}">
                    <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=${dir}&page=${next}&size=${size}" class="page-link">
                        Sau <i class="fa fa-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <!-- Bootstrap and JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
