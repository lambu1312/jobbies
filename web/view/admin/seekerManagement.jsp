<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Candidate Management - Jobbies</title>

            <!--css-->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous">
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

            <!-- Add custom styles -->
            <style>
                /* Candidate Management Page - White Background Theme */

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', system-ui, sans-serif;
                    background: #f8f9fa !important;
                    color: #212529;
                    overflow-x: hidden;
                    min-height: 100vh;
                }

                /* Main Content Area */
                .container-fluid {
                    position: relative;
                    z-index: 10;
                }

                /* Fix column layout */
                .col-md-2 {
                    padding: 0;
                }

                .col-md-10 {
                    padding: 2rem;
                    background: #ffffff;
                    min-height: 100vh;
                }

                /* Page Title */
                h6.fs-2 {
                    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    font-weight: 900;
                    margin-bottom: 2rem;
                    text-align: center;
                }

                /* Filter Section */
                .filter-dropdown {
                    background: #ffffff;
                    border: 2px solid #dee2e6;
                    border-radius: 15px;
                    padding: 1rem 1.5rem;
                    display: inline-flex;
                    align-items: center;
                    gap: 1rem;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                }

                .filter-dropdown label {
                    color: #495057;
                    font-weight: 600;
                    margin: 0;
                }

                .filter-dropdown select {
                    background: #f8f9fa;
                    border: 1px solid #ced4da;
                    border-radius: 10px;
                    color: #495057;
                    padding: 0.6rem 1.2rem;
                    outline: none;
                    transition: all 0.3s;
                    font-weight: 500;
                }

                .filter-dropdown select:focus {
                    border-color: #c471f5;
                    box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.25);
                    background: #ffffff;
                }

                .filter-dropdown select option {
                    background: #ffffff;
                    color: #212529;
                }

                /* Search Section */
                #searchCandidate {
                    background: #ffffff !important;
                    border: 2px solid #dee2e6 !important;
                    border-radius: 30px !important;
                    color: #212529 !important;
                    padding: 1rem 2rem !important;
                    font-size: 1rem;
                    outline: none;
                    transition: all 0.3s;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                }

                #searchCandidate:focus {
                    border-color: #c471f5 !important;
                    box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.25) !important;
                    background: #ffffff !important;
                }

                #searchCandidate::placeholder {
                    color: #6c757d;
                }

                /* Buttons */
                .btn-primary {
                    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                    border: none !important;
                    border-radius: 30px !important;
                    padding: 1rem 2rem !important;
                    font-weight: 700 !important;
                    color: #ffffff !important;
                    transition: all 0.3s !important;
                    box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3) !important;
                }

                .btn-primary:hover {
                    transform: translateY(-2px) !important;
                    box-shadow: 0 6px 20px rgba(196, 113, 245, 0.4) !important;
                }

                /* Table Styling */
                .table-bordered {
                    background: #ffffff !important;
                    border: 2px solid #dee2e6 !important;
                    border-radius: 15px;
                    overflow: hidden;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                }

                .table-bordered thead th {
                    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                    color: #ffffff !important;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                    padding: 1.2rem;
                    border: none !important;
                    font-size: 0.9rem;
                }

                .table-bordered tbody {
                    background: #ffffff;
                }

                .table-bordered tbody tr {
                    border-bottom: 1px solid #e9ecef !important;
                    transition: all 0.2s;
                }

                .table-bordered tbody tr:hover {
                    background: #f8f4ff;
                }

                .table-bordered tbody td {
                    color: #212529 !important;
                    padding: 1.2rem;
                    vertical-align: middle;
                    border: none !important;
                }

                /* Avatar Styling */
                .candidate-avatar {
                    width: 50px !important;
                    height: 50px !important;
                    border-radius: 50% !important;
                    border: 2px solid #c471f5 !important;
                    box-shadow: 0 2px 8px rgba(196, 113, 245, 0.3) !important;
                    object-fit: cover;
                }

                /* Switch Toggle */
                .form-check {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .form-check-input {
                    width: 3rem !important;
                    height: 1.5rem !important;
                    background-color: #e9ecef !important;
                    border: 1px solid #ced4da !important;
                    cursor: pointer;
                }

                .form-check-input:checked {
                    background-color: #28a745 !important;
                    border-color: #28a745 !important;
                }

                .form-check-input:focus {
                    box-shadow: 0 0 0 0.25rem rgba(196, 113, 245, 0.25) !important;
                    border-color: #c471f5 !important;
                }

                /* View Button */
                .btn-info {
                    background: linear-gradient(135deg, #7ee8fa 0%, #5ec9db 100%) !important;
                    border: none !important;
                    border-radius: 10px !important;
                    padding: 0.5rem 1rem !important;
                    color: #000000 !important;
                    font-weight: 700 !important;
                    transition: all 0.3s !important;
                    box-shadow: 0 3px 10px rgba(126, 232, 250, 0.3) !important;
                }

                .btn-info:hover {
                    transform: translateY(-2px) !important;
                    box-shadow: 0 5px 15px rgba(126, 232, 250, 0.4) !important;
                }

                /* Pagination */
                .pagination {
                    margin-top: 2rem;
                    gap: 0.5rem;
                }

                .page-item .page-link {
                    background: #ffffff !important;
                    border: 2px solid #dee2e6 !important;
                    border-radius: 8px;
                    color: #495057 !important;
                    padding: 0.5rem 0.9rem;
                    margin: 0 0.2rem;
                    transition: all 0.3s;
                    font-weight: 600;
                }

                .page-item .page-link:hover {
                    background: #f8f4ff !important;
                    border-color: #c471f5 !important;
                    color: #c471f5 !important;
                }

                .page-item.active .page-link {
                    background: linear-gradient(135deg, #c471f5, #fa71cd) !important;
                    border-color: transparent !important;
                    color: #ffffff !important;
                    box-shadow: 0 3px 10px rgba(196, 113, 245, 0.3);
                }

                /* HR Divider */
                hr {
                    border: none;
                    height: 2px;
                    background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.3), transparent);
                    margin: 1.5rem 0;
                }

                /* Back to Top Button */
                #rts-back-to-top {
                    position: fixed !important;
                    bottom: 20px !important;
                    right: 20px !important;
                    background: linear-gradient(135deg, #c471f5, #fa71cd) !important;
                    border: none !important;
                    border-radius: 50% !important;
                    width: 50px !important;
                    height: 50px !important;
                    display: flex !important;
                    align-items: center !important;
                    justify-content: center !important;
                    box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4) !important;
                    cursor: pointer !important;
                    transition: all 0.3s !important;
                    z-index: 999 !important;
                    color: #ffffff !important;
                }

                #rts-back-to-top:hover {
                    transform: translateY(-5px) !important;
                    box-shadow: 0 6px 20px rgba(196, 113, 245, 0.5) !important;
                }

                /* Loading Animation */
                .loader-wrapper {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: #ffffff;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 9999;
                }

                .loader {
                    width: 50px;
                    height: 50px;
                    border: 4px solid #f3f3f3;
                    border-top-color: #c471f5;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                }

                @keyframes spin {
                    to {
                        transform: rotate(360deg);
                    }
                }

                /* Custom Scrollbar */
                ::-webkit-scrollbar {
                    width: 10px;
                }

                ::-webkit-scrollbar-track {
                    background: #f1f1f1;
                }

                ::-webkit-scrollbar-thumb {
                    background: linear-gradient(135deg, #c471f5, #fa71cd);
                    border-radius: 10px;
                }

                ::-webkit-scrollbar-thumb:hover {
                    background: linear-gradient(135deg, #fa71cd, #c471f5);
                }

                /* Responsive Design */
                @media (max-width: 768px) {
                    .col-md-10 {
                        padding: 1rem;
                    }

                    .filter-dropdown {
                        flex-direction: column;
                        align-items: flex-start;
                        width: 100%;
                    }

                    #searchCandidate {
                        width: 100% !important;
                    }

                    .table-bordered {
                        font-size: 0.85rem;
                    }

                    .candidate-avatar {
                        width: 40px !important;
                        height: 40px !important;
                    }

                    h6.fs-2 {
                        font-size: 1.5rem !important;
                    }
                }

                /* Remove old green styles */
                .candidate-status.active,
                .candidate-status.inactive {
                    display: none;
                }
            </style>
        </head>

        <body>
            <!-- Stars Background -->
            <div class="stars" id="stars"></div>

            <!-- content area -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-2">
                        <!--Side bar-->
                        <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                        <!--side bar-end-->
                    </div>

                    <div class="col-md-10">
                        <!--content-main-->
                        <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                            <div class="dash__content">
                                <div class="dash__overview">
                                    <h6 class="fw-medium mb-30 text-center fs-2">CANDIDATE ACCOUNT MANAGEMENT</h6>

                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <!--drop-down filter candidate-->
                                        <div class="filter-dropdown">
                                            <form action="${pageContext.request.contextPath}/candidates" method="GET">
                                                <label for="candidate-filter">Filter</label>
                                                <select id="candidate-filter" name="filter"
                                                    onchange="this.form.submit()">
                                                    <option value="all" ${param.filter==null || param.filter=='all'
                                                        ? 'selected' : '' }>All Candidates</option>
                                                    <option value="active" ${param.filter=='active' ? 'selected' : '' }>
                                                        Active Candidates</option>
                                                    <option value="inactive" ${param.filter=='inactive' ? 'selected'
                                                        : '' }>Inactive Candidates</option>
                                                </select>
                                            </form>
                                        </div>
                                    </div>

                                    <hr />

                                    <!--search candidate-->
                                    <form action="${pageContext.request.contextPath}/candidates" method="GET">
                                        <div class="d-flex justify-content-center mb-3">
                                            <input type="hidden" name="filter"
                                                value="${param.filter != null ? param.filter : 'all'}">
                                            <input type="text" id="searchCandidate" name="searchQuery"
                                                class="form-control" style="width: 60%;"
                                                placeholder="Search for name/email...">
                                            <button type="submit" class="btn btn-primary ms-2">Search</button>
                                        </div>
                                    </form>

                                    <!--Table-->
                                    <div class="candidate-list">
                                        <table class="table table-bordered" style="text-align: center;">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Avatar</th>
                                                    <th>Full Name</th>
                                                    <th>Email</th>
                                                    <th>Status Account</th>
                                                    <th>View</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${listSeekers}" var="seeker">
                                                    <tr>
                                                        <td>${seeker.getId()}</td>
                                                        <td>
                                                            <c:if test="${empty seeker.getAvatar()}">
                                                                <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png"
                                                                    alt="Avatar" class="candidate-avatar">
                                                            </c:if>
                                                            <c:if test="${not empty seeker.getAvatar()}">
                                                                <img src="${seeker.getAvatar()}" alt="Avatar"
                                                                    class="candidate-avatar">
                                                            </c:if>
                                                        </td>
                                                        <td>${seeker.getFullName()}</td>
                                                        <td>${seeker.getEmail()}</td>
                                                        <td>
                                                            <div class="form-check form-switch">
                                                                <input class="form-check-input" type="checkbox"
                                                                    role="switch" id="flexSwitchCheck${seeker.id}"
                                                                    ${seeker.isActive ? 'checked' : '' }
                                                                    data-seeker-id="${seeker.id}">
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <form action="candidates?action=view-detail" method="POST">
                                                                <input type="hidden" name="id-seeker"
                                                                    value="${seeker.getId()}">
                                                                <button class="btn btn-info" type="submit">
                                                                    <i class="fa fa-eye"></i>
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                        <!-- Pagination -->
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination justify-content-center" id="pagination">
                                                <c:if test="${pageControl.getPage() > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo; Previous</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:set var="startPage"
                                                    value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}" />
                                                <c:set var="endPage"
                                                    value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}" />

                                                <c:if test="${startPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${startPage-1}">...</a>
                                                    </li>
                                                </c:if>

                                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                    <li
                                                        class="page-item <c:if test='${i == pageControl.getPage()}'>active</c:if>">
                                                        <a class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:if test="${endPage < pageControl.getTotalPages()}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${endPage + 1}">...</a>
                                                    </li>
                                                </c:if>

                                                <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">Next &raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Back to Top Button -->
                    <button type="button" class="btn btn-primary" id="rts-back-to-top">
                        <i class="fas fa-arrow-up"></i>
                    </button>
                </div>
            </div>

            <!-- THEME PRELOADER START -->
            <div class="loader-wrapper">
                <div class="loader"></div>
            </div>
            <!-- THEME PRELOADER END -->

            <!-- Scripts -->
            <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

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

                // Hide loader when page loads
                window.addEventListener('load', function () {
                    document.querySelector('.loader-wrapper').style.display = 'none';
                });

                // Status toggle AJAX
                $(document).ready(function () {
                    $('.form-check-input').change(function () {
                        var seekerId = $(this).data('seeker-id');
                        var isActive = this.checked;

                        $.ajax({
                            url: '${pageContext.request.contextPath}/candidates',
                            type: 'POST',
                            data: {
                                action: isActive ? 'active' : 'deactive',
                                'id-seeker': seekerId
                            },
                            success: function (response) {
                                console.log('Seeker status updated successfully');
                            },
                            error: function (xhr, status, error) {
                                console.error('Error updating candidate status');
                                $(this).prop('checked', !isActive);
                            }
                        });
                    });

                    // Back to top button
                    $('#rts-back-to-top').click(function () {
                        $('html, body').animate({ scrollTop: 0 }, 600);
                    });
                });
            </script>
        </body>

        </html>