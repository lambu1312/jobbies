<%@page import="model.CV"%>
<%@page import="model.JobSeekers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seeker's CV</title>
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

            .alert a {
                color: inherit;
                font-weight: 600;
                text-decoration: underline;
            }

            .cv-card {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                overflow: hidden;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out 0.1s both;
            }

            .card-header {
                background: linear-gradient(to bottom, #F8FAFC, #F1F5F9);
                padding: 1.25rem 1.5rem;
                border-bottom: 2px solid var(--color-border);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--color-text-primary);
                margin: 0;
            }

            .card-body {
                padding: 1.5rem;
            }

            .upload-section {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 2px dashed var(--color-border);
                padding: 3rem 2rem;
                text-align: center;
                animation: fadeInUp 0.6s ease-out 0.1s both;
            }

            .upload-icon {
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

            .form-label {
                font-weight: 600;
                color: var(--color-text-primary);
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
                display: block;
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
                max-width: 400px;
                margin: 0 auto;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
            }

            .note-text {
                color: var(--color-success);
                font-size: 0.875rem;
                margin-top: 0.75rem;
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

            .btn-success {
                background: var(--color-success);
                color: white;
                border-color: var(--color-success);
            }

            .btn-success:hover {
                background: #0C8A5F;
                border-color: #0C8A5F;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(14, 167, 112, 0.25);
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

            .btn-block {
                width: 100%;
                justify-content: center;
                margin-bottom: 1rem;
            }

            .cv-viewer {
                background: var(--color-surface);
                border: 1px solid var(--color-border);
                border-radius: var(--radius-md);
                overflow: hidden;
            }

            .cv-viewer iframe {
                width: 100%;
                height: 800px;
                border: none;
                display: block;
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
                max-width: 500px;
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
            }

            .modal-footer {
                display: flex;
                gap: 0.75rem;
                justify-content: flex-end;
                padding: 1rem 1.5rem 1.5rem;
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

                .cv-viewer iframe {
                    height: 600px;
                }

                .form-control {
                    max-width: 100%;
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
        <!-- Header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Quản lý CV của bạn</h1>
                <p class="page-subtitle">Tải lên và cập nhật CV để ứng tuyển công việc</p>
            </div>

            <!-- Display success or error messages -->
            <c:if test="${not empty errorJobSeeker}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${errorJobSeeker} <a href="JobSeekerCheck">Click here!!</a></span>
                </div>
            </c:if>

            <c:if test="${empty errorJobSeeker}">
                <c:if test="${not empty successCV}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>${successCV}</span>
                    </div>
                </c:if>

                <c:if test="${not empty errorCV}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${errorCV}</span>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <!-- Check if there's a CV -->
                <c:if test="${not empty cvFilePath}">
                    <div class="cv-card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <i class="fas fa-file-pdf"></i> CV của bạn
                            </h2>
                            <button type="button" class="btn btn-success" onclick="openModal('updateCVModal')">
                                <i class="fas fa-edit"></i> Cập nhật CV
                            </button>
                        </div>
                        <div class="card-body" style="padding: 0;">
                            <div class="cv-viewer">
                                <iframe src="cv?action=view-cv" allowfullscreen="" frameborder="0"></iframe>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty cvFilePath}">
                    <!-- Form to upload CV if not present -->
                    <div class="upload-section">
                        <div class="upload-icon">
                            <i class="fas fa-cloud-upload-alt"></i>
                        </div>
                        <h3 style="margin-bottom: 1rem; color: var(--color-text-primary);">Tải lên CV của bạn</h3>
                        <p style="color: var(--color-text-secondary); margin-bottom: 2rem;">Tải lên CV để bắt đầu ứng tuyển công việc</p>
                        
                        <form action="${pageContext.request.contextPath}/cv?action=upload-cv" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="cvFile" class="form-label">Chọn file CV (PDF)</label>
                                <input type="file" class="form-control" id="cvFile" name="cvUploadFile" accept=".pdf" required>
                            </div>
                            <p class="note-text">
                                <i class="fas fa-info-circle"></i> Lưu ý: <strong>Tải lên file nhỏ hơn 10MB</strong>
                            </p>
                            <button type="submit" class="btn btn-success" style="margin-top: 1rem;">
                                <i class="fas fa-upload"></i> Tải lên CV
                            </button>
                        </form>
                    </div>
                </c:if>
            </c:if>
        </div>

        <!-- Modal -->
        <div class="modal" id="updateCVModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật CV</h5>
                    <button type="button" class="btn-close" onclick="closeModal('updateCVModal')"></button>
                </div>
                <form action="${pageContext.request.contextPath}/cv?action=update-cv" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="cvFileU" class="form-label">Chọn file CV mới (PDF)</label>
                            <input type="file" class="form-control" id="cvFileU" name="cvFileU" accept=".pdf" required style="max-width: 100%;">
                        </div>
                        <p class="note-text">
                            <i class="fas fa-info-circle"></i> Lưu ý: <strong>Tải lên file nhỏ hơn 10MB</strong>
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('updateCVModal')">Đóng</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Cập nhật CV
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <button type="button" class="back-to-top" id="back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            // Modal functions
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

            // File size validation
            document.getElementById("cvFile")?.addEventListener("change", function () {
                const file = this.files[0];
                if (file && file.size > 10 * 1024 * 1024) {  // 10MB
                    alert("File size exceeds the 10MB limit. Please choose a smaller file.");
                    this.value = "";
                }
            });

            document.getElementById("cvFileU")?.addEventListener("change", function () {
                const file = this.files[0];
                if (file && file.size > 10 * 1024 * 1024) {  // 10MB
                    alert("File size exceeds the 10MB limit. Please choose a smaller file.");
                    this.value = "";
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
