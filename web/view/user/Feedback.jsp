<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.JobPostings"%>
<%@page import="dao.JobPostingsDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản hồi của tôi</title>
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

            th:last-child {
                text-align: center;
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

            td:last-child {
                text-align: center;
            }

            .feedback-content {
                font-size: 0.9375rem;
                color: var(--color-text-primary);
                line-height: 1.5;
            }

            .job-link {
                color: var(--color-primary);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .job-link:hover {
                color: var(--color-primary-dark);
                text-decoration: underline;
            }

            .action-cell {
                display: flex;
                align-items: center;
                justify-content: center;
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

            .btn-warning {
                background: var(--color-warning);
                color: white;
                border-color: var(--color-warning);
            }

            .btn-warning:hover {
                background: #D97706;
                border-color: #D97706;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(245, 158, 11, 0.25);
            }

            .btn-warning:disabled {
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

            .btn-secondary {
                background: #F8FAFC;
                color: var(--color-text-secondary);
                border-color: var(--color-border);
            }

            .btn-secondary:hover {
                background: #F1F5F9;
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
                max-width: 600px;
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
                display: flex;
                align-items: center;
                gap: 0.5rem;
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
            }

            .form-label {
                font-weight: 600;
                color: var(--color-text-primary);
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .form-control {
                padding: 0.625rem 1rem;
                border: 1px solid var(--color-border);
                border-radius: var(--radius-sm);
                font-size: 0.9375rem;
                color: var(--color-text-primary);
                background-color: var(--color-surface);
                transition: all 0.2s ease;
                width: 100%;
                font-family: inherit;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
            }

            textarea.form-control {
                resize: vertical;
                min-height: 120px;
            }

            .modal-footer {
                display: flex;
                gap: 0.75rem;
                justify-content: flex-end;
                padding: 1rem 1.5rem 1.5rem;
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
                font-size: 1rem;
            }

            .back-to-top {
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                width: 48px;
                height: 48px;
                border-radius: 50%;
                display: none;
                align-items: center;
                justify-content: center;
                background: var(--color-primary);
                color: white;
                border: none;
                cursor: pointer;
                box-shadow: 0 4px 12px rgba(43, 89, 255, 0.3);
                transition: all 0.2s ease;
                z-index: 999;
            }

            .back-to-top:hover {
                background: var(--color-primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(43, 89, 255, 0.4);
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
                }

                .btn {
                    width: 100%;
                    justify-content: center;
                }

                .back-to-top {
                    bottom: 1rem;
                    right: 1rem;
                    width: 44px;
                    height: 44px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
        
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Phản hồi của tôi</h1>
                <p class="page-subtitle">Quản lý các phản hồi của bạn về các tin tuyển dụng</p>
            </div>

            <c:choose>
                <c:when test="${not empty feedbackList}">
                    <div class="table-card">
                        <table>
                            <thead>
                                <tr>
                                    <th>Nội dung phản hồi</th>
                                    <th>Tiêu đề công việc</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                JobPostings jobPost = new JobPostings();
                                JobPostingsDAO jobPostDao = new JobPostingsDAO();
                            %>
                            <c:forEach var="feedback" items="${feedbackList}">
                                <c:if test="${feedback.getStatus() != 4}">
                                    <tr>
                                        <td>
                                            <div class="feedback-content">
                                                ${feedback.getContentFeedback()}
                                            </div>
                                        </td>
                                        <td>
                                            <c:set var="jobPostId" value="${feedback.getJobPostingID()}"/>
                                            <%
                                                int jobPostId = (Integer) pageContext.getAttribute("jobPostId");
                                                jobPost = jobPostDao.findJobPostingById(jobPostId);
                                                String title = "";
                                                if(jobPost != null){
                                                    title = jobPost.getTitle();
                                                }
                                            %>
                                            <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${feedback.getJobPostingID()}" class="job-link">
                                                <i class="fa fa-briefcase"></i>
                                                <span><%= title %></span>
                                            </a>
                                        </td>
                                        <td>
                                            <div class="action-cell">
                                                <button type="button" class="btn btn-warning" 
                                                        onclick="openEditModal('${feedback.getFeedbackID()}', '${feedback.getContentFeedback()}')"
                                                        <c:if test="${feedback.getStatus() != 1}">disabled</c:if>>
                                                    <i class="fas fa-edit"></i> Sửa
                                                </button>
                                                <form action="feedbackSeeker" method="post" style="display:inline;">
                                                    <input type="hidden" name="feedbackId" value="${feedback.getFeedbackID()}"/>
                                                    <input type="hidden" name="action" value="delete"/>
                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa phản hồi này?');">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fa fa-comments"></i>
                        </div>
                        <h3>Chưa có phản hồi nào</h3>
                        <p>Bạn chưa có phản hồi nào. Hãy bắt đầu phản hồi về các tin tuyển dụng!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Edit Feedback Modal -->
        <div class="modal" id="editFeedbackModal">
            <div class="modal-content">
                <form action="feedbackSeeker" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fa fa-edit"></i>
                            <span>Chỉnh sửa phản hồi</span>
                        </h5>
                        <button type="button" class="btn-close" onclick="closeEditModal()"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editFeedbackContent" class="form-label">
                                <i class="fa fa-comment"></i>
                                <span>Nội dung phản hồi</span>
                            </label>
                            <textarea class="form-control" id="editFeedbackContent" name="content" rows="5" placeholder="Nhập nội dung phản hồi của bạn..." required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="action" value="edit"/>
                        <input type="hidden" id="editFeedbackId" name="feedbackId"/>
                        <button type="button" class="btn btn-secondary" onclick="closeEditModal()">
                            <i class="fa fa-times"></i> Hủy
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Back to Top Button -->
        <button type="button" class="back-to-top" id="back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>
        
        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            // Modal functions
            function openEditModal(feedbackId, feedbackContent) {
                const modal = document.getElementById('editFeedbackModal');
                document.getElementById('editFeedbackContent').value = feedbackContent;
                document.getElementById('editFeedbackId').value = feedbackId;
                modal.classList.add('show');
                document.body.style.overflow = 'hidden';
            }

            function closeEditModal() {
                const modal = document.getElementById('editFeedbackModal');
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
            
            // Back to top button
            const backToTopButton = document.getElementById('back-to-top');

            window.onscroll = function () {
                if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                    backToTopButton.style.display = 'flex';
                } else {
                    backToTopButton.style.display = 'none';
                }
            };

            backToTopButton.addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        </script>
    </body>
</html>
