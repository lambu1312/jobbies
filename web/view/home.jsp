<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JobPath - Find Your Vibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            /* CSS LẤY TỪ HOME.HTML (Phong cách Không gian/Neon) */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
                overflow-x: hidden;
                min-height: 100vh;
            }

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

            /* --- CÁC STYLE KHÁC VẪN GIỮ NGUYÊN --- */

            /* Chú ý: Nếu header-area.jsp không có nền trong suốt, 
            nó sẽ che mất nền sao, bạn có thể cần chỉnh style cho nó.
            Ví dụ: header { background: rgba(0,0,0,0.5) !important; z-index: 100; }
            (Giả sử header-area.jsp có thẻ <header>) */

            .hero-section {
                position: relative;
                z-index: 10;
                text-align: center;
                padding: 4rem 2rem;
                margin-top: 2rem;
            }

            .hero-section h1 {
                font-size: 4rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1rem;
                text-shadow: 0 0 60px rgba(196, 113, 245, 0.5);
                line-height: 1.2;
            }

            .hero-section p {
                font-size: 1.3rem;
                color: #b8b8d1;
                margin-bottom: 3rem;
            }

            .search-container-custom {
                position: relative;
                max-width: 700px;
                margin: 0 auto 4rem;
            }

            .search-wrapper {
                position: relative;
                background: rgba(255, 255, 255, 0.08);
                backdrop-filter: blur(30px);
                border-radius: 60px;
                padding: 1.5rem 3rem;
                border: 2px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.3);
                animation: float 6s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            .search-wrapper::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(135deg, #c471f5, #fa71cd, #7ee8fa);
                border-radius: 60px;
                z-index: -1;
                opacity: 0.5;
                filter: blur(20px);
            }

            .search-input-custom {
                width: 100%;
                background: transparent;
                border: none;
                outline: none;
                color: #fff;
                font-size: 1.2rem;
                font-weight: 500;
            }

            .search-input-custom::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            /* Filter Sidebar Custom */
            .filter-form-custom {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                color: #fff;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .filter-form-custom h4 {
                color: #fff;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 700;
            }

            .form-control, .form-select, .input-group-text {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: #fff;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.6);
            }

            .form-select option {
                background-color: #1a0b2e;
                color: #fff;
            }

            .btn-success {
                background: linear-gradient(135deg, #fa71cd 0%, #c471f5 100%);
                border: none;
                font-weight: 700;
                margin-top: 1rem;
            }

            .btn-success:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            }

            /* Featured Jobs Section */
            .featured-jobs {
                position: relative;
                z-index: 10;
                max-width: 1200px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 900;
                margin-bottom: 2rem;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .job-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
            }

            .job-card-custom {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                transition: all 0.3s;
                cursor: pointer;
                position: relative;
                overflow: hidden;
                height: 100%;
                color: #fff;
            }

            .job-card-custom::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
                transition: left 0.5s;
            }

            .job-card-custom:hover::before {
                left: 100%;
            }

            .job-card-custom:hover {
                transform: translateY(-10px);
                border-color: #c471f5;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
            }

            .job-card-link-custom {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .job-card-link-custom:hover {
                color: inherit;
            }

            .job-title-custom {
                font-size: 1.3rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                color: #fff;
            }

            .job-company-custom {
                color: #c471f5;
                font-weight: 600;
            }

            .job-badge-custom {
                background: linear-gradient(135deg, #39ff14, #7ee8fa);
                color: #000;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 700;
            }

            .job-details-custom {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
                margin-top: 1rem;
                color: #b8b8d1;
                font-size: 0.9rem;
            }

            .job-details-custom span {
                display: block;
            }

            /* Pagination custom style */
            .pagination .page-item a {
                background-color: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                color: #fff;
                transition: all 0.3s;
            }

            .pagination .page-item a:hover {
                background-color: rgba(196, 113, 245, 0.2);
                border-color: #c471f5;
                color: #c471f5;
            }

            .pagination .page-item.active a {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border-color: #c471f5;
                color: #fff;
            }

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

            .no-jobs-message {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                padding: 2rem;
                color: #fa71cd;
                border: 1px solid #fa71cd;
            }

        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <div class="stars" id="stars"></div>

        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <jsp:include page="../view/common/header-area.jsp"></jsp:include>

            <section class="hero-section">
                <h1>Find Your Vibe,<br>Build Your Future ✨</h1>
                <p>Tìm việc dễ dàng, sự nghiệp vững vàng 🚀</p>

                <div class="search-container-custom mb-5">
                    <form action="home" method="GET">
                        <div class="search-wrapper">
                            <input type="text" name="search" class="search-input-custom" placeholder="🔍 Search jobs, companies, or skills..." value="${param.search}">
                        <input type="hidden" name="filterCategory" value="${param.filterCategory}">
                        <input type="hidden" name="minSalary" value="${param.minSalary}">
                        <input type="hidden" name="maxSalary" value="${param.maxSalary}">
                    </div>
                </form>
            </div>
        </section>

        <section class="featured-jobs">
            <h2 class="section-title">✨ Hot Jobs Right Now</h2>

            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="filter-form-custom">
                            <h4 class="mb-3">Filters</h4>
                            <form action="home" method="GET" id="filterForm">
                                <div class="row align-items-center mb-3">
                                    <div class="col-md-9">
                                        <input type="text" name="search" class="form-control" placeholder="Search by job title" value="${param.search}">
                                    </div>
                                    <div class="col-md-3 p-0 mt-2 mt-md-0 d-flex justify-content-end">
                                        <button type="submit" class="btn btn-sm btn-success w-100">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="jobCategory" class="form-label">Job Category:</label>
                                    <select name="filterCategory" id="jobCategory" class="form-select" onchange="document.getElementById('filterForm').submit();">
                                        <option value="">All Categories</option>
                                        <c:forEach var="category" items="${activeCategories}">
                                            <option value="${category.getId()}" ${category.getId() == param.filterCategory ? 'selected' : ''}>${category.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="minSalary" class="form-label">Salary Range:</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="minSalary" name="minSalary" placeholder="Min ($)" value="${param.minSalary}">
                                        <span class="input-group-text">-</span>
                                        <input type="number" class="form-control" id="maxSalary" name="maxSalary" placeholder="Max ($)" value="${param.maxSalary}">
                                    </div>
                                    <button type="submit" class="btn btn-success w-100">Filter by Salary</button>
                                </div>
                            </form>

                        </div>
                    </div>

                    <div class="col-md-9">
                        <div class="row">
                            <c:if test="${empty jobPostingsList}">
                                <div class="col-12 text-center no-jobs-message">
                                    <h4>Không tìm thấy công việc nào phù hợp với tiêu chí của bạn ✨</h4>
                                </div>
                            </c:if>

                            <c:forEach var="job" items="${jobPostingsList}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <a href="${pageContext.request.contextPath}/viewdetail?action=details&idJP=${job.getJobPostingID()}" class="job-card-link-custom">
                                        <div class="job-card-custom">
                                            <div class="job-header-custom">
                                                <div>
                                                    <div class="job-title-custom">${job.getTitle()}</div>
                                                    <div class="job-company-custom">Công ty TNHH</div> 
                                                </div>
                                                <div class="job-badge-custom">NEW</div>
                                            </div>
                                            <div class="job-details-custom">
                                                <span><i class="fas fa-map-marker-alt me-1"></i> ${job.getLocation()}</span>
                                                <span><i class="fas fa-dollar-sign me-1"></i> ${job.getMinSalary()} - ${job.getMaxSalary()} USD</span>
                                                <span><i class="far fa-clock me-1"></i> Posted: ${job.getPostedDate()}</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>

                        <nav aria-label="Page navigation" class="mt-5">
                            <ul class="pagination justify-content-center" id="pagination">
                                <c:if test="${pageControl.getPage() > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                                <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                                <c:if test="${startPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${startPage-1}">...</a>
                                    </li>
                                </c:if>

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${endPage < pageControl.getTotalPages()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${endPage + 1}">...</a>
                                    </li>
                                </c:if>

                                <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="../view/common/footer.jsp"></jsp:include>

        <script>
            // Script tạo sao nền
            const starsContainer = document.getElementById('stars');
            if (starsContainer) {
                for (let i = 0; i < 100; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 3 + 's';
                    starsContainer.appendChild(star);
                }
            }

            // Logic Salary range validation - Giữ nguyên
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
            }

            // Giữ nguyên logic Back to top nếu nó nằm trong footer.jsp hoặc được xử lý riêng
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>