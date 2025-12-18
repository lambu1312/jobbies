<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <script src="https://cdn.tiny.cloud/1/vaugmbxpwey72le9o04xzdbx0pb0cgxv4ysvnlmu1qnlmngd/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Add custom styles -->
        <style>
/* Recruiter Management Page - White Background Theme */

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
#searchRecruiter {
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

#searchRecruiter:focus {
    border-color: #c471f5 !important;
    box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.25) !important;
    background: #ffffff !important;
}

#searchRecruiter::placeholder {
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

.btn-success {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
    border: none !important;
    border-radius: 30px !important;
    padding: 1rem 2rem !important;
    font-weight: 700 !important;
    color: #ffffff !important;
    transition: all 0.3s !important;
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3) !important;
}

.btn-success:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4) !important;
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
.seeker-avatar {
    width: 50px !important;
    height: 50px !important;
    border-radius: 50% !important;
    border: 2px solid #c471f5 !important;
    box-shadow: 0 2px 8px rgba(196, 113, 245, 0.3) !important;
    object-fit: cover;
}

/* Status Badges */
.status-approved {
    background-color: rgba(25, 135, 84, 0.15);
    color: #198754;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 0.85rem;
    border: 1px solid #198754;
}

.status-pending {
    background-color: rgba(220, 53, 69, 0.15);
    color: #dc3545;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 0.85rem;
    border: 1px solid #dc3545;
}

