<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modern-sidebar" style="width: 280px; position: fixed; top: 0; left: 0; height: 100vh; z-index: 1000;">
    <div class="sidebar-content">
        <div class="rts__logo text-center mb-4">
            <a href="${pageContext.request.contextPath}/home">
                <div class="logo-text">JOBBIES</div>
            </a>
        </div>
        
        <hr class="divider">
        
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link" aria-current="page">
                    <span class="nav-icon"><i class="fa-solid fa-house"></i></span>
                    <span class="nav-text">Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/candidates" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-users"></i></span>
                    <span class="nav-text">Candidate Management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/recruiters" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-user-tie"></i></span>
                    <span class="nav-text">Recruiter Management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/companies" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-building"></i></span>
                    <span class="nav-text">Company Management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/job_posting" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-briefcase"></i></span>
                    <span class="nav-text">Job Postings</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/feedback" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-comment-dots"></i></span>
                    <span class="nav-text">Feedback</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/handbook_admin" class="nav-link">
                    <span class="nav-icon"><i class="fa-solid fa-book"></i></span>
                    <span class="nav-text">Handbook</span>
                </a>
            </li>
        </ul>
        
        <hr class="divider">
        
        <div class="dropdown user-dropdown">
            <a href="#" class="user-profile dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="avatar-wrapper">
                    <c:if test="${empty sessionScope.account.avatar}">
                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="avatar-img">
                    </c:if>
                    <c:if test="${!empty sessionScope.account.avatar}">
                        <img src="${sessionScope.account.avatar}" alt="Avatar" class="avatar-img">
                    </c:if>
                </div>
                <div class="user-info">
                    <strong class="user-name">${sessionScope.account.getFullName()}</strong>
                    <span class="user-role">Admin Page</span>
                </div>
            </a>

            <ul class="dropdown-menu shadow" aria-labelledby="dropdownUser1">
                <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fa-solid fa-house me-2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/authen?action=change-password">
                        <i class="fa-solid fa-lock me-2"></i> Change Password
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item logout-item" href="${pageContext.request.contextPath}/view/authen/logout.jsp">
                        <i class="fa-solid fa-right-from-bracket me-2"></i> Log Out
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<style>
    /* ONLY apply dark background to sidebar, NOT the whole page */
    .modern-sidebar {
        background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
        backdrop-filter: blur(20px);
        border-right: 1px solid rgba(255, 255, 255, 0.1);
        padding: 2rem 1.5rem;
        overflow-y: auto;
        box-shadow: 2px 0 20px rgba(0, 0, 0, 0.3);
    }

    .sidebar-content {
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .logo-text {
        font-size: 2rem;
        font-weight: 900;
        background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 0 30px rgba(196, 113, 245, 0.5);
        letter-spacing: 2px;
        text-decoration: none;
        display: inline-block;
    }

    .logo-text:hover {
        transform: scale(1.05);
        transition: transform 0.3s ease;
    }

    .divider {
        border: none;
        height: 1px;
        background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.5), transparent);
        margin: 1.5rem 0;
    }

    .nav {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .nav-link {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 0.9rem 1.2rem;
        margin-bottom: 0.5rem;
        border-radius: 15px;
        color: #b8b8d1;
        text-decoration: none;
        transition: all 0.3s ease;
        background: transparent;
        border: 1px solid transparent;
        position: relative;
        overflow: hidden;
    }

    .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
        transition: left 0.5s;
    }

    .nav-link:hover::before {
        left: 100%;
    }

    .nav-link:hover {
        background: rgba(196, 113, 245, 0.1);
        border-color: rgba(196, 113, 245, 0.3);
        color: #fff;
        transform: translateX(5px);
    }

    .nav-link.active {
        background: linear-gradient(135deg, rgba(196, 113, 245, 0.2) 0%, rgba(250, 113, 205, 0.2) 100%);
        border-color: #c471f5;
        color: #fff;
        box-shadow: 0 5px 15px rgba(196, 113, 245, 0.3);
    }

    .nav-icon {
        font-size: 1.1rem;
        width: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .nav-text {
        font-weight: 600;
        font-size: 0.95rem;
    }

    .user-dropdown {
        margin-top: auto;
    }

    .user-profile {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        text-decoration: none;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .user-profile:hover {
        background: rgba(196, 113, 245, 0.1);
        border-color: rgba(196, 113, 245, 0.3);
        transform: translateY(-2px);
    }

    .avatar-wrapper {
        position: relative;
    }

    .avatar-img {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        border: 2px solid #c471f5;
        object-fit: cover;
        box-shadow: 0 0 15px rgba(196, 113, 245, 0.4);
    }

    .user-info {
        display: flex;
        flex-direction: column;
        flex: 1;
    }

    .user-name {
        color: #fff;
        font-size: 0.95rem;
        font-weight: 700;
    }

    .user-role {
        color: #b8b8d1;
        font-size: 0.8rem;
    }

    .dropdown-menu {
        background: rgba(26, 11, 46, 0.98) !important;
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        border-radius: 15px !important;
        padding: 0.5rem;
        margin-top: 0.5rem;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5) !important;
    }

    .dropdown-item {
        color: #b8b8d1 !important;
        padding: 0.8rem 1rem;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-weight: 600;
    }

    .dropdown-item:hover {
        background: rgba(196, 113, 245, 0.2) !important;
        color: #fff !important;
    }

    .dropdown-divider {
        border-color: rgba(255, 255, 255, 0.1) !important;
        margin: 0.5rem 0;
    }

    .logout-item {
        background: linear-gradient(135deg, rgba(255, 68, 68, 0.2) 0%, rgba(255, 107, 107, 0.2) 100%) !important;
        color: #ff6b6b !important;
        border: 1px solid rgba(255, 107, 107, 0.3);
    }

    .logout-item:hover {
        background: linear-gradient(135deg, rgba(255, 68, 68, 0.4) 0%, rgba(255, 107, 107, 0.4) 100%) !important;
        color: #fff !important;
        border-color: #ff6b6b;
    }

    /* Scrollbar styling */
    .modern-sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .modern-sidebar::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
    }

    .modern-sidebar::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #c471f5, #fa71cd);
        border-radius: 10px;
    }

    .modern-sidebar::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(135deg, #fa71cd, #c471f5);
    }

    @media (max-width: 768px) {
        .modern-sidebar {
            width: 100%;
            height: auto;
            position: relative;
        }
    }
</style>