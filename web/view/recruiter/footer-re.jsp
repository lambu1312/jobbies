<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer>
    <div class="footer-content">
        <p>&copy; 2024 Jobbies. Tất cả quyền được bảo lưu.</p>
        <div class="footer-links">
            <a href="#">Chính Sách Bảo Mật</a>
            <span class="divider">•</span>
            <a href="#">Điều Khoản Dịch Vụ</a>
        </div>
    </div>
</footer>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    /* Main container to push the footer down */
    .job-posting-container {
        flex: 1;
        padding: 20px;
        margin-left: 260px;
        background-color: #f5f7fa;
        min-height: calc(100vh - 80px);
    }

    /* Footer styling */
    footer {
        background: linear-gradient(135deg, #e8eef5 0%, #dfe5f0 100%);
        color: #1a1a1a;
        text-align: center;
        padding: 20px 0;
        width: calc(100% - 260px);
        margin-left: 260px;
        flex-shrink: 0;
        border-top: 1px solid rgba(196, 113, 245, 0.2);
        box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    footer p {
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 10px;
        color: #666;
    }

    .footer-links {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
    }

    footer a {
        color: #c471f5;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    footer a:hover {
        color: #fa71cd;
        text-decoration: underline;
    }

    .divider {
        color: #ddd;
        font-size: 12px;
    }

    /* Mobile Responsive */
    @media (max-width: 1200px) {
        footer {
            width: 100%;
            margin-left: 0;
        }

        .job-posting-container {
            margin-left: 0;
        }
    }

    @media (max-width: 768px) {
        footer {
            padding: 15px 0;
        }

        footer p {
            font-size: 12px;
            margin-bottom: 8px;
        }

        .footer-links {
            gap: 10px;
            flex-wrap: wrap;
        }

        footer a {
            font-size: 12px;
        }

        .divider {
            font-size: 10px;
        }
    }

    @media (max-width: 480px) {
        footer {
            padding: 12px 0;
        }

        footer p {
            font-size: 11px;
            margin-bottom: 6px;
        }

        .footer-links {
            gap: 8px;
            flex-wrap: wrap;
        }

        footer a {
            font-size: 10px;
        }

        .divider {
            font-size: 8px;
        }
    }
</style>