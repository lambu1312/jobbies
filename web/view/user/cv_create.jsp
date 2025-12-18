<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo CV</title>
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

        .cv-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .cv-option-card {
            background: var(--color-surface);
            border-radius: var(--radius-lg);
            border: 2px solid var(--color-border);
            padding: 2.5rem 2rem;
            text-decoration: none;
            color: var(--color-text-primary);
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: var(--shadow-md);
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .cv-option-card:nth-child(1) { animation-delay: 0.1s; }
        .cv-option-card:nth-child(2) { animation-delay: 0.2s; }

        .cv-option-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: var(--color-primary);
        }

        .cv-option-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #E0F2FE 0%, #F0F9FF 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 2.5rem;
            transition: all 0.3s ease;
        }

        .cv-option-card:hover .cv-option-icon {
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
            transform: scale(1.1);
        }

        .cv-option-card:hover .cv-option-icon i {
            color: white;
        }

        .cv-option-icon i {
            color: var(--color-primary);
            transition: color 0.3s ease;
        }

        .cv-option-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            color: var(--color-text-primary);
        }

        .cv-option-description {
            font-size: 0.9375rem;
            color: var(--color-text-secondary);
            line-height: 1.6;
        }

        .cv-option-card:hover .cv-option-title {
            color: var(--color-primary);
        }

        .back-section {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid var(--color-border);
            animation: fadeInUp 0.6s ease-out 0.3s both;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: var(--color-surface);
            color: var(--color-text-secondary);
            text-decoration: none;
            border-radius: var(--radius-sm);
            font-weight: 500;
            transition: all 0.2s ease;
            border: 1px solid var(--color-border);
        }

        .btn-back:hover {
            background: #F8FAFC;
            border-color: var(--color-primary);
            color: var(--color-primary);
            transform: translateX(-2px);
        }

        .btn-back i {
            transition: transform 0.2s ease;
        }

        .btn-back:hover i {
            transform: translateX(-2px);
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .cv-options {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .cv-option-card {
                padding: 2rem 1.5rem;
            }

            .cv-option-icon {
                width: 70px;
                height: 70px;
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Tạo CV của bạn</h1>
            <p class="page-subtitle">Chọn phương thức tạo CV phù hợp với nhu cầu của bạn</p>
        </div>
        
        <div class="cv-options">
            <a href="${pageContext.request.contextPath}/cv/builder-add" class="cv-option-card">
                <div class="cv-option-icon">
                    <i class="fas fa-edit"></i>
                </div>
                <h3 class="cv-option-title">Tạo CV đơn giản</h3>
                <p class="cv-option-description">
                    Tạo CV nhanh chóng với công cụ soạn thảo trực tuyến. 
                    Dễ dàng chỉnh sửa và cập nhật thông tin.
                </p>
            </a>
            
            <a href="${pageContext.request.contextPath}/cv/upload" class="cv-option-card">
                <div class="cv-option-icon">
                    <i class="fas fa-file-upload"></i>
                </div>
                <h3 class="cv-option-title">Upload CV PDF</h3>
                <p class="cv-option-description">
                    Tải lên file CV có sẵn của bạn ở định dạng PDF. 
                    Nhanh gọn và tiện lợi.
                </p>
            </a>
        </div>
        
        <div class="back-section">
            <a href="${pageContext.request.contextPath}/cv/list" class="btn-back">
                <i class="fa fa-arrow-left"></i>
                <span>Quay lại danh sách CV</span>
            </a>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
