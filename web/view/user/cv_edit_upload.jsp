<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa CV đã tải lên</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --color-primary: #2B59FF;
            --color-primary-dark: #1E3FCC;
            --color-text-primary: #0A0E27;
            --color-text-secondary: #5B6B8C;
            --color-border: #E4E8F0;
            --color-background: #FAFBFC;
            --color-surface: #FFFFFF;
            --color-success: #0EA770;
            --color-success-light: #E8F7F0;
            --color-danger: #E03E52;
            --color-danger-light: #FFEBEE;
            --shadow-sm: 0 1px 2px rgba(10, 14, 39, 0.03);
            --shadow-md: 0 4px 12px rgba(10, 14, 39, 0.06);
            --shadow-lg: 0 12px 32px rgba(10, 14, 39, 0.08);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--color-background);
            color: var(--color-text-primary);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 3rem;
            animation: fadeInUp 0.6s ease-out;
            text-align: center;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
            letter-spacing: -0.01em;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--color-text-secondary);
            font-weight: 400;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: var(--radius-md);
            margin-bottom: 2rem;
            display: flex;
            align-items: flex-start;
            gap: 0.875rem;
            font-size: 0.9375rem;
            border: 1px solid;
            animation: slideInRight 0.4s ease-out;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-danger {
            background: var(--color-danger-light);
            border-color: var(--color-danger);
            color: var(--color-danger);
        }

        .form-card {
            background: var(--color-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--color-border);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            animation: fadeInUp 0.6s ease-out 0.1s both;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            color: var(--color-text-primary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .form-label i {
            color: var(--color-primary);
            font-size: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--color-border);
            border-radius: var(--radius-sm);
            font-size: 0.9375rem;
            color: var(--color-text-primary);
            background-color: var(--color-surface);
            transition: all 0.2s ease;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
        }

        .file-upload-area {
            position: relative;
            border: 2px dashed var(--color-border);
            border-radius: var(--radius-md);
            padding: 2rem;
            text-align: center;
            background: #F8FAFC;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .file-upload-area:hover {
            border-color: var(--color-primary);
            background: #F0F4FF;
        }

        .file-upload-area input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }

        .file-upload-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, #E0F2FE 0%, #F0F9FF 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--color-primary);
            font-size: 1.5rem;
        }

        .file-upload-text {
            color: var(--color-text-primary);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .file-upload-hint {
            color: var(--color-text-secondary);
            font-size: 0.875rem;
        }

        .form-hint {
            font-size: 0.8125rem;
            color: var(--color-text-secondary);
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .form-hint i {
            color: var(--color-primary);
        }

        .form-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
            padding-top: 1.5rem;
            border-top: 1px solid var(--color-border);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.9375rem;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            border: 1px solid;
            white-space: nowrap;
        }

        .btn i {
            font-size: 0.875rem;
        }

        .btn-primary {
            background: var(--color-primary);
            color: white;
            border-color: var(--color-primary);
        }

        .btn-primary:hover {
            background: var(--color-primary-dark);
            border-color: var(--color-primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(43, 89, 255, 0.2);
        }

        .btn-secondary {
            background: white;
            color: var(--color-text-secondary);
            border-color: var(--color-border);
        }

        .btn-secondary:hover {
            background: #F8FAFC;
            border-color: var(--color-primary);
            color: var(--color-primary);
        }

        .quick-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            margin-left: auto;
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .form-card {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .quick-actions {
                margin-left: 0;
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .file-upload-area {
                padding: 1.5rem;
            }

            .file-upload-icon {
                width: 50px;
                height: 50px;
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-edit"></i>
                Chỉnh sửa CV đã tải lên
            </h1>
            <p class="page-subtitle">Cập nhật thông tin và thay thế file PDF của CV</p>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>
        
        <!-- Edit Form -->
        <form method="post"
              action="${pageContext.request.contextPath}/cv/upload-replace"
              enctype="multipart/form-data">
            <input type="hidden" name="cvid" value="${cv.cvId}" />
            
            <div class="form-card">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-heading"></i>
                        Tiêu đề CV
                    </label>
                    <input type="text" 
                           name="title" 
                           value="${cv.title}" 
                           class="form-control"
                           placeholder="Nhập tiêu đề cho CV của bạn"
                           required />
                    <div class="form-hint">
                        <i class="fa fa-info-circle"></i>
                        Tiêu đề giúp bạn dễ dàng nhận diện CV trong danh sách
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-file-pdf"></i>
                        Tải lên file PDF mới
                    </label>
                    <div class="file-upload-area">
                        <input type="file" 
                               name="pdfFile" 
                               accept="application/pdf" 
                               required 
                               onchange="updateFileName(this)" />
                        <div class="file-upload-icon">
                            <i class="fas fa-cloud-upload-alt"></i>
                        </div>
                        <div class="file-upload-text" id="fileName">
                            Nhấn để chọn file PDF
                        </div>
                        <div class="file-upload-hint">
                            hoặc kéo thả file vào đây
                        </div>
                    </div>
                    <div class="form-hint">
                        <i class="fa fa-info-circle"></i>
                        Chỉ chấp nhận file PDF, dung lượng tối đa 10MB
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-save"></i>
                        Lưu thay đổi
                    </button>
                    
                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/cv/list" class="btn btn-secondary">
                            <i class="fa fa-arrow-left"></i>
                            Quay lại
                        </a>
                        <a target="_blank" 
                           href="${pageContext.request.contextPath}/cv/preview?cvid=${cv.cvId}" 
                           class="btn btn-secondary">
                            <i class="fa fa-eye"></i>
                            Xem trước
                        </a>
                        <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" 
                           class="btn btn-secondary">
                            <i class="fa fa-download"></i>
                            Tải xuống
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script>
        function updateFileName(input) {
            const fileName = input.files[0] ? input.files[0].name : 'Nhấn để chọn file PDF';
            document.getElementById('fileName').textContent = fileName;
            
            if (input.files[0]) {
                const fileSize = input.files[0].size / 1024 / 1024; // Convert to MB
                if (fileSize > 10) {
                    alert('Kích thước file vượt quá 10MB. Vui lòng chọn file khác.');
                    input.value = '';
                    document.getElementById('fileName').textContent = 'Nhấn để chọn file PDF';
                }
            }
        }

        // Drag and drop functionality
        const uploadArea = document.querySelector('.file-upload-area');
        const fileInput = uploadArea.querySelector('input[type="file"]');

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.style.borderColor = 'var(--color-primary)';
                uploadArea.style.background = '#F0F4FF';
            }, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.style.borderColor = 'var(--color-border)';
                uploadArea.style.background = '#F8FAFC';
            }, false);
        });

        uploadArea.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            
            if (files.length > 0 && files[0].type === 'application/pdf') {
                fileInput.files = files;
                updateFileName(fileInput);
            } else {
                alert('Vui lòng chỉ tải lên file PDF');
            }
        }, false);
    </script>
</body>
</html>
