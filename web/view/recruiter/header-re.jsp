<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="main-header">
    <!-- Left Section: Logo & Brand -->
    <div class="header-left">
        <div class="brand-logo">
            <i class="fas fa-rocket brand-icon"></i>
            <span class="brand-text">Jobbies</span>
        </div>
    </div>

    <!-- Center Section: Navigation Links -->
    <nav class="header-nav">
        <a href="${pageContext.request.contextPath}/home" class="nav-link">
            <i class="fas fa-home"></i>
            <span>Trang chủ</span>
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-cogs"></i>
            <span>Dịch vụ</span>
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-shield-alt"></i>
            <span>Điều khoản & Bảo mật</span>
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-envelope"></i>
            <span>Liên hệ</span>
        </a>
    </nav>

    <!-- Right Section: User Profile & Notifications -->
<!--    <div class="header-right">
        <div class="header-icons">
            <button class="icon-button" title="Thông báo">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </button>
            <button class="icon-button" title="Tin nhắn">
                <i class="fas fa-comments"></i>
                <span class="notification-badge">2</span>
            </button>
        </div>

         Mobile Menu Toggle 
        <button class="mobile-menu-toggle" id="mobileMenuToggle">
            <i class="fas fa-bars"></i>
        </button>
    </div>-->
</header>

<style>
    /* Header styling */
    .main-header {
        background: linear-gradient(135deg, rgba(20, 10, 32, 0.98) 0%, rgba(26, 11, 46, 0.95) 100%);
        backdrop-filter: blur(20px);
        padding: 0.8rem 2rem;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 260px;
        width: calc(100% - 260px);
        height: 80px;
        z-index: 1000;
        box-shadow: 0 10px 40px rgba(196, 113, 245, 0.15);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Header Left - Logo */
    .header-left {
        display: flex;
        align-items: center;
        min-width: 200px;
    }

    .brand-logo {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        text-decoration: none;
        color: #fff;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .brand-logo:hover {
        transform: scale(1.05);
    }

    .brand-icon {
        font-size: 1.8rem;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .brand-text {
        font-size: 1.4rem;
        font-weight: 900;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: 1px;
    }

    /* Header Center - Navigation */
    .header-nav {
        display: flex;
        justify-content: center;
        gap: 2rem;
        flex: 1;
    }

    .nav-link {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
        font-weight: 600;
        font-size: 0.95rem;
        padding: 0.6rem 1.2rem;
        border-radius: 10px;
        transition: all 0.3s ease;
        position: relative;
    }

    .nav-link i {
        font-size: 1.1rem;
    }

    .nav-link:hover {
        color: #fff;
        background: rgba(196, 113, 245, 0.15);
        transform: translateY(-2px);
    }

    .nav-link::after {
        content: '';
        position: absolute;
        bottom: -3px;
        left: 50%;
        width: 0;
        height: 2px;
        background: linear-gradient(90deg, #c471f5, #fa71cd);
        transform: translateX(-50%);
        transition: width 0.3s ease;
        border-radius: 1px;
    }

    .nav-link:hover::after {
        width: 80%;
    }

    /* Header Right - Icons & User */
    .header-right {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        min-width: 150px;
        justify-content: flex-end;
    }

    .header-icons {
        display: flex;
        gap: 1rem;
    }

    .icon-button {
        background: rgba(196, 113, 245, 0.1);
        border: 1px solid rgba(196, 113, 245, 0.3);
        color: #fff;
        width: 40px;
        height: 40px;
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        transition: all 0.3s ease;
        position: relative;
    }

    .icon-button:hover {
        background: rgba(196, 113, 245, 0.2);
        border-color: #c471f5;
        transform: scale(1.1);
    }

    .notification-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.7rem;
        font-weight: 700;
        border: 2px solid rgba(20, 10, 32, 0.98);
    }

    /* Mobile Menu Toggle */
    .mobile-menu-toggle {
        display: none;
        background: transparent;
        border: none;
        color: #fff;
        font-size: 1.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .mobile-menu-toggle:hover {
        transform: scale(1.15);
    }

    /* Main content margin - adjust for header height */
    .main-content {
        margin-top: 80px;
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
        .header-nav {
            gap: 1rem;
        }

        .nav-link {
            padding: 0.5rem 0.8rem;
            font-size: 0.9rem;
        }

        .nav-link span {
            display: none;
        }

        .nav-link i {
            font-size: 1.2rem;
        }

        .nav-link::after {
            bottom: -5px;
        }
    }

    @media (max-width: 1024px) {
        .main-header {
            left: 0;
            width: 100%;
        }

        .header-nav {
            display: none;
        }

        .header-left {
            min-width: auto;
        }

        .mobile-menu-toggle {
            display: flex;
        }
    }

    @media (max-width: 768px) {
        .main-header {
            padding: 0.8rem 1rem;
            height: 70px;
        }

        .brand-text {
            font-size: 1.2rem;
        }

        .brand-icon {
            font-size: 1.5rem;
        }

        .header-icons {
            gap: 0.8rem;
        }

        .icon-button {
            width: 36px;
            height: 36px;
            font-size: 1rem;
        }

        .main-content {
            margin-top: 70px;
            margin-left: 0;
        }
    }

    /* Styles for sidebar compatibility */
    .sidebar {
        height: 100vh;
        width: 260px;
        position: fixed;
        top: 0;
        left: 0;
        background: linear-gradient(135deg, rgba(196, 113, 245, 0.1) 0%, rgba(126, 232, 250, 0.05) 100%);
        backdrop-filter: blur(20px);
        border-right: 1px solid rgba(255, 255, 255, 0.1);
        padding-top: 0;
        overflow-y: auto;
        z-index: 1001;
    }

    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', system-ui, sans-serif;
    }

    /* Animation for page transitions */
    @keyframes slideInDown {
        from {
            transform: translateY(-100%);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .main-header {
        animation: slideInDown 0.5s ease-out;
    }
</style>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Mobile menu toggle functionality
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const sidebar = document.querySelector('.sidebar');

    mobileMenuToggle.addEventListener('click', function() {
        if (sidebar) {
            sidebar.classList.toggle('active');
        }
    });

    // Close sidebar when clicking outside
    document.addEventListener('click', function(event) {
        if (sidebar && !sidebar.contains(event.target) && !mobileMenuToggle.contains(event.target)) {
            sidebar.classList.remove('active');
        }
    });
</script>