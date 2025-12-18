<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/HomeSeeker" class="logo">JOBBIES</a>

        <div class="nav-links" id="navLinks">
            <a href="${pageContext.request.contextPath}/HomeSeeker">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/handbook">Cẩm nang</a>
            <a href="${pageContext.request.contextPath}/cv">Tạo CV</a>
            <a href="${pageContext.request.contextPath}/FavourJobPosting">Yêu thích</a>
            <a href="${pageContext.request.contextPath}/application">Trạng Thái Xin Việc</a>

                    <div class="user-dropdown">
                        <button class="user-dropdown-toggle" id="userDropdownBtn">
                            <div class="user-avatar">
                                <c:choose>
                                    <c:when test="${empty sessionScope.account.avatar}">
                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png"
                                            alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${sessionScope.account.avatar}" alt="Avatar">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="user-info">
                                <span class="user-name">${sessionScope.account.fullName}</span>
                                <span class="user-role">Người tìm việc</span>
                            </div>
                            <i class="fas fa-chevron-down"></i>
                        </button>

                        <div class="dropdown-menu" id="userDropdownMenu">
                            <a href="${pageContext.request.contextPath}/JobSeekerCheck" class="dropdown-item">
                                <i class="fas fa-user"></i>
                                <span>Hồ sơ</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/cv" class="dropdown-item">
                                <i class="fas fa-file-alt"></i>
                                <span>Quản lý CV</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/education" class="dropdown-item">
                                <i class="fas fa-graduation-cap"></i>
                                <span>Học nghiệp</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/experience" class="dropdown-item">
                                <i class="fas fa-briefcase"></i>
                                <span>Kinh nghiệm</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/application" class="dropdown-item">
                                <i class="fas fa-paper-plane"></i>
                                <span>Đơn đăng ký của tôi</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/feedbackSeeker" class="dropdown-item">
                                <i class="fas fa-comment"></i>
                                <span>Góp ý/Nhận xét</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/authen?action=change-password"
                                class="dropdown-item">
                                <i class="fas fa-lock"></i>
                                <span>Đổi mật khẩu</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/view/authen/logout.jsp"
                                class="dropdown-item logout">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Đăng xuất</span>
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
        position: relative;
        z-index: 100;
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .navbar-container {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.5rem 3rem;
        gap: 2rem;
    }

    .logo {
        font-size: 2rem;
        font-weight: 900;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 0 30px rgba(196, 113, 245, 0.5);
        letter-spacing: 2px;
        text-decoration: none;
        transition: all 0.3s;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .logo:hover {
        transform: scale(1.05);
    }

    .nav-links {
        display: flex;
        gap: 2rem;
        align-items: center;
        flex-wrap: nowrap;
    }

    .nav-links>a {
        color: #fff;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s;
        position: relative;
        white-space: nowrap;
    }

    .nav-links>a::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        transition: width 0.3s;
    }

    .nav-links>a:hover {
        color: #c471f5;
        text-shadow: 0 0 20px rgba(196, 113, 245, 0.8);
    }

    .nav-links>a:hover::after {
        width: 100%;
    }

    .user-dropdown {
        position: relative;
    }

    .user-dropdown-toggle {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding: 0.6rem 1.2rem;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .user-dropdown-toggle:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: #c471f5;
        box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        overflow: hidden;
        border: 2px solid rgba(196, 113, 245, 0.5);
        flex-shrink: 0;
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
        white-space: nowrap;
    }

    .user-role {
        color: #b8b8d1;
        font-size: 0.8rem;
    }

    .user-dropdown-toggle i {
        color: #b8b8d1;
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
        background: rgba(26, 11, 46, 0.95);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        padding: 0.5rem;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
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
        color: #fff;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s;
    }

    .dropdown-item:hover {
        background: rgba(196, 113, 245, 0.2);
        color: #c471f5;
        transform: translateX(5px);
    }

    .dropdown-item i {
        width: 20px;
        text-align: center;
    }

    .dropdown-item.logout {
        color: #ff6b6b;
    }

    .dropdown-item.logout:hover {
        background: rgba(255, 107, 107, 0.2);
        color: #ff6b6b;
    }

    .dropdown-divider {
        height: 1px;
        background: rgba(255, 255, 255, 0.1);
        margin: 0.5rem 0;
    }

    .mobile-menu-toggle {
        display: none;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: #fff;
        padding: 0.8rem;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .mobile-menu-toggle:hover {
        background: rgba(196, 113, 245, 0.2);
        border-color: #c471f5;
    }

    @media (max-width: 1200px) and (min-width: 769px) {
        .nav-links {
            gap: 1.5rem;
        }

        .nav-links>a {
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
            top: 80px;
            right: -100%;
            width: 80%;
            max-width: 300px;
            height: calc(100vh - 80px);
            background: rgba(26, 11, 46, 0.98);
            backdrop-filter: blur(30px);
            border-left: 1px solid rgba(255, 255, 255, 0.1);
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

        .nav-links>a {
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
        }

        .nav-links>a::after {
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