.status-not-yet {
    background-color: rgba(255, 193, 7, 0.15);
    color: #ffc107;
    padding: 6px 12px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 0.85rem;
    border: 1px solid #ffc107;
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
.rts__back__top {
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

.rts__back__top:hover {
    transform: translateY(-5px) !important;
    box-shadow: 0 6px 20px rgba(196, 113, 245, 0.5) !important;
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
    to { transform: rotate(360deg); }
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

    #searchRecruiter {
        width: 100% !important;
    }

    .table-bordered {
        font-size: 0.85rem;
    }

    .seeker-avatar {
        width: 40px !important;
        height: 40px !important;
    }

    h6.fs-2 {
        font-size: 1.5rem !important;
    }
}

/* Remove old status styles */
.recruiter-status.active,
.recruiter-status.inactive {
    display: none;
}
</style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
            <!-- content area -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-2">
                        <!--Side bar-->
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                        <!--side bar-end-->
                    </div>


                    <div class="col-md-10">

                        <!--content-main can fix-->
                        <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                            <div class="dash__content">
                                <!-- sidebar menu -->
                                <div class="sidebar__menu d-md-block d-lg-none">
                                    <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                                </div>
                                <!-- sidebar menu end -->
                                <div class="dash__overview">

                                    <h6 class="fw-medium mb-30 text-center fs-2">QUẢN LÝ CÔNG TY</h6>


                                    <!--drop-down filter company-->
                                    <div class="d-flex justify-content-between align-items-center mb-3 ms-2">
                                    <!-- Error message and Add button -->
                                    <div class="d-flex align-items-center">
                                        <!-- Error message (displayed in red) -->
                                        <span class="text-danger me-3">${requestScope.notice}</span>


                                    </div>
                                </div>

                                <hr/>
                                <!--search company-->
                                <form action="${pageContext.request.contextPath}/companies" method="GET" >
                                    <div class="d-flex justify-content-center mb-3">
                                        <div action="${pageContext.request.contextPath}/companies" method="GET" class="d-flex align-items-center">
                                        <label for="company-filter" class="me-2">Filter</label>
                                        <select id="company-filter" name="filter" class="form-select me-3" onchange="this.form.submit()">
                                            <option value="all" ${param.filter == null || param.filter == 'all' ? 'selected' : ''}>Toàn bộ công ty</option>
                                            <option value="accept" ${param.filter == 'accept' ? 'selected' : ''}>Công ty hoạt động</option>
                                            <option value="violate" ${param.filter == 'violate' ? 'selected' : ''}>Công ty không hoạt động</option>
                                        </select>
                                    </div>
                                        <input type="hidden" name="filter" value="${param.filter != null ? param.filter : 'all'}"> <!-- Thay đổi tại đây -->
                                        <input type="text" id="searchCompany"  name="searchQuery" class="form-control" style="width: 60%;" placeholder="Tìm theo tên công ty...">
                                        <button type="submit" class="btn btn-primary ms-2">Tìm</button>
                                    </div>
                                </form>

                                <!--search company end-->

                                <div class="seeker-list">
                                    <table class="table table-bordered" style="text-align: center; vertical-align: middle;">
                                        <thead>
                                            <tr>
                                                <th>Tên Công Ty</th>
                                                <th>Người Tạo</th>
                                                <th>Trạng Thái</th>
                                                <th>Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Table rows will go here (populated dynamically) -->
                                            <%
                                                Account account = new Account();
                                                AccountDAO accDao = new AccountDAO();
                                            %>
                                            <c:forEach items="${listCompanies}" var="company">
                                                <c:set var="accountId" value="${company.getAccountId()}"/>
                                                <tr>
                                                    <!-- CompanyName Column -->

                                                    <td>
                                                        ${company.getName()}
                                                    </td>
                                                    <td>
                                                        <%
                                                        int accountId = (Integer) pageContext.getAttribute("accountId");
                                                        account = accDao.findUserById(accountId);
                                                        String name = "";
                                                        if(account != null){
                                                         name = account.getFullName();
                                                        
                                                        }else{
                                                         name = "not registered";
                                                            }
                                                        %>
                                                        <%= name%>
                                                    </td>
                                                    <!-- Status Column -->
                                                    <td>
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" role="switch" 
                                                                   id="flexSwitchCheck${company.id}" 
                                                                   ${company.verificationStatus ? 'checked' : ''} 
                                                                   data-company-id="${company.id}">
                                                            <label class="form-check-label" for="flexSwitchCheck${company.id}"></label>
                                                        </div>
                                                    </td>
                                                    <!--Edit Column-->
                                                    <td>


                                                        <!-- Nút View với biểu tượng con mắt -->
                                                        <a href="${pageContext.request.contextPath}/companies?action=view&id=${company.id}" class="btn btn-primary me-2">
                                                            <i class="fas fa-eye"></i> 
                                                        </a>
                                                    </td>

                                                </tr>
                                                <!--Modal Edit Company--> 

                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Pagination -->
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center" id="pagination">
                                            <c:if test="${pageControl.getPage() > 1}">
                                                <li class="page-item">
                                                    <a
                                                        class="page-link"
                                                        href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}"
                                                        aria-label="Previous"
                                                        >
                                                        <span aria-hidden="true">&laquo; Previous</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <!-- Tính toán để chỉ hiển thị 5 trang tại một thời điểm -->
                                            <c:set
                                                var="startPage"
                                                value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"
                                                />
                                            <c:set
                                                var="endPage"
                                                value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"
                                                />
                                            <!-- Nút để quay lại nhóm trang trước (nếu có) -->
                                            <c:if test="${startPage > 1}">
                                                <li class="page-item">
                                                    <a
                                                        class="page-link"
                                                        href="${pageControl.getUrlPattern()}page=${startPage-1}"
                                                        >...</a
                                                    >
                                                </li>
                                            </c:if>
                                            <!-- Hiển thị các trang trong khoảng từ startPage đến endPage -->
                                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                                <li
                                                    class="page-item <c:if test='${i == pageControl.getPage()}'>active</c:if>"
                                                        >
                                                        <a
                                                            class="page-link"
                                                            href="${pageControl.getUrlPattern()}page=${i}"
                                                        >${i}</a
                                                    >
                                                </li>
                                            </c:forEach>
                                            <!-- Nút để chuyển sang nhóm trang tiếp theo (nếu có) -->
                                            <c:if test="${endPage < pageControl.getTotalPages()}">
                                                <li class="page-item">
                                                    <a
                                                        class="page-link"
                                                        href="${pageControl.getUrlPattern()}page=${endPage + 1}"
                                                        >...</a
                                                    >
                                                </li>
                                            </c:if>
                                            <!-- Nút Next để đi đến nhóm trang tiếp theo -->
                                            <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                                <li class="page-item">
                                                    <a
                                                        class="page-link"
                                                        href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}"
                                                        aria-label="Next"
                                                        >
                                                        <span aria-hidden="true">Next &raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>


                                    <!-- Add more seekers here -->
                                </div>
                            </div>
                        </div>
                        <!-- content area end -->

                    </div>
                    <!-- Back to Top Button -->
                    <button type="button" class="btn btn-primary position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
                        <i class="fas fa-arrow-up"></i>
                    </button>

                    <!-- Footer -->

                </div>
            </div>
        </div>



        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
            <div class="offcanvas-header p-0 mb-5 mt-4">
                <a href="index.html" class="offcanvas-title" id="offcanvasLabel">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" alt="logo">
                </a> 
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <!-- login offcanvas -->
            <div class="mb-4 d-block d-sm-none">
                <div class="header__right__btn d-flex justify-content-center gap-3">
                    <!--                    <a href="#" class="small__btn no__fill__btn border-6 font-xs" aria-label="Login Button" data-bs-toggle="modal" data-bs-target="#loginModal"> <i class="rt-login"></i>Sign In</a>-->
                    <a href="#" class="small__btn d-xl-flex fill__btn border-6 font-xs" aria-label="Job Posting Button">Add Job</a>
                </div>
            </div>
            <div class="offcanvas-body p-0">
                <div class="rts__offcanvas__menu overflow-hidden">
                    <div class="offcanvas__menu"></div>
                </div>
                <p class="max-auto font-20 fw-medium text-center text-decoration-underline mt-4">Our Social Links</p>
                <div class="rts__social d-flex justify-content-center gap-3 mt-3">
                    <a href="https://facebook.com"  aria-label="facebook">
                        <i class="fa-brands fa-facebook"></i>
                    </a>
                    <a href="https://instagram.com"  aria-label="instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="https://linkedin.com"  aria-label="linkedin">
                        <i class="fa-brands fa-linkedin"></i>
                    </a>
                    <a href="https://pinterest.com"  aria-label="pinterest">
                        <i class="fa-brands fa-pinterest"></i>
                    </a>
                    <a href="https://youtube.com"  aria-label="youtube">
                        <i class="fa-brands fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
        <!-- THEME PRELOADER START -->
        <div class="loader-wrapper">
            <div class="loader">
            </div>
            <div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>
        </div>
        <!-- THEME PRELOADER END -->
        <button type="button" class="rts__back__top" id="rts-back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>
        <!-- all plugin js -->
        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                                            $(document).ready(function () {
                                                $('.form-check-input').change(function () {
                                                    var companyId = $(this).data('company-id');
                                                    var isActive = this.checked;
                                                    var label = $(this).siblings('.form-check-label');

                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/companies',
                                                        type: 'POST',
                                                        data: {
                                                            action: isActive ? 'accept' : 'violate',
                                                            'id-company': companyId
                                                        },
                                                        success: function (response) {
                                                            console.log('Company status updated successfully');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error updating company status');
                                                            $(this).prop('checked', !isActive);
                                                        }
                                                    });
                                                });
                                            });
        </script>

        <script>
            tinymce.init({
                selector: 'textarea', // Initialize TinyMCE for all text areas
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                menubar: true, // Disable the menubar
                branding: false, // Disable the TinyMCE branding
                height: 300, // Set the height of the editor
                setup: function (editor) {
                    editor.on('change', function () {
                        tinymce.triggerSave(); // Synchronize TinyMCE content with the form
                    });
                }
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>
