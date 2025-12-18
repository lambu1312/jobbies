<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="model.JobPostings" %>
        <%@ page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Favourite Jobs - Jobbies</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

                        th:first-child {
                            width: 50%;
                        }

                        th:last-child {
                            width: 50%;
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

                        td:first-child {
                            width: 50%;
                        }

                        td:last-child {
                            width: 50%;
                        }

                        .job-title {
                            font-weight: 500;
                            font-size: 1rem;
                            color: var(--color-text-primary);
                            line-height: 1.5;
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

                        .btn-primary:disabled {
                            background: #E4E8F0;
                            border-color: #E4E8F0;
                            color: #9CA3AF;
                            cursor: not-allowed;
                            transform: none;
                            box-shadow: none;
                        }

                        .btn-outline-danger {
                            background: white;
                            color: var(--color-danger);
                            border-color: var(--color-danger);
                        }

                        .btn-outline-danger:hover {
                            background: var(--color-danger);
                            color: white;
                            transform: translateY(-1px);
                            box-shadow: 0 4px 12px rgba(224, 62, 82, 0.2);
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

                        .badge-warning {
                            background: var(--color-warning-light);
                            color: var(--color-warning);
                            border-color: #FCD34D;
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
                            animation: fadeIn 0.2s ease-out;
                        }

                        @keyframes fadeIn {
                            from { opacity: 0; }
                            to { opacity: 1; }
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

                        .modal-close {
                            background: none;
                            border: none;
                            color: var(--color-text-secondary);
                            font-size: 1.25rem;
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

                        .modal-close:hover {
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
                        }

                        .page-button {
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

                        .page-button:hover {
                            background: #F8FAFC;
                            border-color: var(--color-primary);
                            color: var(--color-primary);
                        }

                        .page-button.active {
                            background: var(--color-primary);
                            border-color: var(--color-primary);
                            color: white;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 5rem 2rem;
                            animation: fadeInUp 0.6s ease-out;
                        }

                        .empty-state-icon {
                            width: 80px;
                            height: 80px;
                            margin: 0 auto 1.5rem;
                            background: linear-gradient(135deg, #F8FAFC 0%, #F1F5F9 100%);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: var(--color-text-secondary);
                            font-size: 2rem;
                        }

                        .empty-state h3 {
                            font-size: 1.5rem;
                            font-weight: 600;
                            color: var(--color-text-primary);
                            margin-bottom: 0.5rem;
                        }

                        .empty-state p {
                            color: var(--color-text-secondary);
                            margin-bottom: 2rem;
                            font-size: 1rem;
                        }

                        @media (max-width: 768px) {
                            .container {
                                padding: 2rem 1rem;
                            }

                            .page-title {
                                font-size: 2rem;
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

                            .badge {
                                width: 100%;
                                justify-content: center;
                            }
                        }
                    </style>
                </head>

                <body>
                    <!-- Header -->
                    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

                    <div class="container">
                        <div class="page-header">
                            <h1 class="page-title">Công việc yêu thích</h1>
                            <p class="page-subtitle">Quản lý danh sách công việc bạn đã lưu</p>
                        </div>

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
                                <div class="table-card">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Tiêu đề công việc</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="fjp" items="${favourJPs}">
                                                <tr>
                                                    <td>
                                                        <div class="job-title">
                                                            <c:out value="${jobPostingMap[fjp.favourJPID]}" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="action-cell">
                                                            <button type="button" class="btn btn-primary"
                                                                onclick="window.location.href='${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${fjp.jobPostingID}'"
                                                                <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">disabled</c:if>>
                                                                <i class="fas fa-eye"></i>
                                                                Xem chi tiết
                                                            </button>

                                                            <button type="button" class="btn btn-outline-danger"
                                                                onclick="openModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                <i class="fas fa-heart-broken"></i>
                                                                Bỏ thích
                                                            </button>

                                                            <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">
                                                                <span class="badge badge-warning">
                                                                    <i class="fas fa-exclamation-triangle"></i>
                                                                    Công việc vi phạm
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>

                                                <!-- Modal for Unlike Confirmation -->
                                                <div class="modal" id="deleteFavourJPModal-${fjp.favourJPID}">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác nhận bỏ thích</h5>
                                                            <button type="button" class="modal-close"
                                                                onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/FavourJobPosting" method="post">
                                                            <div class="modal-body">
                                                                <p>Bạn có chắc chắn muốn bỏ thích công việc này không? Hành động này không thể hoàn tác.</p>
                                                                <input type="hidden" name="action" value="delete-favourJP">
                                                                <input type="hidden" name="favourJPId" value="${fjp.favourJPID}">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary"
                                                                    onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                    Hủy bỏ
                                                                </button>
                                                                <button type="submit" class="btn btn-danger">
                                                                    <i class="fas fa-heart-broken"></i>
                                                                    Xác nhận
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <nav class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage - 1}"
                                            class="page-button">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${i}"
                                            class="page-button ${i == currentPage ? 'active' : ''}">
                                            ${i}
                                        </a>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage + 1}"
                                            class="page-button">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </c:if>
                                </nav>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <div class="empty-state-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <h3>Chưa có công việc yêu thích</h3>
                                    <p>Khám phá và lưu những công việc phù hợp với bạn ngay hôm nay</p>
                                    <a href="${pageContext.request.contextPath}/HomeSeeker" class="btn btn-primary">
                                        <i class="fas fa-search"></i>
                                        Khám phá công việc
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
