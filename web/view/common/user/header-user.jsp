<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .modern-header {
        position: relative;
        z-index: 100;
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding: 1.5rem 3rem;
    }

    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1400px;
        margin: 0 auto;
    }

    .modern-logo {
        font-size: 2rem;
        font-weight: 900;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 0 30px rgba(196, 113, 245, 0.5);
        letter-spacing: 2px;
        text-decoration: none;
    }

    .modern-nav {
        display: flex;
        gap: 2rem;
        align-items: center;
    }

    .modern-nav-links {
        display: flex;
        gap: 2rem;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .modern-nav-links a {
        color: #fff;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s;
        position: relative;
        font-size: 1rem;
    }

    .modern-nav-links a:hover {
        color: #c471f5;
        text-shadow: 0 0 20px rgba(196, 113, 245, 0.8);
    }

    .user-dropdown {
        position: relative;
    }

    .user-trigger {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        text-decoration: none;
        color: #fff;
        cursor: pointer;
        padding: 0.6rem 1.2rem;
        border-radius: 50px;
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        transition: all 0.3s;
    }

    .user-trigger:hover {
        background: rgba(196, 113, 245, 0.2);
        border-color: #c471f5;
        box-shadow: 0 5px 20px rgba(196, 113, 245, 0.3);
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        border: 2px solid rgba(196, 113, 245, 0.5);
        object-fit: cover;
    }

    .user-info {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    .user-name {
        font-weight: 700;
        font-size: 0.95rem;
        color: #fff;
    }

    .user-role {
        font-size: 0.75rem;
        color: #b8b8d1;
    }

    .dropdown-menu-modern {
        position: absolute;
        top: calc(100% + 1rem);
        right: 0;
        background: rgba(26, 11, 46, 0.95);
        backdrop-filter: blur(30px);
        border: 1px solid rgba(196, 113, 245, 0.3);
        border-radius: 20px;
        padding: 1rem;
        min-width: 280px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        display: none;
        animation: fadeInDown 0.3s ease;
    }

    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .user-dropdown:hover .dropdown-menu-modern {
        display: block;
    }

    .dropdown-menu-modern a {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding: 0.8rem 1rem;
        color: #fff;
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s;
        font-weight: 500;
        font-size: 0.95rem;
    }

    .dropdown-menu-modern a:hover {
        background: rgba(196, 113, 245, 0.2);
        transform: translateX(5px);
    }

    .dropdown-menu-modern a i {
        width: 20px;
        text-align: center;
        color: #c471f5;
    }

    .dropdown-divider-modern {
        height: 1px;
        background: rgba(255, 255, 255, 0.1);
        margin: 0.5rem 0;
        border: none;
    }

    .dropdown-logout {
        color: #ff6b9d !important;
    }

    .dropdown-logout:hover {
        background: rgba(255, 107, 157, 0.1) !important;
    }

    @media (max-width: 768px) {
        .modern-header {
            padding: 1rem 1.5rem;
        }

        .modern-nav-links {
            display: none;
        }

        .user-info {
            display: none;
        }
    }
</style>

<header class="modern-header">
    <div class="header-container">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/HomeSeeker" class="modern-logo">
            JOBBIES
        </a>

        <!-- Navigation -->
        <div class="modern-nav">
            <ul class="modern-nav-links">
                <li><a href="${pageContext.request.contextPath}/HomeSeeker">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/cv">Tạo CV</a></li>
                <li><a href="#">Cẩm Nang</a></li>
                <li><a href="${pageContext.request.contextPath}/FavourJobPosting">Yêu Thích</a></li>
                <li><a href="${pageContext.request.contextPath}/application">Trạng thái</a></li>
            </ul>
            <!-- Mobile Menu Button -->
            <button class="mobile-menu-btn">
                <i class="fas fa-bars"></i>
            </button>
            <!-- User Dropdown -->
            <div class="user-dropdown">
                <div class="user-trigger">
                    <c:choose>
                        <c:when test="${empty sessionScope.account.avatar}">
                            <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" 
                                 alt="Avatar" class="user-avatar">
                        </c:when>
                        <c:otherwise>
                            <img src="${sessionScope.account.avatar}" 
                                 alt="Avatar" class="user-avatar">
                        </c:otherwise>
                    </c:choose>
                    <div class="user-info">
                        <span class="user-name">${sessionScope.account.fullName}</span>
                        <span class="user-role">Seeker Page</span>
                    </div>
                </div>

                <!-- Dropdown Menu -->
                <div class="dropdown-menu-modern">
                    <a href="${pageContext.request.contextPath}/JobSeekerCheck">
                        <i class="fa-solid fa-user"></i> Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/cv">
                        <i class="fa-solid fa-file"></i> Manage your CV
                    </a>
                    <a href="${pageContext.request.contextPath}/education">
                        <i class="fa-solid fa-school"></i> Manage your Education
                    </a>
                    <a href="${pageContext.request.contextPath}/experience">
                        <i class="fa-solid fa-briefcase"></i> Manage your Experience
                    </a>
                    <a href="${pageContext.request.contextPath}/application">
                        <i class="fa-solid fa-bell"></i> My Applications
                    </a>
                    <a href="${pageContext.request.contextPath}/feedbackSeeker">
                        <i class="fa-solid fa-comment"></i> Your Feedback
                    </a>
                    <a href="${pageContext.request.contextPath}/authen?action=change-password">
                        <i class="fa-solid fa-lock"></i> Change Password
                    </a>
                    <hr class="dropdown-divider-modern">
                    <a href="${pageContext.request.contextPath}/view/authen/logout.jsp" class="dropdown-logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Log Out
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>