<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Jobbies</title>
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

        .verify-otp-container {
            width: 100%;
            max-width: 500px;
        }

        .verify-otp-card {
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

        .verify-otp-card::before {
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
            background: linear-gradient(135deg, #7ee8fa 0%, #c471f5 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            box-shadow: 0 10px 30px rgba(126, 232, 250, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .card-title {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #7ee8fa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .card-description {
            color: #b8b8d1;
            font-size: 1rem;
            line-height: 1.6;
        }

        .info-box {
            background: rgba(126, 232, 250, 0.1);
            border: 1px solid rgba(126, 232, 250, 0.3);
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .info-box i {
            color: #7ee8fa;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .info-box-text {
            color: #b8b8d1;
            font-size: 0.9rem;
            line-height: 1.5;
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

        .form-input {
            width: 100%;
            padding: 1rem 1.2rem;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: #fff;
            font-size: 1.2rem;
            font-weight: 600;
            letter-spacing: 0.5rem;
            text-align: center;
            outline: none;
            transition: all 0.3s;
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.4);
            letter-spacing: normal;
        }

        .form-input:focus {
            border-color: #7ee8fa;
            box-shadow: 0 0 20px rgba(126, 232, 250, 0.4);
            background: rgba(255, 255, 255, 0.12);
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

        .submit-button {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #7ee8fa 0%, #c471f5 100%);
            border: none;
            border-radius: 15px;
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(126, 232, 250, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(126, 232, 250, 0.6);
        }

        .submit-button:active {
            transform: translateY(-1px);
        }

        .card-footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }

        .footer-text {
            color: #b8b8d1;
            font-size: 0.95rem;
        }

        .footer-link {
            color: #7ee8fa;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s;
            display: inline-block;
        }

        .footer-link:hover {
            color: #c471f5;
            text-shadow: 0 0 15px rgba(126, 232, 250, 0.6);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 2rem 1rem;
            }

            .verify-otp-card {
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

            .form-input {
                letter-spacing: 0.3rem;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <div class="pixel-decoration deco-1">📱</div>
    <div class="pixel-decoration deco-2">🔐</div>
    <div class="pixel-decoration deco-3">✉️</div>

    <jsp:include page="../common/header-area.jsp"></jsp:include>

    <div class="main-content">
        <div class="verify-otp-container">
            <div class="verify-otp-card">
                <div class="card-header">
                    <div class="card-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="card-title">Xác nhận OTP 🛡️</h3>
                    <p class="card-description">
Nhập mã OTP đã được gửi đến email của bạn
                    </p>
                </div>

                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    <div class="info-box-text">
                        Mã OTP có hiệu lực trong <strong>5 phút</strong>. Vui lòng kiểm tra hộp thư đến hoặc thư rác.
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/authen?action=verify-reset-otp" method="post">
                    <div class="form-group">
                        <label for="ResetOTPCode" class="form-label">
                            <i class="fas fa-lock"></i> Mã OTP
                        </label>
                        <input 
                            type="text" 
                            name="otp" 
                            id="ResetOTPCode" 
                            class="form-input" 
                            placeholder="000000" 
                            maxlength="6"
                            required
                        >
                    </div>

                    <c:if test="${requestScope.error != null}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            ${requestScope.error}
                        </div>
                    </c:if>

                    <button type="submit" class="submit-button">
                        <i class="fas fa-check-circle"></i>
                        Đặt lại mật khẩu
                    </button>
                </form>

                <div class="card-footer">
                    <span class="footer-text">Bạn nhớ mật khẩu?</span>
                    <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="footer-link">
                        Đăng nhập ngay <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
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

        // Auto-format OTP input (only allow numbers)
        const otpInput = document.getElementById('ResetOTPCode');
        if (otpInput) {
            otpInput.addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        }
    </script>
</body>
</html>