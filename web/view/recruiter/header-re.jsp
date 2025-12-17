<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <!-- Navigation Links -->
    <div class="nav-links">
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
        </div>
        <div class="nav-item">
            <a href="#">Giới Thiệu</a>
        </div>
        <div class="nav-item">
            <a href="#">Dịch Vụ</a>
        </div>
        <div class="nav-item">
            <a href="#">Liên Hệ</a>
        </div>
    </div>
    <!-- Jobbies Logo/Text -->
    <div class="jobpath-logo">
        <span class="jobbies-logo">
            <span class="jobbies-text">Jobbies</span>
            
        </span>
    </div>
</header>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Header styling */
    header {
        background: linear-gradient(135deg, #e8eef5 0%, #dfe5f0 100%);
        padding: 15px 30px;
        color: #1a1a1a;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 260px;
        width: calc(100% - 260px);
        height: 70px;
        z-index: 1000;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        border-bottom: 1px solid rgba(196, 113, 245, 0.15);
    }

    /* Sidebar styling */
    .sidebar {
        height: 100vh;
        width: 260px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #fff;
        padding-top: 20px;
        overflow-y: auto;
        border-right: 1px solid #e5e5e5;
    }

    /* Navigation Links */
    .nav-links {
        display: flex;
        justify-content: center;
        flex-grow: 1;
        gap: 0;
    }

    .nav-item {
        margin: 0 25px;
        position: relative;
    }

    .nav-item a {
        color: #666;
        text-decoration: none;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        height: 40px;
        position: relative;
    }

    .nav-item a:hover {
        color: #c471f5;
    }

    .nav-item a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(90deg, #c471f5, #fa71cd);
        transition: width 0.3s ease;
    }

    .nav-item a:hover::after {
        width: 100%;
    }

    /* Jobbies Logo/Text */
    .jobpath-logo {
        font-size: 24px;
        font-weight: bold;
        display: flex;
        align-items: center;
    }

    .jobbies-logo {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2px;
    }

    .jobbies-text {
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        font-size: 22px;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .jobbies-subtitle {
        font-size: 10px;
        color: #999;
        font-weight: 500;
        text-transform: none;
        letter-spacing: 0.5px;
    }

    .logo__image {
        filter: brightness(0.9);
        transition: all 0.3s ease;
    }

    .logo__image:hover {
        filter: brightness(1);
    }

    .green-text {
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    /* Main content margin */
    .main-content {
        margin-top: 90px;
    }

    /* General page styling */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Inter', system-ui, sans-serif;
    }

    /* Mobile Responsive */
    @media (max-width: 1200px) {
        header {
            left: 0;
            width: 100%;
        }

        .nav-links {
            justify-content: flex-start;
            gap: 15px;
        }

        .nav-item {
            margin: 0 15px;
        }

        .nav-item a {
            font-size: 13px;
        }
    }

    @media (max-width: 768px) {
        header {
            flex-direction: column;
            height: auto;
            padding: 10px 20px;
            gap: 10px;
        }

        .nav-links {
            width: 100%;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .nav-item {
            margin: 0 10px;
        }

        .nav-item a {
            font-size: 12px;
            height: 35px;
        }

        .logo__image {
            width: 130px !important;
            height: 35px !important;
        }

        .jobbies-text {
            font-size: 18px;
        }

        .jobbies-subtitle {
            font-size: 8px;
        }
    }

    @media (max-width: 480px) {
        header {
            padding: 10px 15px;
        }

        .nav-links {
            gap: 5px;
        }

        .nav-item {
            margin: 0 8px;
        }

        .nav-item a {
            font-size: 11px;
            height: 30px;
            margin: 0 5px;
        }

        .logo__image {
            width: 110px !important;
            height: 30px !important;
        }

        .jobbies-text {
            font-size: 16px;
        }

        .jobbies-subtitle {
            font-size: 7px;
        }
    }
</style>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>