<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cẩm nang - Jobbies</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        .handbook-container {
            position: relative;
            z-index: 10;
            padding-top: 120px;
            padding-bottom: 60px;
        }

        .handbook-header {
            margin-bottom: 3rem;
        }

        .handbook-title {
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
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

        .handbook-subtitle {
            color: #b8b8d1;
            font-size: 1.1rem;
        }

        /* Search Bar */
        .handbook-search {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 2rem;
        }

        .handbook-search .form-control {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 0.8rem 1rem;
            border-radius: 10px;
        }

        .handbook-search .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .handbook-search .form-control:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: #c471f5;
            box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
            color: #fff;
            outline: none;
        }

        .btn-gradient {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            color: #fff;
            font-weight: 700;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.4);
        }

        .btn-gradient:hover {
            transform: translateY(-2px);
            color: #fff;
            box-shadow: 0 8px 30px rgba(196, 113, 245, 0.6);
        }

        /* Handbook Cards */
        .handbook-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
        }

        .handbook-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
            transition: left 0.5s;
        }

        .handbook-card:hover::before {
            left: 100%;
        }

        .handbook-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
            border-color: #c471f5;
        }

        .handbook-card img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }

        .handbook-card .placeholder-img {
            height: 200px;
            background: linear-gradient(135deg, rgba(196, 113, 245, 0.2), rgba(126, 232, 250, 0.2));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.3);
        }

        .handbook-card .card-body {
            padding: 1.5rem;
        }

        .handbook-card .card-title {
            color: #fff;
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .btn-outline-theme {
            border: 2px solid rgba(196, 113, 245, 0.5);
            color: #c471f5;
            font-weight: 600;
            padding: 0.5rem 1.5rem;
            border-radius: 10px;
            transition: all 0.3s;
        }

        .btn-outline-theme:hover {
            background: rgba(196, 113, 245, 0.2);
            color: #fff;
            border-color: #c471f5;
            transform: translateX(5px);
        }

        /* Alerts */
        .alert {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .alert-danger {
            background: rgba(255, 107, 107, 0.1);
            border-color: rgba(255, 107, 107, 0.3);
            color: #ff6b6b;
        }

        .alert-info {
            background: rgba(126, 232, 250, 0.1);
            border-color: rgba(126, 232, 250, 0.3);
            color: #7ee8fa;
        }

        /* Modern Pagination */
        .pagination {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
            align-items: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }

        .page-item {
            list-style: none;
        }

        .page-link {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #fff;
            padding: 0.6rem 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            min-width: 40px;
            justify-content: center;
        }

        .page-link:hover {
            background: rgba(196, 113, 245, 0.2);
            border-color: #c471f5;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(196, 113, 245, 0.3);
        }

        .page-item.active .page-link {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border-color: transparent;
            color: #fff;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.5);
        }

        .page-item.disabled .page-link {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

        /* Pagination Arrow Icons */
        .page-link i {
            font-size: 0.9rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
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

        /* Responsive */
        @media (max-width: 768px) {
            .handbook-container {
                padding-top: 100px;
            }

            .handbook-title {
                font-size: 2rem;
            }

            .handbook-search {
                flex-direction: column;
            }

            .btn-gradient {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <jsp:include page="../common/header-area.jsp"></jsp:include>

    <div class="container handbook-container">
        <!-- Header -->
        <div class="handbook-header text-center">
            <h1 class="handbook-title">📚 Cẩm Nang Nghề Nghiệp</h1>
            <p class="handbook-subtitle">Khám phá kiến thức và kinh nghiệm từ các chuyên gia</p>
        </div>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/handbook" method="GET" class="handbook-search d-flex align-items-center" style="gap: 1rem;">
            <input type="text" class="form-control flex-grow-1" name="search" placeholder="🔍 Tìm kiếm bài viết..." value="${search}">
            <button type="submit" class="btn btn-gradient">
                <i class="fas fa-search"></i> Tìm kiếm
            </button>
        </form>

        <!-- Alerts -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${param.error}
            </div>
        </c:if>

        <!-- Content -->
        <c:choose>
            <c:when test="${empty posts}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h4>Chưa có bài viết nào</h4>
                    <p style="color: #b8b8d1;">Hãy quay lại sau để khám phá thêm nội dung mới!</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Cards Grid -->
                <div class="row g-4">
                    <c:forEach items="${posts}" var="p">
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="handbook-card">
                                <c:choose>
                                    <c:when test="${not empty p.thumbnail}">
                                        <img src="${p.thumbnail}" alt="${p.title}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="placeholder-img">
                                            <i class="fas fa-book"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title">${p.title}</h5>
                                    <a class="btn btn-outline-theme" href="${pageContext.request.contextPath}/handbook-detail?id=${p.handbookPostID}">
                                        Xem chi tiết <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${pageControl.totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <!-- Previous Button -->
                            <c:if test="${pageControl.page > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page-1}">
                                        <i class="fas fa-chevron-left"></i> Previous
                                    </a>
                                </li>
                            </c:if>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${pageControl.page - 2 > 0 ? pageControl.page - 2 : 1}" />
                            <c:set var="endPage" value="${startPage + 4 <= pageControl.totalPages ? startPage + 4 : pageControl.totalPages}" />

                            <!-- First Page + Ellipsis -->
                            <c:if test="${startPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageControl.urlPattern}page=1">1</a>
                                </li>
                                <c:if test="${startPage > 2}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>

                            <!-- Page Number Range -->
                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <li class="page-item ${i == pageControl.page ? 'active' : ''}">
                                    <a class="page-link" href="${pageControl.urlPattern}page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Ellipsis + Last Page -->
                            <c:if test="${endPage < pageControl.totalPages}">
                                <c:if test="${endPage < pageControl.totalPages - 1}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.totalPages}">${pageControl.totalPages}</a>
                                </li>
                            </c:if>

                            <!-- Next Button -->
                            <c:if test="${pageControl.page < pageControl.totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page+1}">
                                        Next <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="../common/footer.jsp"></jsp:include>

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