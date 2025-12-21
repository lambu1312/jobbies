<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Học Vấn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
                overflow-x: hidden;
            }

            /* --- Background Effects --- */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 0;
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
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 0;
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

            /* --- Layout --- */
            .profile-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - 80px);
                padding: 40px 20px;
                margin-left: 240px; /* Sidebar offset */
                padding-top: 100px; /* Header offset */
                position: relative;
                z-index: 10;
            }

            .profile-card {
                background-color: rgba(255, 255, 255, 0.95);
                padding: 40px 50px;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(196, 113, 245, 0.1);
                max-width: 800px;
                width: 100%;
                border: 1px solid rgba(255, 255, 255, 0.5);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                animation: fadeInUp 0.8s ease;
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

            .profile-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 30px rgba(196, 113, 245, 0.2);
            }

            .form-section h2 {
                font-size: 28px;
                font-weight: 800;
                margin-bottom: 30px;
                /* Gradient Text */
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .profile-info table {
                width: 100%;
                margin-bottom: 20px;
                border-collapse: collapse;
            }

            .profile-info td {
                padding: 15px;
                font-size: 16px;
                color: #333;
                text-align: left;
                border-bottom: 1px solid #f0f0f0;
            }

            .profile-info tr:last-child td {
                border-bottom: none;
            }

            .profile-info td:first-child {
                font-weight: 600;
                color: #6b7280;
                width: 35%;
                text-transform: uppercase;
                font-size: 0.9rem;
            }

            .degree-img-container {
                display: flex;
                justify-content: flex-start;
                align-items: center;
                position: relative;
            }

            .degree-img {
                max-width: 120px;
                height: auto;
                border-radius: 8px;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                margin: 0;
                border: 2px solid #f3e8ff;
            }

            .degree-img:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            /* --- Back Button --- */
            .back-button {
                display: inline-flex;
                align-items: center;
                margin-top: 30px;
                color: #9333ea; /* Purple */
                text-decoration: none;
                font-weight: 600;
                padding: 10px 25px;
                border: 1px solid #e9d5ff;
                border-radius: 30px;
                transition: all 0.3s ease;
                background-color: white;
            }

            .back-button:hover {
                background-color: #f3e8ff;
                color: #7e22ce;
                transform: translateX(-3px);
                box-shadow: 0 2px 8px rgba(147, 51, 234, 0.1);
            }

            .back-button i {
                margin-right: 8px;
            }

            /* --- Modal --- */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.85);
                backdrop-filter: blur(5px);
            }

            .modal-content {
                margin: auto;
                display: block;
                max-width: 90%;
                max-height: 90%;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.5);
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            .close {
                position: absolute;
                top: 20px;
                right: 30px;
                color: #fff;
                font-size: 40px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
                z-index: 1001;
            }

            .close:hover {
                color: #fa71cd;
                transform: scale(1.1);
            }

            hr {
                border-top: 1px dashed #d8b4fe;
                margin: 30px 0;
                opacity: 0.5;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                .profile-container {
                    margin-left: 0;
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

                <div class="form-section">
                    <h2><i class="fas fa-graduation-cap me-2"></i>Chi Tiết Học Vấn</h2>

                    <c:forEach var="education" items="${educations}">
                        <div class="profile-info">
                            <table>
                                <tr>
                                    <td><i class="fas fa-university me-2"></i>Trường / Tổ Chức:</td>
                                    <td><strong>${education.institution}</strong></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-certificate me-2"></i>Bằng Cấp:</td>
                                    <td>${education.degree}</td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-book me-2"></i>Chuyên Ngành:</td>
                                    <td>${education.fieldOfStudy}</td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-calendar-alt me-2"></i>Ngày Bắt Đầu:</td>
                                    <td><fmt:formatDate value="${education.startDate}" pattern="dd/MM/yyyy" /></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-calendar-check me-2"></i>Ngày Kết Thúc:</td>
                                    <td><fmt:formatDate value="${education.endDate}" pattern="dd/MM/yyyy" /></td>
                                </tr>
                                <tr>
                                    <td><i class="fas fa-image me-2"></i>Ảnh Bằng Cấp:</td>
                                    <td>
                                        <c:if test="${not empty education.degreeImg}">
                                            <div class="degree-img-container">
                                                <img src="${pageContext.request.contextPath}/${education.degreeImg}" 
                                                     alt="Ảnh Bằng Cấp" 
                                                     class="degree-img" 
                                                     onclick="openModal(this)"
                                                     title="Nhấn để phóng to">
                                            </div>
                                        </c:if>
                                        <c:if test="${empty education.degreeImg}">
                                            <span class="text-muted font-italic">Chưa cập nhật ảnh</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <hr/>
                    </c:forEach>

                    <c:if test="${empty educations}">
                        <div class="text-center py-4 text-muted">
                            <i class="fas fa-folder-open fa-3x mb-3" style="opacity: 0.3;"></i>
                            <p>Chưa có thông tin học vấn nào được cập nhật.</p>
                        </div>
                    </c:if>

                    <div class="text-center">
                        <a href="javascript:history.back()" class="back-button">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>

            </div>
        </div>

        <div id="myModal" class="modal">
            <span class="close">&times;</span>
            <img class="modal-content" id="img01">
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>

        <script>
            // --- Modal Logic ---
            function openModal(imgElement) {
                var modal = document.getElementById("myModal");
                var modalImg = document.getElementById("img01");
                modal.style.display = "block";
                modalImg.src = imgElement.src;
            }

            var closeBtn = document.getElementsByClassName("close")[0];
            closeBtn.onclick = function () {
                var modal = document.getElementById("myModal");
                modal.style.display = "none";
            };

            window.onclick = function (event) {
                var modal = document.getElementById("myModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };

            // --- Background Stars Logic ---
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 100;
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