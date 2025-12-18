<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách CV của tôi</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --color-primary: #2B59FF;
            --color-primary-dark: #1E3FCC;
            --color-text-primary: #0A0E27;
            --color-text-secondary: #5B6B8C;
            --color-border: #E4E8F0;
            --color-background: #FAFBFC;
            --color-surface: #FFFFFF;
            --color-success: #0EA770;
            --color-success-light: #E8F7F0;
            --color-danger: #E03E52;
            --color-danger-light: #FFEBEE;
            --color-info: #0EA5E9;
            --color-info-light: #E0F2FE;
            --shadow-sm: 0 1px 2px rgba(10, 14, 39, 0.03);
            --shadow-md: 0 4px 12px rgba(10, 14, 39, 0.06);
            --shadow-lg: 0 12px 32px rgba(10, 14, 39, 0.08);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--color-background);
            color: var(--color-text-primary);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 3rem;
            animation: fadeInUp 0.6s ease-out;
            text-align: center;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
            letter-spacing: -0.01em;
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--color-text-secondary);
            font-weight: 400;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: var(--radius-md);
            margin-bottom: 2rem;
            display: flex;
            align-items: flex-start;
            gap: 0.875rem;
            font-size: 0.9375rem;
            border: 1px solid;
            animation: slideInRight 0.4s ease-out;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-danger {
            background: var(--color-danger-light);
            border-color: var(--color-danger);
            color: var(--color-danger);
        }

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            animation: fadeInUp 0.6s ease-out 0.1s both;
        }

        .btn-create {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: var(--color-primary);
            color: white;
            text-decoration: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.9375rem;
            transition: all 0.2s ease;
            border: 1px solid var(--color-primary);
        }

        .btn-create:hover {
            background: var(--color-primary-dark);
            border-color: var(--color-primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(43, 89, 255, 0.2);
        }

        .search-form {
            display: flex;
            gap: 0.75rem;
            flex: 1;
            max-width: 500px;
        }

        .search-input {
            flex: 1;
            padding: 0.625rem 1rem;
            border: 1px solid var(--color-border);
            border-radius: var(--radius-sm);
            font-size: 0.9375rem;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
        }

        .btn-search {
            padding: 0.625rem 1.25rem;
            background: var(--color-text-secondary);
            color: white;
            border: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.9375rem;
        }

        .btn-search:hover {
            background: var(--color-text-primary);
        }

        .filter-bar {
            background: #F8FAFC;
            padding: 1rem 1.5rem;
            border-radius: var(--radius-md);
            margin-bottom: 2rem;
            border: 1px solid var(--color-border);
            display: flex;
            gap: 2rem;
            align-items: center;
            flex-wrap: wrap;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .filter-label {
            color: var(--color-text-primary);
            font-weight: 600;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .filter-link {
            color: var(--color-text-secondary);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            transition: all 0.2s ease;
        }

        .filter-link:hover {
            background: white;
            color: var(--color-primary);
        }

        .table-card {
            background: var(--color-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--color-border);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            animation: fadeInUp 0.6s ease-out 0.3s both;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(to bottom, #F8FAFC, #F1F5F9);
            border-bottom: 2px solid var(--color-border);
        }

        th {
            padding: 1rem 1.25rem;
            text-align: left;
            font-weight: 600;
            color: var(--color-text-secondary);
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.08em;
        }

        tbody tr {
            border-bottom: 1px solid var(--color-border);
            transition: background-color 0.2s ease;
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #F8FAFC;
        }

        td {
            padding: 1.25rem;
            color: var(--color-text-primary);
            vertical-align: middle;
            font-size: 0.9375rem;
        }

        .cv-title {
            font-weight: 600;
            color: var(--color-text-primary);
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8125rem;
            font-weight: 500;
            border: 1px solid;
        }

        .badge-uploaded {
            background: var(--color-success-light);
            color: var(--color-success);
            border-color: #BBF7D0;
        }

        .badge-builder {
            background: var(--color-info-light);
            color: var(--color-info);
            border-color: #BAE6FD;
        }

        .actions-cell {
            white-space: nowrap;
        }

        .action-link {
            color: var(--color-primary);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: color 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .action-link:hover {
            color: var(--color-primary-dark);
            text-decoration: underline;
        }

        .action-separator {
            color: var(--color-border);
            margin: 0 0.5rem;
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            border: 1px solid var(--color-border);
            border-radius: var(--radius-sm);
            font-size: 0.8125rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            background: white;
            color: var(--color-text-secondary);
        }

        .btn-action:hover {
            background: #F8FAFC;
            border-color: var(--color-primary);
            color: var(--color-primary);
        }

        .btn-delete {
            color: var(--color-danger);
            border-color: var(--color-danger);
            background: white;
        }

        .btn-delete:hover {
            background: var(--color-danger);
            color: white;
        }

        .pagination-section {
            margin-top: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1.5rem;
            border-top: 1px solid var(--color-border);
            flex-wrap: wrap;
            gap: 1rem;
        }

        .pagination-info {
            color: var(--color-text-secondary);
            font-size: 0.9375rem;
            font-weight: 500;
        }

        .pagination-links {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }

        .page-link {
            padding: 0.5rem 1rem;
            background: white;
            color: var(--color-text-primary);
            text-decoration: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            border: 1px solid var(--color-border);
            transition: all 0.2s ease;
            font-size: 0.875rem;
        }

        .page-link:hover {
            background: #F8FAFC;
            border-color: var(--color-primary);
            color: var(--color-primary);
        }

        .page-current {
            color: var(--color-text-secondary);
            font-weight: 600;
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .toolbar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-form {
                max-width: 100%;
            }

            .filter-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .table-card {
                overflow-x: auto;
            }

            th, td {
                padding: 0.75rem;
                font-size: 0.875rem;
            }

            .actions-cell {
                white-space: normal;
            }

            .action-link {
                display: block;
                margin: 0.25rem 0;
            }

            .action-separator {
                display: none;
            }

            .pagination-section {
                flex-direction: column;
                align-items: stretch;
            }

            .pagination-links {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Danh sách CV của tôi</h1>
            <p class="page-subtitle">Quản lý và chỉnh sửa các CV của bạn</p>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>
        
        <!-- Toolbar -->
        <div class="toolbar">
            <a href="${pageContext.request.contextPath}/cv/create" class="btn-create">
                <i class="fa fa-plus"></i>
                Tạo CV mới
            </a>
            
            <form method="get" action="${pageContext.request.contextPath}/cv/list" class="search-form">
                <input type="text" name="q" value="${q}" placeholder="Tìm kiếm theo tiêu đề, kỹ năng..." class="search-input" />
                <input type="hidden" name="sort" value="${sort}" />
                <input type="hidden" name="dir" value="${dir}" />
                <input type="hidden" name="size" value="${size}" />
                <button type="submit" class="btn-search">
                    <i class="fa fa-search"></i>
                    Tìm kiếm
                </button>
            </form>
        </div>
        
        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="filter-group">
                <span class="filter-label">
                    <i class="fa fa-sort"></i>
                    Sắp xếp:
                </span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=title&dir=${dir}&page=1&size=${size}" class="filter-link">Tiêu đề</a>
                <span>|</span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=updated&dir=${dir}&page=1&size=${size}" class="filter-link">Cập nhật gần nhất</a>
            </div>
            <div class="filter-group">
                <span class="filter-label">
                    <i class="fa fa-filter"></i>
                    Thứ tự:
                </span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=asc&page=1&size=${size}" class="filter-link">Tăng dần</a>
                <span>/</span>
                <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=desc&page=1&size=${size}" class="filter-link">Giảm dần</a>
            </div>
        </div>
        
        <!-- CV Table -->
        <div class="table-card">
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
                            <td class="cv-title">${cv.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty cv.filePath}">
                                        <span class="badge badge-uploaded">
                                            <i class="fas fa-file-pdf"></i>
                                            PDF
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-builder">
                                            <i class="fas fa-edit"></i>
                                            Builder
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${cv.templateCode}</td>
                            <td>
                                <c:if test="${cv.isDefault}">
                                    <i class="fas fa-check-circle" style="color: var(--color-success); font-size: 1.25rem;"></i>
                                </c:if>
                            </td>
                            <td>
                                <fmt:formatDate value="${cv.lastUpdated}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td class="actions-cell">
                                <a href="${pageContext.request.contextPath}/cv/edit?cvid=${cv.cvId}" class="action-link">
                                    <i class="fa fa-edit"></i>
                                    Sửa
                                </a>
                                <span class="action-separator">|</span>
                                <a target="_blank" href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}&preview=1" class="action-link">
                                    <i class="fa fa-eye"></i>
                                    Xem
                                </a>
                                <span class="action-separator">|</span>
                                <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" class="action-link">
                                    <i class="fa fa-download"></i>
                                    Tải
                                </a>
                                <span class="action-separator">|</span>
                                <form action="${pageContext.request.contextPath}/cv/default" method="post" style="display:inline">
                                    <input type="hidden" name="cvid" value="${cv.cvId}"/>
                                    <button type="submit" class="btn-action">
                                        <i class="fa fa-star"></i>
                                        Đặt mặc định
                                    </button>
                                </form>
                                <span class="action-separator">|</span>
                                <form action="${pageContext.request.contextPath}/cv/delete" method="post" style="display:inline"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa CV này?');">
                                    <input type="hidden" name="cvid" value="${cv.cvId}"/>
                                    <button type="submit" class="btn-action btn-delete">
                                        <i class="fa fa-trash"></i>
                                        Xóa
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
                    <i class="fa fa-list"></i>
                    Tổng số: <strong>${total}</strong> CV
                </div>
                
                <div class="pagination-links">
                    <c:set var="prev" value="${page - 1}"/>
                    <c:set var="next" value="${page + 1}"/>
                    
                    <c:if test="${page > 1}">
                        <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=${dir}&page=${prev}&size=${size}" class="page-link">
                            <i class="fa fa-chevron-left"></i>
                            Trước
                        </a>
                    </c:if>
                    
                    <span class="page-current">
                        Trang ${page} / ${totalPages}
                    </span>
                    
                    <c:if test="${page < totalPages}">
                        <a href="${pageContext.request.contextPath}/cv/list?q=${q}&sort=${sort}&dir=${dir}&page=${next}&size=${size}" class="page-link">
                            Sau
                            <i class="fa fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
