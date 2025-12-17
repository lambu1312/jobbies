<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng xuất - Jobbies</title>
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
            overflow: hidden;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
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

        .deco-1 { top: 15%; left: 10%; }
        .deco-2 { top: 70%; right: 15%; animation-delay: 2s; }
        .deco-3 { bottom: 20%; left: 15%; animation-delay: 1s; }

        .logout-container {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 500px;
            padding: 2rem;
        }

        .logout-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(30px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 3rem;
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3),
                        inset 0 1px 0 rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
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

        .logout-card::before {
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

        .logout-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logout-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, #ff6b6b 0%, #c471f5 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            box-shadow: 0 10px 30px rgba(255, 107, 107, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .logout-title {
            font-size: 1.8rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #ff6b6b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .logout-description {
            color: #b8b8d1;
            font-size: 1rem;
            line-height: 1.6;
        }

        .warning-box {
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .warning-box i {
            color: #ff6b6b;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .warning-box-text {
            color: #b8b8d1;
            font-size: 0.9rem;
            line-height: 1.5;
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

        .btn-cancel {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border: 2px solid rgba(255, 255, 255, 0.2);
        }

        .btn-cancel:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }

        .btn-logout {
            background: linear-gradient(135deg, #ff6b6b 0%, #c471f5 100%);
            color: #fff;
            box-shadow: 0 10px 30px rgba(255, 107, 107, 0.4);
        }

        .btn-logout:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 107, 107, 0.6);
        }

        .btn-logout:active, .btn-cancel:active {
            transform: translateY(-1px);
        }

        .logo-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 900;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 2px;
            text-shadow: 0 0 30px rgba(196, 113, 245, 0.5);
        }

        @media (max-width: 768px) {
            .logout-container {
                padding: 1rem;
            }

            .logout-card {
                padding: 2rem 1.5rem;
            }

            .logout-title {
                font-size: 1.5rem;
            }

            .logout-icon {
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

    <div class="pixel-decoration deco-1">👋</div>
    <div class="pixel-decoration deco-2">🚪</div>
    <div class="pixel-decoration deco-3">⚠️</div>

    <div class="logout-container">
        <div class="logout-card">
            <div class="logo-container">
                <div class="logo">JOBBIES</div>
            </div>

            <div class="logout-header">
                <div class="logout-icon">
                    <i class="fas fa-sign-out-alt"></i>
                </div>
                <h2 class="logout-title">Đăng xuất? 🚪</h2>
                <p class="logout-description">
                    Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?
                </p>
            </div>

            <div class="warning-box">
                <i class="fas fa-info-circle"></i>
                <div class="warning-box-text">
                    Bạn sẽ cần đăng nhập lại để truy cập vào các tính năng của Jobbies.
                </div>
            </div>

            <div class="button-group">
                <button class="btn btn-cancel" onclick="cancelLogout()">
                    <i class="fas fa-times"></i>
                    Hủy bỏ
                </button>
                <button class="btn btn-logout" id="confirmLogout">
                    <i class="fas fa-sign-out-alt"></i>
                    Đăng xuất
                </button>
            </div>
        </div>
    </div>

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

        // Handle the "Log Out" button click
        document.getElementById("confirmLogout").addEventListener("click", function() {
            // Add loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang đăng xuất...';
            this.disabled = true;
            
            setTimeout(() => {
                window.location.href = "${pageContext.request.contextPath}/authen?action=log-out";
            }, 500);
        });

        // Handle the "Cancel" button click
        function cancelLogout() {
            window.history.back();
        }

        // Prevent accidental navigation
        window.addEventListener('beforeunload', function(e) {
            // This is just a safeguard, won't show on modern browsers for security
            e.preventDefault();
        });
    </script>
</body>
</html>