<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Application Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                <style>
            /* CSS LẤY TỪ HOME.HTML (Phong cách Không gian/Neon) */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
                overflow-x: hidden;
                min-height: 100vh;
            }

            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
            }

            .star {
                position: absolute;
                width: 2px;
                height: 2px;
                background: #fff;
                border-radius: 50%;
                animation: twinkle 3s infinite;
            }

            @keyframes twinkle {
                0%, 100% {
                    opacity: 0.3;
                }
                50% {
                    opacity: 1;
                }
            }

            /* --- CÁC STYLE KHÁC VẪN GIỮ NGUYÊN --- */

            /* Chú ý: Nếu header-area.jsp không có nền trong suốt, 
            nó sẽ che mất nền sao, bạn có thể cần chỉnh style cho nó.
            Ví dụ: header { background: rgba(0,0,0,0.5) !important; z-index: 100; }
            (Giả sử header-area.jsp có thẻ <header>) */

            .hero-section {
                position: relative;
                z-index: 10;
                text-align: center;
                padding: 4rem 2rem;
                margin-top: 2rem;
            }

            .hero-section h1 {
                font-size: 4rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #7ee8fa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1rem;
                text-shadow: 0 0 60px rgba(196, 113, 245, 0.5);
                line-height: 1.2;
            }

            .hero-section p {
                font-size: 1.3rem;
                color: #b8b8d1;
                margin-bottom: 3rem;
            }

            .search-container-custom {
                position: relative;
                max-width: 700px;
                margin: 0 auto 4rem;
            }

            .search-wrapper {
                position: relative;
                background: rgba(255, 255, 255, 0.08);
                backdrop-filter: blur(30px);
                border-radius: 60px;
                padding: 1.5rem 3rem;
                border: 2px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.3);
                animation: float 6s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            .search-wrapper::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(135deg, #c471f5, #fa71cd, #7ee8fa);
                border-radius: 60px;
                z-index: -1;
                opacity: 0.5;
                filter: blur(20px);
            }

            .search-input-custom {
                width: 100%;
                background: transparent;
                border: none;
                outline: none;
                color: #fff;
                font-size: 1.2rem;
                font-weight: 500;
            }

            .search-input-custom::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            /* Filter Sidebar Custom */
            .filter-form-custom {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                color: #fff;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .filter-form-custom h4 {
                color: #fff;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 700;
            }

            .form-control, .form-select, .input-group-text {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: #fff;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.6);
            }

            .form-select option {
                background-color: #1a0b2e;
                color: #fff;
            }

            .btn-success {
                background: linear-gradient(135deg, #fa71cd 0%, #c471f5 100%);
                border: none;
                font-weight: 700;
                margin-top: 1rem;
            }

            .btn-success:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            }

            /* Featured Jobs Section */
            .featured-jobs {
                position: relative;
                z-index: 10;
                max-width: 1200px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 900;
                margin-bottom: 2rem;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .job-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
            }

            .job-card-custom {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                transition: all 0.3s;
                cursor: pointer;
                position: relative;
                overflow: hidden;
                height: 100%;
                color: #fff;
            }

            .job-card-custom::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
                transition: left 0.5s;
            }

            .job-card-custom:hover::before {
                left: 100%;
            }

            .job-card-custom:hover {
                transform: translateY(-10px);
                border-color: #c471f5;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
            }

            .job-card-link-custom {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .job-card-link-custom:hover {
                color: inherit;
            }

            .job-title-custom {
                font-size: 1.3rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                color: #fff;
            }

            .job-company-custom {
                color: #c471f5;
                font-weight: 600;
            }

            .job-badge-custom {
                background: linear-gradient(135deg, #39ff14, #7ee8fa);
                color: #000;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 700;
            }

            .job-details-custom {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
                margin-top: 1rem;
                color: #b8b8d1;
                font-size: 0.9rem;
            }

            .job-details-custom span {
                display: block;
            }

            /* Pagination custom style */
            .pagination .page-item a {
                background-color: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                color: #fff;
                transition: all 0.3s;
            }

            .pagination .page-item a:hover {
                background-color: rgba(196, 113, 245, 0.2);
                border-color: #c471f5;
                color: #c471f5;
            }

            .pagination .page-item.active a {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border-color: #c471f5;
                color: #fff;
            }

            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.3;
                z-index: 5;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 {
                top: 20%;
                left: 10%;
            }
            .deco-2 {
                top: 60%;
                right: 15%;
                animation-delay: 2s;
            }
            .deco-3 {
                bottom: 15%;
                left: 20%;
                animation-delay: 1s;
            }

            .no-jobs-message {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                padding: 2rem;
                color: #fa71cd;
                border: 1px solid #fa71cd;
            }

        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <div class="stars" id="stars"></div>

        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

   
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class="container mb-5 mt-5">
                <h1 class="text-center">Application Details</h1>

            <c:if test="${not empty errorApplication}">
                <div class="alert alert-danger" role="alert">
                    ${errorApplication}
                </div>
            </c:if>

            <c:if test="${empty errorApplication}">
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-section">
                            <h2 class="section-header">Information</h2>
                            <c:if test="${not empty account}">
                                <p><strong>Fullname:</strong> ${account.fullName}</p>
                                <p><strong>Date of birth:</strong> ${account.dob}</p>
                                <p><strong>Phone Number:</strong> ${account.phone}</p>
                                <p><strong>Email:</strong> ${account.email}</p>
                                <p><strong>Gender:</strong> ${account.gender ? 'Male' : 'Female'}</p>
                                <p><strong>Address:</strong> ${account.address}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-section">
                            <h2 class="section-header">Application Information</h2>
                            <c:if test="${not empty application}">
                                <p><strong>Applied Date:</strong> ${application.appliedDate}</p>
                                <p><strong>Status:</strong> 
                                    <c:choose>
                                        <c:when test="${application.status == 3}">
                                            <span class="badge bg-info text-dark"><i class="fa fa-clock"></i> Pending</span>
                                        </c:when>
                                        <c:when test="${application.status == 2}">
                                            <span class="badge bg-success"><i class="fa fa-check-circle"></i> Approved</span>
                                        </c:when>
                                        <c:when test="${application.status == 1}">
                                            <span class="badge bg-danger"><i class="fa fa-times-circle"></i> Rejected</span>
                                        </c:when>
                                        <c:when test="${application.status == 0}">
                                            <span class="badge bg-secondary"><i class="fa fa-ban"></i> Cancelled</span>
                                        </c:when>
                                    </c:choose>
                                </p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="info-section">
                            <h2 class="section-header">Job Posting Details</h2>
                            <c:if test="${not empty jobPost}">
                                <p><strong>Title:</strong> ${jobPost.title}</p>
                                <p><strong>Location:</strong> ${jobPost.location}</p>
                                <p><strong>Salary:</strong> ${jobPost.minSalary} $ - ${jobPost.maxSalary} $</p>
                                <c:choose>
                                    <c:when test="${category != 'This category was deleted!'}">
                                        <!-- Hiển thị thông tin Category nếu Category hợp lệ -->
                                        <p><strong>Job Category:</strong> ${category.name}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Hiển thị thông báo lỗi nếu Category bị xóa hoặc không tồn tại -->
                                        <p><strong>Job Category:</strong> This category was deleted!</p>
                                    </c:otherwise>
                                </c:choose>
                                <p><strong>Description:</strong> ${jobPost.description}</p>
                                <p><strong>Requirement:</strong> ${jobPost.requirements}</p>
                            </c:if>
                            <c:if test="${empty jobPost}">
                                <p>Job posting details are not available.</p>
                            </c:if>

                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-section">
                            <h2 class="section-header">CV Details</h2>
                            <c:if test="${not empty cv}">
                                <iframe src="cv?action=view-cv" height="500px" width="100%" allowfullscreen="" frameborder="0"></iframe>
                                </c:if>
                                <c:if test="${empty cv}">
                                <p>CV details are not available.</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-brand">
                    <h3><i class="fas fa-briefcase"></i> Jobbies</h3>
                    <p>Nền tảng tìm việc làm hàng đầu Việt Nam, kết nối hàng nghìn ứng viên với các cơ hội nghề nghiệp tuyệt vời mỗi ngày.</p>
                </div>
                <div class="footer-column">
                    <h4>Dành cho ứng viên</h4>
                    <a href="#">Tìm việc làm</a>
                    <a href="#">Tạo CV</a>
                    <a href="#">Việc làm đã lưu</a>
                    <a href="#">Cẩm nang nghề nghiệp</a>
                </div>
                <div class="footer-column">
                    <h4>Dành cho nhà tuyển dụng</h4>
                    <a href="#">Đăng tin tuyển dụng</a>
                    <a href="#">Tìm kiếm ứng viên</a>
                    <a href="#">Bảng giá dịch vụ</a>
                    <a href="#">Liên hệ hỗ trợ</a>
                </div>
                <div class="footer-column">
                    <h4>Theo dõi chúng tôi</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Jobbies. All rights reserved. | <a href="#">Điều khoản sử dụng</a> | <a href="#">Chính sách bảo mật</a></p>
            </div>
        </footer>

        <!-- Bootstrap and JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
