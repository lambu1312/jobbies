<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác minh tài khoản - Jobbies</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                width: 100%;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #333;
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* Stars background */
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

            /* Main content with padding for sidebar */
            .main-content {
                margin-left: 260px;
                padding: 3rem 2rem;
                padding-top: 120px;
                min-height: 100vh;
                position: relative;
                z-index: 10;
                animation: fadeIn 0.8s ease-in-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Page Title */
            .page-title {
                text-align: center;
                margin-bottom: 3rem;
            }

            .page-title h1 {
                font-size: 2.5rem;
                font-weight: 900;
                background: linear-gradient(135deg, #333 0%, #555 50%, #333 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 0.5rem;
            }

            .page-title p {
                color: #666;
                font-size: 1rem;
                font-weight: 500;
            }

            /* Form card styling */
            .verify-card {
                max-width: 700px;
                margin: 0 auto;
                background: #fff;
                border-radius: 20px;
                padding: 3rem;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.2);
                border: 1px solid rgba(196, 113, 245, 0.1);
                transition: all 0.3s ease;
                position: relative;
            }

            .verify-card::before {
                content: '';
                position: absolute;
                top: -1px;
                left: 20px;
                right: 20px;
                height: 2px;
                background: linear-gradient(90deg, transparent, #c471f5, transparent);
                border-radius: 50%;
            }

            .verify-card:hover {
                box-shadow: 0 30px 80px rgba(196, 113, 245, 0.3);
                transform: translateY(-5px);
            }

            /* Form group */
            .form-group {
                margin-bottom: 2rem;
            }

            .form-label {
                font-weight: 700;
                color: #333;
                margin-bottom: 0.8rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 1rem;
            }

            .form-label i {
                color: #c471f5;
                font-size: 1.1rem;
            }

            .form-control {
                border-radius: 12px;
                padding: 0.9rem 1.2rem;
                font-size: 1rem;
                border: 1.5px solid #e0e0e0;
                color: #333;
                background: #f8f9fa;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .form-control::placeholder {
                color: #999;
            }

            .form-control:hover {
                border-color: #c471f5;
                background: #fff;
                box-shadow: 0 0 0 3px rgba(196, 113, 245, 0.1);
            }

            .form-control:focus {
                border-color: #c471f5;
                background: #fff;
                box-shadow: 0 0 0 4px rgba(196, 113, 245, 0.15);
                outline: none;
            }

            /* File input custom styling */
            .file-input-wrapper {
                position: relative;
                display: flex;
                align-items: center;
                gap: 1rem;
                background: #f8f9fa;
                border: 2px dashed #c471f5;
                border-radius: 12px;
                padding: 1.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .file-input-wrapper:hover {
                background: rgba(196, 113, 245, 0.05);
                border-color: #fa71cd;
            }

            .file-input-wrapper input[type="file"] {
                display: none;
            }

            .file-input-icon {
                font-size: 2rem;
                color: #c471f5;
            }

            .file-input-text {
                flex: 1;
                text-align: left;
            }

            .file-input-text .main-text {
                font-weight: 700;
                color: #333;
                font-size: 0.95rem;
            }

            .file-input-text .sub-text {
                color: #999;
                font-size: 0.85rem;
            }

            /* Image preview */
            .preview-container {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
                flex-wrap: wrap;
            }

            .preview-item {
                position: relative;
                overflow: hidden;
                border-radius: 12px;
                border: 2px solid #e0e0e0;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .preview-item:hover {
                border-color: #c471f5;
                box-shadow: 0 5px 20px rgba(196, 113, 245, 0.2);
            }

            .preview-img {
                width: 120px;
                height: 120px;
                object-fit: cover;
                display: block;
                opacity: 0;
                transition: opacity 0.5s ease;
            }

            .preview-img.show {
                opacity: 1;
            }

            .preview-label {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                color: white;
                padding: 0.3rem 0.5rem;
                font-size: 0.75rem;
                font-weight: 700;
                text-align: center;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .preview-item:hover .preview-label {
                opacity: 1;
            }

            /* Alert messages */
            .alert {
                border-radius: 15px;
                padding: 1.2rem 1.5rem;
                margin-bottom: 2rem;
                border: 1px solid;
                animation: slideDown 0.5s ease-out;
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-danger {
                background: rgba(255, 107, 107, 0.1);
                border-color: #ff6b6b;
                color: #d32f2f;
            }

            .alert-danger i {
                color: #ff6b6b;
                font-size: 1.3rem;
            }

            .alert-success {
                background: rgba(57, 255, 20, 0.1);
                border-color: #39ff14;
                color: #2e7d32;
            }

            .alert-success i {
                color: #39ff14;
                font-size: 1.3rem;
            }

            /* Button styling */
            .btn-submit {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border: none;
                padding: 1rem 2rem;
                font-size: 1rem;
                font-weight: 700;
                border-radius: 50px;
                width: 100%;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.3);
                margin-top: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.8rem;
            }

            .btn-submit:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 40px rgba(196, 113, 245, 0.5);
                color: white;
                text-decoration: none;
            }

            .btn-submit:active {
                transform: scale(0.98);
            }

            /* Required field indicator */
            .required {
                color: #ff6b6b;
                font-weight: 700;
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .main-content {
                    margin-left: 0;
                    padding-top: 100px;
                }
            }

            @media (max-width: 768px) {
                .main-content {
                    padding: 2rem 1rem;
                    padding-top: 100px;
                }

                .verify-card {
                    padding: 2rem 1.5rem;
                }

                .page-title h1 {
                    font-size: 1.8rem;
                }

                .file-input-wrapper {
                    flex-direction: column;
                    text-align: center;
                }

                .file-input-text {
                    text-align: center;
                }

                .preview-container {
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <!-- Stars background -->
        <div class="stars" id="stars"></div>

        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <!-- Page Title -->
            <div class="page-title">
                <h1>🔐 Xác minh tài khoản</h1>
                <p>Vui lòng cung cấp thông tin để xác thực tài khoản của bạn</p>
            </div>

            <!-- Verify Card -->
            <div class="verify-card">
                <!-- Error and success messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <div>${error}</div>
                    </div>
                </c:if>
                <c:if test="${not empty verify}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <div>${verify}</div>
                    </div>
                </c:if>

                <!-- Form -->
                <form action="${pageContext.request.contextPath}/verifyRecruiter" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                    
                    <!-- Business Code input -->
                    <div class="form-group">
                        <label for="businessCode" class="form-label">
                            <i class="fas fa-building"></i>
                            Mã doanh nghiệp <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" id="businessCode" name="businessCode" 
                               placeholder="Nhập mã doanh nghiệp của bạn" 
                               value="${param.businessCode != null ? param.businessCode : ''}" required>
                    </div>

                    <!-- Position input -->
                    <div class="form-group">
                        <label for="position" class="form-label">
                            <i class="fas fa-briefcase"></i>
                            Chức vụ <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control" id="position" name="position" 
                               placeholder="Ví dụ: Nhà tuyển dụng, Trưởng phòng nhân sự,..." 
                               value="${param.position != null ? param.position : ''}" required>
                    </div>

                    <!-- Front of Citizen ID -->
                    <div class="form-group">
                        <label for="frontCitizenID" class="form-label">
                            <i class="fas fa-id-card"></i>
                            Mặt trước CCCD <span class="required">*</span>
                        </label>
                        <label for="frontCitizenID" class="file-input-wrapper">
                            <div class="file-input-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <div class="file-input-text">
                                <div class="main-text">Chọn ảnh mặt trước CCCD</div>
                                <div class="sub-text">PNG, JPG, GIF tối đa 5MB</div>
                            </div>
                            <input type="file" id="frontCitizenID" name="frontCitizenID" accept="image/*" 
                                   onchange="previewImage(this, 'frontPreview')" required>
                        </label>
                        <div class="preview-container">
                            <div class="preview-item" id="frontPreviewContainer" style="display: none;">
                                <img id="frontPreview" class="preview-img" alt="Front Citizen ID">
                                <div class="preview-label">Mặt trước</div>
                            </div>
                        </div>
                    </div>

                    <!-- Back of Citizen ID -->
                    <div class="form-group">
                        <label for="backCitizenID" class="form-label">
                            <i class="fas fa-id-card"></i>
                            Mặt sau CCCD <span class="required">*</span>
                        </label>
                        <label for="backCitizenID" class="file-input-wrapper">
                            <div class="file-input-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <div class="file-input-text">
                                <div class="main-text">Chọn ảnh mặt sau CCCD</div>
                                <div class="sub-text">PNG, JPG, GIF tối đa 5MB</div>
                            </div>
                            <input type="file" id="backCitizenID" name="backCitizenID" accept="image/*" 
                                   onchange="previewImage(this, 'backPreview')" required>
                        </label>
                        <div class="preview-container">
                            <div class="preview-item" id="backPreviewContainer" style="display: none;">
                                <img id="backPreview" class="preview-img" alt="Back Citizen ID">
                                <div class="preview-label">Mặt sau</div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i>
                        Gửi yêu cầu xác minh
                    </button>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- JavaScript -->
        <script>
            // Generate stars
            const starsContainer = document.getElementById('stars');
            for (let i = 0; i < 80; i++) {
                const star = document.createElement('div');
                star.className = 'star';
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                star.style.animationDelay = Math.random() * 3 + 's';
                starsContainer.appendChild(star);
            }

            function previewImage(input, imageId) {
                const file = input.files[0];
                const imgElement = document.getElementById(imageId);
                const containerElement = document.getElementById(imageId + 'Container');

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        imgElement.src = e.target.result;
                        imgElement.classList.add('show');
                        containerElement.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                } else {
                    containerElement.style.display = 'none';
                    imgElement.classList.remove('show');
                }
            }

            function validateForm() {
                const businessCode = document.getElementById("businessCode").value.trim();
                const position = document.getElementById("position").value.trim();

                if (!businessCode) {
                    alert("Vui lòng nhập mã doanh nghiệp");
                    return false;
                }

                if (!position) {
                    alert("Vui lòng nhập chức vụ");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>