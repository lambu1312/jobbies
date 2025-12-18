<%@page import="model.CV"%>
<%@page import="model.JobSeekers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý CV - Jobbies</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
            color: #fff;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* Stars Background */
        .stars {
            position: fixed;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .star {
            position: absolute;
            width: 2px;
            height: 2px;
            background: #fff;
            border-radius: 50%;
            animation: twinkle 3s infinite;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        .pixel-decoration {
            position: fixed;
            font-size: 3rem;
            opacity: 0.3;
            z-index: 5;
            animation: float 4s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .deco-1 { top: 20%; left: 10%; }
        .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
        .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }

        /* Main Container */
        .cv-container {
            position: relative;
            z-index: 10;
            padding-top: 120px;
            padding-bottom: 60px;
        }

        /* Page Title */
        .page-title {
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInUp 0.8s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Alerts */
        .alert {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            animation: slideIn 0.4s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-success {
            background: rgba(57, 255, 20, 0.1);
            border-color: rgba(57, 255, 20, 0.3);
            color: #39ff14;
        }

        .alert-danger {
            background: rgba(255, 107, 107, 0.1);
            border-color: rgba(255, 107, 107, 0.3);
            color: #ff6b6b;
        }

        .alert a {
            color: #7ee8fa;
            text-decoration: underline;
            font-weight: 600;
        }

        /* CV Card */
        .cv-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(30px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3);
            position: relative;
            overflow: hidden;
        }

        .cv-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #c471f5, #fa71cd, #7ee8fa);
            border-radius: 20px;
            z-index: -1;
            opacity: 0.3;
            filter: blur(20px);
        }

        /* Upload Form */
        .upload-form {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
        }

        .upload-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 2rem;
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .form-label {
            color: #b8b8d1;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: #fff;
            padding: 1rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: #c471f5;
            box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
            color: #fff;
            outline: none;
        }

        .note-text {
            color: #39ff14;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        /* Buttons */
        .btn-gradient {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            color: #fff;
            font-weight: 700;
            padding: 1rem 2.5rem;
            border-radius: 15px;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-gradient:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
            color: #fff;
        }

        .btn-update {
            width: 100%;
            margin-bottom: 1.5rem;
        }

        /* CV Preview */
        .cv-preview {
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .cv-preview iframe {
            width: 100%;
            height: 1200px;
            border: none;
            border-radius: 20px;
        }

        /* Modal */
        .modal-content {
            background: rgba(26, 11, 46, 0.95);
            backdrop-filter: blur(30px);
            border: 2px solid rgba(196, 113, 245, 0.3);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
        }

        .modal-header {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border-bottom: none;
            border-radius: 20px 20px 0 0;
            padding: 1.5rem;
        }

        .modal-title {
            color: #fff;
            font-weight: 700;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
        }

        /* Back to Top */
        #back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            border: none;
            border-radius: 50%;
            color: #fff;
            font-size: 1.2rem;
            cursor: pointer;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.5);
            transition: all 0.3s;
            z-index: 1000;
            display: none;
        }

        #back-to-top:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(196, 113, 245, 0.7);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .cv-container {
                padding-top: 100px;
            }

            .page-title {
                font-size: 2rem;
            }

            .upload-form {
                padding: 2rem 1.5rem;
            }

            .cv-preview iframe {
                height: 800px;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <div class="pixel-decoration deco-1">📄</div>
    <div class="pixel-decoration deco-2">✨</div>
    <div class="pixel-decoration deco-3">💼</div>

    <!-- Header -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container cv-container">
        <h1 class="page-title">📋 Quản Lý CV Của Bạn</h1>

        <!-- Error Messages -->
        <c:if test="${not empty errorJobSeeker}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                ${errorJobSeeker} <a href="JobSeekerCheck">Click here!!</a>
            </div>
        </c:if>

        <c:if test="${empty errorJobSeeker}">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successCV}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${successCV}
                </div>
            </c:if>

            <c:if test="${not empty errorCV}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errorCV}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- If CV Exists -->
            <c:if test="${not empty cvFilePath}">
                <div class="cv-card">
                    <!-- Update Button -->
                    <button type="button" class="btn btn-gradient btn-update" data-bs-toggle="modal" data-bs-target="#updateCVModal">
                        <i class="fas fa-upload"></i>
                        Cập nhật CV
                    </button>

                    <!-- CV Preview -->
                    <div class="cv-preview">
                        <iframe src="cv?action=view-cv" allowfullscreen></iframe>
                    </div>
                </div>
            </c:if>

            <!-- If No CV -->
            <c:if test="${empty cvFilePath}">
                <div class="upload-form">
                    <div class="upload-icon">
                        <i class="fas fa-file-pdf"></i>
                    </div>
                    <h3 style="color: #fff; margin-bottom: 1rem;">Tải lên CV của bạn</h3>
                    <p style="color: #b8b8d1; margin-bottom: 2rem;">
                        Hãy tải lên CV để các nhà tuyển dụng có thể tìm thấy bạn!
                    </p>

                    <form action="${pageContext.request.contextPath}/cv?action=upload-cv" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="cvFile" class="form-label">
                                <i class="fas fa-cloud-upload-alt"></i> Chọn file CV (PDF)
                            </label>
                            <input type="file" class="form-control" id="cvFile" name="cvUploadFile" accept=".pdf" required>
                        </div>
                        <div class="note-text">
                            <i class="fas fa-info-circle"></i>
                            <strong>Lưu ý:</strong> File phải nhỏ hơn 10MB (10,240KB)
                        </div>
                        <button type="submit" class="btn btn-gradient mt-3">
                            <i class="fas fa-upload"></i>
                            Tải lên CV
                        </button>
                    </form>
                </div>
            </c:if>
        </c:if>
    </div>

    <!-- Update CV Modal -->
    <div class="modal fade" id="updateCVModal" tabindex="-1" aria-labelledby="updateCVModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateCVModalLabel">
                        <i class="fas fa-edit"></i> Cập nhật CV
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/cv?action=update-cv" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="cvFileU" class="form-label">
                                <i class="fas fa-file-pdf"></i> Chọn file CV mới (PDF)
                            </label>
                            <input type="file" class="form-control" id="cvFileU" name="cvFileU" accept=".pdf" required>
                        </div>
                        <div class="note-text">
                            <i class="fas fa-info-circle"></i>
                            <strong>Lưu ý:</strong> File phải nhỏ hơn 10MB (10,240KB)
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Đóng
                        </button>
                        <button type="submit" class="btn btn-gradient">
                            <i class="fas fa-save"></i> Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Back to Top Button -->
    <button type="button" id="back-to-top">
        <i class="fas fa-arrow-up"></i>
    </button>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script>
        // Generate stars
        const starsContainer = document.getElementById('stars');
        for (let i = 0; i < 100; i++) {
            const star = document.createElement('div');
            star.className = 'star';
            star.style.left = Math.random() * 100 + '%';
            star.style.top = Math.random() * 100 + '%';
            star.style.animationDelay = Math.random() * 3 + 's';
            starsContainer.appendChild(star);
        }

        // File size validation
        document.getElementById("cvFile")?.addEventListener("change", function() {
            const file = this.files[0];
            if (file && file.size > 10 * 1024 * 1024) {
                alert("Kích thước file vượt quá 10MB. Vui lòng chọn file nhỏ hơn.");
                this.value = "";
            }
        });

        document.getElementById("cvFileU")?.addEventListener("change", function() {
            const file = this.files[0];
            if (file && file.size > 10 * 1024 * 1024) {
                alert("Kích thước file vượt quá 10MB. Vui lòng chọn file nhỏ hơn.");
                this.value = "";
            }
        });

        // Back to top button
        const backToTopButton = document.getElementById('back-to-top');

        window.onscroll = function() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                backToTopButton.style.display = 'block';
            } else {
                backToTopButton.style.display = 'none';
            }
        };

        backToTopButton.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>