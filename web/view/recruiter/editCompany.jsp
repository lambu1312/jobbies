<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Company</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            :root {
                --primary-color: #28a745;
                --primary-hover: #218838;
                --border-radius: 8px;
                --shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .main-content {
                padding: 1.25rem;
                margin-left: 250px;
                background-color: #f8f9fa;
                min-height: calc(100vh - 60px);
            }

            .card {
                border: none;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
                background-color: white;
                margin-bottom: 1.5rem;
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                border-radius: var(--border-radius) var(--border-radius) 0 0;
                padding: 1rem;
                font-size: 1.1rem;
                font-weight: 600;
                border: none;
            }

            .card-header i {
                margin-right: 0.5rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 1px solid #dee2e6;
                padding: 0.625rem;
                border-radius: var(--border-radius);
                transition: all 0.2s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }

            textarea.form-control {
                min-height: 120px;
                resize: vertical;
            }

            .alert-warning {
                background-color: #fff3cd;
                border-color: #ffeeba;
                color: #856404;
                font-size: 0.875rem;
                padding: 0.75rem;
                border-radius: var(--border-radius);
                margin-top: 0.5rem;
            }

            .alert-warning i {
                margin-right: 0.5rem;
            }

            .business-license-container {
                position: relative;
                display: inline-block;
                margin: 0 auto;
            }

            .img-thumbnail {
                border-radius: var(--border-radius);
                padding: 0.25rem;
                max-width: 500px;
                max-height: 400px;
                width: auto;
                height: auto;
                border: 2px solid #dee2e6;
                transition: all 0.2s ease;
                display: block;
                margin: 0 auto;
            }

            .img-thumbnail:hover {
                box-shadow: var(--shadow);
            }

            .change-image-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: var(--border-radius);
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: var(--shadow);
            }

            .change-image-btn:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }

            .change-image-btn i {
                margin-right: 0.5rem;
            }

            .image-url-display {
                font-size: 0.875rem;
                color: #6c757d;
                margin-top: 1rem;
                word-break: break-all;
                padding: 0 1rem;
            }

            .form-footer {
                padding: 1rem;
                background-color: #f8f9fa;
                border-top: 1px solid #dee2e6;
                border-radius: 0 0 var(--border-radius) var(--border-radius);
                display: flex;
                justify-content: flex-start;
            }

            .btn-success {
                background-color: var(--primary-color);
                border: none;
                padding: 0.625rem 1.25rem;
                font-weight: 500;
                border-radius: var(--border-radius);
                transition: all 0.2s ease;
            }

            .btn-success:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }

            .btn-success i {
                margin-right: 0.5rem;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 1rem;
                }

                .card-body {
                    padding: 1rem;
                }

                .row > div {
                    margin-bottom: 1rem;
                }

                .img-thumbnail {
                    max-width: 100%;
                }

                .change-image-btn {
                    font-size: 0.75rem;
                    padding: 0.375rem 0.75rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <div class="main-content">
            <%@ include file="../recruiter/header-re.jsp" %>
            
            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Error Messages -->
            <c:if test="${not empty errorCode}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle"></i> ${errorCode}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty duplicateCode}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${duplicateCode}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-edit"></i> Edit Your Company Information
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
                            
                            <div class="row g-3">
                                <!-- Company Name -->
                                <div class="col-md-6">
                                    <label for="companyName" class="form-label">Company Name</label>
                                    <input type="text" class="form-control" id="companyName" name="name" 
                                           value="${requestScope.company.getName()}" required>
                                </div>
                                
                                <!-- Location -->
                                <div class="col-md-6">
                                    <label for="companyLocation" class="form-label">Location</label>
                                    <input type="text" class="form-control" id="companyLocation" name="location" 
                                           value="${requestScope.company.getLocation()}" required>
                                </div>

                                <!-- Description -->
                                <div class="col-md-6">
                                    <label for="companyDescription" class="form-label">Description</label>
                                    <textarea class="form-control" id="companyDescription" name="description" 
                                              required><p>${requestScope.company.getDescription()}</p></textarea>
                                </div>

                                <!-- Business Code - Now Editable -->
                                <div class="col-md-6">
                                    <label for="businessCode" class="form-label">Business Code</label>
                                    <input type="text" class="form-control" id="businessCode" name="businessCode" 
                                           value="${requestScope.company.getBusinessCode()}" required>
                                    <small class="text-muted d-block mt-1">
                                        <i class="fas fa-info-circle"></i> You can now edit the business code
                                    </small>
                                </div>

                                <!-- Business License with Change Button -->
                                <div class="col-12">
                                    <label class="form-label">Business License</label>
                                    
                                    <div class="border rounded p-3 bg-light text-center">
                                        <c:if test="${not empty requestScope.company.getBusinessLicenseImage()}">
                                            <div class="business-license-container d-inline-block">
                                                <img id="licenseImage" 
                                                     src="${requestScope.company.getBusinessLicenseImage()}" 
                                                     alt="Business License" 
                                                     class="img-thumbnail">
                                                <button type="button" class="change-image-btn" 
                                                        onclick="document.getElementById('businessLicenseInput').click()">
                                                    <i class="fas fa-camera"></i> Change Image
                                                </button>
                                            </div>
<!--                                            <div class="image-url-display text-center">
                                                <strong>Current URL:</strong> ${requestScope.company.getBusinessLicenseImage()}
                                            </div>-->
                                        </c:if>
                                        
                                        <c:if test="${empty requestScope.company.getBusinessLicenseImage()}">
                                            <button type="button" class="btn btn-secondary" 
                                                    onclick="document.getElementById('businessLicenseInput').click()">
                                                <i class="fas fa-upload"></i> Upload Business License
                                            </button>
                                        </c:if>
                                    </div>
                                    
                                    <!-- Hidden File Input -->
                                    <input type="file" class="d-none" id="businessLicenseInput" 
                                           name="businessLicense" accept="image/*" onchange="previewImage(event)">
                                </div>
                            </div>

                            <div class="form-footer">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> Save Changes
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
                menubar: true,
                branding: false,
                height: 300,
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
                        alert('File size must be less than 5MB');
                        event.target.value = '';
                        return;
                    }
                    
                    // Check file type
                    if (!file.type.startsWith('image/')) {
                        alert('Please select an image file');
                        event.target.value = '';
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        // Replace the current image directly
                        document.getElementById('licenseImage').src = e.target.result;
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