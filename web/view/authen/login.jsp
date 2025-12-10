<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login - JobPath</title>
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

                /* Login Container */
                .login-container {
                    position: relative;
                    z-index: 10;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-grow: 1;
                    padding: 2rem 1rem;
                }

                .login-card {
                    width: 100%;
                    max-width: 500px;
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

                .login-card::before {
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
                    position: relative;
                }

                .card-title {
                    font-size: 2rem;
                    font-weight: 900;
                    background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    margin-bottom: 0.5rem;
                }

                .card-title .highlight {
                    color: #39ff14;
                }

                .btn-close {
                    position: absolute;
                    top: -1rem;
                    right: 0;
                    background: rgba(255, 255, 255, 0.1);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 50%;
                    width: 35px;
                    height: 35px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    text-decoration: none;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .btn-close:hover {
                    background: rgba(196, 113, 245, 0.3);
                    border-color: #c471f5;
                    transform: rotate(90deg);
                }

                /* Alerts */
                .alert {
                    padding: 1rem;
                    border-radius: 15px;
                    margin-bottom: 1.5rem;
                    border: 1px solid;
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

                .alert-danger {
                    background: rgba(255, 82, 82, 0.1);
                    border-color: rgba(255, 82, 82, 0.3);
                    color: #ff5252;
                }

                .alert-success {
                    background: rgba(57, 255, 20, 0.1);
                    border-color: rgba(57, 255, 20, 0.3);
                    color: #39ff14;
                }

                /* Form Styles */
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

                .form-control {
                    width: 100%;
                    padding: 0.9rem 1.2rem;
                    background: rgba(255, 255, 255, 0.08);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 15px;
                    color: #fff;
                    font-size: 1rem;
                    outline: none;
                    transition: all 0.3s;
                }

                .form-control::placeholder {
                    color: rgba(255, 255, 255, 0.4);
                }

                .form-control:focus {
                    border-color: #c471f5;
                    box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                    background: rgba(255, 255, 255, 0.1);
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

                /* Remember Me & Links */
                .form-options {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 1.5rem;
                }

                .form-check {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .form-check-input {
                    width: 18px;
                    height: 18px;
                    cursor: pointer;
                    accent-color: #c471f5;
                }

                .form-check-label {
                    color: #b8b8d1;
                    font-size: 0.9rem;
                    cursor: pointer;
                }

                .form-link {
                    color: #7ee8fa;
                    text-decoration: none;
                    font-size: 0.9rem;
                    transition: all 0.3s;
                }

                .form-link:hover {
                    color: #c471f5;
                    text-shadow: 0 0 10px rgba(196, 113, 245, 0.5);
                }

                /* reCAPTCHA */
                .recaptcha-container {
                    margin-bottom: 1rem;
                    transform: scale(0.95);
                    transform-origin: 0 0;
                }

                .error-message {
                    color: #ff5252;
                    font-size: 0.85rem;
                    margin-top: 0.5rem;
                }

                /* Buttons */
                .btn-login {
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
                    margin-bottom: 1.5rem;
                }

                .btn-login:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
                }

                .btn-login:active {
                    transform: translateY(0);
                }

                /* Register Link */
                .register-link {
                    text-align: center;
                    color: #b8b8d1;
                    font-size: 0.95rem;
                }

                .register-link a {
                    color: #7ee8fa;
                    text-decoration: none;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .register-link a:hover {
                    color: #c471f5;
                    text-shadow: 0 0 10px rgba(196, 113, 245, 0.5);
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .login-card {
                        padding: 2rem 1.5rem;
                        margin: 1rem;
                    }

                    .card-title {
                        font-size: 1.5rem;
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

            <!-- Login Container -->
            <div class="login-container">
                <div class="login-card">
                    <div class="card-header">
                        <h4 class="card-title">
                            Login Job<span class="highlight">Path</span>
                        </h4>
                        <a href="${pageContext.request.contextPath}/home" class="btn-close" aria-label="Close">✕</a>
                    </div>

                    <!-- Display error message if login fails -->
                    <c:if test="${requestScope.messLogin != null}">
                        <div class="alert alert-danger">
                            ${requestScope.messLogin}
                        </div>
                    </c:if>
                    <c:if test="${not empty requestScope.changePWsuccess}">
                        <div class="alert alert-success">${requestScope.changePWsuccess}</div>
                    </c:if>

                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/authen?action=login" method="post" id="login-form"
                        onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username"
                                placeholder="Enter your username" value="${cookie.cu.value}" required>
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password"
                                    placeholder="Enter your password" value="${cookie.cp.value}" required>
                                <span class="input-group-text" onclick="togglePassword('password')">
                                    👁️
                                </span>
                            </div>
                        </div>

                        <div class="form-options">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe"
                                    ${(cookie.cr !=null ? 'checked' :'')}>
                                <label class="form-check-label" for="rememberMe">Remember Me</label>
                            </div>
                        </div>

                        <!-- Google reCAPTCHA -->
                        <div class="recaptcha-container">
                            <div class="g-recaptcha" data-sitekey="6LeVFEsqAAAAAFK_7xKTrV798KMOrnTYcVgfeMIa"></div>
                            <div id="error" class="error-message"></div>
                        </div>

                        <!-- Login Button -->
                        <button type="button" onclick="checkCapCha()" class="btn-login">Login ✨</button>
                    </form>

                    <!-- Register Link -->
                    <p class="register-link">Don't have an account? <a
                            href="${pageContext.request.contextPath}/authen?action=sign-up">Register</a></p>
                </div>
            </div>

            <jsp:include page="../common/footer.jsp"></jsp:include>

            <!-- JS logic -->
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <script type="text/javascript">
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

                function togglePassword() {
                    var input = document.getElementById("password");
                    var icon = document.querySelector(".input-group-text");
                    if (input.type === "password") {
                        input.type = "text";
                        icon.textContent = '🙈';
                    } else {
                        input.type = "password";
                        icon.textContent = '👁️';
                    }
                }

                // Prevent entering spaces in username and password fields
                function preventSpaces(event) {
                    if (event.key === " ") {
                        event.preventDefault();
                        alert("Username and Password cannot contain spaces!");
                    }
                }

                // Remove spaces when entering username
                document.getElementById("username").addEventListener("input", function () {
                    this.value = this.value.replace(/\s/g, "");
                });

                // Remove spaces when entering password
                document.getElementById("password").addEventListener("input", function () {
                    this.value = this.value.replace(/\s/g, "");
                });

                function validateForm() {
                    var username = document.getElementById("username").value;
                    var password = document.getElementById("password").value;

                    // Trim spaces from start and end
                    username = username.trim();
                    password = password.trim();

                    // Check for spaces anywhere in username or password
                    if (/\s/.test(username) || /\s/.test(password)) {
                        alert("Username and Password cannot contain spaces!");
                        return false;
                    }

                    return true;
                }

                document.getElementById("login-form").onsubmit = function () {
                    return validateForm();
                };

                // Attach event listeners to prevent space input
                document.getElementById("username").addEventListener("keydown", preventSpaces);
                document.getElementById("password").addEventListener("keydown", preventSpaces);

                function checkCapCha() {
                    var form = document.getElementById("login-form");
                    var error = document.getElementById("error");
                    const response = grecaptcha.getResponse();
                    if (response) {
                        form.submit();
                    } else {
                        error.textContent = "Please verify that you are not a robot";
                    }
                }
            </script>
        </body>

        </html>