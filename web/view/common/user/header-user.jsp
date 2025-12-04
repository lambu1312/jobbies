<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<meta charset="UTF-8">

<style>
    /* Header Styles - Transparent with Glassmorphism */
    header {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        background: rgba(10, 0, 21, 0.7) !important;
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(196, 113, 245, 0.1);
        transition: all 0.3s ease;
    }

    header.scrolled {
        background: rgba(10, 0, 21, 0.95) !important;
        box-shadow: 0 8px 32px rgba(196, 113, 245, 0.2);
        border-bottom: 1px solid rgba(196, 113, 245, 0.3);
    }

    /* Container adjustments */
    header .container {
        position: relative;
        z-index: 1001;
    }

    /* Logo Styles with Icon */
    .rts__logo .logo-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        transition: all .3s ease-in-out;
        padding: 8px 16px;
        border-radius: 50px;
        position: relative;
    }

    .rts__logo .logo-brand::before {
        content: '';
        position: absolute;
        inset: 0;
        border-radius: 50px;
        padding: 2px;
        background: linear-gradient(135deg, #c471f5, #fa71cd, #7ee8fa);
        -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .rts__logo .logo-brand:hover::before {
        opacity: 1;
    }

    .logo-icon {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        color: #fff;
        box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .logo-icon::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transform: rotate(45deg);
        transition: all 0.6s ease;
    }

    .rts__logo .logo-brand:hover .logo-icon::before {
        left: 100%;
    }

    .rts__logo .logo-brand:hover .logo-icon {
        transform: scale(1.1) rotate(5deg);
        box-shadow: 0 6px 20px rgba(196, 113, 245, 0.6);
    }

    .logo-title {
        font-size: 28px;
        font-weight: 900;
        font-family: 'Poppins', -apple-system, sans-serif;
        background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        letter-spacing: 1.5px;
        position: relative;
        transition: all .3s;
    }

    .logo-title::after {
        content: '';
        position: absolute;
        bottom: -4px;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(90deg, #c471f5, #fa71cd, #7ee8fa);
        transition: width 0.3s ease;
    }

    .rts__logo .logo-brand:hover .logo-title::after {
        width: 100%;
    }

    .rts__logo .logo-brand:hover .logo-title {
        letter-spacing: 2px;
    }

    /* Navigation Menu Styles */
    .navigation__menu .nav {
        display: flex;
        gap: 2rem;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .navigation__menu .nav-item {
        position: relative;
    }

    .navigation__menu .nav-link {
        color: rgba(255, 255, 255, 0.9) !important;
        font-weight: 600;
        font-size: 15px;
        padding: 0.5rem 0;
        text-decoration: none;
        position: relative;
        transition: all 0.3s ease;
    }

    .navigation__menu .nav-link::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        transition: width 0.3s ease;
    }

    .navigation__menu .nav-link:hover {
        color: #c471f5 !important;
    }

    .navigation__menu .nav-link:hover::after {
        width: 100%;
    }

    /* User Dropdown Styles */
    .dropdown-toggle {
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 50px;
        padding: 0.5rem 1rem;
        transition: all 0.3s ease;
    }

    .dropdown-toggle:hover {
        background: rgba(196, 113, 245, 0.2);
        border-color: rgba(196, 113, 245, 0.5);
        transform: translateY(-2px);
    }

    .dropdown-toggle .author__image img {
        border: 2px solid rgba(196, 113, 245, 0.5);
        transition: all 0.3s ease;
    }

    .dropdown-toggle:hover .author__image img {
        border-color: #c471f5;
        box-shadow: 0 0 20px rgba(196, 113, 245, 0.5);
    }

    .dropdown-toggle .user-name {
        color: #fff;
        font-weight: 600;
    }

    .dropdown-toggle .text-muted {
        color: rgba(255, 255, 255, 0.6) !important;
        font-size: 12px;
    }

    /* Dropdown Menu Styles */
    .dropdown-menu {
        background: rgba(26, 11, 46, 0.95);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 16px;
        padding: 0.5rem;
        min-width: 250px;
        margin-top: 0.5rem;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
    }

    .dropdown-item {
        color: rgba(255, 255, 255, 0.9) !important;
        padding: 0.75rem 1rem;
        border-radius: 10px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .dropdown-item:hover {
        background: rgba(196, 113, 245, 0.2);
        color: #fff !important;
        transform: translateX(5px);
    }

    .dropdown-item i {
        width: 20px;
        color: #c471f5;
    }

    .dropdown-divider {
        border-color: rgba(255, 255, 255, 0.1);
        margin: 0.5rem 0;
    }

    .dropdown-item.text-danger:hover {
        background: rgba(239, 68, 68, 0.2);
        color: #ef4444 !important;
    }

    .dropdown-item.text-danger i {
        color: #ef4444;
    }

    /* Mobile Responsive */
    @media (max-width: 991px) {
        .navigation {
            display: none;
        }
        
        .logo-title {
            font-size: 24px;
        }
    }

    /* Ensure content doesn't hide under fixed header */
    body {
        padding-top: 80px;
    }

    /* Smooth scroll behavior */
    html {
        scroll-behavior: smooth;
    }
</style>

<header>
    <div class="container">
        <div class="d-flex align-items-center justify-content-between py-3">
            <!-- Logo -->
            <div class="rts__logo">
                <a href="${pageContext.request.contextPath}/HomeSeeker" 
                   class="d-flex align-items-center text-decoration-none logo-brand">
                    <span class="logo-title">JOBBIES</span>
                </a>
            </div>

            <!-- Navigation Menu -->
            <div class="rts__menu d-flex gap-4 align-items-center">
                <div class="navigation d-none d-lg-block">
                    <nav class="navigation__menu" id="offcanvas__menu">
                        <ul class="nav">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/HomeSeeker">Công Việc</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cv">Tạo CV</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/application">Trạng Thái Ứng Tuyển</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/FavourJobPosting">Việc Làm Yêu Thích</a>
                            </li>
                        </ul>
                    </nav>
                </div>

                <!-- User Dropdown -->
                <div class="header__right__btn d-flex gap-3">
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" 
                           id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="author__image me-2">
                                <c:choose>
                                    <c:when test="${empty sessionScope.account.avatar}">
                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" 
                                             alt="Avatar" class="rounded-circle" width="40" height="40">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${sessionScope.account.avatar}" 
                                             alt="Avatar" class="rounded-circle" width="40" height="40">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="d-flex flex-column align-items-start">
                                <strong class="user-name">${sessionScope.account.fullName}</strong>
                                <span class="text-muted">Seeker Page</span>
                            </div>
                        </a>

                        <!-- Dropdown Menu -->
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/JobSeekerCheck">
                                    <i class="fa-solid fa-user"></i> Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cv">
                                    <i class="fa-solid fa-file"></i> Manage your CV</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/education">
                                    <i class="fa-solid fa-school"></i> Manage your Education</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/experience">
                                    <i class="fa-solid fa-briefcase"></i> Manage your Experience</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/application">
                                    <i class="fa-solid fa-bell"></i> My Applications</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/FavourJobPosting">
                                    <i class="fa-solid fa-heart"></i> Favourite Jobs</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/feedbackSeeker">
                                    <i class="fa-solid fa-comment"></i> Your Feedback</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/authen?action=change-password">
                                    <i class="fa-solid fa-lock"></i> Change Password</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/view/authen/logout.jsp">
                                    <i class="fa-solid fa-right-from-bracket"></i> Log Out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    // Add scroll effect to header
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
</script>