<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa CV đã tải lên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(to bottom, #f8f9fa 0%, #e9ecef 100%);
            color: #212529;
            min-height: 100vh;
            padding-bottom: 20px;
        }
        
        /* Sticky Header */
        body > *:first-child,
        header,
        nav,
        .header-area,
        [class*="header"] {
            position: sticky !important;
            top: 0 !important;
            z-index: 1000 !important;
            background-color: #fff !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1) !important;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);
            max-width: 800px;
            margin: 30px auto;
        }

        h2 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 10px;
            text-align: center;
            letter-spacing: -0.5px;
            position: relative;
            padding-bottom: 20px;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }
        
        .page-subtitle {
            text-align: center;
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 40px;
        }
        
        .form-section {
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: block;
            font-size: 0.95rem;
        }
        
        .form-label i {
            margin-right: 6px;
            color: #667eea;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            background-color: #fff;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.15);
        }
        
        .file-input-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .file-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px dashed #667eea;
            border-radius: 8px;
            background-color: #f8f9ff;
            cursor: pointer;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }
        
        .file-input:hover {
            background-color: #f0f2ff;
            border-color: #5568d3;
        }
        
        .file-input::file-selector-button {
            padding: 8px 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            margin-right: 10px;
            transition: all 0.2s ease;
        }
        
        .file-input::file-selector-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(102,126,234,0.3);
        }
        
        .actions-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            padding-top: 25px;
            border-top: 1px solid #e9ecef;
            flex-wrap: wrap;
        }
        
        .btn-primary {
            padding: 12px 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(102,126,234,0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102,126,234,0.4);
        }
        
        .quick-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .btn-secondary {
            padding: 10px 18px;
            background-color: #f8f9fa;
            color: #495057;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-secondary:hover {
            background-color: #e9ecef;
            color: #212529;
            transform: translateY(-1px);
            text-decoration: none;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            padding: 16px 20px;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #58151c;
        }
        
        .help-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .help-text i {
            color: #667eea;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 25px 20px;
            }
            
            h2 {
                font-size: 1.75rem;
            }
            
            .form-section {
                padding: 20px;
            }
            
            .actions-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-primary {
                width: 100%;
            }
            
            .quick-actions {
                flex-direction: column;
            }
            
            .btn-secondary {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>
    <!-- Header Area End -->

    <div class="container">
        <h2>Chỉnh sửa CV đã tải lên</h2>
        <p class="page-subtitle">Cập nhật thông tin và thay thế file PDF của CV</p>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fa fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <!-- Edit Form -->
        <form method="post"
              action="${pageContext.request.contextPath}/cv/upload-replace"
              enctype="multipart/form-data">
            <input type="hidden" name="cvid" value="${cv.cvId}" />
            
            <div class="form-section">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-heading"></i> Tiêu đề CV
                    </label>
                    <input type="text" 
                           name="title" 
                           value="${cv.title}" 
                           class="form-control"
                           placeholder="Nhập tiêu đề cho CV của bạn"
                           required />
                    <div class="help-text">
                        <i class="fa fa-info-circle"></i>
                        Tiêu đề giúp bạn dễ dàng nhận diện CV trong danh sách
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fa fa-file-pdf"></i> Tải lên file PDF mới
                    </label>
                    <input type="file" 
                           name="pdfFile" 
                           accept="application/pdf" 
                           class="file-input"
                           required />
                    <div class="help-text">
                        <i class="fa fa-info-circle"></i>
                        Chỉ chấp nhận file PDF, dung lượng tối đa 10MB
                    </div>
                </div>
            </div>
            
            <div class="actions-section">
                <button type="submit" class="btn-primary">
                    <i class="fa fa-save"></i> Lưu thay đổi
                </button>
                
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/cv/list" class="btn-secondary">
                        <i class="fa fa-arrow-left"></i> Quay lại
                    </a>
                    <a target="_blank" 
                       href="${pageContext.request.contextPath}/cv/preview?cvid=${cv.cvId}" 
                       class="btn-secondary">
                        <i class="fa fa-eye"></i> Xem trước
                    </a>
                    <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" 
                       class="btn-secondary">
                        <i class="fa fa-download"></i> Tải xuống
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <!-- Bootstrap and JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
