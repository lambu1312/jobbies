<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Bài Đăng Việc Làm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
            color: #1a1a1a;
            overflow-x: hidden;
            min-height: 100vh;
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

        /* Main layout using flexbox */
        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            position: relative;
            z-index: 10;
        }

        /* Main content layout */
        .job-posting-container {
            flex: 1;
            padding: 2rem;
            margin-left: 240px;
            padding-top: 80px;
            display: flex;
            flex-direction: column;
            position: relative;
            z-index: 10;
        }
/* Ensure table takes available space */
        .table-wrapper {
            flex: 1;
        }

        /* Header section */
        .header-section {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
            padding: 2rem 0;
        }

        .header-section h2 {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
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

        /* Search bar, Add New Job, and Filter positioning */
        .controls-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1.5rem;
            width: 100%;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        /* Add new job button */
        .btn-add-job {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            padding: 10px 20px;
            font-size: 15px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-weight: 600;
            white-space: nowrap;
        }

        .btn-add-job:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
            color: white;
            text-decoration: none;
        }

        /* Filter buttons styling */
        .filter-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-buttons .btn-filter {
            background-color: rgba(255, 255, 255, 0.8);
            border: 1.5px solid #c471f5;
            color: #1a1a1a;
            padding: 8px 14px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .filter-buttons .btn-filter:hover {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
        }

        /* Search bar styling */
        .search-container {
            display: flex;
            gap: 0;
        }

        .search-box {
            width: 250px;
            padding: 10px 14px;
border: 1.5px solid #c471f5;
            border-right: none;
            border-radius: 8px 0 0 8px;
            font-size: 14px;
            outline: none;
            background-color: rgba(255, 255, 255, 0.9);
            color: #1a1a1a;
            transition: all 0.3s ease;
        }

        .search-box::placeholder {
            color: #999;
        }

        .search-box:focus {
            box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
            background-color: rgba(255, 255, 255, 0.15);
            border-color: #c471f5;
        }

        .search-button {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            padding: 10px 15px;
            border-radius: 0 8px 8px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: auto;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
        }

        .search-button i {
            color: white;
            font-size: 16px;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        table thead th {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 15px;
            font-weight: 600;
            border: none;
        }

        table tbody td {
            padding: 14px 15px;
            border-bottom: 1px solid #e5e5e5;
            text-align: center;
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

        /* Action buttons styling */
        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            background-color: transparent;
            color: #c471f5;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            width: 32px;
            height: 32px;
            border-radius: 6px;
        }

        .btn-action:last-child {
            margin-right: 0;
        }

        .btn-action:hover {
            color: #fff;
            background-color: #c471f5;
            transform: scale(1.1);
        }
.btn-action.text-info {
            color: #0da5c0;
        }

        .btn-action.text-info:hover {
            color: #fff;
            background-color: #0da5c0;
        }

        .text-danger {
            color: #dc3545;
        }

        .text-danger:hover {
            background-color: #dc3545;
            color: white;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 2rem;
            padding-bottom: 2rem;
            gap: 8px;
        }

        .pagination a,
        .pagination span {
            padding: 10px 14px;
            border: 1.5px solid #c471f5;
            font-size: 14px;
            cursor: pointer;
            border-radius: 8px;
            text-decoration: none;
            color: #1a1a1a;
            transition: all 0.3s ease;
            font-weight: 600;
            background-color: rgba(255, 255, 255, 0.8);
        }

        .pagination a:hover {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
        }

        .pagination .page-link.active,
        .pagination .active a {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            border-color: transparent;
        }

        /* Error message styling */
        .error-message {
            color: #dc3545;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            margin-top: 2rem;
            font-weight: 600;
            background-color: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .job-title-violate {
            color: #dc3545;
            font-weight: bold;
            opacity: 0.8;
        }

        .job-title-violate .fa-exclamation-triangle {
            color: #dc3545;
            margin-left: 5px;
        }

        .status-violate {
            color: #dc3545;
            font-weight: bold;
            opacity: 0.8;
        }

        .edit-violate {
            color: #dc3545;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .date-violate {
            color: #dc3545;
            font-weight: bold;
            opacity: 0.8;
        }

        /* Footer container */
        .footer-container {
            margin-top: auto;
        }

        /* Mobile Responsive */
        @media (max-width: 1200px) {
            .job-posting-container {
                margin-left: 0;
                padding-top: 60px;
            }
        }

        @media (max-width: 768px) {
            .controls-container {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-add-job {
                width: 100%;
                justify-content: center;
}

            .filter-buttons {
                width: 100%;
                justify-content: flex-start;
            }

            .search-container {
                width: 100%;
            }

            .search-box {
                width: 100%;
            }

            table {
                font-size: 12px;
            }

            table thead th,
            table tbody td {
                padding: 10px 8px;
            }

            .btn-action {
                margin-right: 8px;
            }

            .header-section h2 {
                font-size: 1.8rem;
            }

            .pixel-decoration {
                display: none;
            }
        }

        @media (max-width: 480px) {
            .job-posting-container {
                padding: 1rem;
            }

            .header-section h2 {
                font-size: 1.5rem;
            }

            table {
                font-size: 11px;
            }

            table thead th,
            table tbody td {
                padding: 8px 5px;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>

    <div class="pixel-decoration deco-1">✨</div>
    <div class="pixel-decoration deco-2">💎</div>
    <div class="pixel-decoration deco-3">🚀</div>

    <div class="page-container">
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content for Job Posting Management -->
        <div class="job-posting-container">
            <!-- Centered Header section -->
            <div class="header-section">
                <h2>Quản Lý Bài Đăng Việc Làm</h2>
            </div>

            <!-- Search bar, Add New Job, and Filters -->
            <div class="controls-container">
                <!-- Add New Job Button -->
                <a href="${pageContext.request.contextPath}/AddJobPosting" class="btn-add-job">
                    <i class="fas fa-plus"></i> Thêm Công Việc Mới
                </a>

                <!-- Filter Buttons -->
                <div class="filter-buttons">
                    <a href="${pageContext.request.contextPath}/jobPost?sort=title&page=1&searchJP=${searchJP}" class="btn-filter">
                        Lọc theo Tiêu Đề A-Z
                    </a>
                    <a href="${pageContext.request.contextPath}/jobPost?sort=postedDate&page=1&searchJP=${searchJP}" class="btn-filter">
                        Lọc theo Ngày Đăng
                    </a>
                    <a href="${pageContext.request.contextPath}/jobPost?sort=status&page=1&searchJP=${searchJP}" class="btn-filter">
                        Lọc theo Trạng Thái
                    </a>
                </div>

                <!-- Search bar -->
                <form action="${pageContext.request.contextPath}/jobPost" method="get" class="search-container">
<input type="text" name="searchJP" class="search-box" placeholder="Tìm kiếm theo tiêu đề..." />
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Table for displaying job postings -->
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Tiêu Đề Công Việc</th>
                            <th>Ngày Đăng</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                            <th>Ứng Tuyển</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="i" items="${listJobPosting}">
                            <tr>
                                <td>
                                    <c:if test="${i.getStatus() == 'Violate'}">
                                        <span class="job-title-violate">
                                            ${i.getTitle()}
                                            <i class="fas fa-exclamation-triangle" title="Vi phạm"></i>
                                        </span>
                                    </c:if>
                                    <c:if test="${i.getStatus() != 'Violate'}">
                                        ${i.getTitle()}
                                    </c:if>
                                </td>

                                <td>
                                    <c:if test="${i.getStatus() == 'Violate'}">
                                        <span class="date-violate">
                                            <fmt:formatDate value="${i.getPostedDate()}" pattern="dd-MM-yyyy" />
                                        </span>
                                    </c:if>
                                    <c:if test="${i.getStatus() != 'Violate'}">
                                        <fmt:formatDate value="${i.getPostedDate()}" pattern="dd-MM-yyyy" />
                                    </c:if>
                                </td>

                                <td>
                                    <c:if test="${i.getStatus() == 'Violate'}">
                                        <span class="status-violate">${i.getStatus()}</span>
                                    </c:if>
                                    <c:if test="${i.getStatus() != 'Violate'}">
                                        ${i.getStatus()}
                                    </c:if>
                                </td>

                                <td>
                                    <a href="${pageContext.request.contextPath}/detailsJP?action=details&idJP=${i.getJobPostingID()}" class="btn-action" title="Xem chi tiết">
<i class="fas fa-eye"></i>
                                    </a>

                                    <c:choose>
                                        <c:when test="${i.getStatus() == 'Violate'}">
                                            <span class="btn-action edit-violate" onclick="showEditWarning()" title="Không thể chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/updateJP?idJP=${i.getJobPostingID()}" class="btn-action" title="Chỉnh sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:if test="${i.application.size() != 0}">
                                        <a href="${pageContext.request.contextPath}/applicationSeekers?action=view&jobPostId=${i.getJobPostingID()}" class="btn-action text-info" title="Xem ứng tuyển">
                                            <i class="fas fa-arrow-up"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${i.application.size() == 0}">
                                        <span>Chưa có</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Error message if no job postings found -->
            <c:if test="${not empty requestScope.NoJP}">
                <div class="error-message">${requestScope.NoJP}</div>
            </c:if>

            <!-- Pagination controls -->
            <nav aria-label="Page navigation" class="footer-container">
                <ul class="pagination justify-content-center">
                    <!-- Previous button -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage - 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Trang trước">
                                <span aria-hidden="true">&laquo; Trước</span>
                            </a>
                        </li>
                    </c:if>

                    <!-- Calculate page range -->
                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}" />
<c:set var="endPage" value="${startPage + 4 <= totalPages ? startPage + 4 : totalPages}" />

                    <!-- Jump to previous group -->
                    <c:if test="${startPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${startPage - 1}&sort=${sortField}&searchJP=${searchJP}">...</a>
                        </li>
                    </c:if>

                    <!-- Display page numbers -->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${i}&sort=${sortField}&searchJP=${searchJP}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- Jump to next group -->
                    <c:if test="${endPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${endPage + 1}&sort=${sortField}&searchJP=${searchJP}">...</a>
                        </li>
                    </c:if>

                    <!-- Next button -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage + 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Trang sau">
                                <span aria-hidden="true">Sau &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
    </div>

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

        function showEditWarning() {
            alert("Bài đăng công việc này không thể chỉnh sửa vì có trạng thái 'Vi phạm'");
        }
    </script>
</body>
</html>
