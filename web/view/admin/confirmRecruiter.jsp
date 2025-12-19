<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CompanyDAO"%>
<%@page import="dao.AccountDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Account"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Add custom styles -->
        <style>
        /* Confirmation Page - White Background Theme */

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
.table-title {
    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-weight: 900;
    margin-bottom: 2rem;
    text-align: center;
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
.table-responsive {
    margin-top: 20px;
    overflow-x: auto;
}

.table {
    background: #ffffff !important;
    border: 2px solid #dee2e6 !important;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
}

.table-success {
    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
}

.table-success th {
    color: #ffffff !important;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 1.2rem;
    border: none !important;
    font-size: 0.9rem;
}

.table tbody {
    background: #ffffff;
}

.table tbody tr {
    border-bottom: 1px solid #e9ecef !important;
    transition: all 0.2s;
}

.table tbody tr:hover {
    background: #f8f4ff;
}

.table tbody td {
    color: #212529 !important;
    padding: 1.2rem;
    vertical-align: middle;
    border: none !important;
}

/* Image Thumbnails */
.img-thumbnail {
    border: 2px solid #dee2e6 !important;
    border-radius: 10px !important;
    cursor: pointer;
    transition: all 0.3s;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.img-thumbnail:hover {
    transform: scale(1.05);
    border-color: #c471f5 !important;
    box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3);
}

/* Verify Buttons */
.btn-verify {
    padding: 8px 12px;
    margin: 0 5px;
    border: none;
    cursor: pointer;
    border-radius: 50%;
    font-size: 1rem;
    transition: all 0.3s;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.btn-confirm {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
}

.btn-confirm:hover {
    transform: scale(1.1);
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
}

.btn-reject {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
}

.btn-reject:hover {
    transform: scale(1.1);
    box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
}

/* Notification Box */
.notification-box {
    padding: 15px;
    border-radius: 15px;
    margin: 20px 0;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.notification-box.error {
    background-color: #f8d7da;
    color: #721c24;
    border: 2px solid #f5c6cb;
}

/* Modal Styling */
.modal-content {
    border-radius: 15px;
    border: none;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.modal-header {
    background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
    color: #ffffff;
    border-radius: 15px 15px 0 0;
    padding: 1.5rem;
}

.modal-title {
    font-weight: 700;
}

.modal-body {
    padding: 2rem;
}

.btn-close {
    background-color: #ffffff;
    opacity: 1;
    border-radius: 50%;
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

    #searchRecruiter {
        width: 100% !important;
        margin-bottom: 0.5rem;
    }

    .table {
        font-size: 0.85rem;
    }

    .table-title {
        font-size: 1.5rem !important;
    }

    .btn-verify {
        padding: 6px 10px;
        font-size: 0.9rem;
    }

    .notification-box {
        font-size: 14px;
        padding: 12px;
    }
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
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2 class="mt-4 mb-4 table-title">Xác nhận tài khoản người tuyển dụng</h2>
                                    <div class="table-responsive">
                                        <!--search recruiter-->
                                        <form action="${pageContext.request.contextPath}/confirm" method="GET">
                                        <div class="d-flex justify-content-center mb-3">
                                            <input type="text" id="searchRecruiter"  name="searchQuery" class="form-control" style="width: 60%;" placeholder="Tìm theo tên...">
                                            <button type="submit" class="btn btn-primary ms-2">Tìm</button>
                                        </div>
                                    </form>

                                    <!--search recruiter end-->       
                                    <table class="table table-striped table-hover" style="border: 2px">
                                        <thead class="table-success">
                                            <tr>
                                                <th>Tên</th>
                                                <th>Xác nhận</th>
                                                <th>Công ty</th>
                                                <th>Căn cước công dân (mặt trước)</th>
                                                <th>Căn cước công dân (mặt sau)</th>
                                                <th>Vị trí</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                         // Tạo một đối tượng CompanyDAO
                                            CompanyDAO companyDao = new CompanyDAO();
                                         // tao doi tuong account 
                                            AccountDAO accountDao = new AccountDAO();
                                            %>
                                            <c:forEach items="${listConfirm}" var="recruiter">
                                                <c:if test="${recruiter.isIsVerify() == false}">
                                                    <c:set var="accountId" value="${recruiter.getAccountID()}" />
                                                    <%int accountId = (Integer) pageContext.getAttribute("accountId");%>
                                                    <tr>
                                                        <td>
                                                            <%
                                                                Account account = accountDao.findUserById(accountId);
                                                            %>
                                                            <%= account.getFullName() %>
                                                        </td>

                                                        <td>
                                                            <form action="${pageContext.request.contextPath}/confirm" method="POST" class="d-inline">
                                                                <input type="hidden" name="recruiterId" value="${recruiter.getRecruiterID()}">
                                                                <input type="hidden" name="action" value="confirm">
                                                                <button type="submit" class="btn-verify btn-confirm" onclick="return confirmAction('confirm')">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            </form>
                                                            <form action="${pageContext.request.contextPath}/confirm" method="POST" class="d-inline">
                                                                <input type="hidden" name="recruiterId" value="${recruiter.getRecruiterID()}">
                                                                <input type="hidden" name="action" value="reject">
                                                                <button type="submit" class="btn-verify btn-reject" onclick="return confirmAction('reject')">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            </form>
                                                        </td>


                                                        <td>

                                                            <%
                                                                List<Company> companies = companyDao.getCompanyNameByAccountId(accountId);
                                                                String companyName = "";
                                                                if (companies != null && !companies.isEmpty()) {
                                                                    companyName = companies.get(0).getName(); // Lấy tên công ty từ danh sách
                                                                }
                                                            %>
                                                            <%= companyName %> <!-- Hiển thị tên công ty -->
                                                        </td>
                                                        <td>
                                                            <img src="${recruiter.getFrontCitizenImage()}" alt="Front Citizen Image" class="img-fluid img-thumbnail" style="max-width: 100px;" 
                                                                 data-bs-toggle="modal" data-bs-target="#imageModal" onclick="showImage('${recruiter.getFrontCitizenImage()}')">
                                                        </td>
                                                        <td>
                                                            <img src="${recruiter.getBackCitizenImage()}" alt="Back Citizen Image" class="img-fluid img-thumbnail" style="max-width: 100px;" 
                                                                 data-bs-toggle="modal" data-bs-target="#imageModal" onclick="showImage('${recruiter.getBackCitizenImage()}')">
                                                        </td>


                                                        <td>${recruiter.getPosition()}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                    <!--hien thi thong bao-->
                                    <c:if test="${not empty notice}">
                                        <tr>
                                            <td colspan="4">
                                                <div class="notification-box error">
                                                    <p>${notice}</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <!--button back-->
                                    <div class="d-flex justify-content-start mt-3 mb-3">
                                        <a href="recruiters" class="btn btn-success">
                                            <i class="fas fa-arrow-left me-2"></i>Trở lại
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--content-main can fix end-->
                </div>

                <!-- Back to Top Button -->


                <!-- Footer -->
            </div>
        </div>

        <!-- Rest of the file remains unchanged -->

        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
            <!-- Offcanvas content remains unchanged -->
        </div>
        <!--modal hien thi anh citizen-->
        <!-- Modal to display image -->
        <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">Image</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="modalImage" src="" alt="Image" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
        <!--end modal-->
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
                                                                     function confirmAction() {
                                                                         return confirm("Are you sure you want to confirm this recruiter?");
                                                                     }
        </script>
        <script>
            function showImage(imageUrl) {
                document.getElementById('modalImage').src = imageUrl;
            }
        </script>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>