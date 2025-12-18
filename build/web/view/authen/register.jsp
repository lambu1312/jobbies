<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - JobPath</title>
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

                0%,
                100% {
                    opacity: 0.3;
                }

                50% {
                    opacity: 1;
                }
            }

            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.3;
                z-index: 5;
                animation: float 4s ease-in-out infinite;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-20px);
                }
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

            /* Register Container */
            .register-container {
                position: relative;
                z-index: 10;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
                padding: 2rem 1rem;
            }

            .register-card {
                width: 100%;
                max-width: 600px;
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 30px;
                padding: 3rem 2.5rem;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3);
                position: relative;
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .register-card::before {
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
                filter: blur(15px);
            }

            .card-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .card-title {
                font-size: 2rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 0.5rem;
            }

            .card-subtitle {
                color: #b8b8d1;
                font-size: 1rem;
                margin-bottom: 1.5rem;
            }

            /* Role Selection */
            .role-selection {
                display: flex;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .role-btn {
                flex: 1;
                max-width: 200px;
                padding: 0.9rem 1.5rem;
                background: rgba(255, 255, 255, 0.08);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 15px;
                color: #b8b8d1;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                font-size: 1rem;
            }

            .role-btn:hover {
                border-color: #c471f5;
                color: #fff;
                transform: translateY(-2px);
            }

            .role-btn.active {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border-color: transparent;
                color: #fff;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.3rem;
            }

            .form-label {
                display: block;
                color: #b8b8d1;
                font-weight: 600;
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
            }

            .form-control,
            .form-select {
                width: 100%;
                padding: 0.85rem 1.1rem;
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                color: #fff;
                font-size: 0.95rem;
                outline: none;
                transition: all 0.3s;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #c471f5;
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                background: rgba(255, 255, 255, 0.1);
            }

            .form-select {
                cursor: pointer;
            }

            .form-select option {
                background: #1a0b2e;
                color: #fff;
            }

            .input-group {
                position: relative;
                display: flex;
                align-items: center;
            }

            .input-group .form-control {
                padding-right: 3rem;
            }

            .input-group-text {
                position: absolute;
                right: 1rem;
                cursor: pointer;
                font-size: 1.2rem;
                transition: transform 0.3s;
                z-index: 10;
            }

            .input-group-text:hover {
                transform: scale(1.1);
            }

            /* Error Messages */
            .text-danger {
                color: #ff5252;
                font-size: 0.8rem;
                margin-top: 0.3rem;
                display: block;
            }

            .form-text {
                color: #7ee8fa;
                font-size: 0.8rem;
                margin-top: 0.4rem;
                display: block;
            }

            /* Two Column Layout */
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            /* Submit Button */
            .btn-register {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                border-radius: 15px;
                color: #fff;
                font-weight: 700;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
                margin-top: 1rem;
            }

            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
            }

            .btn-register:active {
                transform: translateY(0);
            }

            /* Login Link */
            .login-link {
                text-align: center;
                color: #b8b8d1;
                font-size: 0.95rem;
                margin-top: 1.5rem;
            }

            .login-link a {
                color: #7ee8fa;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .login-link a:hover {
                color: #c471f5;
                text-shadow: 0 0 10px rgba(196, 113, 245, 0.5);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .register-card {
                    padding: 2rem 1.5rem;
                    margin: 1rem;
                }

                .card-title {
                    font-size: 1.5rem;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .role-selection {
                    flex-direction: column;
                }

                .role-btn {
                    max-width: 100%;
                }

                .pixel-decoration {
                    font-size: 2rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="stars" id="stars"></div>

        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <!-- Header Area -->
        <jsp:include page="../common/header-area.jsp"></jsp:include>

            <!-- Register Container -->
            <div class="register-container">
                <div class="register-card">
                    <div class="card-header">
                        <h4 class="card-title">Tạo 1 tài khoản mới ✨</h4>
                        <p class="card-subtitle">Chọn loại tài khoản</p>
                    </div>

                    <!-- Role Selection -->
                    <div class="role-selection">
                        <button class="role-btn active" data-role="seeker">
                            <i class="fas fa-user"></i> Người tìm việc
                        </button>
                        <button class="role-btn" data-role="recruiter">
                            <i class="fas fa-briefcase"></i> Nhà tuyển dụng
                        </button>
                    </div>

                    <!-- Register Form -->
                    <form action="${pageContext.request.contextPath}/authen?action=sign-up" method="POST">
                    <input type="hidden" name="role" value="3" />

                    <div class="form-row">
                        <div class="form-group">
                            <label for="lastname" class="form-label">Họ</label>
                            <input type="text" name="lastname" id="lastname" class="form-control"
                                   placeholder="Enter last name" value="${requestScope.lname}" required>
                            <span class="text-danger">${errorLname}</span>
                        </div>

                        <div class="form-group">
                            <label for="firstname" class="form-label">Tên</label>
                            <input type="text" name="firstname" id="firstname" class="form-control"
                                   placeholder="Enter first name" value="${requestScope.fname}" required>
                            <span class="text-danger">${errorFname}</span>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="gender" class="form-label">Giới tính</label>
                            <select name="gender" id="gender" class="form-select">
                                <option value="male" ${gender=='male' ? 'selected' : '' }>Nam</option>
                                <option value="female" ${gender=='female' ? 'selected' : '' }>Nữ</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="dob" class="form-label">Ngày sinh</label>
                            <input type="date" name="dob" id="dob" class="form-control" value="${requestScope.dob}"
                                   required>
                            <span class="text-danger">${errorDob}</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <input type="text" name="username" id="username" class="form-control"
                               placeholder="Enter username" value="${requestScope.username}" required>
                        <span class="text-danger">${errorUsernameExits}</span>
                        <span class="text-danger">${errorUsername}</span>
                    </div>

                    <div class="form-group">
                        <label for="signemail" class="form-label">Email của bạn</label>
                        <input type="email" name="email" id="signemail" class="form-control"
                               placeholder="Enter your email" value="${requestScope.email}" required>
                        <span class="text-danger">${errorEmail}</span>
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Enter your password" value="${requestScope.password}" required>
                            <span class="input-group-text" onclick="togglePassword('password')">
                                👁️
                            </span>
                        </div>
                        <small class="form-text">! Mật khẩu phải dài từ 8-20 ký tự, chứa ít nhất 1 chữ và 1 ký tự đặc biệt.</small>
                        <span class="text-danger">${errorPassword}</span>
                    </div>

                    <button type="submit" class="btn-register">Đăng ký 🚀</button>
                </form>

                <p class="login-link">Đã có tài khoản? <a
                        href="${pageContext.request.contextPath}/view/authen/login.jsp">Đăng nhập</a></p>
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
            </script>

        <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>


        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const buttons = document.querySelectorAll('button[data-role]');
                const hiddenInput = document.querySelector('input[name="role"]');

                buttons.forEach(button => {
                    button.addEventListener('click', function () {
                        buttons.forEach(btn => btn.classList.remove('active'));
                        this.classList.add('active');

                        const role = this.getAttribute('data-role');
                        hiddenInput.value = (role === 'seeker') ? '3' : '2';
                    });
                });

                // Set initial value
                const activeButton = document.querySelector('button.active');
                if (activeButton) {
                    hiddenInput.value = activeButton.getAttribute('data-role') === 'seeker' ? '3' : '2';
                }
            });

            function togglePassword(id) {
                var input = document.getElementById(id);
                var icon = document.querySelector(".input-group-text");
                if (input.type === "password") {
                    input.type = "text";
                    icon.textContent = '🙈';
                } else {
                    input.type = "password";
                    icon.textContent = '👁️';
                }
            }

            // Prevent spaces in username and password fields
            document.getElementById("username").addEventListener("input", function () {
                this.value = this.value.replace(/\s/g, "");
            });

            document.getElementById("password").addEventListener("input", function () {
                this.value = this.value.replace(/\s/g, "");
            });
        </script>
    </body>

</html>