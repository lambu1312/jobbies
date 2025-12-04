<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobbies - Tìm Việc Làm Mơ Ước</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Poppins:wght@400;600;700;900&display=swap" rel="stylesheet">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
                overflow-x: hidden;
                min-height: 100vh;
                padding-top: 80px; /* Space for fixed header */
            }

            /* Stars Background */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
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
                opacity: 0.3;
                z-index: 5;
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

            /* Hero Section */
            .hero-section {
                position: relative;
                z-index: 10;
                text-align: center;
                padding: 4rem 2rem 2rem;
            }

            .hero-section h1 {
                font-size: 3.5rem;
                font-weight: 900;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 1rem;
                line-height: 1.2;
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

            .hero-section p {
                font-size: 1.2rem;
                color: #b8b8d1;
                margin-bottom: 2rem;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
                animation: fadeInUp 0.8s ease 0.2s backwards;
            }

            /* Filter and Content Section */
            .content-section {
                position: relative;
                z-index: 10;
                padding: 2rem 0;
            }

            /* Filter Sidebar */
            .filter-form {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                position: sticky;
                top: 100px;
            }

            .filter-form h4 {
                font-weight: 700;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 1.5rem;
                font-size: 1.3rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .filter-form h4 i {
                color: #c471f5;
                -webkit-text-fill-color: #c471f5;
            }

            .form-label {
                color: #e2e8f0;
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 8px;
            }

            .form-control,
            .form-select {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                color: #fff;
                padding: 12px 16px;
                transition: all 0.3s ease;
            }

            .form-control:focus,
            .form-select:focus {
                background-color: rgba(255, 255, 255, 0.15);
                border-color: #c471f5;
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                color: #fff;
                outline: none;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-select option {
                background-color: #1a0b2e;
                color: #fff;
            }

            .input-group-text {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                color: rgba(255, 255, 255, 0.7);
            }

            .search-button {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                border-radius: 12px;
                color: #fff;
                padding: 12px 20px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
                width: 100%;
            }

            .search-button:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
            }

            .btn-success {
                background: linear-gradient(135deg, #fa71cd 0%, #c471f5 100%);
                border: none;
                font-weight: 700;
                margin-top: 1rem;
                padding: 12px;
                border-radius: 12px;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
            }

            /* Job Cards */
            .job-card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                transition: all 0.3s ease;
                overflow: hidden;
                position: relative;
                height: 100%;
            }

            .job-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
                transition: left 0.5s;
            }

            .job-card:hover::before {
                left: 100%;
            }

            .job-card:hover {
                transform: translateY(-10px);
                border-color: #c471f5;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
            }

            .job-card-link {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .job-card-link:hover {
                color: inherit;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 1rem;
                line-height: 1.4;
                transition: color 0.3s ease;
            }

            .job-card:hover .card-title {
                color: #c471f5;
            }

            .badge {
                padding: 6px 12px;
                border-radius: 100px;
                font-size: 12px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }

            .bg-primary {
                background: linear-gradient(135deg, #7ee8fa, #80d0c7) !important;
                color: #000 !important;
            }

            .bg-success {
                background: linear-gradient(135deg, #39ff14, #7ee8fa) !important;
                color: #000 !important;
            }

            .text-muted {
                color: #b8b8d1 !important;
                font-size: 13px;
            }

            /* Pagination */
            .pagination {
                display: flex;
                gap: 8px;
                justify-content: center;
                margin-top: 3rem;
            }

            .page-item .page-link {
                background-color: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                color: #fff;
                padding: 10px 16px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .page-item .page-link:hover {
                background-color: rgba(196, 113, 245, 0.2);
                border-color: #c471f5;
                color: #c471f5;
                transform: translateY(-2px);
            }

            .page-item.active .page-link {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border-color: #c471f5;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                border: 1px solid rgba(250, 113, 205, 0.3);
            }

            .empty-state-icon {
                width: 100px;
                height: 100px;
                background: rgba(196, 113, 245, 0.2);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 2rem;
            }

            .empty-state-icon i {
                font-size: 40px;
                color: #c471f5;
            }

            .empty-state h4 {
                color: #fff;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #b8b8d1;
                font-size: 15px;
            }

            /* Footer */
            .footer {
                position: relative;
                z-index: 10;
                background: rgba(0, 0, 0, 0.3);
                backdrop-filter: blur(20px);
                color: #e2e8f0;
                padding: 60px 24px 24px;
                margin-top: 60px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 48px;
            }

            .footer-brand h3 {
                font-size: 24px;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .footer-brand h3 i {
                color: #c471f5;
                -webkit-text-fill-color: #c471f5;
            }

            .footer-brand p {
                color: #b8b8d1;
                font-size: 15px;
                line-height: 1.7;
            }

            .footer-column h4 {
                font-size: 16px;
                font-weight: 700;
                color: white;
                margin-bottom: 20px;
            }

            .footer-column a {
                display: block;
                color: #b8b8d1;
                text-decoration: none;
                font-size: 15px;
                margin-bottom: 12px;
                transition: all 0.3s;
            }

            .footer-column a:hover {
                color: #c471f5;
                transform: translateX(5px);
            }

            .social-links {
                display: flex;
                gap: 12px;
            }

            .social-links a {
                width: 40px;
                height: 40px;
                border-radius: 12px;
                background: rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #e2e8f0;
                transition: all 0.3s;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .social-links a:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                transform: translateY(-3px);
                border-color: transparent;
            }

            .footer-bottom {
                max-width: 1200px;
                margin: 48px auto 0;
                padding-top: 24px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                text-align: center;
                color: #b8b8d1;
                font-size: 14px;
            }

            .footer-bottom a {
                color: #c471f5;
                text-decoration: none;
            }

            .footer-bottom a:hover {
                color: #fa71cd;
            }

            /* Back to Top */
            .back-to-top {
                position: fixed;
                bottom: 24px;
                right: 24px;
                width: 48px;
                height: 48px;
                border-radius: 50%;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border: none;
                cursor: pointer;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
                display: none;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
                z-index: 1000;
            }

            .back-to-top:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
            }

            .back-to-top.visible {
                display: flex;
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                body {
                    padding-top: 70px;
                }

                .hero-section h1 {
                    font-size: 2.5rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .filter-form {
                    position: static;
                    margin-bottom: 2rem;
                }

                .footer-content {
                    grid-template-columns: 1fr;
                    gap: 32px;
                }

                .pixel-decoration {
                    display: none;
                }
            }

            @media (max-width: 480px) {
                .hero-section h1 {
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Stars Background -->
        <div class="stars" id="stars"></div>

        <!-- Floating Decorations -->
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <!-- Header -->
        <jsp:include page="../common/user/header-user.jsp"/>

        <!-- Hero Section -->
        <section class="hero-section">
            <h1>Tìm Công Việc Mơ Ước<br>Của Bạn</h1>
            <p>Khám phá hàng nghìn cơ hội việc làm từ các công ty hàng đầu. 
                Bắt đầu hành trình sự nghiệp của bạn ngay hôm nay!</p>
        </section>

        <!-- Filter and Job Listings Section -->
        <section class="content-section">
            <div class="container">
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-lg-3 mb-4">
                        <div class="filter-form">
                            <h4>
                                <i class="fas fa-sliders-h"></i>
                                Bộ lọc
                            </h4>
                            <form action="HomeSeeker" method="GET" id="filterForm">

                                <!-- Search Input -->
                                <div class="mb-3">
                                    <label class="form-label">Tìm kiếm</label>
                                    <div class="input-group">
                                        <input type="text" name="search" class="form-control" 
                                               placeholder="Vị trí công việc..." value="${param.search}">
                                    </div>
                                </div>

                                <!-- Category Filter -->
                                <div class="mb-3">
                                    <label for="jobCategory" class="form-label">Ngành nghề</label>
                                    <select name="filterCategory" class="form-select">
                                        <option value="">Tất cả ngành nghề</option>
                                        <c:forEach var="category" items="${activeCategories}">
                                            <option value="${category.getId()}"
                                                    ${category.getId() == param.filterCategory ? 'selected' : ''}>
                                                ${category.getName()}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Job Type Filter -->
                                <div class="mb-3">
                                    <label class="form-label">Loại hình làm việc</label>
                                    <select name="filterJobType" class="form-select">
                                        <option value="">Tất cả loại hình</option>
                                        <c:forEach var="jt" items="${jobTypes}">
                                            <option value="${jt.jobTypeID}"
                                                    ${jt.jobTypeID == param.filterJobType ? 'selected' : ''}>
                                                ${jt.jobTypeName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Salary Filter -->
                                <div class="mb-3">
                                    <label class="form-label">Mức lương ($)</label>
                                    <div class="input-group">
                                        <input type="number" name="minSalary" class="form-control"
                                               placeholder="Từ" value="${param.minSalary}">
                                        <span class="input-group-text">-</span>
                                        <input type="number" name="maxSalary" class="form-control"
                                               placeholder="Đến" value="${param.maxSalary}">
                                    </div>
                                </div>

                                <!-- Location Filter -->
                                <div class="mb-3">
                                    <label class="form-label">Địa điểm</label>
                                    <select name="filterLocation" class="form-select">
                                        <option value="">Tất cả địa điểm</option>
                                        <c:forEach var="lc" items="${locations}">
                                            <option value="${lc.locationID}"
                                                    ${lc.locationID == param.filterLocation ? 'selected' : ''}>
                                                ${lc.locationName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Deadline Filter -->
                                <div class="mb-3">
                                    <label class="form-label">Thời hạn ứng tuyển</label>
                                    <select name="filterDeadline" class="form-select">
                                        <option value="">Tất cả thời hạn</option>
                                        <c:forEach var="dl" items="${deadlines}">
                                            <option value="${dl.deadlineID}"
                                                    ${dl.deadlineID == param.filterDeadline ? 'selected' : ''}>
                                                ${dl.deadlineName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Submit -->
                                <div class="d-grid mb-3">
                                    <button type="submit" class="search-button">
                                        <i class="fas fa-filter me-2"></i>Lọc kết quả
                                    </button>
                                </div>
                            </form>

                        </div>
                    </div>

                    <!-- Job Listings -->
                    <div class="col-lg-9">
                        <div class="row">
                            <c:choose>
                                <c:when test="${empty jobPostingsList}">
                                    <div class="col-12">
                                        <div class="empty-state">
                                            <div class="empty-state-icon">
                                                <i class="fas fa-briefcase"></i>
                                            </div>
                                            <h4>Không tìm thấy công việc</h4>
                                            <p>Hãy thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="job" items="${jobPostingsList}">
                                        <div class="col-md-6 col-xl-4 mb-4">
                                            <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${job.getJobPostingID()}" 
                                               class="job-card-link">
                                                <div class="card job-card">
                                                    <div class="card-body">
                                                        <h5 class="card-title">${job.getTitle()}</h5>
                                                        <div class="mb-2">
                                                            <span class="badge bg-primary">
                                                                <i class="fas fa-map-marker-alt"></i>
                                                                ${job.getLocation()}
                                                            </span>
                                                        </div>
                                                        <div class="mb-3">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-dollar-sign"></i>
                                                                ${job.getMinSalary()} - ${job.getMaxSalary()}
                                                            </span>
                                                        </div>
                                                        <p class="text-muted mb-0">
                                                            <i class="far fa-clock me-1"></i>
                                                            Đăng: ${job.getPostedDate()}
                                                        </p>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${not empty jobPostingsList}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" id="pagination">
                                    <c:if test="${pageControl.getPage() > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                                    <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>

        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-brand">
                    <h3><i class="fas fa-briefcase"></i> Jobbies</h3>
                    <p>Nền tảng tìm việc làm hàng đầu Việt Nam, kết nối hàng nghìn ứng viên với các cơ hội nghề nghiệp tuyệt vời mỗi ngày.</p>
                </div>
                <div class="footer-column">
                    <h4>Dành cho ứng viên</h4>
                    <a href="#">Tìm việc làm</a>
                    <a href="#">Tạo CV</a>
                    <a href="#">Việc làm đã lưu</a>
                    <a href="#">Cẩm nang nghề nghiệp</a>
                </div>
                <div class="footer-column">
                    <h4>Dành cho nhà tuyển dụng</h4>
                    <a href="#">Đăng tin tuyển dụng</a>
                    <a href="#">Tìm kiếm ứng viên</a>
                    <a href="#">Bảng giá dịch vụ</a>
                    <a href="#">Liên hệ hỗ trợ</a>
                </div>
                <div class="footer-column">
                    <h4>Theo dõi chúng tôi</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Jobbies. All rights reserved. | <a href="#">Điều khoản sử dụng</a> | <a href="#">Chính sách bảo mật</a></p>
            </div>
        </footer>

        <!-- Back to Top Button -->
        <button type="button" class="back-to-top" id="back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
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

            // Salary range validation
            const minSalaryInput = document.getElementById('minSalary');
            const maxSalaryInput = document.getElementById('maxSalary');

            if (minSalaryInput && maxSalaryInput) {
                minSalaryInput.addEventListener('change', function () {
                    const minValue = parseInt(this.value);
                    if (maxSalaryInput.value && minValue > parseInt(maxSalaryInput.value)) {
                        maxSalaryInput.value = minValue;
                    }
                });

                maxSalaryInput.addEventListener('change', function () {
                    const maxValue = parseInt(this.value);
                    if (minSalaryInput.value && maxValue < parseInt(minSalaryInput.value)) {
                        minSalaryInput.value = maxValue;
                    }
                });

            // Back to top button
            const backToTopButton = document.getElementById('back-to-top');

            window.onscroll = function () {