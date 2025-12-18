<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Add custom styles -->
        <style>
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

                                            /* Column Layout */
                                            .col-md-3 {
                                                padding: 0;
                                            }

                                            .col-md-9 {
                                                padding: 2rem;
                                                background: #ffffff;
                                                min-height: 100vh;
                                            }

                                            /* Page Title */
                                            h4.fs-2 {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                                                -webkit-background-clip: text;
                                                -webkit-text-fill-color: transparent;
                                                font-weight: 900;
                                                margin-bottom: 2rem;
                                                text-align: center;
                                            }

                                            /* Profile Form Container */
                                            .bg-light {
                                                background: #ffffff !important;
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 20px !important;
                                                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
                                            }

                                            /* Avatar Styling */
                                            .rounded-circle {
                                                border: 3px solid #c471f5 !important;
                                                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3) !important;
                                                object-fit: cover;
                                            }

                                            /* Form Labels */
                                            .form-label {
                                                color: #495057;
                                                font-weight: 600;
                                                font-size: 0.9rem;
                                                margin-bottom: 0.5rem;
                                            }

                                            /* Form Inputs */
                                            .form-control {
                                                background: #f8f9fa !important;
                                                border: 1px solid #dee2e6 !important;
                                                border-radius: 10px !important;
                                                color: #212529 !important;
                                                padding: 0.75rem 1rem !important;
                                                font-size: 0.95rem;
                                                transition: all 0.3s;
                                            }

                                            .form-control:focus {
                                                background: #ffffff !important;
                                                border-color: #c471f5 !important;
                                                box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.15) !important;
                                                outline: none;
                                            }

                                            .form-control:read-only {
                                                background: #e9ecef !important;
                                                cursor: not-allowed;
                                            }

                                            /* Buttons */
                                            .btn-success {
                                                background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
                                                border: none !important;
                                                border-radius: 12px !important;
                                                padding: 0.6rem 1.5rem !important;
                                                font-weight: 700 !important;
                                                color: #ffffff !important;
                                                transition: all 0.3s !important;
                                                box-shadow: 0 3px 12px rgba(40, 167, 69, 0.3) !important;
                                                width: 100%;
                                            }

                                            .btn-success:hover {
                                                transform: translateY(-2px) !important;
                                                box-shadow: 0 5px 18px rgba(40, 167, 69, 0.4) !important;
                                            }

                                            .btn-info {
                                                background: linear-gradient(135deg, #7ee8fa 0%, #5ec9db 100%) !important;
                                                border: none !important;
                                                border-radius: 12px !important;
                                                padding: 0.7rem 2rem !important;
                                                font-weight: 700 !important;
                                                color: #000000 !important;
                                                transition: all 0.3s !important;
                                                box-shadow: 0 3px 12px rgba(126, 232, 250, 0.3) !important;
                                            }

                                            .btn-info:hover {
                                                transform: translateY(-2px) !important;
                                                box-shadow: 0 5px 18px rgba(126, 232, 250, 0.4) !important;
                                            }

                                            .btn-secondary {
                                                background: #6c757d !important;
                                                border: none !important;
                                                border-radius: 10px !important;
                                                padding: 0.6rem 1.5rem !important;
                                                font-weight: 600 !important;
                                                transition: all 0.3s !important;
                                            }

                                            .btn-secondary:hover {
                                                background: #5a6268 !important;
                                                transform: translateY(-2px) !important;
                                            }

                                            .btn-primary {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                border: none !important;
                                                color: #ffffff !important;
                                            }

                                            /* Modal Styling */
                                            .modal-content {
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 20px !important;
                                                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15) !important;
                                            }

                                            .modal-header {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                color: #ffffff !important;
                                                border-radius: 18px 18px 0 0 !important;
                                                border-bottom: none !important;
                                            }

                                            .modal-title {
                                                font-weight: 700;
                                                font-size: 1.3rem;
                                                color: #ffffff !important;
                                            }

                                            .modal-body {
                                                padding: 2rem;
                                                background: #ffffff;
                                            }

                                            .modal-footer {
                                                border-top: 1px solid #dee2e6 !important;
                                                padding: 1.5rem;
                                            }

                                            .btn-close {
                                                filter: brightness(0) invert(1);
                                            }

                                            /* Table in Modal */
                                            .table {
                                                margin-bottom: 0;
                                            }

                                            .table-bordered {
                                                border: 2px solid #dee2e6 !important;
                                                border-radius: 12px !important;
                                                overflow: hidden;
                                            }

                                            .table-light th {
                                                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                                                color: #ffffff !important;
                                                font-weight: 700;
                                                text-transform: uppercase;
                                                font-size: 0.85rem;
                                                letter-spacing: 0.5px;
                                                padding: 1rem;
                                                border: none !important;
                                            }

                                            .table tbody td {
                                                color: #212529 !important;
                                                padding: 1rem;
                                                vertical-align: middle;
                                                border-color: #dee2e6 !important;
                                            }

                                            .table tbody tr:hover {
                                                background: #f8f4ff;
                                            }

                                            /* Certificate Image in Table */
                                            .table img {
                                                max-width: 100px !important;
                                                height: auto !important;
                                                border-radius: 8px;
                                                border: 2px solid #dee2e6;
                                                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                                transition: all 0.3s;
                                                cursor: pointer;
                                            }

                                            .table img:hover {
                                                transform: scale(1.1);
                                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                                                z-index: 10;
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

                                            @keyframes spin {
                                                to {
                                                    transform: rotate(360deg);
                                                }
                                            }

                                            /* Profile Info Section */
                                            .d-flex.align-items-start {
                                                gap: 2rem;
                                            }

                                            .me-4 {
                                                min-width: 150px;
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

                                            /* Empty State */
                                            .table tbody tr td[colspan] {
                                                color: #6c757d !important;
                                                font-style: italic;
                                                padding: 2rem;
                                            }

                                            /* Responsive Design */
                                            @media (max-width: 768px) {
                                                .col-md-9 {
                                                    padding: 1rem;
                                                }

                                                .d-flex.align-items-start {
                                                    flex-direction: column;
                                                }

                                                .me-4 {
                                                    width: 100%;
                                                    text-align: center;
                                                    margin-bottom: 1.5rem;
                                                }

                                                .rounded-circle {
                                                    width: 120px !important;
                                                    height: 120px !important;
                                                }

                                                h4.fs-2 {
                                                    font-size: 1.5rem !important;
                                                }

                                                .btn-success,
                                                .btn-info {
                                                    width: 100%;
                                                    margin-bottom: 0.5rem;
                                                }
                                            }
                                        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
            <!-- content area -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <!--Side bar-->
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                        <!--side bar-end-->
                    </div>


                    <div class="col-md-9">

                        <!--content-main can fix-->
                        
                        <div class="container mt-4" style="background-color: #f8f9fa; padding: 20px; border-radius: 5px;">
                        <h2 class="text-center mb-4" style="background-color: #c471f5; padding: 20px; border-radius: 5px;">Chi Tiết Công Ty</h2>
                            <form>
                                <div class="mb-3 row">
                                    <label for="companyName" class="col-sm-3 col-form-label fw-bold">Tên Công Ty:</label>
                                    <div class="col-sm-9">
                                        <p class="form-control-plaintext">${CompanyDetail.getName()}</p>
                                </div>
                            </div>
                                <hr>
                            <div class="mb-3 row">
                                <label for="companyDescription" class="col-sm-3 col-form-label fw-bold">Mô Tả:</label>
                                <div class="col-sm-9">
                                    <p class="form-control-plaintext">${CompanyDetail.getDescription()}</p>
                                </div>
                            </div>
                                <hr>
                            <div class="mb-3 row">
                                <label for="companyLocation" class="col-sm-3 col-form-label fw-bold">Địa chỉ:</label>
                                <div class="col-sm-9">
                                    <p class="form-control-plaintext">${CompanyDetail.getLocation()}</p>
                                </div>
                            </div>
                                <hr>
                            <div class="mb-3 row">
                                <label for="verificationStatus" class="col-sm-3 col-form-label fw-bold">Trạng Thái:</label>
                                <div class="col-sm-9">
                                    <p class="form-control-plaintext ${CompanyDetail.isVerificationStatus() == true ? 'Accept' : 'Violate'}">
                                        ${CompanyDetail.isVerificationStatus() == true ? 'Accept' : 'Violate'}
                                    </p>
                                </div>
                            </div>
                                    <hr>
                            <div class="mb-3 row">
                                <label for="businessLicense" class="col-sm-3 col-form-label fw-bold">giấy phép kinh doanh:</label>
                                <div class="col-sm-9">
                                    <img src="${CompanyDetail.getBusinessLicenseImage()}" 
                                         alt="Business License" class="img-fluid img-thumbnail" style="max-width: 300px;">
                                </div>
                            </div>
                            <hr>
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-info"
                                    onclick="location.href = '${pageContext.request.contextPath}/companies'">
                                    <i class="fas fa-arrow-left me-2"></i>Trở lại
                                </button>
                            </div>
                        </form>
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
        <!-- all plugin js -->
        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        
    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>
