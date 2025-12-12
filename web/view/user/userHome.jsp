<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobbies - Tìm Việc Làm Mơ Ước</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Poppins:wght@400;600;700;900&display=swap"
            rel="stylesheet">

        <style>
            /* CRITICAL: Force navbar and dropdown positioning */
            nav.navbar,
            .navbar {
                position: relative !important;
                z-index: 9999 !important;
            }

            .user-dropdown {
                position: relative !important;
                z-index: 10000 !important;
            }

            .user-dropdown .dropdown-menu {
                position: absolute !important;
                top: calc(100% + 0.5rem) !important;
                right: 0 !important;
                z-index: 10001 !important;
                display: block !important;
            }

            .user-dropdown:not(.active) .dropdown-menu {
                opacity: 0 !important;
                visibility: hidden !important;
                pointer-events: none !important;
            }

            .user-dropdown.active .dropdown-menu {
                opacity: 1 !important;
                visibility: visible !important;
                pointer-events: auto !important;
            }

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
                overflow-y: auto;
                min-height: 100vh;
            }

            /* Stars Background */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1 !important;
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

                0%,
                100% {
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

                0%,
                100% {
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-20px);
                }
            }

            /* Hero Section */
            .hero-section {
                position: relative;
                z-index: 10 !important;
                text-align: center;
                padding: 4rem 2rem 2rem;
                margin-top: 100px;
                /* Space for fixed header */
            }

            .hero-section h1 {
                font-size: 3rem;
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
                font-size: 1rem;
                color: #b8b8d1;
                margin-bottom: 2rem;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
                animation: fadeInUp 0.8s ease 0.2s backwards;
            }

            /* Filter Form */
            .filter-form {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 1.5rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                margin-bottom: 2rem;
            }

            .filter-form h4 {
                font-weight: 700;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 1rem;
                font-size: 1.1rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .filter-form h4 i {
                color: #c471f5;
                -webkit-text-fill-color: #c471f5;
            }

            /* Filter Grid Layout */
            .filter-grid {
                display: grid;
                grid-template-columns: 2fr 1.5fr 1.5fr 1.5fr 2.5fr 1fr auto;
                gap: 1rem;
                align-items: end;
            }

            .form-label {
                color: #e2e8f0;
                font-weight: 600;
                font-size: 12px;
                margin-bottom: 6px;
                display: block;
            }

            .form-control,
            .form-select {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 8px;
                color: #fff;
                padding: 8px 12px;
                font-size: 13px;
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

            /* Salary Input Wrapper */
            .salary-inputs-wrapper {
                display: flex;
                gap: 12px;
                align-items: center;
            }

            .salary-inputs-wrapper .form-control {
                flex: 1;
                padding: 12px 16px;
                font-size: 15px;
                min-height: 45px;
            }

            .salary-separator {
                color: #b8b8d1;
                font-size: 18px;
                font-weight: 600;
            }

            /* Search Button */
            .search-button {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                border-radius: 8px;
                color: #fff;
                padding: 8px 16px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
                font-size: 20px;
                white-space: nowrap;
            }

            .search-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
            }

            /* Checkbox Styling */
            .filter-checkbox {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 8px 12px;
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 8px;
                cursor: pointer;
                font-size: 13px;
            }

            .filter-checkbox input[type="checkbox"] {
                cursor: pointer;
                width: 16px;
                height: 16px;
            }

            .filter-checkbox input[type="checkbox"]:checked {
                accent-color: #c471f5;
            }

            /* Content Section */
            .content-section {
                position: relative;
                z-index: 10 !important;
                padding: 0;
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

            /* Badges */
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

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .filter-grid {
                    grid-template-columns: 1fr 1fr 1fr 1fr;
                    gap: 0.8rem;
                }
            }

            @media (max-width: 768px) {
                .hero-section {
                    margin-top: 80px;
                    padding: 3rem 1.5rem 2rem;
                }

                .hero-section h1 {
                    font-size: 2.5rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .filter-grid {
                    grid-template-columns: 1fr;
                    gap: 0.8rem;
                }

                .search-button {
                    width: 100%;
                }

                .pixel-decoration {
                    display: none;
                }

                .salary-inputs-wrapper {
                    gap: 8px;
                }

                .salary-inputs-wrapper .form-control {
                    padding: 10px 12px;
                    font-size: 14px;
                    min-height: 40px;
                }
            }

            @media (max-width: 480px) {
                .hero-section h1 {
                    font-size: 2rem;
                }

                .filter-form {
                    padding: 1rem;
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
        <jsp:include page="../common/user/header-user.jsp" />

        <!-- Hero Section -->
        <section class="hero-section">
            <h1>Tìm Công Việc Mơ Ước<br>Của Bạn</h1>
            <p>Khám phá hàng nghìn cơ hội việc làm từ các công ty hàng đầu. Bắt đầu hành trình sự nghiệp của bạn
                ngay hôm nay!</p>
        </section>

        <!-- Filter and Job Listings Section -->
        <section class="content-section">
            <div class="container">
                <!-- Compact horizontal filter layout -->
                <div class="filter-form">
                    <h4>
                        <i class="fas fa-sliders-h"></i>
                        Bộ lọc
                    </h4>
                    <form action="HomeSeeker" method="GET" id="filterForm">
                        <div class="filter-grid">
                            <!-- Search -->
                            <div>
                                <label class="form-label">Tìm kiếm</label>
                                <input type="text" name="search" class="form-control" placeholder="Vị trí..."
                                       value="${param.search}">
                            </div>

                            <!-- Category -->
                            <div>
                                <label class="form-label">Ngành nghề</label>
                                <select name="filterCategory" class="form-select">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="category" items="${activeCategories}">
                                        <option value="${category.getId()}"
                                                ${category.getId()==param.filterCategory ? 'selected' : '' }>
                                            ${category.getName()}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Job Type -->
                            <div>
                                <label class="form-label">Loại hình</label>
                                <select name="filterJobType" class="form-select">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="jt" items="${jobTypes}">
                                        <option value="${jt.jobTypeID}" ${jt.jobTypeID==param.filterJobType
                                                         ? 'selected' : '' }>
                                                    ${jt.jobTypeName}
                                                </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Location -->
                                <div>
                                    <label class="form-label">Địa điểm</label>
                                    <select name="filterLocation" class="form-select">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="lc" items="${locations}">
                                            <option value="${lc.locationID}" ${lc.locationID==param.filterLocation
                                                             ? 'selected' : '' }>
                                                        ${lc.locationName}
                                                    </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Salary Min & Max - Cùng một dòng, to hơn -->
                                    <div>
                                        <label class="form-label">Lương (triệu)</label>
                                        <div style="display: flex; gap: 12px; align-items: center;">
                                            <input type="number" name="minSalary" id="minSalary" class="form-control"
                                                   placeholder="Từ" value="${param.minSalary}" min="0" step="100"
                                                   style="flex: 1; padding: 12px 16px; font-size: 15px;">
                                            <span style="color: #b8b8d1; font-size: 18px; font-weight: 600;">-</span>
                                            <input type="number" name="maxSalary" id="maxSalary" class="form-control"
                                                   placeholder="Đến" value="${param.maxSalary}" min="0" step="100"
                                                   style="flex: 1; padding: 12px 16px; font-size: 15px;">
                                        </div>
                                    </div>

                                    <!-- Currency -->
                                    <div>
                                        <label class="form-label">Tiền</label>
                                        <select name="currency" class="form-select">
                                            <option value="VND" ${param.currency=='VND' ? 'selected' : '' }>VND</option>
                                            <option value="USD" ${param.currency=='USD' ? 'selected' : '' }>USD</option>
                                            <option value="EUR" ${param.currency=='EUR' ? 'selected' : '' }>EUR</option>
                                            <option value="JPY" ${param.currency=='JPY' ? 'selected' : '' }>JPY</option>
                                        </select>
                                    </div>


                                </div>

                                <!-- Second row for date and checkbox -->
                                <div class="filter-grid" style="margin-top: 1rem;">
                                    <!-- Date From -->
                                    <div>
                                        <label class="form-label">Từ ngày</label>
                                        <input type="date" name="dateFrom" class="form-control"
                                               value="${param.dateFrom}">
                                    </div>

                                    <!-- Date To -->
                                    <div>
                                        <label class="form-label">Đến ngày</label>
                                        <input type="date" name="dateTo" class="form-control" value="${param.dateTo}">
                                    </div>

                                    <!-- Online Checkbox -->
                                    <div style="display: flex; align-items: flex-end;">
                                        <label class="filter-checkbox">
                                            <span>Làm việc Online</span>
                                            <input type="checkbox" name="onlineOnly" value="true"
                                                   ${param.onlineOnly=='true' ? 'checked' : '' }>

                                        </label>
                                    </div>
                                    <!-- Filter Button -->
                                    <div>
                                        <button type="submit" class="search-button">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>

                            </form>
                        </div>

                        <!-- Job Listings - Full Width -->
                        <div class="row" style="margin-top: 2rem;">
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
                                        <div class="col-md-6 col-lg-4 mb-4">
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
                                            <a class="page-link"
                                               href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:set var="startPage"
                                           value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}" />
                                    <c:set var="endPage"
                                           value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}" />

                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                        <li class="page-item">
                                            <a class="page-link"
                                               href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </section>

                <!-- Footer -->
                <jsp:include page="../common/footer.jsp" />

                <!-- Back to Top Button -->
                <button type="button" class="btn btn-success position-fixed bottom-0 end-0 m-4" id="back-to-top">
                    <i class="fas fa-arrow-up"></i>
                </button>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
                <script>
                    // Category filter auto-submit
                    document.getElementById('jobCategory').addEventListener('change', function () {
                        document.getElementById('filterForm').submit();
                    });

                    // Salary range validation
                    const minSalaryInput = document.getElementById('minSalary');
                    const maxSalaryInput = document.getElementById('maxSalary');

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
                        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                            backToTopButton.style.display = 'block';
                        } else {
                            backToTopButton.style.display = 'none';
                        }
                    };

                    backToTopButton.addEventListener('click', function () {
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });
                    });
                </script>

                <jsp:include page="../common/user/common-js-user.jsp" />
            </body>

        </html>