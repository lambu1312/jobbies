<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết ứng dụng</title>
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

            .alert-danger {
                background: var(--color-danger-light);
                border-color: var(--color-danger);
                color: var(--color-danger);
            }

            .row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .info-card {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                overflow: hidden;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out;
                animation-fill-mode: both;
            }

            .info-card:nth-child(1) { animation-delay: 0.1s; }
            .info-card:nth-child(2) { animation-delay: 0.2s; }
            .info-card:nth-child(3) { animation-delay: 0.3s; }
            .info-card:nth-child(4) { animation-delay: 0.4s; }

            .card-header {
                background: linear-gradient(to bottom, #F8FAFC, #F1F5F9);
                padding: 1.25rem 1.5rem;
                border-bottom: 2px solid var(--color-border);
            }

            .section-header {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--color-text-primary);
                margin: 0;
            }

            .card-body {
                padding: 1.5rem;
            }

            .info-item {
                margin-bottom: 1rem;
            }

            .info-item:last-child {
                margin-bottom: 0;
            }

            .info-label {
                font-weight: 600;
                color: var(--color-text-primary);
                font-size: 0.875rem;
                margin-bottom: 0.25rem;
                display: block;
            }

            .info-value {
                color: var(--color-text-secondary);
                font-size: 0.9375rem;
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

            .badge.bg-secondary {
                background: #F1F5F9;
                color: var(--color-secondary);
                border-color: #CBD5E1;
            }

            .cv-viewer {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                overflow: hidden;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out 0.4s both;
            }

            .cv-viewer iframe {
                width: 100%;
                height: 600px;
                border: none;
                display: block;
            }

            .empty-message {
                text-align: center;
                padding: 3rem 2rem;
                color: var(--color-text-secondary);
            }

            .empty-message i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: #CBD5E1;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 2rem 1rem;
                }

                .page-title {
                    font-size: 1.75rem;
                }

                .row {
                    grid-template-columns: 1fr;
                }

                .cv-viewer iframe {
                    height: 500px;
                }
            }

            /* Full width layouts for specific sections */
            .full-width-card {
                grid-column: 1 / -1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Chi tiết ứng dụng</h1>
                <p class="page-subtitle">Thông tin chi tiết về đơn ứng tuyển của bạn</p>
            </div>

            <c:if test="${not empty errorApplication}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${errorApplication}</span>
                </div>
            </c:if>

            <c:if test="${empty errorApplication}">
                <div class="row">
                    <!-- Personal Information Card -->
                    <div class="info-card">
                        <div class="card-header">
                            <h2 class="section-header">
                                <i class="fas fa-user"></i> Thông tin cá nhân
                            </h2>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty account}">
                                <div class="info-item">
                                    <span class="info-label">Họ và Tên</span>
                                    <span class="info-value">${account.fullName}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Ngày Sinh</span>
                                    <span class="info-value">${account.dob}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Số Điện Thoại</span>
                                    <span class="info-value">${account.phone}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">${account.email}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Giới Tính</span>
                                    <span class="info-value">${account.gender ? 'Nam' : 'Nữ'}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Địa Chỉ</span>
                                    <span class="info-value">${account.address}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Application Status Card -->
                    <div class="info-card">
                        <div class="card-header">
                            <h2 class="section-header">
                                <i class="fas fa-file-alt"></i> Thông tin ứng dụng
                            </h2>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty application}">
                                <div class="info-item">
                                    <span class="info-label">Ngày nộp đơn</span>
                                    <span class="info-value">${application.appliedDate}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Trạng thái</span>
                                    <div>
                                        <c:choose>
                                            <c:when test="${application.status == 3}">
                                                <span class="badge bg-info"><i class="fa fa-clock"></i> Chưa giải quyết</span>
                                            </c:when>
                                            <c:when test="${application.status == 2}">
                                                <span class="badge bg-success"><i class="fa fa-check-circle"></i> Đậu</span>
                                            </c:when>
                                            <c:when test="${application.status == 1}">
                                                <span class="badge bg-danger"><i class="fa fa-times-circle"></i> Loại</span>
                                            </c:when>
                                            <c:when test="${application.status == 0}">
                                                <span class="badge bg-secondary"><i class="fa fa-ban"></i> Đã hủy</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Job Posting Details Card -->
                    <div class="info-card">
                        <div class="card-header">
                            <h2 class="section-header">
                                <i class="fas fa-briefcase"></i> Chi tiết đăng tuyển
                            </h2>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty jobPost}">
                                <div class="info-item">
                                    <span class="info-label">Tiêu đề</span>
                                    <span class="info-value">${jobPost.title}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Vị trí</span>
                                    <span class="info-value">${jobPost.location}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Lương</span>
                                    <span class="info-value">${jobPost.minSalary}$ - ${jobPost.maxSalary}$</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Danh mục công việc</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${category != 'This category was deleted!'}">
                                                ${category.name}
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--color-danger);">Danh mục này đã bị xóa!</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Mô tả</span>
                                    <span class="info-value">${jobPost.description}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Yêu cầu</span>
                                    <span class="info-value">${jobPost.requirements}</span>
                                </div>
                            </c:if>
                            <c:if test="${empty jobPost}">
                                <div class="empty-message">
                                    <i class="fas fa-inbox"></i>
                                    <p>Thông tin chi tiết về tin tuyển dụng hiện không có sẵn.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- CV Viewer Card -->
                    <div class="info-card">
                        <div class="card-header">
                            <h2 class="section-header">
                                <i class="fas fa-file-pdf"></i> Chi tiết CV
                            </h2>
                        </div>
                        <div class="card-body" style="padding: 0;">
                            <c:if test="${not empty cv}">
                                <iframe src="cv?action=view-cv" height="600px" width="100%" allowfullscreen="" frameborder="0"></iframe>
                            </c:if>
                            <c:if test="${empty cv}">
                                <div class="empty-message">
                                    <i class="fas fa-file-excel"></i>
                                    <p>Thông tin chi tiết về CV hiện không có sẵn.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <jsp:include page="../common/footer.jsp"></jsp:include>
    </body>
</html>
