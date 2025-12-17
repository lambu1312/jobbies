<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo CV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(to bottom, #f8f9fa 0%, #e9ecef 100%);
            color: #212529;
            min-height: 100vh;
            padding-top: 80px;
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
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);
            max-width: 800px;
            margin: 0 auto;
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
            margin-bottom: 50px;
        }
        
        .cv-options {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .cv-option-card {
            flex: 1;
            min-width: 280px;
            max-width: 350px;
            padding: 35px 30px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            text-decoration: none;
            color: #2c3e50;
            transition: all 0.3s ease;
            background: #ffffff;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .cv-option-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
            border-color: #667eea;
            color: #667eea;
        }
        
        .cv-option-card .icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            display: block;
        }
        
        .cv-option-card .title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 12px;
            display: block;
        }
        
        .cv-option-card .description {
            font-size: 0.9rem;
            color: #6c757d;
            line-height: 1.6;
        }
        
        .cv-option-card:hover .description {
            color: #495057;
        }
        
        .back-link-section {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid #e9ecef;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background-color: #f8f9fa;
            color: #495057;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 2px solid #e9ecef;
        }
        
        .back-link:hover {
            background-color: #e9ecef;
            color: #212529;
            transform: translateX(-3px);
            border-color: #dee2e6;
        }
        
        .back-link i {
            transition: transform 0.3s ease;
        }
        
        .back-link:hover i {
            transform: translateX(-3px);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 1.75rem;
            }
            
            .cv-options {
                flex-direction: column;
                gap: 15px;
            }
            
            .cv-option-card {
                min-width: 100%;
                padding: 25px 20px;
            }
            
            .cv-option-card .icon {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>
    <!-- Header Area End -->

    <div class="container">
        <h2>Tạo CV của bạn</h2>
        <p class="page-subtitle">Chọn phương thức tạo CV phù hợp với nhu cầu của bạn</p>
        
        <div class="cv-options">
            <a href="${pageContext.request.contextPath}/cv/edit" class="cv-option-card">
                <span class="icon">✏️</span>
                <span class="title">Tạo CV đơn giản</span>
                <p class="description">
                    Tạo CV nhanh chóng với công cụ soạn thảo trực tuyến. 
                    Dễ dàng chỉnh sửa và cập nhật thông tin.
                </p>
            </a>
            
            <a href="${pageContext.request.contextPath}/cv/upload" class="cv-option-card">
                <span class="icon">📄</span>
                <span class="title">Upload CV PDF</span>
                <p class="description">
                    Tải lên file CV có sẵn của bạn ở định dạng PDF. 
                    Nhanh gọn và tiện lợi.
                </p>
            </a>
        </div>
        
        <div class="back-link-section">
            <a href="${pageContext.request.contextPath}/cv/list" class="back-link">
                <i class="fa fa-arrow-left"></i>
                Quay lại danh sách CV
            </a>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <!-- Bootstrap and JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
