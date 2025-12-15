<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="model.JobPostings" %>
        <%@ page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="en">

            <div class="container mb-5 mt-5">
                <h1 class="text-center">Bài đăng tuyển dụng yêu thích của tôi</h1>

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

            <c:if test="${not empty favourJPs}">
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Chức danh công việc</th>
                            <th>Hoạt động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fjp" items="${favourJPs}">
                            <tr>

                                <td><c:out value="${jobPostingMap[fjp.favourJPID]}" /></td>
                                <td>
                                    <button type="button" 
                                            class="btn btn-info btn-sm" 
                                            onclick="window.location.href = '${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${fjp.jobPostingID}'"
                                            <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">disabled</c:if>>
                                                <i class="fa-solid fa-eye"></i> Xem
                                            </button> 
                                            <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteFavourJPModal-${fjp.favourJPID}">
                                                <i class="fa fa-trash"></i> Xóa Thích
                                            </button>
                                                <c:if test="${favourJPMap[fjp.favourJPID] == 'Violate'}">
                                        <span class="badge bg-warning text-dark"><i class="fa-solid fa-triangle-exclamation"></i> Thông báo tuyển dụng này vi phạm quy định!</span>
                                    </c:if>
                                    </td>
                                    
                                </tr>

                                <!-- Modal for Cancel Application -->
                            <div class="modal fade" id="deleteFavourJPModal-${fjp.favourJPID}" tabindex="-1" aria-labelledby="cancelModalLabel-${app.applicationID}" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteFavourJPModal-${fjp.favourJPID}">Bỏ Bài Đăng Tuyển Dụng</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/FavourJobPosting" method="post">
                                        <div class="modal-body">
                                            <p>Bạn có chắc chắn muốn bỏ thích tin tuyển dụng này không?</p>
                                            <input type="hidden" name="action" value="delete-favourJP">
                                            <input type="hidden" name="favourJPId" value="${fjp.favourJPID}">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-danger">Xác nhận Không thích</button>
                                        </div>
                                    </form>
                                </div>
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
                                                <th>Job Title</th>
                                                <th>Actions</th>
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
                                                            <h5 class="modal-title">Unlike Job Posting</h5>
                                                            <button type="button" class="modal-close"
                                                                onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </div>
                                                        <form
                                                            action="${pageContext.request.contextPath}/FavourJobPosting"
                                                            method="post">
                                                            <div class="modal-body">
                                                                <p>Are you sure you want to unlike this job posting?</p>
                                                                <input type="hidden" name="action"
                                                                    value="delete-favourJP">
                                                                <input type="hidden" name="favourJPId"
                                                                    value="${fjp.favourJPID}">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary"
                                                                    onclick="closeModal('deleteFavourJPModal-${fjp.favourJPID}')">
                                                                    Cancel
                                                                </button>
                                                                <button type="submit" class="btn btn-danger">
                                                                    <i class="fas fa-heart-broken"></i>
                                                                    Confirm Unlike
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
                                    <h3>No Favourite Jobs Yet</h3>
                                    <p>Start exploring and save your favourite job postings!</p>
                                    <a href="${pageContext.request.contextPath}/HomeSeeker" class="btn btn-view">
                                        <i class="fas fa-search"></i>
                                        Browse Jobs
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