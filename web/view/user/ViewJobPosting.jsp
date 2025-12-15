<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Job Posting Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
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
                0%, 100% { opacity: 0.3; }
                50% { opacity: 1; }
            }

            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.3;
                z-index: 5;
                animation: float 4s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }

            .deco-1 { top: 20%; left: 10%; }
            .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
            .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }

            .container {
                position: relative;
                z-index: 10;
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }

            .alert {
                padding: 1rem 1.5rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                display: flex;
                align-items: center;
                gap: 0.8rem;
                animation: slideIn 0.3s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
}
.alert-danger {
                background: rgba(255, 107, 107, 0.2);
                border: 1px solid #ff6b6b;
                color: #ff6b6b;
            }

            .alert-success {
                background: rgba(57, 255, 20, 0.2);
                border: 1px solid #39ff14;
                color: #39ff14;
            }

            .card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                transition: all 0.3s;
                animation: fadeInUp 0.6s ease-out;
                margin-bottom: 2rem;
                color: #fff;
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

            .card:hover {
                border-color: rgba(196, 113, 245, 0.3);
                box-shadow: 0 10px 40px rgba(196, 113, 245, 0.2);
            }

            .card-title {
                font-size: 2.5rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
                line-height: 1.2;
            }

            .card-header {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: #fff;
                padding: 1rem 1.5rem;
                border-radius: 15px 15px 0 0;
                margin: -2rem -2rem 2rem -2rem;
                border: none;
            }

            .card-header h5 {
                margin: 0;
                font-weight: 700;
                font-size: 1.3rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .card-body {
                color: #fff;
            }

            .card-body p {
                color: #e0e0e0;
                line-height: 1.8;
                margin-bottom: 1rem;
            }

            .card-body strong {
                color: #c471f5;
                font-weight: 600;
            }

            .card-body i {
                color: #c471f5;
                margin-right: 0.5rem;
            }

            .btn {
                padding: 0.8rem 1.5rem;
                border: none;
                border-radius: 15px;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
text-decoration: none;
}

            .btn-outline-primary {
                background: transparent;
                color: #7ee8fa;
                border: 2px solid #7ee8fa;
            }

            .btn-outline-primary:hover {
                background: rgba(126, 232, 250, 0.2);
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(126, 232, 250, 0.4);
            }

            .btn-primary {
                background: linear-gradient(135deg, #7ee8fa 0%, #80ffdb 100%);
                color: #000;
                box-shadow: 0 5px 20px rgba(126, 232, 250, 0.4);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(126, 232, 250, 0.6);
            }

            .btn-success {
                background: linear-gradient(135deg, #39ff14 0%, #7ee8fa 100%);
                color: #000;
                box-shadow: 0 5px 20px rgba(57, 255, 20, 0.4);
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(57, 255, 20, 0.6);
            }

            .btn-outline-success {
                background: transparent;
                color: #39ff14;
                border: 2px solid #39ff14;
            }

            .btn-outline-success:hover {
                background: rgba(57, 255, 20, 0.2);
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(57, 255, 20, 0.4);
            }

            .btn-block {
                width: 100%;
                margin-bottom: 1rem;
            }

            .form-label {
                color: #c471f5;
                font-weight: 600;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .form-control, .input-group-text {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.15);
                color: #fff;
                padding: 0.8rem 1rem;
                border-radius: 10px;
            }

            .form-control:focus {
                background: rgba(255, 255, 255, 0.08);
                border-color: #c471f5;
                box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
                color: #fff;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .input-group-text {
                border-right: none;
                color: #c471f5;
            }

            .input-group .form-control {
                border-left: none;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 120px;
            }

            .toast {
                background: linear-gradient(135deg, #39ff14 0%, #7ee8fa 100%);
                color: #000;
border: none;
box-shadow: 0 10px 40px rgba(57, 255, 20, 0.4);
            }

            .toast-body {
                font-weight: 600;
            }

            .btn-close-white {
                filter: invert(1);
            }

            hr {
                border-color: rgba(255, 255, 255, 0.2);
                margin: 1.5rem 0;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                }

                .card-title {
                    font-size: 2rem;
                }

                .card {
                    padding: 1.5rem;
                }

                .card-header {
                    margin: -1.5rem -1.5rem 1.5rem -1.5rem;
                }
            }

            /* Generate some stars */
            .star:nth-child(1) { top: 10%; left: 20%; animation-delay: 0s; }
            .star:nth-child(2) { top: 30%; left: 60%; animation-delay: 1s; }
            .star:nth-child(3) { top: 50%; left: 40%; animation-delay: 2s; }
            .star:nth-child(4) { top: 70%; left: 80%; animation-delay: 1.5s; }
            .star:nth-child(5) { top: 20%; left: 70%; animation-delay: 0.5s; }
        </style>
    </head>

    <body>
        <!-- Stars Background -->
        <div class="stars">
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
            <div class="star"></div>
        </div>

        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <!-- Include header -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

        <div class="container my-5">
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
                    <div class="col-md-10">
                        <!-- Job Basic Info -->
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h1 class="card-title">${jobPost.title}</h1>
                                <hr>
                                <div class="row">
                                    <div class="col-md-4">
<p><i class="fas fa-calendar-alt"></i> <strong>Ngày Đăng:</strong> ${jobPost.postedDate}</p>
</div>
                                    <div class="col-md-4">
                                        <p><i class="fas fa-hourglass-end"></i> <strong>Hạn: </strong> ${jobPost.closingDate}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-location-dot"></i> <strong>Địa Chỉ:</strong> ${jobPost.location}</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-circle"></i> <strong>Trạng Thái: </strong>${jobPost.status}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><i class="fa-solid fa-money-bill"></i> <strong>Lương: </strong>${jobPost.minSalary} $ - ${jobPost.maxSalary} $</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <c:choose>
                                        <c:when test="${category != 'Danh mục này đã bị xóa!'}">
                                            <p><i class="fa-solid fa-list"></i> <strong>Danh mục công việc:</strong> ${category.name}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><i class="fa-solid fa-list"></i> <strong>Danh mục công việc:</strong> Danh mục này đã bị xóa!</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-2">
                        <!-- Sidebar Section for Application Form -->
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <!-- Error Message -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <c:if test="${empty existFavourJP}">
                                    <!-- Like Form -->
                                    <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-favourJP" method="post" class="mb-3">
<input type="hidden" name="jobPostingIDF" value="${jobPost.jobPostingID}">
                                        <c:if test="${not empty jobSeekerF}">
<input type="hidden" name="jobSeekerIDF" value="${jobSeekerF.jobSeekerID}">
                                        </c:if>
                                        <button type="submit" class="btn btn-outline-primary btn-block w-100">
                                            <i class="fas fa-thumbs-up"></i> Thích
                                        </button>
                                    </form>
                                </c:if>
                                
                                <c:if test="${not empty existFavourJP}">
                                    <button class="btn btn-primary btn-block w-100 mb-3">
                                        <i class="fas fa-thumbs-up"></i> Đã Thích
                                    </button>
                                </c:if>
                                
                                <c:if test="${empty existingApplication}">
                                    <!-- Apply Job Form -->
                                    <c:if test="${not empty isOpenJP}">
                                        <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-application" method="post">
                                            <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                            <c:if test="${not empty jobSeeker}">
                                                <input type="hidden" name="jobSeekerID" value="${jobSeeker.jobSeekerID}">
                                            </c:if>
                                            <c:if test="${not empty cv}">
                                                <input type="hidden" name="cvid" value="${cv.CVID}">
                                            </c:if>
                                            <button type="submit" class="btn btn-success btn-block w-100">
                                                <i class="fas fa-paper-plane"></i> Ứng tuyển
                                            </button>
                                        </form>
                                    </c:if>
                                </c:if>
                                
                                <c:if test="${not empty existingApplication}">
                                    <button class="btn btn-outline-success btn-block w-100">
                                        <i class="fas fa-check-circle"></i> Đã Ứng Tuyển
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Job Description -->
<div class="card shadow-sm">
                    <div class="card-header">
                        <h5><i class="fas fa-file-alt"></i> Miêu tả công việc</h5>
                    </div>
                    <div class="card-body">
<p>${jobPost.description}</p>
                    </div>
                </aside>
            </div>
        </c:if>

                <!-- Job Requirements -->
                <div class="card shadow-sm">
                    <div class="card-header">
                        <h5><i class="fas fa-list-check"></i> Yêu cầu</h5>
                    </div>
                    <div class="card-body">
                        <p>${jobPost.requirements}</p>
                    </div>
                </div>
            </c:if>
        </div>
        
        <!--Feedback Section-->
        <div class="container my-5">
            <c:if test="${not empty jobPost}">
                <c:if test="${not empty notice}">
                    <div class="position-fixed top-0 end-0 p-3" style="z-index: 11">
                        <div id="liveToast" class="toast align-items-center border-0" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="fas fa-check-circle"></i> ${notice}
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Feedback Section -->
                <div class="card shadow-sm">
                    <div class="card-header">
                        <h5><i class="fas fa-comments"></i> Đánh Giá</h5>
                    </div>
                    <div class="card-body">
                        <!-- Feedback Form -->
                        <form action="${pageContext.request.contextPath}/feedbackSeeker?action=create" method="post">
                            <input type="hidden" name="jobPostingID" value="${jobPost.getJobPostingID()}">
                            <div class="mb-3">
                                <label for="feedbackContent" class="form-label">
                                    <i class="fas fa-pencil-alt"></i> Hãy để lại phản hồi của bạn:
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-comment-dots"></i></span>
                                    <textarea class="form-control" id="feedbackContent" name="content" rows="4" required placeholder="Nhập phản hồi của bạn tại đây..."></textarea>
                                </div>
                            </div>
<button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Gửi Phản Hồi
                            </button>
                        </form>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Include footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

        <!-- Bootstrap JS and Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastEl = document.getElementById('liveToast');
                if (toastEl) {
                    var toast = new bootstrap.Toast(toastEl);
                    toast.show();
                }
            });
        </script>
    </body>
</html>
