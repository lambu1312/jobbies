<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Hồ Sơ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* Stars Background */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1 !important;
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

            /* Floating Decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 5 !important;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 { top: 20%; left: 10%; }
            .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
            .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }

            @keyframes fadeInUp {
                from { opacity: 0; transform: translateY(30px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Profile container styling */
            .profile-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - 80px);
                padding: 20px;
                margin-left: 240px;
                padding-top: 80px;
                position: relative;
                z-index: 10;
            }

            /* Card styling */
            .profile-card {
background: rgba(255, 255, 255, 0.95);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
                max-width: 600px;
                width: 100%;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap; /* Cho phép xuống dòng trên mobile */
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                animation: fadeInUp 0.8s ease;
                border: 1px solid rgba(0, 0, 0, 0.1);
            }

            .profile-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.3);
            }

            /* Sidebar (Avatar area) */
            .profile-sidebar {
                text-align: center;
                margin-right: 30px;
                flex: 0 0 150px; /* Cố định chiều rộng */
            }

            .profile-sidebar img {
                width: 140px;
                height: 140px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.2);
                transition: transform 0.3s ease;
                border: 3px solid transparent;
                background: linear-gradient(white, white) padding-box, linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) border-box;
            }

            .profile-sidebar img:hover { transform: scale(1.08); }

            .profile-sidebar h4 {
                font-weight: 700;
                margin-bottom: 5px;
                font-size: 18px;
                background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            /* Form Section */
            .form-section {
                flex: 1;
            }

            .form-section h2 {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 20px;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .form-group { margin-bottom: 15px; }
            .form-group label { font-weight: 600; margin-bottom: 6px; font-size: 14px; color: #555; display: block; }
            
            .form-control, .form-select {
                padding: 10px 14px;
                height: 42px;
                border-radius: 8px;
                border: 1.5px solid #e5e5e5;
                transition: all 0.3s ease;
                background-color: rgba(255, 255, 255, 0.9);
                font-size: 14px;
            }

            .form-control:focus, .form-select:focus {
                border-color: #c471f5;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
outline: none;
                background-color: white;
            }

            .btn-success {
                margin-top: 16px;
                padding: 12px 24px;
                font-size: 15px;
                border-radius: 8px;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                transition: all 0.3s ease;
                font-weight: 600;
                width: 100%;
                color: white;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
                opacity: 0.9;
            }

            /* Responsive */
            @media (max-width: 1200px) { .profile-container { margin-left: 0; padding-top: 60px; } }
            @media (max-width: 768px) {
                .profile-card { flex-direction: column; padding: 25px 20px; }
                .profile-sidebar { margin-right: 0; margin-bottom: 25px; flex: auto; }
                .pixel-decoration { display: none; }
            }
        </style>
    </head>
    <body>
        <div class="stars" id="stars"></div>
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <%@ include file="../recruiter/sidebar-re.jsp" %>
        <%@ include file="../recruiter/header-re.jsp" %>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-sidebar">
                    <c:if test="${empty sessionScope.account.getAvatar()}">
                        <img id="avatar-preview" src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Ảnh đại diện">
                    </c:if>
                    <c:if test="${!empty sessionScope.account.getAvatar()}">
                        <img id="avatar-preview" src="${sessionScope.account.getAvatar()}" alt="Ảnh đại diện">
                    </c:if>
                    <h4>${sessionScope.account.getFullName()}</h4>
                </div>

                <div class="form-section">
                    <h2>Cập Nhật Hồ Sơ</h2>
                    
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success fade show" role="alert">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorsMessage}">
                        <div class="alert alert-danger fade show" role="alert">
                            <i class="fas fa-exclamation-triangle"></i>
<ul class="mb-0 ps-3">
                                <c:forEach var="error" items="${errorsMessage}">
                                    <li>${error}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/authen?action=edit-profile" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="avatar"><i class="fas fa-camera"></i> Đổi Ảnh Đại Diện</label>
                            <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" onchange="previewAvatar(event)">
                        </div>

                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label for="lastName">Họ</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.account.getLastName()}" required>
                            </div>
                            <div class="col-md-6 form-group">
                                <label for="firstName">Tên</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.account.getFirstName()}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.account.getEmail()}" required>
                        </div>

                        <div class="form-group">
                            <label for="phone"><i class="fas fa-phone"></i> Số Điện Thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.account.getPhone()}" required>
                        </div>

                        <div class="form-group">
                            <label for="gender"><i class="fas fa-venus-mars"></i> Giới Tính</label>
                            <select class="form-select" id="gender" name="gender">
                                <option value="male" ${sessionScope.account.gender ? 'selected' : ''}>Nam</option>
                                <option value="female" ${!sessionScope.account.gender ? 'selected' : ''}>Nữ</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="address"><i class="fas fa-map-marker-alt"></i> Địa Chỉ</label>
                            <input type="text" class="form-control" id="address" name="address" value="${sessionScope.account.getAddress()}" required>
</div>

                        <div class="form-group">
                            <label for="dob"><i class="fas fa-calendar"></i> Ngày Sinh</label>
                            <input type="date" class="form-control" id="dob" name="date" value="${sessionScope.account.getDob()}" required>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Lưu Cập Nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function previewAvatar(event) {
                var reader = new FileReader();
                reader.onload = function () {
                    var output = document.getElementById('avatar-preview');
                    output.src = reader.result;
                };
                if(event.target.files[0]) {
                    reader.readAsDataURL(event.target.files[0]);
                }
            }

            // Generate stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 150;
                for (let i = 0; i < numberOfStars; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 3 + 's';
                    star.style.width = Math.random() * 2 + 1 + 'px';
                    star.style.height = star.style.width;
                    starsContainer.appendChild(star);
                }
            }
            createStars();
        </script>

        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>