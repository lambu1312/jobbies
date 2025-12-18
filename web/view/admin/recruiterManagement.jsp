<%-- 
    Document   : recruiterManagement
    Created on : Sep 15, 2024, 4:26:38 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CompanyDAO"%>
<%@page import="dao.RecruitersDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Recruiters"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Add custom styles -->
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
                        <!--tao doi tuong companyDao de lay ve ten company-->

                        <!--end-->
                        <h6 class="fw-medium mb-30 text-center fs-2">QUẢN LÝ TÀI KHOẢN NHÀ TUYỂN DỤNG</h6>
                        <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                            <div class="dash__content">
                                <!-- sidebar menu -->
                                <div class="sidebar__menu d-md-block d-lg-none">
                                    <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                                </div>
                                <!-- sidebar menu end -->
                                <div class="d-flex justify-content-between align-items-center mb-3 ms-2">
                                    <!--drop-down filter recruiter-->
                                    <div class="filter-dropdown">
                                        <form action="${pageContext.request.contextPath}/recruiters" method="GET">
                                        <label for="recruiter-filter">Filter </label>
                                        <select id="recruiter-filter" name="filter" onchange="this.form.submit()">
                                            <option value="all" ${param.filter == null || param.filter == 'all' ? 'selected' : ''}>Toàn bộ tài khoản người tuyển dụng</option>
                                            <option value="active" ${param.filter == 'active' ? 'selected' : ''}>Tài khoản người tuyển dụng hoạt động</option>
                                            <option value="inactive" ${param.filter == 'inactive' ? 'selected' : ''}>Tài khoản người tuyển dụng không hoạt động</option>
                                        </select>
                                    </form>
                                </div>

                                <!-- Confirm Recruiter button -->
                                <form action="${pageContext.request.contextPath}/confirm" method="GET">
                                    <input type="hidden" name="action" value="confirm-recruiter">
                                    <button type="submit" class="btn btn-success">Xác nhận tài khoản người tuyển dụng</button>
                                </form>
                            </div>

                            <hr/>
                            <!--search recruiter-->
                            <form action="${pageContext.request.contextPath}/recruiters" method="GET">
                                <div class="d-flex justify-content-center mb-3">
                                    <input type="hidden" name="filter" value="${param.filter != null ? param.filter : 'all'}"> <!-- Thay đổi tại đây -->
                                    <input type="text" id="searchRecruiter"  name="searchQuery" class="form-control" style="width: 60%;" placeholder="Tìm theo tên/email...">
                                    <button type="submit" class="btn btn-primary ms-2">Tìm</button>
                                </div>
                            </form>

                            <!--search recruiter end-->
                            <div class="recruiter-list">
                                <table class="table table-bordered" style="text-align: center; vertical-align: middle;">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Avatar</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Công Ty</th>
                                            <th>Trạng thái xác nhận</th>
                                            <th>Trạng thái tài khoản</th>
                                            <th>Xem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Table rows will go here (populated dynamically) -->
                                        <%
                                         // Tạo một đối tượng CompanyDAO
                                            CompanyDAO companyDao = new CompanyDAO();
                                         // Tao mot doi tuong Recruiter
                                            RecruitersDAO recruitersDao = new RecruitersDAO();
                                        %>
                                        <c:forEach items="${listRecruiters}" var="recruiter">
                                            <c:set var="recruiterId" value="${recruiter.getId()}" />
                                            <tr>
                                                <td>${recruiter.getId()}</td>
                                                <!-- Avatar Column -->
                                                <td>
                                                    <c:if test="${empty recruiter.getAvatar()}">
                                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="seeker-avatar" style="width: 50px; height: 50px; border-radius: 50%;">
                                                    </c:if>
                                                    <c:if test="${not empty recruiter.getAvatar()}">
                                                        <img src="${recruiter.getAvatar()}" alt="Avatar" class="seeker-avatar" style="width: 50px; height: 50px; border-radius: 50%;">
                                                    </c:if>    
                                                </td>

                                                <!-- Full Name Column -->
                                                <td>${recruiter.getFullName()}</td>
                                                <td>${recruiter.getEmail()}</td>
                                                <!--Company Name Column-->
                                                <td>
                                                    <%
                                                        int recruiterAccountId = (Integer) pageContext.getAttribute("recruiterId");
                                                        List<Company> companies = companyDao.getCompanyNameByAccountId(recruiterAccountId);
                                                        String companyName = "";
                                                        String statusClassCom = "";
                                                        if (companies != null && !companies.isEmpty()) {
                                                            companyName = companies.get(0).getName(); // Lấy tên công ty từ danh sách
                                                        }else{
                                                            companyName = "Not yet registered";
                                                            statusClassCom = "status-not-yet";
                                                        }
                                                    %>
                                                    <span class="<%= statusClassCom %>"><%= companyName %></span> <!-- Hiển thị tên công ty -->
                                                </td>
                                                <!--verifiaction column-->
                                                <td>
                                                    <%
                                                    Recruiters recruiters = recruitersDao.findRecruitersbyAccountID(String.valueOf(recruiterAccountId));
                                                    String verification = "";
                                                    String statusClass = "";
                                                    if(recruiters != null){
                                                        verification = recruiters.isIsVerify() == true ? "Approved" : "Pending";
                                                        statusClass = recruiters.isIsVerify() == true ? "status-approved" : "status-pending";
                                                    }else{
                                                        verification = "None";
                                                        statusClass = "status-not-yet";
                                                        }
                                                    %>
                                                    <span class="<%= statusClass %>"><%= verification %></span>
                                                </td>
                                                <!-- Status Column -->
                                                <td>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheck${recruiter.id}" ${recruiter.isActive ? 'checked' : ''} data-recruiter-id="${recruiter.id}">
                                                        <label class="form-check-label" for="flexSwitchCheck${recruiter.id}"></label>
                                                    </div>
                                                </td>

                                                <!-- Action Column -->
                                                <td>
                                                    <form action="recruiters?action=view-detail" method="POST">
                                                        <input type="hidden" name="id-recruiter" value="${recruiter.getId()}">
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



                                <!-- Add more recruiters here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Theme Preloader End -->

    <!-- Back to Top Button -->
    <button type="button" class="rts__back__top" id="rts-back-to-top">
        <i class="fas fa-arrow-up"></i>
    </button>

    <!-- Include common JavaScript files -->
    <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>

        <!-- Custom script for recruiter status switcher -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                $('.form-check-input').change(function () {
                                                    var recruiterId = $(this).data('recruiter-id');
                                                    var isActive = this.checked;

                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/recruiters',
                                                        type: 'POST',
                                                        data: {
                                                            action: isActive ? 'active' : 'deactive',
                                                            'id-recruiter': recruiterId
                                                        },
                                                        success: function (response) {
                                                            console.log('Recruiter status updated successfully');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error updating recruiter status');
                                                            $(this).prop('checked', !isActive);
                                                        }
                                                    });
                                                });
                                            });
    </script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>

    // Back to top button functionality
    const backToTopBtn = document.getElementById('rts-back-to-top');
    
    if (backToTopBtn) {
        // Show/hide button on scroll
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopBtn.style.opacity = '1';
                backToTopBtn.style.visibility = 'visible';
            } else {
                backToTopBtn.style.opacity = '0';
                backToTopBtn.style.visibility = 'hidden';
            }
        });

        // Scroll to top when clicked
        backToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
</script>

</body>
</html>
