<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/HomeSeeker" class="logo">JOBBIES</a>

        <div class="nav-links" id="navLinks">
            <a href="${pageContext.request.contextPath}/HomeSeeker">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/cv/list">Tạo CV</a>
            <a href="${pageContext.request.contextPath}/FavourJobPosting">Yêu thích</a>
            <a href="${pageContext.request.contextPath}/application">Trạng Thái Xin Việc</a>

            <div class="user-dropdown">
                <button class="user-dropdown-toggle" id="userDropdownBtn">
                    <div class="user-avatar">
                        <c:choose>
                            <c:when test="${empty sessionScope.account.avatar}">
                                <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <img src="${sessionScope.account.avatar}" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user-info">
                        <span class="user-name">${sessionScope.account.fullName}</span>
                        <span class="user-role">Candidate</span>
                    </div>
                    <i class="fas fa-chevron-down"></i>
                </button>

                <div class="dropdown-menu" id="userDropdownMenu">
                    <a href="${pageContext.request.contextPath}/JobSeekerCheck" class="dropdown-item">
                        <i class="fas fa-user"></i>
                        <span>Profile</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/cv" class="dropdown-item">
                        <i class="fas fa-file-alt"></i>
                        <span>Manage CV</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/education" class="dropdown-item">
                        <i class="fas fa-graduation-cap"></i>
                        <span>Education</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/experience" class="dropdown-item">
                        <i class="fas fa-briefcase"></i>
                        <span>Experience</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/feedbackSeeker" class="dropdown-item">
                        <i class="fas fa-comment"></i>
                        <span>Feedback</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/authen?action=change-password" class="dropdown-item">
                        <i class="fas fa-lock"></i>
                        <span>Change Password</span>
                    </a>
                        
                        <a href="${pageContext.request.contextPath}/authen?action=deactivate-user"
                       class="btn btn-warning">Deactivate account</a>
                    <div class="dropdown-divider"></div>
                    <a href="${pageContext.request.contextPath}/view/authen/logout.jsp" class="dropdown-item logout">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Log Out</span>
                    </a>
                </div>
            </div>
        </div>

        <button class="mobile-menu-toggle" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>
    </div>
</nav>

<style>
    .navbar {
        background: linear-gradient(135deg, #2c0253 0%, #571457 100%);
        box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .navbar-container {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.2rem 3rem;
        gap: 2rem;
    }

    .logo {
        font-size: 2rem;
        font-weight: 900;
        color: #fff;
        letter-spacing: 2px;
        text-decoration: none;
        transition: all 0.3s;
        white-space: nowrap;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }

    .logo:hover {
        transform: scale(1.05);
        color: #fff;
    }

    .nav-links {
        display: flex;
        gap: 2rem;
        align-items: center;
        flex-wrap: nowrap;
    }

    .nav-links > a {
        color: #fff;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s;
        position: relative;
        white-space: nowrap;
    }

    .nav-links > a::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 0;
        height: 2px;
        background: #fff;
        transition: width 0.3s;
    }

    .nav-links > a:hover {
        color: #fff;
        opacity: 0.9;
    }

    .nav-links > a:hover::after {
        width: 100%;
    }

    .user-dropdown {
        position: relative;
    }

    .user-dropdown-toggle {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding: 0.5rem 1rem;
        background: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .user-dropdown-toggle:hover {
        background: rgba(255, 255, 255, 0.3);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        overflow: hidden;
        border: 2px solid #fff;
    }

    .user-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .user-info {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    .user-name {
        color: #fff;
        font-weight: 700;
        font-size: 0.95rem;
    }

    .user-role {
        color: rgba(255, 255, 255, 0.8);
        font-size: 0.8rem;
    }

    .user-dropdown-toggle i {
        color: #fff;
        transition: transform 0.3s;
    }

    .user-dropdown.active .user-dropdown-toggle i {
        transform: rotate(180deg);
    }

    .dropdown-menu {
        position: absolute;
        top: calc(100% + 0.5rem);
        right: 0;
        min-width: 250px;
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 15px;
        padding: 0.5rem;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
    }

    .user-dropdown.active .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-item {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding: 0.8rem 1rem;
        color: #2d3748;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s;
    }

    .dropdown-item:hover {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
        transform: translateX(5px);
    }

    .dropdown-item i {
        width: 20px;
        text-align: center;
    }

    .dropdown-item.logout {
        color: #dc3545;
    }

    .dropdown-item.logout:hover {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
    }

    .dropdown-divider {
        height: 1px;
        background: #e2e8f0;
        margin: 0.5rem 0;
    }

    .mobile-menu-toggle {
        display: none;
        background: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        color: #fff;
        padding: 0.8rem;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .mobile-menu-toggle:hover {
        background: rgba(255, 255, 255, 0.3);
    }

    @media (max-width: 1200px) and (min-width: 769px) {
        .nav-links {
            gap: 1.5rem;
        }

        .nav-links > a {
            font-size: 0.9rem;
        }

        .logo {
            font-size: 1.8rem;
        }
    }

    @media (max-width: 768px) {
        .navbar-container {
            padding: 1rem 1.5rem;
        }

        .logo {
            font-size: 1.5rem;
        }

        .nav-links {
            position: fixed;
            top: 70px;
            right: -100%;
            width: 80%;
            max-width: 300px;
            height: calc(100vh - 70px);
            background: linear-gradient(135deg, #667eea, #764ba2);
            flex-direction: column;
            align-items: stretch;
            padding: 2rem;
            gap: 1rem;
            transition: right 0.3s;
            overflow-y: auto;
        }

        .nav-links.active {
            right: 0;
        }

        .nav-links > a {
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-links > a::after {
            display: none;
        }

        .mobile-menu-toggle {
            display: block;
        }

        .user-dropdown-toggle {
            width: 100%;
            justify-content: center;
        }

        .dropdown-menu {
            position: static;
            opacity: 1;
            visibility: visible;
            transform: none;
            margin-top: 1rem;
        }
    }
</style>

<script>
    // User dropdown toggle
    const userDropdownBtn = document.getElementById('userDropdownBtn');
    const userDropdown = userDropdownBtn?.closest('.user-dropdown');

    if (userDropdownBtn) {
        userDropdownBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            userDropdown.classList.toggle('active');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function (e) {
            if (!userDropdown.contains(e.target)) {
                userDropdown.classList.remove('active');
            }
        });
    }

    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navLinks = document.getElementById('navLinks');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function () {
            navLinks.classList.toggle('active');
            this.innerHTML = navLinks.classList.contains('active')
                ? '<i class="fas fa-times"></i>'
                : '<i class="fas fa-bars"></i>';
        });

        // Close mobile menu when clicking on a link
        const navLinksItems = navLinks.querySelectorAll('a');
        navLinksItems.forEach(link => {
            link.addEventListener('click', () => {
                navLinks.classList.remove('active');
                mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
            });
        });
    }
</script>