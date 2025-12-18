<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Hồ Sơ Công Ty</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            /* Tông màu Tím Hồng chủ đạo */
            :root {
                --primary-purple: #a855f7;
                --gradient-bg: linear-gradient(90deg, #c084fc 0%, #f472b6 100%);
                --gradient-header: linear-gradient(90deg, #be54e3, #e863b8);
                --shadow: 0 4px 15px rgba(168, 85, 247, 0.15);
            }

            body {
                background-color: #fdfbff;
            }

            .main-content {
                padding: 30px;
                margin-left: 260px;
                background-color: #fdfbff;
                min-height: calc(100vh - 60px);
                margin-top: 60px;
            }

            .card {
                border: 1px solid #f3e8ff;
                border-radius: 15px;
                box-shadow: var(--shadow);
                background-color: white;
                margin-bottom: 1.5rem;
                overflow: hidden;
            }

            .card-header {
                background: var(--gradient-header);
                color: white;
                padding: 15px 20px;
                font-size: 1.1rem;
                font-weight: 700;
                border: none;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .card-header i {
                margin-right: 0.5rem;
            }

            .card-body {
                padding: 2rem;
            }

            .form-label {
                font-weight: 600;
                color: #6b21a8;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 1px solid #e9d5ff;
                padding: 0.625rem;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .form-control:focus {
                border-color: #d8b4fe;
                box-shadow: 0 0 0 0.25rem rgba(216, 180, 254, 0.25);
            }

            /* Custom Save Button */
            .btn-save {
                background: var(--gradient-bg);
                color: white;
                border: none;
                padding: 10px 30px;
                font-weight: 600;
                border-radius: 50px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(236, 72, 153, 0.3);
            }

            .btn-save:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(236, 72, 153, 0.5);
                color: white;
            }

            /* Business License Image Styling */
            .license-wrapper {
                background-color: #faf5ff;
                border: 1px dashed #d8b4fe;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                position: relative;
            }

            .business-license-container {
                position: relative;
                display: inline-block;
                margin: 0 auto;
            }

            .img-thumbnail {
                border-radius: 10px;
                padding: 0.25rem;
                max-width: 100%;
                max-height: 350px;
                width: auto;
                border: 1px solid #e9d5ff;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            }

            .change-image-btn {
                position: absolute;
                bottom: 15px;
                right: 15px;
                background: rgba(255, 255, 255, 0.9);
                color: #9333ea;
                border: 1px solid #e9d5ff;
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .change-image-btn:hover {
                background: #9333ea;
                color: white;
            }
            
            .btn-upload-new {
                background-color: white;
                color: #9333ea;
                border: 1px dashed #9333ea;
                padding: 15px 30px;
                border-radius: 10px;
                transition: 0.3s;
            }
            
            .btn-upload-new:hover {
                background-color: #faf5ff;
                border-color: #d946ef;
                color: #d946ef;
            }

            .form-footer {
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #f3e8ff;
                display: flex;
                justify-content: flex-end;
            }

            /* Alerts */
            .alert {
                border-radius: 10px;
                border: none;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 1rem;
                }
                .change-image-btn {
                    position: static;
                    margin-top: 10px;
                    display: block;
                    width: 100%;
                }
            }
            
            .tox-tinymce {
                border: 1px solid #e9d5ff !important;
                border-radius: 8px !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <div class="main-content">
            <%@ include file="../recruiter/header-re.jsp" %>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorCode}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${errorCode}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty duplicateCode}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> ${duplicateCode}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit"></i> Chỉnh Sửa Hồ Sơ Công Ty
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-warning" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${empty error}">
                        <form id="editCompanyForm" action="${pageContext.request.contextPath}/company?action=edit" 
                              method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="companyId" value="${requestScope.company.getId()}">
                            
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label for="companyName" class="form-label">Tên Công Ty <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="companyName" name="name" 
                                           value="${requestScope.company.getName()}" required placeholder="Nhập tên công ty">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="companyLocation" class="form-label">Địa Chỉ / Trụ Sở <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="companyLocation" name="location" 
                                           value="${requestScope.company.getLocation()}" required placeholder="Nhập địa chỉ">
                                </div>

                                <div class="col-12">
                                    <label for="companyDescription" class="form-label">Mô Tả Công Ty <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="companyDescription" name="description" 
                                              required><p>${requestScope.company.getDescription()}</p></textarea>
                                </div>

                                <div class="col-md-6">
                                    <label for="businessCode" class="form-label">Mã Số Thuế / Mã Doanh Nghiệp <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="businessCode" name="businessCode" 
                                           value="${requestScope.company.getBusinessCode()}" required>
                                    <small class="text-muted d-block mt-2">
                                        <i class="fas fa-info-circle text-primary"></i> Bạn có thể chỉnh sửa mã số này nếu có sai sót.
                                    </small>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Giấy Phép Kinh Doanh</label>
                                    
                                    <div class="license-wrapper">
                                        <c:if test="${not empty requestScope.company.getBusinessLicenseImage()}">
                                            <div class="business-license-container">
                                                <img id="licenseImage" 
                                                     src="${requestScope.company.getBusinessLicenseImage()}" 
                                                     alt="Business License" 
                                                     class="img-thumbnail">
                                                <button type="button" class="change-image-btn shadow-sm" 
                                                        onclick="document.getElementById('businessLicenseInput').click()">
                                                    <i class="fas fa-camera"></i> Đổi Ảnh
                                                </button>
                                            </div>
                                        </c:if>
                                        
                                        <c:if test="${empty requestScope.company.getBusinessLicenseImage()}">
                                            <button type="button" class="btn-upload-new" 
                                                    onclick="document.getElementById('businessLicenseInput').click()">
                                                <i class="fas fa-cloud-upload-alt fa-2x mb-2"></i><br>
                                                Tải lên Giấy Phép Kinh Doanh
                                            </button>
                                        </c:if>
                                        
                                        <input type="file" class="d-none" id="businessLicenseInput" 
                                               name="businessLicense" accept="image/*" onchange="previewImage(event)">
                                    </div>
                                </div>
                            </div>

                            <div class="form-footer">
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save"></i> Lưu Thay Đổi
                                </button>
                            </div>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>
        
        <script>
            // Initialize TinyMCE
            tinymce.init({
                selector: '#companyDescription',
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                menubar: false,
                branding: false,
                height: 300,
                placeholder: 'Nhập mô tả về công ty...',
                setup: function (editor) {
                    editor.on('change', function () {
                        tinymce.triggerSave();
                    });
                }
            });

            // Preview new image - Replace current image directly
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    // Check file size (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert('Kích thước file phải nhỏ hơn 5MB');
                        event.target.value = '';
                        return;
                    }
                    
                    // Check file type
                    if (!file.type.startsWith('image/')) {
                        alert('Vui lòng chọn định dạng file hình ảnh');
                        event.target.value = '';
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        // Check if image element exists, if not create logic to show it (simplified here assuming img exists or reload)
                        const img = document.getElementById('licenseImage');
                        if (img) {
                            img.src = e.target.result;
                        } else {
                            // Logic xử lý nếu chưa có ảnh (optional: reload hoặc chèn DOM)
                            alert('Ảnh đã được chọn. Vui lòng nhấn Lưu để cập nhật.');
                        }
                    };
                    reader.readAsDataURL(file);
                }
            }

            // Auto-hide alerts after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    setTimeout(function() {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000);
                });
            });
        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>