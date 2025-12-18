<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Seeker Profile</title>
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

        .alert-danger {
            background: var(--color-danger-light);
            border-color: var(--color-danger);
            color: var(--color-danger);
        }

        .alert-danger ul {
            margin: 0;
            padding-left: 1.25rem;
        }

        .alert-danger li {
            margin-bottom: 0.25rem;
        }

        .alert-success {
            background: var(--color-success-light);
            border-color: var(--color-success);
            color: var(--color-success);
        }

        .form-card {
            background: var(--color-surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--color-border);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            animation: fadeInUp 0.6s ease-out 0.1s both;
        }

        .card-header {
            background: linear-gradient(to bottom, #F8FAFC, #F1F5F9);
            padding: 1.25rem 2rem;
            border-bottom: 2px solid var(--color-border);
        }

        .card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--color-text-primary);
            margin: 0;
        }

        .card-body {
            padding: 2rem;
        }

        .avatar-section {
            text-align: center;
            margin-bottom: 2rem;
        }

        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--color-border);
            margin-bottom: 1rem;
            box-shadow: var(--shadow-md);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group-full {
            grid-column: 1 / -1;
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
            box-shadow: 0 0 0 3px rgba(43, 89, 255, 0.1);
        }

        .form-control:read-only {
            background-color: #F8FAFC;
            color: var(--color-text-secondary);
            cursor: not-allowed;
        }

        .file-upload-wrapper {
            position: relative;
        }

        .file-upload-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1.125rem;
            background: white;
            color: var(--color-text-secondary);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .file-upload-btn:hover {
            background: #F8FAFC;
            border-color: var(--color-primary);
            color: var(--color-primary);
        }

        .file-upload-input {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }

        .btn-submit {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
            max-width: 300px;
            margin: 0 auto;
            padding: 0.875rem 2rem;
            background: var(--color-success);
            color: white;
            border: 1px solid var(--color-success);
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.9375rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-submit:hover {
            background: #0C8A5F;
            border-color: #0C8A5F;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(14, 167, 112, 0.25);
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .avatar-preview {
                width: 120px;
                height: 120px;
            }

            .btn-submit {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Header Area -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Chỉnh sửa hồ sơ</h1>
            <p class="page-subtitle">Cập nhật thông tin cá nhân của bạn</p>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <!-- Error Messages -->
        <c:if test="${not empty errorsMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <div>
                    <ul>
                        <c:forEach var="error" items="${errorsMessage}">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <span>${requestScope.error}</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/authen?action=edit-profile" method="POST" id="profile-form" enctype="multipart/form-data">
            <div class="form-card">
                <div class="card-header">
                    <h2 class="card-title">
                        <i class="fas fa-user"></i> Thông tin cá nhân
                    </h2>
                </div>
                <div class="card-body">
                    <!-- Avatar Section -->
                    <div class="avatar-section">
                        <c:choose>
                            <c:when test="${empty sessionScope.account.getAvatar()}">
                                <img id="preview" src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" 
                                     alt="Avatar" class="avatar-preview">
                            </c:when>
                            <c:otherwise>
                                <img id="preview" src="${sessionScope.account.getAvatar()}" 
                                     alt="Avatar" class="avatar-preview">
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="file-upload-wrapper">
                            <label class="file-upload-btn">
                                <i class="fas fa-camera"></i>
                                Tải ảnh mới
                                <input type="file" class="file-upload-input" id="file" name="avatar" 
                                       accept="image/*" onchange="previewImage(event)">
                            </label>
                        </div>
                    </div>

                    <!-- Form Fields -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="lname" class="form-label">Họ</label>
                            <input type="text" name="lastName" id="lname" class="form-control" 
                                   readonly required value="${sessionScope.account.getLastName()}">
                        </div>
                        <div class="form-group">
                            <label for="fname" class="form-label">Tên</label>
                            <input type="text" name="firstName" id="fname" class="form-control" 
                                   readonly required value="${sessionScope.account.getFirstName()}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text" name="phone" id="phone" class="form-control" 
                                   placeholder="+84" required value="${sessionScope.account.getPhone()}">
                        </div>
                        <div class="form-group">
                            <label for="dob" class="form-label">Ngày sinh</label>
                            <input type="date" name="date" id="dob" class="form-control" 
                                   readonly value="${sessionScope.account.getDob()}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="genderDisplay" class="form-label">Giới tính</label>
                            <input type="text" id="genderDisplay" class="form-control" 
                                   value="${sessionScope.account.gender == true ? 'Nam' : 'Nữ'}" readonly>
                            <input type="hidden" name="gender" id="genderHidden">
                        </div>
                        <div class="form-group">
                            <label for="add" class="form-label">Địa chỉ</label>
                            <input type="text" name="address" id="add" class="form-control" 
                                   placeholder="Nhập địa chỉ của bạn" required value="${sessionScope.account.getAddress()}">
                        </div>
                    </div>

                    <div class="form-group form-group-full">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" name="email" id="email" class="form-control" 
                               value="${sessionScope.account.getEmail()}" required readonly>
                    </div>
                </div>
            </div>

            <div style="margin-top: 2rem;">
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save"></i>
                    Lưu thông tin
                </button>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <script>
        function previewImage(event) {
            var input = event.target;
            if (!input.files || !input.files[0]) return;

            var reader = new FileReader();
            reader.onload = function (e) {
                var output = document.getElementById('preview');
                if (output) {
                    output.src = e.target.result;
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    </script>
</body>
</html>
