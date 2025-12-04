<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header>
    <!-- Navigation Links -->
    <div class="nav-links">
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        </div>
        <div class="nav-item">
            <a href="#">Dịch vụ</a>
        </div>
        <div class="nav-item">
            <a href="#">Điều khoản và bảo mật</a>
        </div>
        <div class="nav-item">
            <a href="#">Liên hệ</a>
        </div>
    </div>

    <!-- Jobbies Logo -->
    <div class="jobpath-logo">
        <img class="logo__image"
             src="${pageContext.request.contextPath}/assets/img/logo/logo_jobbies.png"
             width="350"
             height="150"
             style="object-fit: contain;"
             alt="Jobbies Logo">
    </div>
</header>

<style>
    /* Header styling */
    header {
        background-color: #140A20;
        padding: 15px 30px;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 260px;
        width: calc(100% - 260px);
        height: 70px;
        z-index: 1000;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
        border-right: 1px solid #ddd;
    }

    /* Center the Navigation Links */
    .nav-links {
        display: flex;
        justify-content: center;
        flex-grow: 1;
    }

    .nav-item {
        margin: 0 20px;
    }

    .nav-item a {
        color: white;
        text-decoration: none;
    }

    .nav-item a:hover {
        color: #f8f9fa;
    }

    /* Logo */
    .jobpath-logo {
        display: flex;
        align-items: center;
    }

    /* Main content margin */
    .main-content {
        margin-top: 90px;
    }

    body {
        margin: 0;
        padding: 0;
    }
</style>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
