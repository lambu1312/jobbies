<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bảng Điều Khiển Nhà Tuyển Dụng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body, html {
                height: 100%;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                font-family: 'Inter', system-ui, sans-serif;
                color: #1a1a1a;
                overflow-x: hidden;
                font-size: 16px;
            }

            /* Stars Background */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1 !important;
                display: none;
            }

            .star {
                position: absolute;
                width: 2px;
                height: 2px;
                background: #fff;
                border-radius: 50%;
                animation: twinkle 3s infinite;
            }

            @keyframes twinkle {
                0%, 100% {
                    opacity: 0.3;
                }
                50% {
                    opacity: 1;
                }
            }

            /* Floating Decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 5 !important;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 {
                top: 20%;
                left: 10%;
            }
            
            .deco-2 {
                top: 60%;
                right: 15%;
                animation-delay: 2s;
            }
            
            .deco-3 {
                bottom: 15%;
                left: 20%;
                animation-delay: 1s;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            /* Main content next to the sidebar */
            .main-content {
                margin-left: 260px;
                padding: 20px;
                min-height: 100vh;
                position: relative;
                z-index: 10;
                padding-top: 90px;
            }

            /* Header styling */
            header {
                background: linear-gradient(135deg, #e8eef5 0%, #dfe5f0 100%);
                padding: 15px 30px;
                color: #1a1a1a;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                left: 260px;
                width: calc(100% - 260px);
                height: 70px;
                z-index: 1000;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
                border-bottom: 1px solid rgba(196, 113, 245, 0.15);
            }

            /* Navigation Links */
            .nav-links {
                display: flex;
                justify-content: center;
                flex-grow: 1;
                gap: 0;
            }

            .nav-item {
                margin: 0 25px;
                position: relative;
            }

            .nav-item a {
                color: #666;
                text-decoration: none;
                font-weight: 500;
                font-size: 14px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                height: 40px;
                position: relative;
            }

            .nav-item a:hover {
                color: #c471f5;
            }

            .nav-item a::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 0;
                height: 2px;
                background: linear-gradient(90deg, #c471f5, #fa71cd);
                transition: width 0.3s ease;
            }

            .nav-item a:hover::after {
                width: 100%;
            }

            /* Jobbies Logo/Text */
            .jobpath-logo {
                font-size: 24px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            .jobbies-logo {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 2px;
            }

            .jobbies-text {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-size: 22px;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            /* Page Title */
            .page-title {
                font-size: 2.5rem;
                background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
                margin-bottom: 30px;
                animation: fadeInUp 0.8s ease;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Dashboard styling */
            .top-metrics {
                display: flex;
                justify-content: space-between;
                gap: 20px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            .metric-box {
                flex: 1;
                min-width: 200px;
                background: rgba(255, 255, 255, 0.95);
                padding: 20px;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .metric-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.2);
            }

            .metric-box h5 {
                font-size: 14px;
                font-weight: 600;
                color: #666;
                margin-bottom: 10px;
            }

            .metric-box h3 {
                font-size: 32px;
                font-weight: 700;
                margin: 10px 0;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .metric-box p {
                font-size: 13px;
                color: #999;
                margin: 0;
            }

            /* Chart and Table Containers */
            .recent-postings {
                display: flex;
                justify-content: space-between;
                gap: 20px;
                flex-wrap: wrap;
                margin-top: 30px;
            }

            .table-container, .chart-container {
                flex: 1;
                min-width: 300px;
                background: rgba(255, 255, 255, 0.95);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .table-container h5 {
                font-size: 16px;
                font-weight: 600;
                color: #1a1a1a;
                margin-bottom: 15px;
            }

            .chart-container {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .table-container.full-width {
                width: 100%;
                max-width: 100%;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            table thead th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                padding: 12px;
                text-align: center;
                font-size: 13px;
                font-weight: 600;
                border: none;
            }

            table tbody td {
                text-align: center;
                padding: 12px;
                border-bottom: 1px solid #e5e5e5;
                font-size: 14px;
                color: #333;
            }

            table tbody tr {
                transition: all 0.3s ease;
            }

            table tbody tr:hover {
                background-color: rgba(196, 113, 245, 0.05);
            }

            table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Card styling for Bootstrap cards */
            .card {
                background: rgba(255, 255, 255, 0.95);
                border: 1px solid rgba(0, 0, 0, 0.05);
                border-radius: 12px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.2);
            }

            .card-body {
                padding: 20px;
            }

            .card-title {
                font-size: 14px;
                font-weight: 600;
                color: #666;
                margin-bottom: 10px;
            }

            .card-body h3 {
                font-size: 32px;
                font-weight: 700;
                margin: 10px 0;
            }

            .card-body p {
                font-size: 13px;
                color: #999;
                margin: 0;
            }

            /* Text color utilities */
            .text-primary {
                color: #c471f5 !important;
            }

            .text-info {
                color: #0da5c0 !important;
            }

            .text-success {
                color: #28a745 !important;
            }

            .text-warning {
                color: #fa71cd !important;
            }

            /* Row and Column */
            .row {
                margin-bottom: 20px;
            }

            .col-lg-3, .col-md-6 {
                margin-bottom: 20px;
            }

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .main-content {
                    margin-left: 0;
                    padding-top: 100px;
                }

                header {
                    left: 0;
                    width: 100%;
                }

                .nav-links {
                    justify-content: flex-start;
                    gap: 15px;
                }

                .nav-item {
                    margin: 0 15px;
                }

                .nav-item a {
                    font-size: 13px;
                }
            }

            @media (max-width: 768px) {
                .page-title {
                    font-size: 1.8rem;
                }

                .top-metrics {
                    flex-direction: column;
                }

                .metric-box {
                    margin-bottom: 0;
                }

                .recent-postings {
                    flex-direction: column;
                }

                .table-container, .chart-container {
                    min-width: 100%;
                }

                .pixel-decoration {
                    display: none;
                }

                table {
                    font-size: 12px;
                }

                table thead th,
                table tbody td {
                    padding: 10px 8px;
                }
            }

            @media (max-width: 480px) {
                .main-content {
                    padding: 60px 10px 10px;
                }

                .page-title {
                    font-size: 1.5rem;
                    margin-bottom: 20px;
                }

                table {
                    font-size: 11px;
                }

                table thead th,
                table tbody td {
                    padding: 8px 5px;
                }

                .metric-box {
                    min-width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="stars" id="stars"></div>
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header with Bootstrap Navbar -->
            <%@ include file="../recruiter/header-re.jsp" %>
            
            <h1 class="page-title">Tổng Quan Bảng Điều Khiển</h1>

            <!-- Metrics Cards -->
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Công Việc Đã Đăng</h5>
                            <h3 class="text-primary">${listSize.size()}</h3>
                            <p>Công việc đăng tháng này</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Bài Đăng Vi Phạm</h5>
                            <h3 class="text-danger">${totalViolateJPForRecruiter}</h3>
                            <p>Tổng số bài đăng</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Ứng Viên Chờ Duyệt</h5>
                            <h3 class="text-info">${totalPendingApplications}</h3>
                            <p>Tổng số ứng viên</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Ứng Viên Thành Công</h5>
                            <h3 class="text-warning">${totalAgreeForRecruiter}</h3>
                            <p>Tổng số ứng viên</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top 5 Recent Job Postings section -->
            <div class="table-container full-width">
                <h5>5 Bài Đăng Công Việc Gần Đây</h5>
                <table>
                    <thead>
                        <tr>
                            <th>Tiêu Đề Công Việc</th>
                            <th>Ngày Đăng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="i" items="${listTop5}">
                            <tr>
                                <td>${i.getTitle()}</td>
                                <td><fmt:formatDate value="${i.getPostedDate()}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>                      
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- Chart.js Script to Generate Chart -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Generate stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 150;

                for (let i = 0; i < numberOfStars; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 3 + 's';
                    star.style.width = Math.random() * 2 + 1 + 'px';
                    star.style.height = star.style.width;
                    starsContainer.appendChild(star);
                }
            }

            createStars();

            // Modal trigger script
            document.querySelectorAll('.sidebar a').forEach(link => {
                link.addEventListener('click', function (e) {
                    if (this.getAttribute('href') === '#') {
                        e.preventDefault();
                        var profileModal = new bootstrap.Modal(document.getElementById('profileModal'));
                        profileModal.show();
                    }
                });
            });
        </script>
    </body>
</html>