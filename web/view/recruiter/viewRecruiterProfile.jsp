<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xem Hồ Sơ Cá Nhân</title>
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
                0%, 100% {
                    opacity: 0.3;
                }
                50% {
                    opacity: 1;
                }
            }

            /* Floating Decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 5 !important;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 {
                top: 20%;
                left: 10%;
            }

            .deco-2 {
                top: 60%;
                right: 15%;
                animation-delay: 2s;
            }

            .deco-3 {
                bottom: 15%;
                left: 20%;
                animation-delay: 1s;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
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

            /* Card styling for the profile section */
            .profile-card {
                background: rgba(255, 255, 255, 0.95);
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
                max-width: 750px;
                width: 100%;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                animation: fadeInUp 0.8s ease;
                border: 1px solid rgba(0, 0, 0, 0.1);
            }

            /* Hover effect for card */
            .profile-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.3);
            }

            /* Styling for avatar and user details */
            .profile-sidebar {
                text-align: center;
                margin-right: 30px;
                flex: 1 1 200px;
            }

            .profile-sidebar img {
                width: 140px;
                height: 140px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.2);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: 3px solid transparent;
                background: linear-gradient(white, white) padding-box,
                            linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) border-box;
            }

            .profile-sidebar img:hover {
                transform: scale(1.08);
                box-shadow: 0 8px 25px rgba(196, 113, 245, 0.4);
            }

            .profile-sidebar h4 {
                font-weight: 700;
                margin-bottom: 5px;
                font-size: 22px;
                background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .profile-sidebar p {
                color: #666;
                font-size: 14px;
                font-weight: 500;
            }

            .form-section {
                flex: 2 1 400px;
            }

            .form-section h2 {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 20px;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Styling for profile information */
            .profile-info {
                width: 100%;
                margin-top: 20px;
            }

            .profile-info table {
                width: 100%;
                margin-bottom: 20px;
            }

            .profile-info tr {
                transition: background-color 0.3s ease;
            }

            .profile-info tr:hover {
                background-color: rgba(196, 113, 245, 0.05);
            }

            .profile-info td {
                padding: 14px 12px;
                font-size: 15px;
                color: #333;
                border-bottom: 1px solid #e5e5e5;
            }

            .profile-info tr:last-child td {
                border-bottom: none;
            }

            .profile-info td:first-child {
                font-weight: 600;
                color: #555;
                text-align: right;
                padding-right: 20px;
                width: 35%;
            }

            .profile-info td:last-child {
                text-align: left;
                color: #1a1a1a;
            }

            .edit-profile-btn {
                text-align: center;
                margin-top: 25px;
            }

            .edit-profile-btn a {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 12px 24px;
                font-size: 15px;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
                transition: all 0.3s ease;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3);
            }

            .edit-profile-btn a:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
                color: white;
            }

            .edit-profile-btn a i {
                font-size: 16px;
            }

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .profile-container {
                    margin-left: 0;
                    padding-top: 60px;
                }
            }

            @media (max-width: 768px) {
                .profile-card {
                    flex-direction: column;
                    padding: 30px 20px;
                }

                .profile-sidebar {
                    margin-right: 0;
                    margin-bottom: 30px;
                }

                .profile-info td {
                    padding: 12px 8px;
                    font-size: 14px;
                }

                .profile-info td:first-child {
                    width: 40%;
                }

                .pixel-decoration {
                    display: none;
                }
            }

            @media (max-width: 480px) {
                .profile-container {
                    padding: 10px;
                }

                .profile-card {
                    padding: 20px 15px;
                }

                .profile-sidebar h4 {
                    font-size: 20px;
                }

                .form-section h2 {
                    font-size: 20px;
                }

                .profile-info td {
                    padding: 10px 5px;
                    font-size: 13px;
                }

                .profile-sidebar img {
                    width: 120px;
                    height: 120px;
                }
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
                    <p>Thông Tin Nhà Tuyển Dụng</p>
                </div>

                <div class="form-section">
                    <h2>Chi Tiết Hồ Sơ</h2>
                    <div class="profile-info">
                        <table>
                            <tr>
                                <td>Họ và tên:</td>
                                <td>${sessionScope.account.getFullName()}</td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td>${sessionScope.account.getEmail()}</td>
                            </tr>
                            <tr>
                                <td>Số điện thoại:</td>
                                <td>${sessionScope.account.getPhone()}</td>
                            </tr>
                            <tr>
                                <td>Giới tính:</td>
                                <td>${sessionScope.account.isGender() == true ? 'Nam' : 'Nữ'}</td>
                            </tr>
                            <tr>
                                <td>Địa chỉ:</td>
                                <td>${sessionScope.account.getAddress()}</td>
                            </tr>
                            <tr>
                                <td>Ngày sinh:</td>
                                <td>${sessionScope.account.getDob()}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="edit-profile-btn">
                        <a href="${pageContext.request.contextPath}/view/recruiter/editRecruiterProfile.jsp">
                            <i class="fas fa-edit"></i> Chỉnh Sửa Hồ Sơ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>

        <script>
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
    </body>
</html>