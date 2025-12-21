<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Job_Posting_Category" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

            .breadcrumb {
                display: flex;
                gap: 0.5rem;
                align-items: center;
                margin-bottom: 2rem;
                color: var(--color-text-secondary);
                font-size: 0.9rem;
            }

            .breadcrumb a {
                color: var(--color-primary);
                text-decoration: none;
                transition: all 0.3s;
            }

            .breadcrumb a:hover {
                color: var(--color-primary-dark);
            }

            .job-detail-wrapper {
                display: grid;
                grid-template-columns: 1fr 350px;
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

            .job-header {
                padding: 2rem;
            }

            .job-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--color-text-primary);
                margin-bottom: 1.5rem;
                line-height: 1.3;
            }

            .job-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid var(--color-border);
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

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8125rem;
                font-weight: 600;
            }

            .status-active {
                background: var(--color-success-light);
                color: var(--color-success);
            }

            .status-closed {
                background: var(--color-danger-light);
                color: var(--color-danger);
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

            .card-content p {
                margin-bottom: 1rem;
            }

            .sidebar {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .apply-card {
                position: sticky;
                top: 2rem;
                animation: fadeInUp 0.6s ease-out 0.4s both;
            }

            .apply-button {
                width: 100%;
                padding: 0.875rem 1.25rem;
                background: var(--color-primary);
                border: 2px solid var(--color-primary);
                border-radius: var(--radius-sm);
                color: white;
                font-weight: 600;
                font-size: 0.9375rem;
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .apply-button:hover {
                background: var(--color-primary-dark);
                border-color: var(--color-primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(43, 89, 255, 0.2);
            }

            .login-notice {
                color: var(--color-text-secondary);
                line-height: 1.6;
                text-align: center;
                padding: 1.5rem;
            }

            .login-notice p {
                margin-bottom: 1rem;
            }

            .login-notice a {
                color: var(--color-primary);
                text-decoration: none;
                font-weight: 600;
            }

            .error-message {
                background: var(--color-danger-light);
                border: 1px solid var(--color-danger);
                border-radius: var(--radius-md);
                padding: 1rem 1.25rem;
                color: var(--color-danger);
                text-align: center;
                font-weight: 600;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            @media (max-width: 1024px) {
                .job-detail-wrapper {
                    grid-template-columns: 1fr;
                }

                .apply-card {
                    position: static;
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 2rem 1rem;
                }

                .job-header {
                    padding: 1.5rem;
                }

                .job-title {
                    font-size: 1.75rem;
                }

                .job-meta {
                    grid-template-columns: 1fr;
                }

                .card-header,
                .card-content {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <jsp:include page="../view/common/header-area.jsp"></jsp:include>

            <div class="container">
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-home"></i> Home
                </a>
                <span>/</span>
                <a href="${pageContext.request.contextPath}/home">Công việc</a>
                <span>/</span>
                <span>Chi tiết công việc</span>
            </nav>

            <c:choose>
                <c:when test="${not empty jobPost}">
                    <div class="job-detail-wrapper">
                        <!-- Main Content -->
                        <div class="job-main">
                            <!-- Job Header Card -->
                            <div class="card">
                                <div class="job-header">
                                    <h1 class="job-title">${jobPost.getTitle()}</h1>

                                    <div class="job-meta">
                                        <div class="meta-item">
                                            <div class="meta-icon">
                                                <i class="fas fa-calendar-alt"></i>
                                            </div>
                                            <div class="meta-content">
                                                <div class="meta-label">Ngày Đăng:</div>
                                                <div class="meta-value">${jobPost.getPostedDate()}</div>
                                            </div>
                                        </div>

                                        <div class="meta-item">
                                            <div class="meta-icon">
                                                <i class="fas fa-hourglass-end"></i>
                                            </div>
                                            <div class="meta-content">
                                                <div class="meta-label">Hạn:</div>
                                                <div class="meta-value">${jobPost.getClosingDate()}</div>
                                            </div>
                                        </div>

                                        <div class="meta-item">
                                            <div class="meta-icon">
                                                <i class="fas fa-map-marker-alt"></i>
                                            </div>
                                            <div class="meta-content">
                                                <div class="meta-label">Địa điểm:</div>
                                                <div class="meta-value">${jobPost.getLocation()}</div>
                                            </div>
                                        </div>

                                        <div class="meta-item">
                                            <div class="meta-icon">
                                                <i class="fas fa-dollar-sign"></i>
                                            </div>
                                            <div class="meta-content">
                                                <div class="meta-label">Lương:</div>
                                                <div class="meta-value">${jobPost.getMinSalary()} - ${jobPost.getMaxSalary()}</div>
                                            </div>
                                        </div>

                                        <div class="meta-item">
                                            <div class="meta-icon">
                                                <i class="fas fa-list"></i>
                                            </div>
                                            <div class="meta-content">
                                                <div class="meta-label">Danh mục:</div>
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
                                                <div class="meta-label">Trạng thái:</div>
                                                <div class="meta-value">
                                                    <span class="status-badge ${jobPost.getStatus() == 'Active' ? 'status-active' : 'status-closed'}">
                                                        ${jobPost.getStatus()}
                                                    </span>
                                                </div>
                                            </div>
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
                                    ${jobPost.getDescription()}
                                </div>
                            </div>

                            <!-- Requirements Card -->
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-clipboard-check"></i>
                                    <h5>Yêu cầu</h5>
                                </div>
                                <div class="card-content">
                                    ${jobPost.getRequirements()}
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar -->
                        <aside class="sidebar">
                            <c:choose>
                                <c:when test="${empty sessionScope.account}">
                                    <!-- Login Notice Card -->
                                    <div class="card apply-card">
                                        <div class="card-header">
                                            <i class="fas fa-briefcase"></i>
                                            <h5>đăng kí công việc</h5>
                                        </div>
                                        <div class="login-notice">
                                            <p>🔒 Bạn phải đăng nhập để đăng kí công việc</p>
                                            <a href="${pageContext.request.contextPath}/authen">
                                                <button class="apply-button">
                                                    <i class="fas fa-sign-in-alt"></i>
                                                    Đăng nhập
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Apply Button Card -->
                                    <div class="card apply-card">
                                        <div class="card-header">
                                            <i class="fas fa-briefcase"></i>
                                            <h5>Apply Now</h5>
                                        </div>
                                        <div style="padding: 1.5rem;">
                                            <button class="apply-button" onclick="applyJob()">
                                                <i class="fas fa-paper-plane"></i>
                                                Submit Application
                                            </button>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </aside>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        Công việc không tìm thấy hoặc đã bị xóa
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Footer -->
        <jsp:include page="../view/common/footer.jsp"></jsp:include>

        <script>
            // Apply job function
            function applyJob() {
                alert('🎉 Application submitted successfully! (Demo)');
            }
        </script>
    </body>

</html>