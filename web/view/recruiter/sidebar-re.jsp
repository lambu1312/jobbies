<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<div class="sidebar">
    <!-- User Info Section (Avatar & Name at the top) -->
    <div class="user-info">
        <c:if test="${empty sessionScope.account.getAvatar()}">
            <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="rounded-circle avatar-img">
        </c:if>
        <c:if test="${!empty sessionScope.account.getAvatar()}">
            <img src="${sessionScope.account.getAvatar()}" alt="User Avatar" class="avatar-img">
        </c:if>
        <div class="user-name">
            <span>${sessionScope.account.getFullName()}</span>
        </div>
    </div>

    <!-- Navigation Links -->
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/Dashboard" class="nav-link">
            <i class="fa-solid fa-home"></i>
            <span>Bảng Điều Khiển</span>
        </a>
        <a href="${pageContext.request.contextPath}/view/recruiter/viewRecruiterProfile.jsp" class="nav-link">
            <i class="fa-solid fa-address-card"></i>
            <span>Hồ Sơ</span>
        </a>
        <a href="${pageContext.request.contextPath}/jobPost" class="nav-link">
            <i class="fa-solid fa-list"></i>
            <span>Đăng bài tuyển dụng </span>
        </a>
        <a href="${pageContext.request.contextPath}/interviewManagement" class="nav-link">
            <i class="fa-solid fa-calendar-check"></i>
            <span>Quản Lý Phỏng Vấn</span>
        </a>
        <a href="${pageContext.request.contextPath}/company?action=create" class="nav-link">
            <i class="fa-solid fa-building"></i>
            <span>Tạo Công Ty</span>
        </a>
        <a href="${pageContext.request.contextPath}/company?action=edit" class="nav-link">
            <i class="fas fa-pencil-alt"></i>
            <span>Chỉnh Sửa Công Ty</span>
        </a>
        <a href="${pageContext.request.contextPath}/view/recruiter/changePW-re.jsp" class="nav-link">
            <i class="fas fa-lock"></i>
            <span>Đổi Mật Khẩu</span>
        </a>
        <a href="${pageContext.request.contextPath}/view/recruiter/deactiveAccountRecruiter.jsp" class="nav-link">
            <i class="fa-solid fa-eraser"></i>
            <span>Vô Hiệu Hóa Tài Khoản</span>
        </a>
        <a href="${pageContext.request.contextPath}/view/authen/logout.jsp" class="nav-link logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Đăng Xuất</span>
        </a>
    </nav>
</div>

<!-- Include styles -->
<header>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
</header>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

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
        font-family: 'Inter', system-ui, sans-serif;
        z-index: 999;
    }

    /* Scrollbar styling */
    .sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: transparent;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: #ddd;
        border-radius: 3px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
        background: #c471f5;
    }

    /* User Info Section */
    .user-info {
        text-align: center;
        padding: 20px;
        margin-bottom: 10px;
        border-bottom: 1px solid #e5e5e5;
    }

    .user-info .avatar-img {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 12px;
        border: 2px solid #c471f5;
        transition: all 0.3s ease;
    }

    .user-info .avatar-img:hover {
        border-color: #fa71cd;
        box-shadow: 0 0 10px rgba(196, 113, 245, 0.3);
    }

    .user-info .user-name {
        font-weight: 600;
        color: #1a1a1a;
        font-size: 14px;
        margin: 0;
    }

    /* Navigation */
    .sidebar-nav {
        display: flex;
        flex-direction: column;
        padding: 10px 0;
    }

    /* Navigation Links */
    .sidebar a.nav-link {
        padding: 12px 20px;
        text-decoration: none;
        font-size: 14px;
        color: #666;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: all 0.3s ease;
        border-left: 3px solid transparent;
        position: relative;
    }

    .sidebar a.nav-link i {
        font-size: 16px;
        width: 20px;
        text-align: center;
        color: #c471f5;
        transition: all 0.3s ease;
    }

    .sidebar a.nav-link span {
        transition: all 0.3s ease;
    }

    .sidebar a.nav-link:hover {
        background-color: rgba(196, 113, 245, 0.1);
        color: #c471f5;
        border-left-color: #c471f5;
        padding-left: 24px;
    }

    .sidebar a.nav-link:hover i {
        color: #fa71cd;
    }

    /* Logout Link */
    .sidebar a.nav-link.logout {
        color: #dc3545;
        margin-top: auto;
        border-top: 1px solid #e5e5e5;
        padding-top: 16px;
        margin-top: 20px;
    }

    .sidebar a.nav-link.logout i {
        color: #dc3545;
    }

    .sidebar a.nav-link.logout:hover {
        background-color: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border-left-color: #dc3545;
    }

    .sidebar a.nav-link.logout:hover i {
        color: #c82333;
    }

    /* Mobile Responsive */
    @media (max-width: 1200px) {
        .sidebar {
            width: 260px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }
    }

    @media (max-width: 768px) {
        .sidebar {
            width: 240px;
        }

        .user-info .avatar-img {
            width: 60px;
            height: 60px;
        }

        .sidebar a.nav-link {
            padding: 10px 16px;
            font-size: 13px;
        }

        .sidebar a.nav-link i {
            font-size: 14px;
        }

        .user-info .user-name {
            font-size: 13px;
        }
    }

    @media (max-width: 480px) {
        .sidebar {
            width: 220px;
        }

        .user-info {
            padding: 15px;
        }

        .user-info .avatar-img {
            width: 55px;
            height: 55px;
        }

        .sidebar a.nav-link {
            padding: 8px 14px;
            font-size: 12px;
            gap: 10px;
        }

        .sidebar a.nav-link i {
            font-size: 13px;
            width: 16px;
        }

        .user-info .user-name {
            font-size: 12px;
        }
    }
</style>