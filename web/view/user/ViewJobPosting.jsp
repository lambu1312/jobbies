<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Công Việc - Jobbies</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Poppins:wght@400;600;700;900&display=swap" rel="stylesheet">
        
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
                overflow-x: hidden;
                min-height: 100vh;
                padding-top: 80px;
            }

            /* Stars Background */
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
                0%, 100% { opacity: 0.3; }
                50% { opacity: 1; }
            }

            /* Floating Decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.3;
                z-index: 5;
                animation: float 4s ease-in-out infinite;
            }

            .deco-1 { top: 20%; left: 10%; }
            .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
            .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }

            /* Alert Styling */
            .alert {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 15px;
                color: #fff;
                margin-bottom: 2rem;
            }

            .alert-danger {
                border-color: rgba(220, 53, 69, 0.5);
                background: rgba(220, 53, 69, 0.1);
            }

            .alert-success {
                border-color: rgba(40, 167, 69, 0.5);
                background: rgba(40, 167, 69, 0.1);
            }

            /* Card Styling */
            .card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
                margin-bottom: 2rem;
                position: relative;
                z-index: 10;
            }

            .card:hover {
                transform: translateY(-5px);
                border-color: rgba(196, 113, 245, 0.3);
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.2);
            }

            .card-header {
                background: linear-gradient(135deg, rgba(196, 113, 245, 0.2) 0%, rgba(250, 113, 205, 0.2) 100%);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px 20px 0 0 !important;
                padding: 1.5rem;
                font-weight: 700;
            }

            .card-header h1, .card-header h5 {
                margin: 0;
                color: #fff;
                text-shadow: 0 2px 10px rgba(196, 113, 245, 0.3);
            }

            .card-title {
                font-size: 2rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 1.5rem;
            }

            .card-body {
                padding: 2rem;
            }

            .card-body p {
                color: #e2e8f0;
                line-height: 1.8;
            }

            .card-body strong {
                color: #c471f5;
                font-weight: 600;
            }

            /* Icon Styling */
            .card-body i, .btn i {
                color: #7ee8fa;
                margin-right: 8px;
            }

            /* Button Styling */
            .btn {
                border-radius: 12px;
                padding: 12px 24px;
                font-weight: 600;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-primary {
                background: linear-gradient(135deg, #7ee8fa 0%, #80d0c7 100%);
                color: #000;
            }

            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(126, 232, 250, 0.5);
                color: #000;
            }

            .btn-success {
                background: linear-gradient(135deg, #39ff14 0%, #7ee8fa 100%);
                color: #000;
            }

            .btn-success:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(57, 255, 20, 0.5);
                color: #000;
            }

            .btn-outline-primary {
                background: rgba(126, 232, 250, 0.1);
                border: 2px solid #7ee8fa;
                color: #7ee8fa;
            }

            .btn-outline-primary:hover {
                background: linear-gradient(135deg, #7ee8fa 0%, #80d0c7 100%);
                color: #000;
                border-color: transparent;
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(126, 232, 250, 0.5);
            }

            .btn-outline-success {
                background: rgba(57, 255, 20, 0.1);
                border: 2px solid #39ff14;
                color: #39ff14;
            }

            .btn-outline-success:hover {
                background: linear-gradient(135deg, #39ff14 0%, #7ee8fa 100%);
                color: #000;
                border-color: transparent;
            }

            .btn-block {
                width: 100%;
                margin-bottom: 1rem;
            }

            /* Sidebar Styling */
            .sidebar-card {
                position: sticky;
                top: 100px;
            }

            /* Form Styling */
            .form-control, .form-select, textarea {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                color: #fff;
                padding: 12px 16px;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus, textarea:focus {
                background-color: rgba(255, 255, 255, 0.15);
                border-color: #c471f5;
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                color: #fff;
                outline: none;
            }

            .form-control::placeholder, textarea::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-label {
                color: #e2e8f0;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .input-group-text {
                background-color: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                color: #7ee8fa;
            }

            /* Toast Notification */
            .toast {
                border-radius: 15px;
                backdrop-filter: blur(20px);
            }

            /* Footer */
            .footer {
                position: relative;
                z-index: 10;
                background: rgba(0, 0, 0, 0.3);
                backdrop-filter: blur(20px);
                color: #e2e8f0;
                padding: 60px 24px 24px;
                margin-top: 60px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 48px;
            }

            .footer-brand h3 {
                font-size: 24px;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .footer-brand h3 i {
                color: #c471f5;
                -webkit-text-fill-color: #c471f5;
            }

            .footer-brand p {
                color: #b8b8d1;
                font-size: 15px;
                line-height: 1.7;
            }

            .footer-column h4 {
                font-size: 16px;
                font-weight: 700;
                color: white;
                margin-bottom: 20px;
            }

            .footer-column a {
                display: block;
                color: #b8b8d1;
                text-decoration: none;
                font-size: 15px;
                margin-bottom: 12px;
                transition: all 0.3s;
            }

            .footer-column a:hover {
                color: #c471f5;
                transform: translateX(5px);
            }

            .social-links {
                display: flex;
                gap: 12px;
            }

            .social-links a {
                width: 40px;
                height: 40px;
                border-radius: 12px;
                background: rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #e2e8f0;
                transition: all 0.3s;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .social-links a:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                transform: translateY(-3px);
                border-color: transparent;
            }

            .footer-bottom {
                max-width: 1200px;
                margin: 48px auto 0;
                padding-top: 24px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                text-align: center;
                color: #b8b8d1;
                font-size: 14px;
            }

            .footer-bottom a {
                color: #c471f5;
                text-decoration: none;
            }

            .footer-bottom a:hover {
                color: #fa71cd;
            }

            /* Back to Top */
            .back-to-top {
                position: fixed;
                bottom: 24px;
                right: 24px;
                width: 48px;
                height: 48px;
                border-radius: 50%;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border: none;
                cursor: pointer;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.5);
                display: none;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
                z-index: 1000;
            }

            .back-to-top:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
            }

            .back-to-top.visible {
                display: flex;
            }

            /* Responsive */
            @media (max-width: 768px) {
                body {
                    padding-top: 70px;
                }

                .footer-content {
                    grid-template-columns: 1fr;
                    gap: 32px;
                }

                .pixel-decoration {
                    display: none;
                }

                .card-title {
                    font-size: 1.5rem;
                }
            }

            /* Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .card {
                animation: fadeInUp 0.6s ease;
            }

            hr {
                border-color: rgba(255, 255, 255, 0.2);
                margin: 1.5rem 0;
            }
        </style>
    </head>
    <body>
        <!-- Stars Background -->
        <div class="stars" id="stars"></div>

        <!-- Floating Decorations -->
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <!-- Include header -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

        <div class="container my-5">
            <!-- Error/Success Messages -->
            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <%= request.getParameter("success") %>
            </div>
            <% } %>

            <c:if test="${not empty jobPost}">
                <div class="row">
                    <!-- Job Details Section -->
                    <div class="col-lg-9">
                        <!-- Job Basic Info -->
                        <div class="card">
                            <div class="card-header">
                                <h1>${jobPost.title}</h1>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><i class="fas fa-calendar-alt"></i> <strong>Ngày đăng:</strong> ${jobPost.postedDate}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><i class="fas fa-hourglass-end"></i> <strong>Hạn nộp:</strong> ${jobPost.closingDate}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-location-dot"></i> <strong>Địa điểm:</strong> ${jobPost.location}</p>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-circle"></i> <strong>Trạng thái:</strong> ${jobPost.status}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-money-bill"></i> <strong>Lương:</strong> ${jobPost.minSalary} $ - ${jobPost.maxSalary} $</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <c:choose>
                                            <c:when test="${category != 'This category was deleted!'}">
                                                <p><i class="fa-solid fa-list"></i> <strong>Ngành nghề:</strong> ${category.name}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p><i class="fa-solid fa-list"></i> <strong>Ngành nghề:</strong> <span style="color: #ff6b6b;">Danh mục đã bị xóa!</span></p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Job Description -->
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-file-alt"></i> Mô tả công việc</h5>
                            </div>
                            <div class="card-body">
                                <p>${jobPost.description}</p>
                            </div>
                        </div>

                        <!-- Job Requirements -->
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-clipboard-list"></i> Yêu cầu công việc</h5>
                            </div>
                            <div class="card-body">
                                <p>${jobPost.requirements}</p>
                            </div>
                        </div>

                        <!-- Feedback Section -->
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-comments"></i> Đánh giá & Phản hồi</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/feedbackSeeker?action=create" method="post">
                                    <input type="hidden" name="jobPostingID" value="${jobPost.getJobPostingID()}">
                                    <div class="mb-3">
                                        <label for="feedbackContent" class="form-label">Để lại đánh giá của bạn:</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-pencil-alt"></i></span>
                                            <textarea class="form-control" id="feedbackContent" name="content" rows="4" required placeholder="Nhập đánh giá của bạn tại đây..."></textarea>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane"></i> Gửi đánh giá
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar Section -->
                    <div class="col-lg-3">
                        <div class="card sidebar-card">
                            <div class="card-body">
                                <!-- Error Message -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <!-- Like Button -->
                                <c:if test="${empty existFavourJP}">
                                    <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-favourJP" method="post" class="mb-3">
                                        <input type="hidden" name="jobPostingIDF" value="${jobPost.jobPostingID}">
                                        <c:if test="${not empty jobSeekerF}">
                                            <input type="hidden" name="jobSeekerIDF" value="${jobSeekerF.jobSeekerID}">
                                        </c:if>
                                        <button type="submit" class="btn btn-outline-primary btn-block">
                                            <i class="fas fa-thumbs-up"></i> Yêu thích
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${not empty existFavourJP}">
                                    <button class="btn btn-primary btn-block" disabled>
                                        <i class="fas fa-thumbs-up"></i> Đã yêu thích
                                    </button>
                                </c:if>

                                <!-- Apply Button -->
                                <c:if test="${empty existingApplication}">
                                    <c:if test="${not empty isOpenJP}">
                                        <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-application" method="post">
                                            <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                            <c:if test="${not empty jobSeeker}">
                                                <input type="hidden" name="jobSeekerID" value="${jobSeeker.jobSeekerID}">
                                            </c:if>
                                            <c:if test="${not empty cv}">
                                                <input type="hidden" name="cvid" value="${cv.CVID}">
                                            </c:if>
                                            <button type="submit" class="btn btn-success btn-block">
                                                <i class="fas fa-paper-plane"></i> Ứng tuyển ngay
                                            </button>
                                        </form>
                                    </c:if>
                                </c:if>
                                <c:if test="${not empty existingApplication}">
                                    <button class="btn btn-outline-success btn-block" disabled>
                                        <i class="fas fa-check-circle"></i> Đã ứng tuyển
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Toast Notification -->
            <c:if test="${not empty notice}">
                <div class="position-fixed top-0 end-0 p-3" style="z-index: 11">
                    <div id="liveToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="d-flex">
                            <div class="toast-body">
                                ${notice}
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
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

        <!-- Back to Top Button -->
        <button type="button" class="back-to-top" id="back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script>
            // Generate stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 150;

                for (let i = 0; i < numberOfStars; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 3 + 's';
                    star.style.width = Math.random() * 2 + 1 + 'px';
                    star.style.height = star.style.width;
                    starsContainer.appendChild(star);
                }
            }

            createStars();

            // Toast notification
            document.addEventListener('DOMContentLoaded', function () {
                var toastEl = document.getElementById('liveToast');
                if (toastEl) {
                    var toast = new bootstrap.Toast(toastEl);
                    toast.show();
                }
            });

            // Back to top button
            const backToTopButton = document.getElementById('back-to-top');

            window.onscroll = function () {
                if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                    backToTopButton.classList.add('visible');
                } else {
                    backToTopButton.classList.remove('visible');
                }
            };

            backToTopButton.addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        </script>
    </body>
</html>