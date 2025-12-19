<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Check CV</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --color-primary: #667eea;
            --color-primary-dark: #5568d3;
            --color-secondary: #764ba2;
            --color-text-primary: #0A0E27;
            --color-text-secondary: #5B6B8C;
            --color-border: #E4E8F0;
            --color-background: #FAFBFC;
            --color-surface: #FFFFFF;
            --color-success: #0EA770;
            --color-success-light: #E8F7F0;
            --color-danger: #E03E52;
            --color-danger-light: #FFEBEE;
            --color-info: #667eea;
            --color-info-light: #E0E7FF;
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
            max-width: 900px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-title i {
            background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            font-size: 1rem;
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

        .alert i {
            flex-shrink: 0;
            margin-top: 0.125rem;
        }

        .alert-success {
            background: var(--color-success-light);
            border-color: var(--color-success);
            color: var(--color-success);
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
            display: block;
            font-weight: 600;
            color: var(--color-text-primary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
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
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        input[type="file"].form-control {
            cursor: pointer;
            padding: 0.625rem 1rem;
        }

        input[type="file"].form-control::file-selector-button {
            padding: 0.5rem 1rem;
            border: 1px solid var(--color-border);
            border-radius: var(--radius-sm);
            background: #F8FAFC;
            color: var(--color-text-primary);
            cursor: pointer;
            font-weight: 500;
            font-size: 0.875rem;
            margin-right: 1rem;
            transition: all 0.2s ease;
        }

        input[type="file"].form-control::file-selector-button:hover {
            background: var(--color-info-light);
            border-color: var(--color-primary);
            color: var(--color-primary);
        }

        .form-hint {
            font-size: 0.8125rem;
            color: var(--color-text-secondary);
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-hint i {
            font-size: 0.75rem;
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
            background: none;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
            color: white;
            border-color: var(--color-primary);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--color-primary-dark), #6842a0);
            border-color: var(--color-primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:disabled {
            background: #E4E8F0;
            border-color: #E4E8F0;
            color: #9CA3AF;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .info-box {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            border: 1px solid rgba(102, 126, 234, 0.2);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .info-box-title {
            font-weight: 600;
            color: var(--color-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .info-box-title i {
            font-size: 1.25rem;
        }

        .info-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .info-list li {
            padding: 0.5rem 0;
            color: var(--color-text-secondary);
            font-size: 0.875rem;
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .info-list li i {
            color: var(--color-primary);
            margin-top: 0.125rem;
            font-size: 0.75rem;
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
        <h1 class="page-title">
            <i class="fas fa-robot"></i> AI Check CV
        </h1>
        <p class="page-subtitle">Phân tích CV của bạn bằng trí tuệ nhân tạo</p>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/cv-ai" method="post" enctype="multipart/form-data">
        <div class="form-card">
            <div class="form-group">
                <label class="form-label">Chọn File CV (PDF) *</label>
                <input class="form-control" type="file" name="pdfFile" accept="application/pdf" required />
                <div class="form-hint">
                    <i class="fas fa-info-circle"></i>
                    Dung lượng tối đa 10MB. PDF phải có text (không phải ảnh scan).
                </div>
            </div>

            <button class="btn btn-primary" type="submit">
                <i class="fas fa-wand-magic-sparkles"></i>
                Quét CV Bằng AI
            </button>

            <div class="info-box">
                <div class="info-box-title">
                    <i class="fas fa-lightbulb"></i>
                    AI sẽ phân tích những gì?
                </div>
                <ul class="info-list">
                    <li>
                        <i class="fas fa-circle"></i>
                        <span>Đánh giá cấu trúc và bố cục CV</span>
                    </li>
                    <li>
                        <i class="fas fa-circle"></i>
                        <span>Kiểm tra nội dung và độ chuyên nghiệp</span>
                    </li>
                    <li>
                        <i class="fas fa-circle"></i>
                        <span>Đề xuất cải thiện và tối ưu hóa</span>
                    </li>
                    <li>
                        <i class="fas fa-circle"></i>
                        <span>So sánh với tiêu chuẩn ngành</span>
                    </li>
                </ul>
            </div>
        </div>
    </form>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>
