<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Detail - Jobbies</title>
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

            .job-detail-wrapper {
                display: grid;
                grid-template-columns: 1fr 320px;
                gap: 2rem;
            }

            .job-main {
                display: flex;
                flex-direction: column;
                gap: 2rem;
            }

            .card {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                overflow: hidden;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out;
                animation-fill-mode: both;
            }

            .card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .card:nth-child(4) {
                animation-delay: 0.4s;
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

            .job-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--color-text-primary);
                margin-bottom: 1.5rem;
                line-height: 1.3;
                padding: 2rem 2rem 0;
            }

            .job-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                padding: 0 2rem 2rem;
            }

            .meta-item {
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .meta-icon {
                width: 40px;
                height: 40px;
                background: linear-gradient(135deg, #E0F2FE 0%, #F0F9FF 100%);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .meta-icon i {
                color: var(--color-primary);
                font-size: 1rem;
            }

            .meta-content {
                flex: 1;
            }

            .meta-label {
                color: var(--color-text-secondary);
                font-size: 0.8125rem;
                margin-bottom: 0.25rem;
                font-weight: 500;
            }

            .meta-value {
                font-weight: 600;
                color: var(--color-text-primary);
                font-size: 0.9375rem;
            }

            .card-header {
                background: linear-gradient(to bottom, #F8FAFC, #F1F5F9);
                padding: 1.25rem 2rem;
                border-bottom: 2px solid var(--color-border);
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .card-header i {
                font-size: 1.25rem;
                color: var(--color-primary);
            }

            .card-header h5 {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--color-text-primary);
                margin: 0;
            }

            .card-content {
                padding: 2rem;
                color: var(--color-text-secondary);
                line-height: 1.8;
                font-size: 0.9375rem;
            }

            .sidebar {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .action-card {
                position: sticky;
                top: 2rem;
                animation: fadeInUp 0.6s ease-out 0.5s both;
            }

            .action-card .card {
                padding: 1.5rem;
            }

            .btn {
                width: 100%;
                padding: 0.875rem 1.25rem;
                border: none;
                border-radius: var(--radius-sm);
                font-weight: 500;
                font-size: 0.9375rem;
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                text-decoration: none;
                margin-bottom: 0.75rem;
            }

            .btn:last-child {
                margin-bottom: 0;
            }

            .btn i {
                font-size: 0.875rem;
            }

            .btn-like {
                background: white;
                color: var(--color-danger);
                border: 2px solid var(--color-danger);
            }

            .btn-like:hover {
                background: var(--color-danger);
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(224, 62, 82, 0.2);
            }

            .btn-liked {
                background: var(--color-danger-light);
                color: var(--color-danger);
                border: 2px solid var(--color-danger);
                cursor: not-allowed;
            }

            .btn-apply {
                background: var(--color-primary);
                color: white;
                border: 2px solid var(--color-primary);
            }

            .btn-apply:hover {
                background: var(--color-primary-dark);
                border-color: var(--color-primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(43, 89, 255, 0.2);
            }

            .btn-applied {
                background: var(--color-success-light);
                color: var(--color-success);
                border: 2px solid var(--color-success);
                cursor: not-allowed;
            }

            .feedback-form {
                padding: 2rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-label {
                display: block;
                color: var(--color-text-primary);
                font-weight: 600;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-textarea {
                width: 100%;
                padding: 0.875rem;
                background: var(--color-surface);
                border: 1px solid var(--color-border);
                border-radius: var(--radius-sm);
                color: var(--color-text-primary);
                font-size: 0.9375rem;
                outline: none;
                transition: all 0.2s ease;
                resize: vertical;
                min-height: 120px;
                font-family: inherit;
            }

            .form-textarea:focus {
                border-color: var(--color-primary);
                box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
            }

            .form-textarea::placeholder {
                color: #9CA3AF;
            }

            .btn-submit {
                background: var(--color-primary);
                color: white;
                border: 2px solid var(--color-primary);
                width: auto;
                padding: 0.75rem 1.5rem;
            }

            .btn-submit:hover {
                background: var(--color-primary-dark);
                border-color: var(--color-primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(43, 89, 255, 0.25);
            }

            .toast {
                position: fixed;
                top: 2rem;
                right: 2rem;
                background: var(--color-success);
                color: white;
                padding: 1rem 1.5rem;
                border-radius: var(--radius-md);
                box-shadow: 0 10px 40px rgba(14, 167, 112, 0.3);
                display: flex;
                align-items: center;
                gap: 1rem;
                z-index: 1000;
                animation: slideInFromRight 0.3s ease-out;
            }

            @keyframes slideInFromRight {
                from {
                    opacity: 0;
                    transform: translateX(100%);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .toast-close {
                background: none;
                border: none;
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
                padding: 0;
                display: flex;
                align-items: center;
            }

            .divider {
                height: 1px;
                background: var(--color-border);
                margin: 1.5rem 0;
            }

            @media (max-width: 1024px) {
                .job-detail-wrapper {
                    grid-template-columns: 1fr;
                }

                .action-card {
                    position: static;
                }

                .sidebar {
                    order: -1;
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 2rem 1rem;
                }

                .job-title {
                    font-size: 1.75rem;
                    padding: 1.5rem 1.5rem 0;
                }

                .job-meta {
                    grid-template-columns: 1fr;
                    padding: 0 1.5rem 1.5rem;
                }

                .card-header,
                .card-content,
                .feedback-form {
                    padding: 1.5rem;
                }

                .toast {
                    right: 1rem;
                    left: 1rem;
                    top: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class="container">
                <!-- Alert Messages -->
            <% if (request.getParameter("error") != null) {%>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= request.getParameter("error")%></span>
            </div>
            <% } %>

            <% if (request.getParameter("success") != null) {%>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span><%= request.getParameter("success")%></span>
            </div>
            <% }%>

            <c:if test="${not empty jobPost}">
                <div class="job-detail-wrapper">
                    <!-- Main Content -->
                    <div class="job-main">
                        <!-- Job Header Card -->
                        <div class="card">
                            <h1 class="job-title">${jobPost.title}</h1>

                            <div class="job-meta">
                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Ngày đăng</div>
                                        <div class="meta-value">${jobPost.postedDate}</div>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-hourglass-end"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Hạn ứng tuyển</div>
                                        <div class="meta-value">${jobPost.closingDate}</div>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Địa điểm</div>
                                        <div class="meta-value">${jobPost.location}</div>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Mức lương</div>
                                        <div class="meta-value">${jobPost.minSalary} - ${jobPost.maxSalary} ${jobPost.getCurrency()}</div>
                                    </div>
                                </div>  

                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-list"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Danh mục</div>
                                        <div class="meta-value">
                                            <c:choose>
                                                <c:when test="${category != 'This category was deleted!'}">
                                                    ${category.name}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--color-danger);">Deleted Category</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <div class="meta-icon">
                                        <i class="fas fa-circle"></i>
                                    </div>
                                    <div class="meta-content">
                                        <div class="meta-label">Trạng thái</div>
                                        <div class="meta-value">${jobPost.status}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Description Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-file-alt"></i>
                                <h5>Mô tả công việc</h5>
                            </div>
                            <div class="card-content">
                                ${jobPost.description}
                            </div>
                        </div>

                        <!-- Requirements Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-clipboard-check"></i>
                                <h5>Yêu cầu công việc</h5>
                            </div>
                            <div class="card-content">
                                ${jobPost.requirements}
                            </div>
                        </div>

                        <!-- Feedback Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-comments"></i>
                                <h5>Đánh giá công việc</h5>
                            </div>
                            <form action="${pageContext.request.contextPath}/feedbackSeeker?action=create" method="post" class="feedback-form">
                                <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                <div class="form-group">
                                    <label class="form-label">Để lại đánh giá của bạn:</label>
                                    <textarea class="form-textarea" name="content" required placeholder="Nhập đánh giá của bạn về công việc này..."></textarea>
                                </div>
                                <button type="submit" class="btn btn-submit">
                                    <i class="fas fa-paper-plane"></i>
                                    Gửi đánh giá
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="card action-card">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" style="margin-bottom: 1rem;">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <span>${error}</span>
                                </div>
                            </c:if>

                            <!-- Like Button -->
                            <c:choose>
                                <c:when test="${empty existFavourJP}">
                                    <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-favourJP" method="post">
                                        <input type="hidden" name="jobPostingIDF" value="${jobPost.jobPostingID}">
                                        <c:if test="${not empty jobSeekerF}">
                                            <input type="hidden" name="jobSeekerIDF" value="${jobSeekerF.jobSeekerID}">
                                        </c:if>
                                        <button type="submit" class="btn btn-like">
                                            <i class="fas fa-heart"></i>
                                            Yêu thích
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-liked" disabled>
                                        <i class="fas fa-heart"></i>
                                        Đã yêu thích
                                    </button>
                                </c:otherwise>
                            </c:choose>

                            <!-- Apply Button -->
                            <c:choose>
                                <c:when test="${empty existingApplication}">
                                    <c:if test="${not empty isOpenJP}">
                                        <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-application" method="post">
                                            <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                            <c:if test="${not empty jobSeeker}">
                                                <input type="hidden" name="jobSeekerID" value="${jobSeeker.jobSeekerID}">
                                            </c:if>
                                            <c:if test="${not empty cv}">
                                                <input type="hidden" name="cvid" value="${cv.CVID}">
                                            </c:if>
                                            <button type="submit" class="btn btn-apply">
                                                <i class="fas fa-paper-plane"></i>
                                                Ứng tuyển ngay
                                            </button>
                                        </form>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-applied" disabled>
                                        <i class="fas fa-check-circle"></i>
                                        Đã ứng tuyển
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </aside>
                </div>
            </c:if>

            <!-- Toast Notification -->
            <c:if test="${not empty notice}">
                <div class="toast" id="liveToast">
                    <i class="fas fa-check-circle"></i>
                    <span>${notice}</span>
                    <button class="toast-close" onclick="this.parentElement.remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            // Auto-hide toast after 5 seconds
            const toast = document.getElementById('liveToast');
            if (toast) {
                setTimeout(() => {
                    toast.style.animation = 'slideInFromRight 0.3s ease-out reverse';
                    setTimeout(() => toast.remove(), 300);
                }, 5000);
            }
        </script>
    </body>
</html>
