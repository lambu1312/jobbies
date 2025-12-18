<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.JobPostings" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ứng dụng của tôi</title>
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
                --color-warning: #F59E0B;
                --color-warning-light: #FFF9EB;
                --color-info: #0EA5E9;
                --color-info-light: #E0F2FE;
                --color-secondary: #6c757d;
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
                max-width: 1200px;
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

            .alert i {
                flex-shrink: 0;
                margin-top: 0.125rem;
            }

            .alert-danger {
                background: var(--color-danger-light);
                border-color: var(--color-danger);
                color: var(--color-danger);
            }

            .alert-success {
                background: var(--color-success-light);
                border-color: var(--color-success);
                color: var(--color-success);
            }

            .filter-container {
                margin-bottom: 1.5rem;
                animation: fadeInUp 0.6s ease-out 0.05s both;
            }

            .form-select {
                padding: 0.625rem 2.5rem 0.625rem 1rem;
                border: 1px solid var(--color-border);
                border-radius: var(--radius-sm);
                font-size: 0.9375rem;
                color: var(--color-text-primary);
                background-color: var(--color-surface);
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%235B6B8C' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 0.75rem center;
                background-size: 16px 12px;
                appearance: none;
                cursor: pointer;
                transition: all 0.2s ease;
                max-width: 300px;
            }

            .form-select:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
            }

            .table-card {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                overflow: hidden;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out 0.1s both;
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
                padding: 1.25rem 1.5rem;
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
                padding: 1.5rem;
                color: var(--color-text-primary);
                vertical-align: middle;
            }

            .action-cell {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                flex-wrap: wrap;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.625rem 1.125rem;
                border-radius: var(--radius-sm);
                font-weight: 500;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                border: 1px solid;
                white-space: nowrap;
            }

            .btn i {
                font-size: 0.875rem;
            }

            .btn-primary {
                background: var(--color-primary);
                color: white;
                border-color: var(--color-primary);
            }

            .btn-primary:hover {
                background: var(--color-primary-dark);
                border-color: var(--color-primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(43, 89, 255, 0.2);
            }

            .btn-info {
                background: var(--color-info);
                color: white;
                border-color: var(--color-info);
            }

            .btn-info:hover {
                background: #0284C7;
                border-color: #0284C7;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(14, 165, 233, 0.2);
            }

            .btn-info:disabled {
                background: #E4E8F0;
                border-color: #E4E8F0;
                color: #9CA3AF;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .btn-danger {
                background: var(--color-danger);
                color: white;
                border-color: var(--color-danger);
            }

            .btn-danger:hover {
                background: #C42D3F;
                border-color: #C42D3F;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(224, 62, 82, 0.25);
            }

            .btn-danger:disabled {
                background: #E4E8F0;
                border-color: #E4E8F0;
                color: #9CA3AF;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .btn-secondary {
                background: #F8FAFC;
                color: var(--color-text-secondary);
                border-color: var(--color-border);
            }

            .btn-secondary:hover {
                background: #F1F5F9;
                border-color: #CBD5E1;
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
                white-space: nowrap;
            }

            .badge.bg-info {
                background: var(--color-info-light);
                color: var(--color-info);
                border-color: #BAE6FD;
            }

            .badge.bg-success {
                background: var(--color-success-light);
                color: var(--color-success);
                border-color: #BBF7D0;
            }

            .badge.bg-danger {
                background: var(--color-danger-light);
                color: var(--color-danger);
                border-color: #FECACA;
            }

            .badge.bg-warning {
                background: var(--color-warning-light);
                color: var(--color-warning);
                border-color: #FCD34D;
            }

            .badge.bg-secondary {
                background: #F1F5F9;
                color: var(--color-secondary);
                border-color: #CBD5E1;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(10, 14, 39, 0.4);
                backdrop-filter: blur(4px);
            }

            .modal.show {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem;
            }

            .modal-content {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                max-width: 480px;
                width: 100%;
                box-shadow: 0 24px 48px rgba(10, 14, 39, 0.15);
                animation: scaleIn 0.2s ease-out;
            }

            @keyframes scaleIn {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            .modal-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1.5rem 1.5rem 1rem;
                border-bottom: 1px solid var(--color-border);
            }

            .modal-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--color-text-primary);
            }

            .btn-close {
                background: none;
                border: none;
                color: var(--color-text-secondary);
                font-size: 1.5rem;
                cursor: pointer;
                padding: 0.25rem;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 6px;
                transition: all 0.2s ease;
            }

            .btn-close::before {
                content: "×";
                font-size: 1.5rem;
            }

            .btn-close:hover {
                background: #F1F5F9;
                color: var(--color-text-primary);
            }

            .modal-body {
                padding: 1.5rem;
                color: var(--color-text-secondary);
                font-size: 0.9375rem;
                line-height: 1.6;
            }

            .modal-footer {
                display: flex;
                gap: 0.75rem;
                justify-content: flex-end;
                padding: 1rem 1.5rem 1.5rem;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 0.5rem;
                margin-top: 2rem;
                flex-wrap: wrap;
                list-style: none;
            }

            .page-item {
                display: flex;
            }

            .page-link {
                min-width: 40px;
                height: 40px;
                padding: 0 0.75rem;
                background: var(--color-surface);
                border: 1px solid var(--color-border);
                border-radius: var(--radius-sm);
                color: var(--color-text-primary);
                text-decoration: none;
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 500;
                font-size: 0.875rem;
            }

            .page-link:hover {
                background: #F8FAFC;
                border-color: var(--color-primary);
                color: var(--color-primary);
            }

            .page-item.active .page-link {
                background: var(--color-primary);
                border-color: var(--color-primary);
                color: white;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 2rem 1rem;
                }

                .page-title {
                    font-size: 1.75rem;
                }

                .table-card {
                    overflow-x: auto;
                }

                th,
                td {
                    padding: 1rem;
                    font-size: 0.875rem;
                }

                .action-cell {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .btn {
                    width: 100%;
                    justify-content: center;
                }

                .form-select {
                    max-width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Ứng dụng của tôi</h1>
                <p class="page-subtitle">Quản lý các đơn ứng tuyển của bạn</p>
            </div>

            <!-- Display error or success message if any -->
            <c:if test="${not empty errorApplication}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${errorApplication}</span>
                </div>
            </c:if>

            <c:if test="${not empty successApplication}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${successApplication}</span>
                </div>
            </c:if>

            <!-- Applications Table -->
            <c:if test="${not empty applications}">
                <div class="filter-container">
                    <form action="application" method="GET">
                        <select name="status" class="form-select" onchange="this.form.submit()">
                            <option value="" ${empty param.status ? 'selected' : ''}>Tất cả trạng thái</option>
                            <option value="3" ${param.status == '3' ? 'selected' : ''}>Chưa giải quyết</option>
                            <option value="2" ${param.status == '2' ? 'selected' : ''}>Đậu</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Loại</option>
                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã Hủy</option>
                        </select>
                    </form>
                </div>

                <div class="table-card">
                    <table>
                        <thead>
                            <tr>
                                <th>Chức danh</th>
                                <th>Ngày nộp đơn</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td><c:out value="${jobPostingMap[app.applicationID]}" /></td>
                                    <td>${app.appliedDate}</td>
                                    <td>
                                        <!-- Display the violation message if it exists, otherwise display the status badge -->
                                        <c:choose>
                                            <c:when test="${applicationStatusMap[app.applicationID] == 'Violate'}">
                                                <span class="badge bg-warning"><i class="fa-solid fa-triangle-exclamation"></i> Vi Phạm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${app.status == 3}">
                                                        <span class="badge bg-info"><i class="fa fa-clock"></i> Chưa Giải Quyết</span>
                                                    </c:when>
                                                    <c:when test="${app.status == 2}">
                                                        <span class="badge bg-success"><i class="fa fa-check-circle"></i> Đậu</span>
                                                    </c:when>
                                                    <c:when test="${app.status == 1}">
                                                        <span class="badge bg-danger"><i class="fa fa-times-circle"></i> Loại</span>
                                                    </c:when>
                                                    <c:when test="${app.status == 0}">
                                                        <span class="badge bg-secondary"><i class="fa fa-ban"></i> Đã Hủy</span>
                                                    </c:when>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-cell">
                                            <!-- View Button: Disabled if the job posting is "Violate" -->
                                            <button type="button" 
                                                    class="btn btn-info" 
                                                    onclick="window.location.href = '${pageContext.request.contextPath}/ViewDetailApplication?action=details&applicationId=${app.applicationID}'"
                                                    <c:if test="${applicationStatusMap[app.applicationID] == 'Violate'}">disabled</c:if>>
                                                <i class="fa-solid fa-eye"></i> Xem chi tiết
                                            </button>

                                            <!-- Cancel Button: Disabled if the application status is not Pending (3) or the job posting is "Violate" -->
                                            <button type="button" 
                                                    class="btn btn-danger" 
                                                    onclick="openModal('cancelApplicationModal-${app.applicationID}')"
                                                    <c:if test="${app.status != 3 || applicationStatusMap[app.applicationID] == 'Violate'}">disabled</c:if>>
                                                <i class="fa fa-ban"></i> Hủy bỏ
                                            </button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Modal for Cancel Application -->
                                <div class="modal" id="cancelApplicationModal-${app.applicationID}">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Hủy đơn đăng ký</h5>
                                            <button type="button" class="btn-close" onclick="closeModal('cancelApplicationModal-${app.applicationID}')"></button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/application" method="post">
                                            <div class="modal-body">
                                                <p>Bạn có chắc chắn muốn hủy đơn đăng ký này không? Hành động này không thể hoàn tác.</p>
                                                <input type="hidden" name="action" value="cancel-application">
                                                <input type="hidden" name="applicationId" value="${app.applicationID}">
                                                <input type="hidden" name="status" value="0">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" onclick="closeModal('cancelApplicationModal-${app.applicationID}')">Đóng</button>
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fa fa-ban"></i> Xác nhận Hủy
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${currentPage - 1}&status=${selectedStatus}">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${i}&status=${selectedStatus}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${currentPage + 1}&status=${selectedStatus}">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            function openModal(modalId) {
                const modal = document.getElementById(modalId);
                modal.classList.add('show');
                document.body.style.overflow = 'hidden';
            }

            function closeModal(modalId) {
                const modal = document.getElementById(modalId);
                modal.classList.remove('show');
                document.body.style.overflow = 'auto';
            }

            // Close modal when clicking outside
            window.onclick = function (event) {
                if (event.target.classList.contains('modal')) {
                    event.target.classList.remove('show');
                    document.body.style.overflow = 'auto';
                }
            }

            // Close modal on ESC key
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape') {
                    const modals = document.querySelectorAll('.modal.show');
                    modals.forEach(modal => {
                        modal.classList.remove('show');
                    });
                    document.body.style.overflow = 'auto';
                }
            });
        </script>
    </body>
</html>
