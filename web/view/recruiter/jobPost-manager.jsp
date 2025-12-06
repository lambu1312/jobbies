<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Job Posting Management - Jobbies</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: #f5f7fa;
            color: #333;
            overflow-x: hidden;
            min-height: 100vh;
        }

        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            position: relative;
            z-index: 10;
        }

        .job-posting-container {
            flex: 1;
            padding: 3rem 2rem;
            margin-left: 260px;
            padding-top: 120px;
            display: flex;
            flex-direction: column;
        }

        .header-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .header-section h2 {
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, #333 0%, #c471f5 50%, #7ee8fa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1.2;
        }

        .controls-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
            max-width: 1400px;
            margin: 0 auto 2rem;
            width: 100%;
        }

        .btn-add-job {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            border-radius: 50px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.3);
            border: none;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-add-job:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(196, 113, 245, 0.5);
            color: white;
            text-decoration: none;
        }

        .filter-buttons {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .btn-filter {
            background: #fff;
            border: 2px solid #e0e0e0;
            color: #333;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .btn-filter:hover {
            background: #fff;
            border-color: #c471f5;
            color: #c471f5;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.2);
            text-decoration: none;
        }

        .search-container {
            display: flex;
            gap: 0;
        }

        .search-box {
            padding: 0.8rem 1.5rem;
            border: 2px solid #e0e0e0;
            border-right: none;
            border-radius: 50px 0 0 50px;
            font-size: 1rem;
            outline: none;
            height: 42px;
            background: #fff;
            color: #333;
            flex: 1;
            max-width: 250px;
            transition: all 0.3s;
        }

        .search-box::placeholder {
            color: #999;
        }

        .search-box:focus {
            border-color: #c471f5;
            box-shadow: 0 0 0 3px rgba(196, 113, 245, 0.1);
        }

        .search-button {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 0 50px 50px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 42px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.3);
        }

        .search-button:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 30px rgba(196, 113, 245, 0.5);
        }

        .search-button i {
            color: white;
            font-size: 1rem;
        }

        .table-wrapper {
            flex: 1;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        table thead th {
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            color: white;
            padding: 1.2rem;
            text-align: center;
            font-size: 1rem;
            font-weight: 700;
            border-bottom: 2px solid #e0e0e0;
        }

        table tbody td {
            padding: 1rem 1.2rem;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
            font-size: 0.95rem;
            color: #333;
        }

        table tbody tr {
            transition: all 0.3s;
        }

        table tbody tr:hover {
            background-color: #f8f9ff;
        }

        .job-title {
            color: #333;
            font-weight: 600;
            text-align: left;
        }

        .job-title-violate {
            color: #ff6b6b;
            font-weight: 700;
            opacity: 0.8;
        }

        .job-title-violate i {
            color: #ff6b6b;
            margin-left: 0.5rem;
        }

        .status-active {
            background: rgba(57, 255, 20, 0.1);
            color: #27ae60;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            border: 1px solid #27ae60;
            display: inline-block;
        }

        .status-violate {
            background: rgba(255, 107, 107, 0.1);
            color: #ff6b6b;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-weight: 700;
            border: 1px solid #ff6b6b;
            display: inline-block;
        }

        .date-violate {
            color: #ff6b6b;
            font-weight: 600;
        }

        .btn-action {
            background: transparent;
            color: #3498db;
            font-size: 1.1rem;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            border: none;
            margin: 0 0.8rem;
            padding: 0.5rem;
        }

        .btn-action:hover {
            color: #c471f5;
            transform: scale(1.2);
        }

        .btn-action.edit-violate {
            color: #ff6b6b;
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-action.text-info {
            color: #3498db;
            font-size: 0.95rem;
            display: inline-block;
        }

        .btn-action.text-info:hover {
            color: #c471f5;
        }

        .error-message {
            color: #ff6b6b;
            padding: 1.5rem 2rem;
            border-radius: 15px;
            text-align: center;
            margin: 2rem auto;
            font-weight: 600;
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid #ff6b6b;
            max-width: 600px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .page-link {
            min-width: 40px;
            height: 40px;
            padding: 0 0.8rem;
            background: #fff;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            color: #333;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .page-link:hover {
            background: #f8f9ff;
            border-color: #c471f5;
            color: #c471f5;
        }

        .page-link.active {
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            border-color: transparent;
            color: white;
            box-shadow: 0 5px 15px rgba(196, 113, 245, 0.4);
        }

        .no-data {
            text-align: center;
            padding: 3rem 2rem;
            color: #666;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.1);
        }

        .no-data h4 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #333;
        }

        @media (max-width: 1024px) {
            .job-posting-container {
                margin-left: 0;
                padding-top: 100px;
            }

            .controls-container {
                flex-direction: column;
                align-items: flex-start;
            }

            table {
                font-size: 0.85rem;
            }

            table tbody td {
                padding: 0.8rem;
            }
        }

        @media (max-width: 768px) {
            .header-section h2 {
                font-size: 2rem;
            }

            .controls-container {
                gap: 1rem;
            }

            .filter-buttons {
                width: 100%;
                gap: 0.5rem;
            }

            .btn-filter {
                flex: 1;
                min-width: calc(50% - 0.25rem);
            }

            table thead th,
            table tbody td {
                padding: 0.8rem 0.5rem;
                font-size: 0.85rem;
            }

            .btn-action {
                margin: 0 0.5rem;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content for Job Posting Management -->
        <div class="job-posting-container">
            <!-- Centered Header section -->
            <div class="header-section">
                <h2>✨ Quản lý đăng tin tuyển dụng</h2>
            </div>

            <!-- Search bar, Add New Job, and Filters -->
            <div class="controls-container">
                <!-- Add New Job Button -->
                <a href="${pageContext.request.contextPath}/AddJobPosting" class="btn-add-job">
                    <i class="fas fa-plus"></i> Thêm tin tuyển dụng
                </a>

                <!-- Filter Buttons -->
                <div class="filter-buttons">
                    <a href="${pageContext.request.contextPath}/jobPost?sort=title&order=ASC&page=1&searchJP=${searchJP}" class="btn-filter">
                        <i class="fas fa-arrow-up-a-z"></i> Sắp xếp A-Z
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/jobPost?sort=postedDate&order=DESC&page=1&searchJP=${searchJP}" class="btn-filter">
                        <i class="fas fa-calendar"></i> Ngày đăng mới nhất
                    </a>

                    <a href="${pageContext.request.contextPath}/jobPost?sort=status&order=ASC&page=1&searchJP=${searchJP}" class="btn-filter">
                        <i class="fas fa-filter"></i> Sắp xếp trạng thái
                    </a>
                </div>

                <!-- Search bar -->
                <form action="${pageContext.request.contextPath}/jobPost" method="get" class="search-container">
                    <input type="text" name="searchJP" class="search-box" placeholder="🔍 Tìm kiếm tiêu đề...">
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Table for displaying job postings -->
            <div class="table-wrapper">
                <c:choose>
                    <c:when test="${empty listJobPosting}">
                        <div class="no-data">
                            <h4>🔍 Không tìm thấy tin tuyển dụng</h4>
                            <p>Hãy thêm một tin tuyển dụng mới để bắt đầu</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Tiêu đề công việc</th>
                                    <th>Ngày đăng</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                    <th>Người ứng tuyển</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="i" items="${listJobPosting}">
                                    <tr>
                                        <td class="job-title">
                                            <c:if test="${i.getStatus() == 'Violate'}">
                                                <span class="job-title-violate">
                                                    ${i.getTitle()}
                                                    <i class="fas fa-exclamation-triangle" title="Violate"></i>
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
                                                <span class="status-active">${i.getStatus()}</span>
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
                                                <a href="${pageContext.request.contextPath}/applicationSeekers?action=view&jobPostId=${i.getJobPostingID()}" class="btn-action text-info">
                                                    📋 ${i.application.size()} người ứng tuyển
                                                </a>
                                            </c:if>

                                            <c:if test="${i.application.size() == 0}">
                                                <span>Chưa có người ứng tuyển</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Error message if no job postings found -->
            <c:if test="${not empty requestScope.NoJP}">
                <div class="error-message">${requestScope.NoJP}</div>
            </c:if>

            <!-- Pagination controls -->
            <nav class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage - 1}&sort=${sortField}&searchJP=${searchJP}">
                        « Trước
                    </a>
                </c:if>

                <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                <c:set var="endPage" value="${startPage + 4 <= totalPages ? startPage + 4 : totalPages}"/>

                <c:if test="${startPage > 1}">
                    <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${startPage - 1}&sort=${sortField}&searchJP=${searchJP}">...</a>
                </c:if>

                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <a class="page-link <c:if test='${i == currentPage}'>active</c:if>" 
                       href="${pageContext.request.contextPath}/jobPost?page=${i}&sort=${sortField}&searchJP=${searchJP}">
                        ${i}
                    </a>
                </c:forEach>

                <c:if test="${endPage < totalPages}">
                    <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${endPage + 1}&sort=${sortField}&searchJP=${searchJP}">...</a>
                </c:if>

                <c:if test="${currentPage < totalPages}">
                    <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage + 1}&sort=${sortField}&searchJP=${searchJP}">
                        Sau »
                    </a>
                </c:if>
            </nav>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
    </div>

    <script>
        function showEditWarning() {
            alert("Không thể chỉnh sửa tin tuyển dụng này vì trạng thái là 'Violate'");
        }
    </script>
</body>
</html>