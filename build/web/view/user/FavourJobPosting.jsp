<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="model.JobPostings" %>
        <%@ page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Favourite Jobs - Jobbies</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

                            0%,
                            100% {
                                opacity: 0.3;
                            }

                            50% {
                                opacity: 1;
                            }
                        }

                        .pixel-decoration {
                            position: fixed;
                            font-size: 3rem;
                            opacity: 0.3;
                            z-index: 5;
                            animation: float 4s ease-in-out infinite;
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

                        .container {
                            position: relative;
                            z-index: 10;
                            max-width: 1200px;
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        .page-title {
                            font-size: 2.5rem;
                            font-weight: 900;
                            margin-bottom: 2rem;
                            text-align: center;
                            background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        .alert {
                            padding: 1rem 1.5rem;
                            border-radius: 15px;
                            margin-bottom: 2rem;
                            display: flex;
                            align-items: center;
                            gap: 0.8rem;
                            animation: slideIn 0.3s ease-out;
                        }

                        @keyframes slideIn {
                            from {
                                opacity: 0;
                                transform: translateY(-20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .alert-danger {
                            background: rgba(255, 107, 107, 0.2);
                            border: 1px solid #ff6b6b;
                            color: #ff6b6b;
                        }

                        .alert-success {
                            background: rgba(57, 255, 20, 0.2);
                            border: 1px solid #39ff14;
                            color: #39ff14;
                        }

                        .table-container {
                            background: rgba(255, 255, 255, 0.05);
                            backdrop-filter: blur(20px);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 20px;
                            overflow: hidden;
                            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
                            margin-bottom: 2rem;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        thead {
                            background: rgba(196, 113, 245, 0.2);
                        }

                        th {
                            padding: 1.2rem;
                            text-align: left;
                            font-weight: 700;
                            color: #fff;
                            text-transform: uppercase;
                            font-size: 0.85rem;
                            letter-spacing: 1px;
                        }

                        tbody tr {
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            transition: all 0.3s;
                        }

                        tbody tr:hover {
                            background: rgba(196, 113, 245, 0.1);
                        }

                        td {
                            padding: 1.2rem;
                            color: #e0e0e0;
                        }

                        .job-title {
                            font-weight: 600;
                            font-size: 1.1rem;
                        }

                        .btn {
                            padding: 0.6rem 1.2rem;
                            border: none;
                            border-radius: 10px;
                            font-weight: 700;
                            cursor: pointer;
                            transition: all 0.3s;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            font-size: 0.9rem;
                            margin-right: 0.5rem;
                        }

                        .btn-view {
                            background: rgba(126, 232, 250, 0.2);
                            color: #7ee8fa;
                            border: 1px solid #7ee8fa;
                        }

                        .btn-view:hover {
                            background: rgba(126, 232, 250, 0.3);
                            transform: translateY(-2px);
                            box-shadow: 0 5px 15px rgba(126, 232, 250, 0.4);
                        }

                        .btn-view:disabled {
                            opacity: 0.5;
                            cursor: not-allowed;
                        }

                        .btn-unlike {
                            background: rgba(255, 107, 107, 0.2);
                            color: #ff6b6b;
                            border: 1px solid #ff6b6b;
                        }

                        .btn-unlike:hover {
                            background: rgba(255, 107, 107, 0.3);
                            transform: translateY(-2px);
                            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
                        }

                        .badge-warning {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.5rem 1rem;
                            background: rgba(255, 193, 7, 0.2);
                            color: #ffc107;
                            border: 1px solid #ffc107;
                            border-radius: 20px;
                            font-size: 0.85rem;
                            font-weight: 600;
                            margin-left: 0.5rem;
                        }

                        .modal {
                            display: none;
                            position: fixed;
                            z-index: 1000;
                            left: 0;
                            top: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.7);
                            backdrop-filter: blur(10px);
                            animation: fadeIn 0.3s ease-out;
                        }

                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                            }

                            to {
                                opacity: 1;
                            }
                        }

                        .modal.show {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }

                        .modal-content {
                            background: rgba(26, 11, 46, 0.95);
                            backdrop-filter: blur(20px);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 20px;
                            padding: 2rem;
                            max-width: 500px;
                            width: 90%;
                            animation: slideUp 0.3s ease-out;
                        }

                        @keyframes slideUp {
                            from {
                                opacity: 0;
                                transform: translateY(50px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .modal-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 1.5rem;
                            padding-bottom: 1rem;
                            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        }

                        .modal-title {
                            font-size: 1.5rem;
                            font-weight: 700;
                            background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        .modal-close {
                            background: none;
                            border: none;
                            color: #fff;
                            font-size: 1.5rem;
                            cursor: pointer;
                            transition: all 0.3s;
                        }

                        .modal-close:hover {
                            color: #ff6b6b;
                            transform: rotate(90deg);
                        }

                        .modal-body {
                            color: #e0e0e0;
                            margin-bottom: 1.5rem;
                            line-height: 1.6;
                        }

                        .modal-footer {
                            display: flex;
                            gap: 1rem;
                            justify-content: flex-end;
                        }

                        .btn-secondary {
                            background: rgba(255, 255, 255, 0.1);
                            color: #fff;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                        }

                        .btn-secondary:hover {
                            background: rgba(255, 255, 255, 0.15);
                        }

                        .btn-danger {
                            background: linear-gradient(135deg, #ff6b6b, #ff5252);
                            color: #fff;
                        }

                        .btn-danger:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 5px 20px rgba(255, 107, 107, 0.5);
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

                        .empty-state {
                            text-align: center;
                            padding: 4rem 2rem;
                            color: #b8b8d1;
                        }

                        .empty-state i {
                            font-size: 4rem;
                            margin-bottom: 1rem;
                            opacity: 0.5;
                        }

                        @media (max-width: 768px) {
                            .container {
                                padding: 1rem;
                            }

                            .table-container {
                                overflow-x: auto;
                            }

                            th,
                            td {
                                padding: 0.8rem;
                                font-size: 0.9rem;
                            }

                            .btn {
                                padding: 0.5rem 0.8rem;
                                font-size: 0.85rem;
                            }

                            .badge-warning {
                                display: block;
                                margin: 0.5rem 0 0 0;
                            }
                        }
                    </style>
                </head>

                <body>
                    <div class="stars" id="stars"></div>

                    <div class="pixel-decoration deco-1">✨</div>
                    <div class="pixel-decoration deco-2">💎</div>
                    <div class="pixel-decoration deco-3">🚀</div>

                    <!-- Header -->
                    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

                    <div class="container">
                        <h1 class="page-title">Trang Yêu thích 💖</h1>

                        <!-- Alert Messages -->
                        <c:if test="${not empty errorFavourJP}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i>
                                ${errorFavourJP}
                            </div>
                        </c:if>

                        <c:if test="${not empty successFavourJP}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i>
                                ${successFavourJP}
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty favourJPs}">
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Tiêu đề công việc</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="fjp" items="${favourJPs}">
                                                <tr>
                                                    <td class="job-title">
                                                        <c:out value="${jobPostingMap[fjp.favourJPID]}" />
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-view"
                                                            onclick="window.location.href='${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${fjp.jobPostingID}'"
                                                            <c:if
                                                            test="${favourJPMap[fjp.favourJPID] == 'Violate'}">disabled
                                                            </c:if>>
                                                            <i class="fas fa-eye"></i>
                                                            View
                                                        </button>

                                                        <button type="button" class="btn btn-unlike"
                                                            onclick="openModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                            <i class="fas fa-heart-broken"></i>
                                                            Unlike
                                                        </button>

                                                        <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">
                                                            <span class="badge-warning">
                                                                <i class="fas fa-exclamation-triangle"></i>
                                                                Job Violated
                                                            </span>
                                                        </c:if>
                                                    </td>
                                                </tr>

                                                <!-- Modal for Unlike Confirmation -->
                                                <div class="modal" id="deleteFavourJPModal-${fjp.favourJPID}">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Không thích công việc</h5>
                                                            <button type="button" class="modal-close"
                                                                onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </div>
                                                        <form
                                                            action="${pageContext.request.contextPath}/FavourJobPosting"
                                                            method="post">
                                                            <div class="modal-body">
                                                                <p>Bạn có chắc không thích công việc này không?</p>
                                                                <input type="hidden" name="action"
                                                                    value="delete-favourJP">
                                                                <input type="hidden" name="favourJPId"
                                                                    value="${fjp.favourJPID}">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary"
                                                                    onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                    Hủy
                                                                </button>
                                                                <button type="submit" class="btn btn-danger">
                                                                    <i class="fas fa-heart-broken"></i>
                                                                    Xác nhận
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <nav class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage - 1}"
                                            class="page-button">
                                            « Previous
                                        </a>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${i}"
                                            class="page-button ${i == currentPage ? 'active' : ''}">
                                            ${i}
                                        </a>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/FavourJobPosting?page=${currentPage + 1}"
                                            class="page-button">
                                            Next »
                                        </a>
                                    </c:if>
                                </nav>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-heart-broken"></i>
                                    <h3>Chưa có công việc yêu thích</h3>
                                    <p>Bắt đầu tìm kiếm và lưu công việc yêu thích đi !</p>
                                    <a href="${pageContext.request.contextPath}/HomeSeeker" class="btn btn-view">
                                        <i class="fas fa-search"></i>
                                        Tìm việc
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Footer -->
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

                        // Modal functions
                        function openModal(modalId) {
                            document.getElementById(modalId).classList.add('show');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeModal(modalId) {
                            document.getElementById(modalId).classList.remove('show');
                            document.body.style.overflow = 'auto';
                        }

                        // Close modal when clicking outside
                        window.onclick = function (event) {
                            if (event.target.classList.contains('modal')) {
                                event.target.classList.remove('show');
                                document.body.style.overflow = 'auto';
                            }
                        }

                        // Close modal on ESC key
                        document.addEventListener('keydown', function (event) {
                            if (event.key === 'Escape') {
                                const modals = document.querySelectorAll('.modal.show');
                                modals.forEach(modal => {
                                    modal.classList.remove('show');
                                });
                                document.body.style.overflow = 'auto';
                            }
                        });
                    </script>
                </body>

                </html>