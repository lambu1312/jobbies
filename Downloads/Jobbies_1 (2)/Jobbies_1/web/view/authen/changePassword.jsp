<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu - Jobbies</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
            color: #fff;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

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

        .main-content {
            position: relative;
            z-index: 10;
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 4rem 2rem;
        }

        .change-password-container {
            width: 100%;
            max-width: 500px;
        }

        .change-password-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(30px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 3rem;
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3),
                        inset 0 1px 0 rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .change-password-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #c471f5, #fa71cd, #7ee8fa);
            border-radius: 30px;
z-index: -1;
opacity: 0.3;
            filter: blur(20px);
        }

        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, #fa71cd 0%, #c471f5 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            box-shadow: 0 10px 30px rgba(250, 113, 205, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .card-title {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #fa71cd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .card-description {
            color: #b8b8d1;
            font-size: 1rem;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            color: #b8b8d1;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .password-wrapper {
            position: relative;
            margin-bottom: 0.5rem;
        }

        .form-input {
            width: 100%;
            padding: 1rem 3rem 1rem 1.2rem;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: #fff;
            font-size: 1rem;
            outline: none;
            transition: all 0.3s;
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        .form-input:focus {
            border-color: #fa71cd;
            box-shadow: 0 0 20px rgba(250, 113, 205, 0.3);
            background: rgba(255, 255, 255, 0.12);
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #b8b8d1;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s;
            padding: 0.5rem;
        }

        .toggle-password:hover {
            color: #fa71cd;
        }

        .password-note {
            background: rgba(250, 113, 205, 0.1);
            border: 1px solid rgba(250, 113, 205, 0.3);
            border-radius: 10px;
            padding: 0.8rem;
            margin-top: 0.5rem;
            display: none;
            animation: slideDown 0.3s ease-out;
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

        .password-note.show {
            display: block;
        }

        .password-note-title {
            color: #fa71cd;
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .password-note ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .password-note li {
            color: #b8b8d1;
            font-size: 0.8rem;
            padding: 0.2rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .password-note li::before {
            content: '✓';
            color: #fa71cd;
            font-weight: bold;
        }

        .error-message {
            background: rgba(255, 71, 87, 0.15);
            border: 1px solid rgba(255, 71, 87, 0.5);
            color: #ff6b6b;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-weight: 600;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            flex: 1;
            padding: 1rem;
            border: none;
            border-radius: 15px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .update-btn {
            background: linear-gradient(135deg, #fa71cd 0%, #c471f5 100%);
            color: #fff;
            box-shadow: 0 10px 30px rgba(250, 113, 205, 0.4);
        }

        .update-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(250, 113, 205, 0.6);
        }

        .cancel-btn {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border: 2px solid rgba(255, 255, 255, 0.2);
            text-decoration: none;
        }

        .cancel-btn:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 2rem 1rem;
            }

            .change-password-card {
                padding: 2rem 1.5rem;
            }

            .card-title {
                font-size: 1.5rem;
            }

            .card-icon {
width: 60px;
height: 60px;
                font-size: 2rem;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <div class="pixel-decoration deco-1">🔒</div>
    <div class="pixel-decoration deco-2">🔑</div>
    <div class="pixel-decoration deco-3">🛡️</div>

    <jsp:include page="../common/header-area.jsp"></jsp:include>

    <div class="main-content">
        <div class="change-password-container">
            <div class="change-password-card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-user-lock"></i>
                    </div>
                    <h3 class="card-title">Đổi mật khẩu 🔐</h3>
                    <p class="card-description">
                        Cập nhật mật khẩu để bảo vệ tài khoản của bạn
                    </p>
                </div>

                <form action="${pageContext.request.contextPath}/authen?action=change-password" method="POST" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="currentPassword" class="form-label">
                            <i class="fas fa-lock"></i> Mật khẩu hiện tại
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="currentPassword" 
                                name="currentPassword" 
                                class="form-input" 
                                placeholder="Nhập mật khẩu hiện tại" 
                                required 
                                onkeydown="preventSpaces(event)"
                            >
                            <button type="button" class="toggle-password" onclick="togglePasswordVisibility('currentPassword')">
                                <i class="fas fa-eye" id="currentPassword-icon"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newPassword" class="form-label">
                            <i class="fas fa-key"></i> Mật khẩu mới
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="newPassword" 
                                name="newPassword" 
                                class="form-input" 
                                placeholder="Nhập mật khẩu mới" 
                                required 
                                onkeydown="preventSpaces(event)"
                            >
<button type="button" class="toggle-password" onclick="togglePasswordVisibility('newPassword')">
                                <i class="fas fa-eye" id="newPassword-icon"></i>
                            </button>
                        </div>
                        <div id="passwordNote" class="password-note">
                            <div class="password-note-title">
                                <i class="fas fa-info-circle"></i>
                                Yêu cầu mật khẩu:
                            </div>
                            <ul>
                                <li>Từ 8 đến 20 ký tự</li>
                                <li>Bao gồm số, chữ cái</li>
                                <li>Có ký tự đặc biệt</li>
                                <li>Không chứa khoảng trắng</li>
                            </ul>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="retypePassword" class="form-label">
                            <i class="fas fa-check-circle"></i> Nhập lại mật khẩu
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="retypePassword" 
                                name="retypePassword" 
                                class="form-input" 
                                placeholder="Xác nhận mật khẩu mới" 
                                required 
                                onkeydown="preventSpaces(event)"
                            >
                            <button type="button" class="toggle-password" onclick="togglePasswordVisibility('retypePassword')">
                                <i class="fas fa-eye" id="retypePassword-icon"></i>
                            </button>
                        </div>
                    </div>

                    <c:if test="${not empty requestScope.changePWfail}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            ${requestScope.changePWfail}
                        </div>
                    </c:if>

                    <div class="button-group">
                        <button type="submit" class="btn update-btn">
                            <i class="fas fa-save"></i>
                            Cập nhật
                        </button>
                        <button type="button" class="btn cancel-btn" onclick="cancelChangePassword()">
                            <i class="fas fa-times"></i>
                            Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

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

        // Toggle password visibility
        function togglePasswordVisibility(id) {
            const input = document.getElementById(id);
            const icon = document.getElementById(id + '-icon');
            
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = "password";
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        // Show/hide password note
        var newPasswordInput = document.getElementById('newPassword');
        var passwordNote = document.getElementById('passwordNote');

        newPasswordInput.addEventListener('focus', function() {
            passwordNote.classList.add('show');
        });

        newPasswordInput.addEventListener('blur', function() {
            setTimeout(() => {
                passwordNote.classList.remove('show');
            }, 200);
        });

        // Prevent entering spaces in password fields
        function preventSpaces(event) {
            if (event.key === " ") {
                event.preventDefault();
                const input = event.target;
                input.style.borderColor = '#ff6b6b';
                setTimeout(() => {
                    input.style.borderColor = '';
                }, 500);
            }
        }

        // Validate form before submission
        function validateForm() {
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;
            var retypePassword = document.getElementById("retypePassword").value;

            if (currentPassword.includes(" ") || newPassword.includes(" ") || retypePassword.includes(" ")) {
                alert("Mật khẩu không được chứa khoảng trắng!");
                return false;
            }

            if (newPassword !== retypePassword) {
                alert("Mật khẩu mới và xác nhận mật khẩu không khớp!");
                return false;
            }

            return true;
        }

        // Cancel change password
        function cancelChangePassword() {
            var role = ${sessionScope.account.getRoleId()};
            if (role === 1) {
                window.location.href = "${pageContext.request.contextPath}/view/admin/adminHome.jsp";
            } else if (role === 2) {
window.location.href = "${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp";
            } else if (role === 3) {
                window.location.href = "${pageContext.request.contextPath}/HomeSeeker";
            }
        }

        // Password match indicator
        const retypePasswordInput = document.getElementById('retypePassword');
        retypePasswordInput.addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            if (newPassword !== '' && retypePasswordInput.value !== '') {
                if (newPassword === retypePasswordInput.value) {
                    retypePasswordInput.style.borderColor = '#39ff14';
                } else {
                    retypePasswordInput.style.borderColor = '#ff6b6b';
                }
            }
        });
    </script>
</body>
</html>