<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Sidebar -->
<div class="sidebar">
    <!-- Logo Section -->
    <div class="sidebar-logo">
        <div class="logo-container">
            <i class="fas fa-rocket logo-icon"></i>
            <span class="logo-text">Jobbies</span>
        </div>
    </div>

    <!-- User Info Section -->
    <div class="user-info">
        <div class="avatar-wrapper">
            <c:if test="${empty sessionScope.account.getAvatar()}">
                <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="avatar-img">
            </c:if>
            <c:if test="${!empty sessionScope.account.getAvatar()}">
                <img src="${sessionScope.account.getAvatar()}" alt="User Avatar" class="avatar-img">
            </c:if>
            <div class="avatar-status"></div>
        </div>
        <div class="user-details">
            <span class="user-name">${sessionScope.account.getFullName()}</span>
            <span class="user-role">Recruiter</span>
        </div>
    </div>

    <!-- Navigation Links -->
    <nav class="sidebar-nav">
        <a href="#" class="nav-link">
            <i class="fas fa-home"></i>
            <span>Tổng quan</span>
        </a>
        <a class="nav-link">
            <i class="fas fa-address-card"></i>
            <span>Trang cá nhân</span>
        </a>
        <a href="${pageContext.request.contextPath}/jobPost" class="nav-link">
            <i class="fas fa-list"></i>
            <span>Đăng tin tuyển dụng</span>
        </a>
        <a class="nav-link">
            <i class="fas fa-building"></i>
            <span>Tạo công ty</span>
        </a>
        <a class="nav-link">
            <i class="fas fa-pencil-alt"></i>
            <span>Chỉnh sửa công ty</span>
        </a>
        
        <!-- Divider -->
        <div class="nav-divider"></div>
        
        <!-- Account Section -->
        <div class="nav-section-title">Tài khoản</div>
        
        <a href="#" class="nav-link">
            <i class="fas fa-lock"></i>
            <span>Thay đổi mật khẩu</span>
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-user-slash"></i>
            <span>Vô hiệu hóa tài khoản</span>
        </a>
        <a href="${pageContext.request.contextPath}/view/authen/logout.jsp" class="nav-link logout-link">
            <i class="fas fa-sign-out-alt"></i>
            <span>Đăng xuất</span>
        </a>
    </nav>
</div>

<!-- Styles -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    .sidebar {
        height: 100vh;
        width: 260px;
        position: fixed;
        top: 0;
        left: 0;
        background: #fff;
        border-right: 1px solid #e0e0e0;
        padding: 0;
        overflow-y: auto;
        overflow-x: hidden;
        z-index: 1000;
        box-shadow: 2px 0 15px rgba(196, 113, 245, 0.1);
    }

    /* Custom Scrollbar */
    .sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: #f5f5f5;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        border-radius: 10px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(135deg, #b860e8, #f05bc6);
    }

    /* Logo Section */
    .sidebar-logo {
        padding: 2rem 1.5rem;
        text-align: center;
        border-bottom: 2px solid #f0f0f0;
        margin-bottom: 1.5rem;
    }

    .logo-container {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.8rem;
    }

    .logo-icon {
        font-size: 2rem;
        color: #c471f5;
    }

    .logo-text {
        font-size: 1.8rem;
        font-weight: 900;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: 1px;
    }

    /* User Info Section */
    .user-info {
        padding: 1.5rem;
        text-align: center;
        margin-bottom: 1.5rem;
        background: #f8f9ff;
        border-radius: 15px;
        margin: 0 1rem 1.5rem;
        border: 1px solid #e8e8f0;
    }

    .avatar-wrapper {
        position: relative;
        display: inline-block;
        margin-bottom: 1rem;
    }

    .avatar-img {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid transparent;
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        padding: 3px;
        box-shadow: 0 5px 15px rgba(196, 113, 245, 0.25);
        transition: all 0.3s;
    }

    .avatar-img:hover {
        transform: scale(1.08);
        box-shadow: 0 8px 25px rgba(196, 113, 245, 0.4);
    }

    .avatar-status {
        position: absolute;
        bottom: 5px;
        right: 5px;
        width: 16px;
        height: 16px;
        background: #39ff14;
        border-radius: 50%;
        border: 3px solid #fff;
        box-shadow: 0 0 10px rgba(57, 255, 20, 0.6);
    }

    .user-details {
        display: flex;
        flex-direction: column;
        gap: 0.3rem;
    }

    .user-name {
        font-weight: 700;
        color: #333;
        font-size: 1.1rem;
    }

    .user-role {
        font-size: 0.85rem;
        color: #999;
        font-weight: 500;
    }

    /* Navigation */
    .sidebar-nav {
        padding: 0 0.8rem;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 0.9rem 1.2rem;
        margin-bottom: 0.4rem;
        text-decoration: none;
        color: #333;
        border-radius: 12px;
        transition: all 0.3s;
        position: relative;
        overflow: hidden;
        font-size: 0.95rem;
        font-weight: 500;
    }

    .nav-link::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 3px;
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        transform: scaleY(0);
        transition: transform 0.3s;
    }

    .nav-link:hover {
        background: #f5f0ff;
        color: #333;
        transform: translateX(5px);
    }

    .nav-link:hover::before {
        transform: scaleY(1);
    }

    .nav-link.active {
        background: linear-gradient(90deg, rgba(196, 113, 245, 0.15), transparent);
        color: #333;
        border-left: 3px solid #c471f5;
    }

    .nav-link i {
        margin-right: 1rem;
        font-size: 1.1rem;
        width: 20px;
        text-align: center;
        color: #c471f5;
        transition: all 0.3s;
    }

    .nav-link:hover i {
        transform: scale(1.15);
        color: #fa71cd;
    }

    .nav-link:hover span {
        color: #333;
    }

    .nav-link span {
        flex: 1;
        text-align: left;
        color: #333;
        font-weight: 500;
    }

    /* Section Divider */
    .nav-divider {
        height: 1px;
        background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
        margin: 1.5rem 1rem;
    }

    /* Section Title */
    .nav-section-title {
        padding: 0.8rem 1.2rem;
        font-size: 0.75rem;
        font-weight: 700;
        color: #333;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        margin-top: 0.5rem;
        margin-bottom: 0.8rem;
    }

    /* Logout Link Special Style */
    .logout-link {
        color: #ff6b6b;
        margin-top: 0.5rem;
    }

    .logout-link span {
        color: #ff6b6b;
        font-weight: 500;
    }

    .logout-link i {
        color: #ff6b6b;
    }

    .logout-link:hover {
        background: rgba(255, 107, 107, 0.1);
        color: #ff6b6b;
    }

    .logout-link:hover i {
        color: #ff6b6b;
        transform: scale(1.15);
    }

    /* Responsive Design */
    @media (max-width: 1024px) {
        .sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s;
        }

        .sidebar.active {
            transform: translateX(0);
        }
    }

    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            max-width: 280px;
        }

        .logo-text {
            font-size: 1.5rem;
        }

        .user-name {
            font-size: 1rem;
        }

        .nav-link {
            padding: 0.8rem 1rem;
            font-size: 0.9rem;
        }

        .nav-link i {
            font-size: 1rem;
        }
    }
</style>