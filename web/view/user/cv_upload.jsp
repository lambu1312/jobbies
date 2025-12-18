<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload CV PDF</title>
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
            --color-info: #0EA5E9;
            --color-info-light: #E0F2FE;
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
            max-width: 700px;
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
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--color-text-secondary);
            font-weight: 400;
        }

        .upload-hero {
            text-align: center;
            padding: 2.5rem 2rem;
            background: linear-gradient(135deg, #F0F4FF 0%, #E0F2FE 100%);
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            border: 2px dashed var(--color-primary);
            animation: fadeInUp 0.6s ease-out 0.1s both;
        }

        .upload-hero-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
        }

        .upload-hero-text {
            color: var(--color-text-secondary);
            font-size: 0.9375rem;
        }

        .info-box {
            background: var(--color-info-light);
            border-left: 4px solid var(--color-info);
            padding: 1.25rem 1.5rem;
            border-radius: var(--radius-md);
            margin-bottom: 2rem;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        .info-box-title {
            font-size: 0.9375rem;
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-box-title i {
            color: var(--color-info);
        }

        .info-box ul {
            margin: 0;
            padding-left: 1.5rem;
            color: var(--color-text-secondary);
            font-size: 0.875rem;
        }

        .info-box ul li {
            margin-bottom: 0.375rem;
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
            animation: fadeInUp 0.6s ease-out 0.3s both;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group:last-of-type {
            margin-bottom: 0;
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

        .required {
            color: var(--color-danger);
            margin-left: 0.25rem;
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
            padding: 2.5rem 2rem;
            text-align: center;
            background: #F8FAFC;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .file-upload-area:hover {
            border-color: var(--color-primary);
            background: #F0F4FF;
        }

        .file-upload-area.dragover {
            border-color: var(--color-primary);
            background: #F0F4FF;
            transform: scale(1.02);
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
            transition: all 0.3s ease;
        }

        .file-upload-area:hover .file-upload-icon {
            transform: scale(1.1);
        }

        .file-upload-text {
            color: var(--color-text-primary);
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 0.9375rem;
        }

        .file-upload-hint {
            color: var(--color-text-secondary);
            font-size: 0.875rem;
        }

        .file-name-display {
            margin-top: 1rem;
            padding: 0.75rem 1rem;
            background: var(--color-success-light);
            border: 1px solid var(--color-success);
            border-radius: var(--radius-sm);
            color: var(--color-success);
            font-size: 0.875rem;
            display: none;
            align-items: center;
            gap: 0.5rem;
        }

        .file-name-display.show {
            display: flex;
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
            padding-top: 1.5rem;
            border-top: 1px solid var(--color-border);
            margin-top: 1.5rem;
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
            flex: 1;
            justify-content: center;
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

            .upload-hero {
                padding: 2rem 1.5rem;
            }

            .upload-hero-icon {
                width: 70px;
                height: 70px;
                font-size: 1.75rem;
            }

            .file-upload-area {
                padding: 2rem 1.5rem;
            }

            .file-upload-icon {
                width: 50px;
                height: 50px;
                font-size: 1.25rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Upload CV PDF</h1>
            <p class="page-subtitle">Tải lên file CV có sẵn của bạn</p>
        </div>
        
<!--         Upload Hero 
        <div class="upload-hero">
            <div class="upload-hero-icon">
                <i class="fa fa-cloud-upload-alt"></i>
            </div>
            <p class="upload-hero-text">Nhanh chóng và tiện lợi - Chỉ cần vài bước đơn giản</p>
        </div>-->
        
        <!-- Info Box -->
        <div class="info-box">
            <h4 class="info-box-title">
                <i class="fa fa-info-circle"></i>
                Lưu ý khi upload CV
            </h4>
            <ul>
                <li>Chỉ chấp nhận file PDF</li>
                <li>Dung lượng tối đa: 10MB</li>
                <li>Đảm bảo CV của bạn rõ ràng và dễ đọc</li>
                <li>Nên đặt tên file có ý nghĩa để dễ quản lý</li>
            </ul>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>
        
        <!-- Upload Form -->
        <form method="post" action="${pageContext.request.contextPath}/cv/upload" enctype="multipart/form-data">
            <div class="form-card">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-heading"></i>
                        Tiêu đề CV
                        <span class="required">*</span>
                    </label>
                    <input type="text" 
                           name="title" 
                           class="form-control"
                           placeholder="VD: CV Marketing 2025" 
                           required />
                    <div class="form-hint">
                        <i class="fa fa-info-circle"></i>
                        Đặt tên để dễ dàng nhận diện CV trong danh sách
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-file-pdf"></i>
                        Chọn file PDF
                        <span class="required">*</span>
                    </label>
                    <div class="file-upload-area" id="uploadArea">
                        <input type="file" 
                               name="pdfFile" 
                               accept="application/pdf" 
                               id="fileInput"
                               required />
                        <div class="file-upload-icon">
                            <i class="fas fa-cloud-upload-alt"></i>
                        </div>
                        <div class="file-upload-text">
                            Kéo thả file hoặc click để chọn
                        </div>
                        <div class="file-upload-hint">
                            Định dạng: PDF | Dung lượng tối đa: 10MB
                        </div>
                    </div>
                    <div class="file-name-display" id="fileNameDisplay">
                        <i class="fas fa-file-pdf"></i>
                        <span id="fileName"></span>
                    </div>
                    <div class="form-hint">
                        <i class="fa fa-info-circle"></i>
                        File PDF sẽ được lưu trữ an toàn trong hệ thống
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-upload"></i>
                        Upload CV
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/cv/list" class="btn btn-secondary">
                        <i class="fa fa-arrow-left"></i>
                        Quay lại
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script>
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const fileNameDisplay = document.getElementById('fileNameDisplay');
        const fileNameSpan = document.getElementById('fileName');

        // File input change
        fileInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                
                // Validate file size (10MB)
                if (file.size > 10 * 1024 * 1024) {
                    alert('Kích thước file vượt quá 10MB. Vui lòng chọn file khác.');
                    this.value = '';
                    fileNameDisplay.classList.remove('show');
                    return;
                }
                
                // Validate file type
                if (file.type !== 'application/pdf') {
                    alert('Vui lòng chỉ tải lên file PDF');
                    this.value = '';
                    fileNameDisplay.classList.remove('show');
                    return;
                }
                
                // Display file name
                fileNameSpan.textContent = file.name;
                fileNameDisplay.classList.add('show');
            }
        });

        // Drag and drop functionality
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.classList.add('dragover');
            }, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.classList.remove('dragover');
            }, false);
        });

        uploadArea.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            
            if (files.length > 0) {
                if (files[0].type === 'application/pdf') {
                    fileInput.files = files;
                    
                    // Trigger change event
                    const event = new Event('change', { bubbles: true });
                    fileInput.dispatchEvent(event);
                } else {
                    alert('Vui lòng chỉ tải lên file PDF');
                }
            }
        }, false);
    </script>
</body>
</html>
