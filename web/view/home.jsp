<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobbies - Find Your Vibe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        .navbar {
            position: relative;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 3rem;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(196, 113, 245, 0.5);
            letter-spacing: 2px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
        }

        .nav-links a:hover {
            color: #c471f5;
            text-shadow: 0 0 20px rgba(196, 113, 245, 0.8);
        }

        .cta-button {
            padding: 0.8rem 2rem;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            border-radius: 50px;
            color: #fff;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 0 30px rgba(196, 113, 245, 0.4);
        }

        .cta-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 40px rgba(196, 113, 245, 0.7);
        }

        .hero {
            position: relative;
            z-index: 10;
            text-align: center;
            padding: 4rem 2rem;
            margin-top: 2rem;
        }

        .hero h1 {
            font-size: 4rem;
/*            font-weight: 900;*/
            background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
            text-shadow: 0 0 60px rgba(196, 113, 245, 0.5);
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.3rem;
            color: #b8b8d1;
            margin-bottom: 3rem;
        }

        .search-container {
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
            display: flex;
            gap: 1rem;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
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

        .search-input {
            flex: 1;
            background: transparent;
            border: none;
            outline: none;
            color: #fff;
            font-size: 1.2rem;
            font-weight: 500;
        }

        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .search-button {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            color: #fff;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-button:hover {
            transform: scale(1.05);
        }

        .content-section {
            position: relative;
            z-index: 10;
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            display: flex;
            gap: 2rem;
        }

        .filters-sidebar {
            width: 300px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            height: fit-content;
            position: sticky;
            top: 2rem;
        }

        .filter-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .filter-group {
            margin-bottom: 1.5rem;
        }

        .filter-label {
            display: block;
            color: #b8b8d1;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .filter-select, .filter-input {
            width: 100%;
            padding: 0.8rem;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #fff;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.3s;
        }

        .filter-select:focus, .filter-input:focus {
            border-color: #c471f5;
            box-shadow: 0 0 15px rgba(196, 113, 245, 0.3);
        }

        .filter-select option {
            background: #1a0b2e;
            color: #fff;
        }

        .salary-range {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .salary-range input {
            flex: 1;
        }

        .salary-range span {
            color: #b8b8d1;
        }

        .filter-button {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            border-radius: 15px;
            color: #fff;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 1rem;
        }

        .filter-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.5);
        }

        .jobs-content {
            flex: 1;
        }

        .section-title {
            font-size: 2rem;
            font-weight: 900;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .job-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .job-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.3s;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            color: inherit;
            display: block;
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
            color: inherit;
        }

        .job-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #fff;
        }

        .job-badges {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 1rem;
        }

        .job-badge {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .badge-location {
            background: rgba(126, 232, 250, 0.2);
            color: #7ee8fa;
            border: 1px solid #7ee8fa;
        }

        .badge-salary {
            background: rgba(57, 255, 20, 0.2);
            color: #39ff14;
            border: 1px solid #39ff14;
        }

        .job-date {
            color: #b8b8d1;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .no-jobs {
            text-align: center;
            padding: 4rem 2rem;
            color: #b8b8d1;
        }

        .no-jobs h4 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .page-button {
            min-width: 40px;
            height: 40px;
            padding: 0 0.8rem;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #fff;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .page-button:hover {
            background: rgba(196, 113, 245, 0.3);
            border-color: #c471f5;
            color: #fff;
        }

        .page-button.active {
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            border-color: transparent;
            box-shadow: 0 5px 15px rgba(196, 113, 245, 0.4);
        }

        .pixel-decoration {
            position: fixed;
            font-size: 3rem;
            opacity: 0.3;
            z-index: 5;
            animation: float 4s ease-in-out infinite;
        }

        .deco-1 { top: 20%; left: 10%; }
        .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
        .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }

        @media (max-width: 1024px) {
            .content-section {
                flex-direction: column;
            }

            .filters-sidebar {
                width: 100%;
                position: static;
            }

            .job-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 1rem 1.5rem;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .search-wrapper {
                flex-direction: column;
                padding: 1.5rem;
            }

            .job-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <div class="pixel-decoration deco-1">✨</div>
    <div class="pixel-decoration deco-2">💎</div>
    <div class="pixel-decoration deco-3">🚀</div>

    <jsp:include page="../view/common/header-area.jsp"></jsp:include>

    <section class="hero">
        <h1>Find Your Vibe,<br>Build Your Future ✨</h1>
        <p>Tìm việc dễ dàng, sự nghiệp vững vàng 🚀</p>

        <div class="search-container">
            <form action="${pageContext.request.contextPath}/home" method="GET">
                <div class="search-wrapper">
                    <input type="text" name="search" class="search-input" placeholder="🔍 Search jobs, companies, or skills..." value="${param.search}">
                    <button type="submit" class="search-button">Search</button>
                </div>
            </form>
        </div>
    </section>

    <div class="content-section">
        <!-- Filters Sidebar -->
<aside class="filters-sidebar">
    <h3 class="filter-title">🎯 Filters</h3>
    <form action="${pageContext.request.contextPath}/home" method="GET" id="filterForm">
        <input type="hidden" name="search" value="${param.search}">
        
        <!-- Category Filter -->
        <div class="filter-group">
            <label class="filter-label">Job Category</label>
            <select name="filterCategory" id="filterCategory" class="filter-select" onchange="document.getElementById('filterForm').submit();">
                <option value="">All Categories</option>
                <c:forEach var="category" items="${activeCategories}">
                    <option value="${category.getId()}" ${category.getId() == param.filterCategory ? 'selected' : ''}>
                        ${category.getName()}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Salary Range Filter -->
        <div class="filter-group">
            <label class="filter-label">Salary Range ($)</label>
            <input type="number" 
                   name="minSalary" 
                   id="minSalary" 
                   class="filter-input" 
                   placeholder="Min (e.g. 1000)" 
                   value="${param.minSalary}"
                   min="0"
                   step="100">
            <span style="display: block; text-align: center; padding: 0.5rem 0; color: #b8b8d1;">to</span>
            <input type="number" 
                   name="maxSalary" 
                   id="maxSalary" 
                   class="filter-input" 
                   placeholder="Max (e.g. 5000)" 
                   value="${param.maxSalary}"
                   min="0"
                   step="100">
            <button type="submit" class="filter-button">Apply Filter 🔍</button>
        </div>
    </form>
</aside>

        <!-- Job Listings -->
        <main class="jobs-content">
            <h2 class="section-title">✨ Hot Jobs Right Now</h2>

            <c:choose>
                <c:when test="${empty jobPostingsList}">
                    <div class="no-jobs">
                        <h4>🔍 No jobs found matching your criteria</h4>
                        <p>Try adjusting your filters or search terms</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="job-grid">
                        <c:forEach var="job" items="${jobPostingsList}">
                            <a href="${pageContext.request.contextPath}/viewdetail?action=details&idJP=${job.getJobPostingID()}" class="job-card">
                                <h5 class="job-title">${job.getTitle()}</h5>
                                <div class="job-badges">
                                    <span class="job-badge badge-location">
                                        <i class="fas fa-map-marker-alt"></i>
                                        ${job.getLocation()}
                                    </span>
                                    <span class="job-badge badge-salary">
                                        <i class="fas fa-dollar-sign"></i>
                                        $${job.getMinSalary()} - $${job.getMaxSalary()}
                                    </span>
                                </div>
                                <div class="job-date">
                                    <i class="far fa-clock"></i>
                                    Posted: ${job.getPostedDate()}
                                </div>
                            </a>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <nav class="pagination">
                        <c:if test="${pageControl.getPage() > 1}">
                            <a href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}" class="page-button">
                                « Previous
                            </a>
                        </c:if>

                        <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                        <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                        <c:if test="${startPage > 1}">
                            <a href="${pageControl.getUrlPattern()}page=${startPage-1}" class="page-button">...</a>
                        </c:if>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <a href="${pageControl.getUrlPattern()}page=${i}" class="page-button ${i == pageControl.getPage() ? 'active' : ''}">
                                ${i}
                            </a>
                        </c:forEach>

                        <c:if test="${endPage < pageControl.getTotalPages()}">
                            <a href="${pageControl.getUrlPattern()}page=${endPage + 1}" class="page-button">...</a>
                        </c:if>

                        <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                            <a href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}" class="page-button">
                                Next »
                            </a>
                        </c:if>
                    </nav>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
                    
        <!-- Footer -->
        <jsp:include page="../view/common/footer.jsp"></jsp:include>

    <script>
        // Generate stars
        const starsContainer = document.getElementById('stars');
        for (let i = 0; i < 100; i++) {
            const star = document.createElement('div');
            star.className = 'star';
            star.style.left = Math.random() * 100 + '%';
            star.style.top = Math.random() * 100 + '%';
            star.style.animationDelay = Math.random() * 3 + 's';
            starsContainer.appendChild(star);
        }
    </script>
</body>
</html>