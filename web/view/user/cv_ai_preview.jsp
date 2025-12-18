<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Quét CV - Preview</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            animation: fadeInUp 0.6s ease-out;
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
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-title i {
            background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .confidence-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: var(--color-info-light);
            border: 1px solid var(--color-primary);
            border-radius: var(--radius-md);
            font-size: 0.875rem;
            color: var(--color-primary);
            font-weight: 600;
        }

        .confidence-badge i {
            font-size: 1rem;
        }

        .message-text {
            color: var(--color-text-secondary);
            font-size: 0.875rem;
            margin-top: 0.5rem;
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

        .content-wrapper {
            display: flex;
            gap: 2rem;
            align-items: flex-start;
            animation: fadeInUp 0.6s ease-out 0.1s both;
        }

        .pdf-section {
            flex: 1.2;
            min-width: 0;
        }

        .form-section {
            flex: 1;
            min-width: 360px;
        }

        .card {
            background: var(--color-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--color-border);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
        }

        .pdf-viewer {
            width: 100%;
            height: 75vh;
            border: 1px solid var(--color-border);
            border-radius: var(--radius-md);
            background: var(--color-surface);
        }

        .no-pdf-message {
            padding: 3rem;
            text-align: center;
            color: var(--color-danger);
            background: var(--color-danger-light);
            border: 1px solid var(--color-danger);
            border-radius: var(--radius-md);
        }

        .no-pdf-message i {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
        }

        .form-group {
            margin-bottom: 1.25rem;
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

        .form-actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--color-border);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            border: 1px solid;
            white-space: nowrap;
            background: none;
            flex: 1;
            justify-content: center;
        }

        .btn i {
            font-size: 0.875rem;
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

        .btn-danger {
            background: var(--color-surface);
            color: var(--color-danger);
            border-color: var(--color-danger);
        }

        .btn-danger:hover {
            background: var(--color-danger);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(224, 62, 82, 0.25);
        }

        .form-card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--color-border);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-card-title i {
            color: var(--color-primary);
        }

        @media (max-width: 1024px) {
            .content-wrapper {
                flex-direction: column;
            }

            .pdf-section,
            .form-section {
                width: 100%;
                min-width: 0;
            }

            .pdf-viewer {
                height: 60vh;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .card {
                padding: 1.25rem;
            }

            .page-title {
                font-size: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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
            <i class="fas fa-robot"></i> AI Đã Quét Xong CV
        </h1>
        

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

    <div class="content-wrapper">
        <!-- PDF Preview Section -->
        <div class="pdf-section">
            <div class="card">
                <c:choose>
                    <c:when test="${not empty pdfUrl}">
                        <iframe src="${pdfUrl}" class="pdf-viewer"></iframe>
                    </c:when>
                    <c:otherwise>
                        <div class="no-pdf-message">
                            <i class="fas fa-file-pdf"></i>
                            <div>Không có đường dẫn PDF để hiển thị.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Form Section -->
        <div class="form-section">
            <form method="post" action="${pageContext.request.contextPath}/cv-ai" class="card">
                <input type="hidden" name="action" value="save"/>

                <div class="form-card-title">
                    <i class="fas fa-user-edit"></i>
                    Kiểm Tra & Hoàn Thiện Thông Tin
                </div>

                <div class="form-group">
                    <label class="form-label">Họ Và Tên</label>
                    <input class="form-control" name="fullName" value="${draft.fullName}" placeholder="Nguyễn Văn A" />
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input class="form-control" type="email" name="email" value="${draft.email}" placeholder="example@email.com" />
                </div>

                <div class="form-group">
                    <label class="form-label">Số Điện Thoại</label>
                    <input class="form-control" type="tel" name="phone" value="${draft.phone}" placeholder="0123456789" />
                </div>

                <div class="form-group">
                    <label class="form-label">Ngày Sinh</label>
                    <input class="form-control" type="date" name="dob" value="${draft.dob}" placeholder="yyyy-MM-dd" />
                </div>

                <div class="form-group">
                    <label class="form-label">Địa Chỉ</label>
                    <input class="form-control" name="address" value="${draft.address}" placeholder="Hà Nội, Việt Nam" />
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Lưu Thông Tin
                    </button>
                </div>
            </form>

            <form method="post" action="${pageContext.request.contextPath}/cv-ai" style="margin-top: 1rem;">
                <input type="hidden" name="action" value="discard"/>
                <div class="card" style="padding: 1rem;">
                    <button type="submit" class="btn btn-danger" style="width: 100%;">
                        <i class="fas fa-times-circle"></i>
                        Hủy Bỏ
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>
