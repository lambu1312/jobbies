<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo Hồ Sơ Công Ty</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            /* Tông màu Tím Hồng chủ đạo */
            :root {
                --primary-purple: #a855f7;
                --gradient-bg: linear-gradient(90deg, #c084fc 0%, #f472b6 100%);
                --gradient-header: linear-gradient(90deg, #be54e3, #e863b8);
            }

            /* Tùy chỉnh cho main content */
            body {
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                background-color: #fdfbff;
            }

            /* Page wrapper for proper layout */
            .page-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Main content container */
            .main-content {
                flex: 1 0 auto; 
                padding: 30px;
                margin-left: 260px; /* Space for sidebar */
                background-color: #fdfbff;
                margin-top: 70px; /* Space for fixed header */
            }

            /* Card layout */
            .card {
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(168, 85, 247, 0.1);
                padding: 0;
                background-color: white;
                margin-bottom: 20px;
                border: 1px solid #f3e8ff;
                overflow: hidden;
            }

            .card-header {
                background: var(--gradient-header);
                color: white;
                padding: 15px 20px;
                font-size: 18px;
                font-weight: 700;
                display: flex;
                align-items: center;
                border-bottom: none;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .card-header i {
                margin-right: 10px;
            }

            .card-body {
                padding: 30px;
            }

            /* Form styles */
            .form-label {
                font-weight: 600;
                color: #6b21a8; /* Tím đậm */
            }

            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #e9d5ff;
                padding: 10px;
            }
            
            .form-control:focus {
                border-color: #d8b4fe;
                box-shadow: 0 0 0 0.25rem rgba(216, 180, 254, 0.25);
            }

            .form-footer {
                display: flex;
                justify-content: flex-end; /* Đẩy nút sang phải */
                margin-top: 30px;
            }
            
            /* Custom Button */
            .btn-create {
                background: var(--gradient-bg);
                color: white;
                border: none;
                padding: 10px 30px;
                border-radius: 50px;
                font-weight: 600;
                font-size: 16px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(236, 72, 153, 0.3);
            }
            
            .btn-create:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(236, 72, 153, 0.5);
                color: white;
            }

            .invalid-feedback {
                font-size: 14px;
            }

            .is-invalid {
                border-color: #dc3545;
                background-color: #fff8f8;
            }

            /* Footer positioning */
            footer {
                flex-shrink: 0;
                background: #fff; /* Footer nền trắng hoặc màu nhạt */
                border-top: 1px solid #e9ecef;
                padding: 15px 0;
                margin-left: 260px;
                width: calc(100% - 260px);
            }

            /* Alert messages */
            .alert {
                margin-bottom: 25px;
                border-radius: 10px;
            }
            
            /* TinyMCE border fix */
            .tox-tinymce {
                border: 1px solid #e9d5ff !important;
                border-radius: 8px !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        
        <div class="page-wrapper">
            <div class="main-content">
                <%@ include file="../recruiter/header-re.jsp" %>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger shadow-sm" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                        <a href="${pageContext.request.contextPath}/company?action=edit" class="alert-link ms-2">
                            Chỉnh sửa lại
                        </a>
                    </div>
                </c:if>
                <c:if test="${not empty notice}">
                    <div class="alert alert-success shadow-sm" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${notice}
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-building"></i> Điền Thông Tin Công Ty
                    </div>
                    <div class="card-body">
                        <form id="addCompanyForm" action="${pageContext.request.contextPath}/company?action=create" method="POST" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="companyName" class="form-label">Tên Công Ty <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="companyName" name="name" 
                                           placeholder="Nhập tên công ty của bạn"
                                           value="${requestScope.company.getName()}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="companyLocation" class="form-label">Địa Chỉ / Trụ Sở <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="companyLocation" name="location" 
                                           placeholder="Nhập địa chỉ công ty"
                                           value="${requestScope.company.getLocation()}" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="businessCode" class="form-label">Mã Số Thuế / Mã Doanh Nghiệp (10 số) <span class="text-danger">*</span></label>

                                    <input type="text" 
                                           class="form-control <c:if test='${not empty errorCode or not empty duplicateCode}'>is-invalid</c:if>" 
                                           id="businessCode" name="businessCode" 
                                           placeholder="Nhập mã số kinh doanh"
                                           value="${requestScope.company.getBusinessCode()}"
                                           pattern="[0-9]{10}"
                                           maxlength="10"
                                           minlength="10"
                                           title="Business code must be exactly 10 digits"
                                           required>

                                    <c:if test="${not empty errorCode}">
                                        <div class="invalid-feedback">
                                            ${errorCode}
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty duplicateCode}">
                                        <div class="invalid-feedback">
                                            ${duplicateCode}
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="businessLicense" class="form-label">Giấy Phép Kinh Doanh (Ảnh) <span class="text-danger">*</span></label>
                                    <input type="file" class="form-control" id="businessLicense" name="businessLicense" accept="image/*" required>
                                    <div class="form-text text-muted">Vui lòng tải lên ảnh chụp rõ nét giấy phép kinh doanh.</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="companyDescription" class="form-label">Mô Tả Công Ty <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="companyDescription" name="description" rows="4" 
                                          placeholder="Giới thiệu về công ty, văn hóa, tầm nhìn..." required>${requestScope.company.getDescription()}</textarea>
                            </div>

                            <div class="form-footer">
                                <button type="submit" class="btn btn-create">
                                    <i class="fas fa-plus-circle me-2"></i> Tạo Mới
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>

            <%@ include file="../recruiter/footer-re.jsp" %>
        </div>
        
        <script>
            tinymce.init({
                selector: 'textarea#companyDescription',
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                menubar: false,
                branding: false,
                height: 350,
                placeholder: 'Nhập mô tả chi tiết về công ty tại đây...',
                setup: function (editor) {
                    editor.on('change', function () {
                        tinymce.triggerSave();
                    });
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>