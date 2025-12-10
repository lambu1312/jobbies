<%-- Document : forgotPassword Created on : Sep 15, 2024, 9:50:14 PM Author : Admin --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Verify OTP - JobPath</title>
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

                    /* OTP Container */
                    .otp-container {
                        position: relative;
                        z-index: 10;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        flex-grow: 1;
                        padding: 2rem 1rem;
                    }

                    .otp-card {
                        width: 100%;
                        max-width: 500px;
                        background: rgba(255, 255, 255, 0.05);
                        backdrop-filter: blur(20px);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 30px;
                        overflow: hidden;
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

                    .otp-card::before {
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
                        background: rgba(196, 113, 245, 0.1);
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        padding: 2rem;
                        text-align: center;
                    }

                    .card-title {
                        font-size: 1.5rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 0.5rem;
                    }

                    .card-icon {
                        font-size: 2rem;
                        animation: pulse 2s ease-in-out infinite;
                    }

                    @keyframes pulse {

                        0%,
                        100% {
                            transform: scale(1);
                        }

                        50% {
                            transform: scale(1.1);
                        }
                    }

                    .card-body {
                        padding: 2.5rem;
                    }

                    .info-message {
                        background: rgba(126, 232, 250, 0.1);
                        border: 1px solid rgba(126, 232, 250, 0.3);
                        border-radius: 15px;
                        padding: 1rem;
                        margin-bottom: 2rem;
                        color: #7ee8fa;
                        text-align: center;
                        font-size: 0.9rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        justify-content: center;
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

                    .otp-input-container {
                        display: flex;
                        gap: 0.5rem;
                        justify-content: center;
                        margin-bottom: 1rem;
                    }

                    .otp-digit {
                        width: 50px;
                        height: 60px;
                        font-size: 1.5rem;
                        font-weight: 700;
                        text-align: center;
                        background: rgba(255, 255, 255, 0.08);
                        border: 2px solid rgba(255, 255, 255, 0.2);
                        border-radius: 12px;
                        color: #fff;
                        outline: none;
                        transition: all 0.3s;
                    }

                    .otp-digit:focus {
                        border-color: #c471f5;
                        box-shadow: 0 0 20px rgba(196, 113, 245, 0.4);
                        background: rgba(255, 255, 255, 0.1);
                        transform: scale(1.05);
                    }

                    .otp-digit::placeholder {
                        color: rgba(255, 255, 255, 0.3);
                    }

                    .form-control {
                        width: 100%;
                        padding: 1rem 1.2rem;
                        background: rgba(255, 255, 255, 0.08);
                        border: 1px solid rgba(255, 255, 255, 0.2);
                        border-radius: 15px;
                        color: #fff;
                        font-size: 1rem;
                        text-align: center;
                        letter-spacing: 0.3rem;
                        font-weight: 600;
                        outline: none;
                        transition: all 0.3s;
                    }

                    .form-control::placeholder {
                        color: rgba(255, 255, 255, 0.4);
                        letter-spacing: normal;
                    }

                    .form-control:focus {
                        border-color: #c471f5;
                        box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                        background: rgba(255, 255, 255, 0.1);
                    }

                    /* Error Message */
                    .error-message {
                        background: rgba(255, 82, 82, 0.1);
                        border: 1px solid rgba(255, 82, 82, 0.3);
                        border-radius: 12px;
                        padding: 0.8rem;
                        margin-bottom: 1rem;
                        color: #ff5252;
                        text-align: center;
                        font-size: 0.9rem;
                        animation: shake 0.5s;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        justify-content: center;
                    }

                    @keyframes shake {

                        0%,
                        100% {
                            transform: translateX(0);
                        }

                        25% {
                            transform: translateX(-10px);
                        }

                        75% {
                            transform: translateX(10px);
                        }
                    }

                    /* Submit Button */
                    .btn-submit {
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
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 0.5rem;
                    }

                    .btn-submit:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
                    }

                    .btn-submit:active {
                        transform: translateY(0);
                    }

                    /* Resend Link */
                    .resend-container {
                        text-align: center;
                        margin-top: 1.5rem;
                        color: #b8b8d1;
                        font-size: 0.9rem;
                    }

                    .resend-link {
                        color: #7ee8fa;
                        text-decoration: none;
                        font-weight: 600;
                        transition: all 0.3s;
                    }

                    .resend-link:hover {
                        color: #c471f5;
                        text-shadow: 0 0 10px rgba(196, 113, 245, 0.5);
                    }

                    /* Timer */
                    .timer {
                        display: inline-block;
                        background: rgba(57, 255, 20, 0.1);
                        border: 1px solid rgba(57, 255, 20, 0.3);
                        color: #39ff14;
                        padding: 0.3rem 0.8rem;
                        border-radius: 20px;
                        font-weight: 600;
                        font-size: 0.85rem;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .otp-card {
                            margin: 1rem;
                        }

                        .card-header,
                        .card-body {
                            padding: 1.5rem;
                        }

                        .card-title {
                            font-size: 1.3rem;
                        }

                        .otp-digit {
                            width: 45px;
                            height: 55px;
                            font-size: 1.3rem;
                        }

                        .pixel-decoration {
                            font-size: 2rem;
                        }
                    }

                    @media (max-width: 480px) {
                        .otp-digit {
                            width: 40px;
                            height: 50px;
                            font-size: 1.2rem;
                        }

                        .otp-input-container {
                            gap: 0.3rem;
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

                <!-- OTP Container -->
                <div class="otp-container">
                    <div class="otp-card">
                        <div class="card-header">
                            <h6 class="card-title">
                                <span class="card-icon">🔐</span>
                                Confirm OTP
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="info-message">
                                <i class="fas fa-info-circle"></i>
                                Please enter the OTP code sent to your email
                            </div>

                            <form action="${pageContext.request.contextPath}/authen?action=verify-otp" method="post"
                                id="otpForm">
                                <div class="form-group">
                                    <label for="ResetOTPCode" class="form-label">Enter OTP Code</label>
                                    <input type="text" name="otp" id="ResetOTPCode" class="form-control"
                                        placeholder="Enter 6-digit OTP" maxlength="6" required>
                                </div>

                                <c:if test="${requestScope.error != null}">
                                    <div class="error-message">
                                        <i class="fas fa-exclamation-circle"></i>
                                        ${requestScope.error}
                                    </div>
                                </c:if>

                                <button type="submit" class="btn-submit">
                                    <i class="fas fa-check-circle"></i>
                                    Verify OTP
                                </button>
                            </form>

                            <div class="resend-container">
                                Didn't receive the code?
                                <a href="#" class="resend-link">Resend OTP</a>
                                <br>
                                <span class="timer">⏱️ Expires in 5:00</span>
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

                    // OTP Input validation - only numbers
                    const otpInput = document.getElementById('ResetOTPCode');
                    otpInput.addEventListener('input', function (e) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });

                    // Auto-submit on 6 digits (optional)
                    otpInput.addEventListener('input', function () {
                        if (this.value.length === 6) {
                            // Optionally auto-submit
                            // document.getElementById('otpForm').submit();
                        }
                    });

                    // Timer countdown (optional implementation)
                    let timeLeft = 300; // 5 minutes in seconds
                    const timerElement = document.querySelector('.timer');

                    function updateTimer() {
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        timerElement.textContent = `⏱️ Expires in ${minutes}:${seconds.toString().padStart(2, '0')}`;

                        if (timeLeft > 0) {
                            timeLeft--;
                        } else {
                            timerElement.textContent = '⏱️ Expired';
                            timerElement.style.background = 'rgba(255, 82, 82, 0.1)';
                            timerElement.style.borderColor = 'rgba(255, 82, 82, 0.3)';
                            timerElement.style.color = '#ff5252';
                        }
                    }

                    setInterval(updateTimer, 1000);
                </script>
            </body>

            </html>