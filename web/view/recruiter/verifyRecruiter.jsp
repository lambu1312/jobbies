<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác Thực Tài Khoản Nhà Tuyển Dụng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Custom CSS -->
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
            }

            /* Main content with sidebar margin */
            .main-content {
                margin-left: 260px;
                padding: 40px;
                padding-top: 100px;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            /* Form card styling with hover effect */
            .verify-card {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 12px;
                border: 1px solid rgba(196, 113, 245, 0.2);
                max-width: 650px;
                width: 100%;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
            }

            .verify-card:hover {
                border-color: rgba(196, 113, 245, 0.4);
                box-shadow: 0 8px 30px rgba(196, 113, 245, 0.15);
            }

            /* Card header */
            .verify-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .verify-header h2 {
                font-weight: 700;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-size: 28px;
                margin-bottom: 10px;
            }

            .verify-header p {
                color: #666;
                font-size: 14px;
                margin: 0;
            }

            /* Form label styling */
            .form-label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
                color: #333;
            }

            /* Form control styling */
            .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
                padding: 12px 14px;
                font-size: 14px;
                background-color: #f8f9fa;
                transition: all 0.3s ease;
                margin-bottom: 20px;
                color: #1a1a1a;
            }

            .form-control::placeholder {
                color: #999;
            }

            .form-control:hover {
                border-color: #c471f5;
                background-color: #fff;
            }

            .form-control:focus {
                border-color: #c471f5;
                background-color: #fff;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
                outline: none;
            }

            /* Form group */
            .form-group {
                margin-bottom: 0;
            }

            .mb-3 {
                margin-bottom: 20px;
            }

            /* File input styling */
            .form-control[type="file"] {
                padding: 10px 14px;
            }

            .form-control[type="file"]::file-selector-button {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
                margin-right: 10px;
            }

            .form-control[type="file"]::file-selector-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(196, 113, 245, 0.3);
            }

            /* Image preview */
            .preview-container {
                margin-top: 12px;
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: wrap;
            }

            .preview-img {
                width: 100px;
                height: 100px;
                border: 2px solid rgba(196, 113, 245, 0.3);
                border-radius: 8px;
                object-fit: cover;
                display: none;
                opacity: 0;
                transition: all 0.5s ease;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .preview-img.show {
                display: block;
                opacity: 1;
                border-color: #c471f5;
                box-shadow: 0 4px 12px rgba(196, 113, 245, 0.2);
            }

            .preview-label {
                font-size: 12px;
                color: #666;
                font-weight: 600;
            }

            /* Alert messages */
            .alert {
                border-radius: 8px;
                border: none;
                font-size: 14px;
                margin-bottom: 20px;
                animation: slideDown 0.4s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
                border-left: 4px solid #dc3545;
            }

            .alert-success {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
                border-left: 4px solid #28a745;
            }

            .alert ul {
                margin: 0;
                padding-left: 20px;
            }

            .alert li {
                margin-bottom: 5px;
            }

            /* Button styling */
            .btn-group {
                display: flex;
                justify-content: flex-start;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-submit,
            .btn-reset {
                padding: 12px 28px;
                font-size: 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 600;
                border: none;
            }

            .btn-submit {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
                color: white;
                text-decoration: none;
            }

            .btn-submit:active {
                transform: translateY(0);
            }

            .btn-reset {
                background-color: #e0e0e0;
                color: #333;
            }

            .btn-reset:hover {
                background-color: #d0d0d0;
                transform: translateY(-2px);
            }

            /* Info text */
            .info-text {
                font-size: 13px;
                color: #666;
                margin-top: 6px;
                display: block;
                font-weight: 500;
            }

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .main-content {
                    margin-left: 0;
                }
            }

            @media (max-width: 768px) {
                .main-content {
                    padding: 20px;
                    padding-top: 80px;
                }

                .verify-card {
                    padding: 25px;
                }

                .verify-header h2 {
                    font-size: 22px;
                    margin-bottom: 15px;
                }

                .form-control {
                    font-size: 13px;
                    padding: 10px 12px;
                }

                .btn-group {
                    flex-wrap: wrap;
                    gap: 10px;
                }

                .btn-submit,
                .btn-reset {
                    padding: 10px 20px;
                    font-size: 14px;
                    flex: 1;
                    min-width: 100px;
                }

                .preview-img {
                    width: 80px;
                    height: 80px;
                }
            }

            @media (max-width: 480px) {
                .main-content {
                    padding: 15px;
                }

                .verify-card {
                    padding: 20px;
                }

                .verify-header h2 {
                    font-size: 18px;
                    margin-bottom: 15px;
                }

                .form-label {
                    font-size: 13px;
                }

                .form-control {
                    font-size: 12px;
                    padding: 10px;
                    margin-bottom: 15px;
                }

                .btn-submit,
                .btn-reset {
                    padding: 10px 16px;
                    font-size: 13px;
                    width: 100%;
                }

                .preview-img {
                    width: 70px;
                    height: 70px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content -->
        <div class="main-content">
            <div class="verify-card">
                <div class="verify-header">
                    <h2><i class="fas fa-shield-alt"></i> Xác Thực Tài Khoản</h2>
                    <p>Vui lòng cung cấp thông tin xác thực để hoàn tất quá trình đăng ký</p>
                </div>

                <form action="${pageContext.request.contextPath}/verifyRecruiter" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                    <!-- Business Code input -->
                    <div class="mb-3">
                        <label for="businessCode" class="form-label">Mã Số Kinh Doanh:</label>
                        <input type="text" class="form-control" id="businessCode" name="businessCode" placeholder="Ví dụ: 0123456789" value="${param.businessCode != null ? param.businessCode : ''}" required>
                        <small class="info-text"><i class="fas fa-info-circle"></i> Nhập mã số kinh doanh của công ty</small>
                    </div>

                    <!-- Position input -->
                    <div class="mb-3">
                        <label for="position" class="form-label">Chức Vụ:</label>
                        <input type="text" class="form-control" id="position" name="position" placeholder="Ví dụ: Nhà Tuyển Dụng" value="${param.position != null ? param.position : ''}" required>
                        <small class="info-text"><i class="fas fa-info-circle"></i> Nhập chức vụ của bạn tại công ty</small>
                    </div>

                    <!-- Upload Front of Citizen ID -->
                    <div class="mb-3">
                        <label for="frontCitizenID" class="form-label">Mặt Trước CCCD/Hộ Chiếu:</label>
                        <input type="file" class="form-control" id="frontCitizenID" name="frontCitizenID" accept="image/*" onchange="previewImage(this, 'frontPreview')" required>
                        <small class="info-text"><i class="fas fa-info-circle"></i> Tải ảnh mặt trước CCCD hoặc Hộ Chiếu</small>
                        <div class="preview-container">
                            <img id="frontPreview" class="preview-img" alt="Mặt Trước CCCD">
                            <span id="frontLabel" class="preview-label" style="display: none;">Mặt Trước</span>
                        </div>
                    </div>

                    <!-- Upload Back of Citizen ID -->
                    <div class="mb-3">
                        <label for="backCitizenID" class="form-label">Mặt Sau CCCD/Hộ Chiếu:</label>
                        <input type="file" class="form-control" id="backCitizenID" name="backCitizenID" accept="image/*" onchange="previewImage(this, 'backPreview')" required>
                        <small class="info-text"><i class="fas fa-info-circle"></i> Tải ảnh mặt sau CCCD hoặc Hộ Chiếu</small>
                        <div class="preview-container">
                            <img id="backPreview" class="preview-img" alt="Mặt Sau CCCD">
                            <span id="backLabel" class="preview-label" style="display: none;">Mặt Sau</span>
                        </div>
                    </div>

                    <!-- Error messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <!-- Success message -->
                    <c:if test="${not empty verify}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> ${verify}
                        </div>
                    </c:if>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-paper-plane"></i> Gửi Yêu Cầu
                        </button>
                        <button type="reset" class="btn btn-reset" onclick="clearForm()">
                            <i class="fas fa-redo"></i> Đặt Lại
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript -->
        <script>
            function previewImage(input, imageId) {
                const file = input.files[0];
                const imgElement = document.getElementById(imageId);
                const labelElement = document.getElementById(imageId.replace('Preview', 'Label'));

                if (file) {
                    // Check file size (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert('❌ Kích thước file không được vượt quá 5MB!');
                        input.value = '';
                        imgElement.classList.remove('show');
                        labelElement.style.display = 'none';
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        imgElement.src = e.target.result;
                        imgElement.classList.add('show');
                        labelElement.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                } else {
                    imgElement.classList.remove('show');
                    labelElement.style.display = 'none';
                }
            }

            function validateForm() {
                const businessCode = document.getElementById("businessCode").value.trim();
                const position = document.getElementById("position").value.trim();
                const frontFile = document.getElementById("frontCitizenID").files[0];
                const backFile = document.getElementById("backCitizenID").files[0];

                // Validate business code
                if (!businessCode) {
                    alert("❌ Vui lòng nhập Mã Số Kinh Doanh!");
                    return false;
                }

                if (businessCode.length < 5) {
                    alert("❌ Mã Số Kinh Doanh phải có ít nhất 5 ký tự!");
                    return false;
                }

                // Validate position
                if (!position) {
                    alert("❌ Vui lòng nhập Chức Vụ!");
                    return false;
                }

                if (position.length < 3) {
                    alert("❌ Chức Vụ phải có ít nhất 3 ký tự!");
                    return false;
                }

                // Validate files
                if (!frontFile) {
                    alert("❌ Vui lòng tải lên ảnh Mặt Trước CCCD/Hộ Chiếu!");
                    return false;
                }

                if (!backFile) {
                    alert("❌ Vui lòng tải lên ảnh Mặt Sau CCCD/Hộ Chiếu!");
                    return false;
                }

                // Validate file types
                const validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
                if (!validTypes.includes(frontFile.type)) {
                    alert("❌ Mặt Trước: Chỉ hỗ trợ file ảnh (JPEG, PNG, GIF, WebP)!");
                    return false;
                }

                if (!validTypes.includes(backFile.type)) {
                    alert("❌ Mặt Sau: Chỉ hỗ trợ file ảnh (JPEG, PNG, GIF, WebP)!");
                    return false;
                }

                return true;
            }

            function clearForm() {
                document.getElementById("businessCode").value = '';
                document.getElementById("position").value = '';
                document.getElementById("frontCitizenID").value = '';
                document.getElementById("backCitizenID").value = '';

                const frontImg = document.getElementById('frontPreview');
                const backImg = document.getElementById('backPreview');
                const frontLabel = document.getElementById('frontLabel');
                const backLabel = document.getElementById('backLabel');

                frontImg.classList.remove('show');
                backImg.classList.remove('show');
                frontLabel.style.display = 'none';
                backLabel.style.display = 'none';
            }
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>