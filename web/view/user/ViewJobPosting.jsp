<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Detail - Jobbies</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .action-card {
                position: static;
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

            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.3;
                z-index: 5;
                animation: float 4s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
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

            .container {
                padding: 1rem;
            }

            .job-title {
                font-size: 2rem;
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

            .job-detail-wrapper {
                display: grid;
                grid-template-columns: 1fr 280px;
                gap: 2rem;
            }

            .job-main {
                display: flex;
                flex-direction: column;
                gap: 2rem;
            }

            .card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                transition: all 0.3s;
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

            .card:hover {
                border-color: rgba(196, 113, 245, 0.3);
                box-shadow: 0 10px 40px rgba(196, 113, 245, 0.2);
            }

            .job-title {
                font-size: 2.5rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
                line-height: 1.2;
            }

            .job-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                padding-top: 1rem;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                color: #e0e0e0;
            }

            .meta-item i {
                color: #c471f5;
                font-size: 1.1rem;
                width: 24px;
                text-align: center;
            }

            .meta-label {
                color: #b8b8d1;
                font-size: 0.85rem;
                margin-right: 0.3rem;
            }

            .meta-value {
                font-weight: 600;
            }

            .salary-display {
                background: linear-gradient(135deg, rgba(196, 113, 245, 0.1), rgba(250, 113, 205, 0.1));
                padding: 0.8rem 1rem;
                border-radius: 10px;
                border-left: 3px solid #c471f5;
            }

            .salary-amount {
                font-size: 1.3rem;
                font-weight: 800;
                background: linear-gradient(135deg, #7ee8fa, #c471f5);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .salary-currency {
                font-size: 0.9rem;
                color: #7ee8fa;
                font-weight: 700;
                margin-top: 0.3rem;
            }

            .card-header {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid rgba(196, 113, 245, 0.3);
            }

            .card-header i {
                font-size: 1.5rem;
                color: #c471f5;
            }

            .card-header h5 {
                font-size: 1.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin: 0;
            }

            .card-content {
                color: #e0e0e0;
                line-height: 1.8;
                font-size: 1rem;
            }

            .sidebar {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .action-card {
                position: sticky;
                top: 2rem;
            }

            .btn {
                width: 100%;
                padding: 1rem;
                border: none;
                border-radius: 15px;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                text-decoration: none;
            }

            .btn-like {
                background: rgba(126, 232, 250, 0.2);
                color: #7ee8fa;
                border: 1px solid #7ee8fa;
            }

            .btn-like:hover {
                background: rgba(126, 232, 250, 0.3);
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(126, 232, 250, 0.4);
            }

            .btn-liked {
                background: rgba(126, 232, 250, 0.3);
                color: #7ee8fa;
                border: 1px solid #7ee8fa;
                cursor: default;
            }

            .btn-apply {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: #fff;
                box-shadow: 0 5px 20px rgba(196, 113, 245, 0.4);
            }

            .btn-apply:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(196, 113, 245, 0.6);
            }

            .btn-applied {
                background: rgba(57, 255, 20, 0.3);
                color: #39ff14;
                border: 1px solid #39ff14;
                cursor: default;
            }

            .feedback-form {
                margin-top: 1rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-label {
                display: block;
                color: #b8b8d1;
                font-weight: 600;
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
            }

            .form-textarea {
                width: 100%;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 10px;
                color: #fff;
                font-size: 0.95rem;
                outline: none;
                transition: all 0.3s;
                resize: vertical;
                min-height: 120px;
            }

            .form-textarea:focus {
                border-color: #c471f5;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.3);
            }

            .form-textarea::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .btn-submit {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: #fff;
                padding: 0.8rem 2rem;
                width: auto;
                margin-top: 1rem;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(196, 113, 245, 0.5);
            }

            .toast {
                position: fixed;
                top: 2rem;
                right: 2rem;
                background: rgba(57, 255, 20, 0.95);
                backdrop-filter: blur(20px);
                color: #000;
                padding: 1rem 1.5rem;
                border-radius: 15px;
                box-shadow: 0 10px 40px rgba(57, 255, 20, 0.4);
                display: flex;
                align-items: center;
                gap: 1rem;
                z-index: 1000;
                animation: slideInRight 0.3s ease-out;
            }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>
    </head>
    <body>
        <div class="stars" id="stars"></div>

        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <!-- Header -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class="container">
                <!-- Alert Messages -->
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
                <div class="job-detail-wrapper">
                    <!-- Main Content -->
                    <div class="job-main">
                        <!-- Job Header Card -->
                        <div class="card">
                            <h1 class="job-title">${jobPost.title}</h1>

                            <div class="job-meta">
                                <div class="meta-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    <div>
                                        <span class="meta-label">Posted:</span>
                                        <span class="meta-value">${jobPost.postedDate}</span>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-hourglass-end"></i>
                                    <div>
                                        <span class="meta-label">Deadline:</span>
                                        <span class="meta-value">${jobPost.closingDate}</span>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <div>
                                        <span class="meta-label">Location:</span>
                                        <span class="meta-value">${jobPost.location}</span>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-dollar-sign"></i>
                                    <div>
                                        <span class="meta-label">Salary:</span>
                                        <div class="salary-display">
                                            <div class="salary-amount">
                                                ${jobPost.minSalary} - ${jobPost.maxSalary}
                                            </div>
                                            <div class="salary-currency">
                                                <c:choose>
                                                    <c:when test="${jobPost.currency == 'USD'}">
                                                        💵 USD ($)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'VND'}">
                                                        🇻🇳 VND (₫)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'EUR'}">
                                                        💶 EUR (€)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'GBP'}">
                                                        💷 GBP (£)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'JPY'}">
                                                        🇯🇵 JPY (¥)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'AUD'}">
                                                        🇦🇺 AUD (A$)
                                                    </c:when>
                                                    <c:when test="${jobPost.currency == 'CAD'}">
                                                        🇨🇦 CAD (C$)
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${jobPost.currency}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-list"></i>
                                    <div>
                                        <span class="meta-label">Category:</span>
                                        <span class="meta-value">
                                            <c:choose>
                                                <c:when test="${category != 'This category was deleted!'}">
                                                    ${category.name}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #ff6b6b;">Deleted Category</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>

                                <div class="meta-item">
                                    <i class="fas fa-circle"></i>
                                    <div>
                                        <span class="meta-label">Status:</span>
                                        <span class="meta-value">${jobPost.status}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Description Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-file-alt"></i>
                                <h5>Job Description</h5>
                            </div>
                            <div class="card-content">
                                ${jobPost.description}
                            </div>
                        </div>

                        <!-- Requirements Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-clipboard-check"></i>
                                <h5>Requirements</h5>
                            </div>
                            <div class="card-content">
                                ${jobPost.requirements}
                            </div>
                        </div>

                        <!-- Feedback Card -->
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-comments"></i>
                                <h5>Feedback</h5>
                            </div>
                            <form action="${pageContext.request.contextPath}/feedbackSeeker?action=create" method="post" class="feedback-form">
                                <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                <div class="form-group">
                                    <label class="form-label">Leave your feedback:</label>
                                    <textarea class="form-textarea" name="content" required placeholder="Enter your feedback here..."></textarea>
                                </div>
                                <button type="submit" class="btn btn-submit">
                                    <i class="fas fa-paper-plane"></i>
                                    Submit Feedback
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="card action-card">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle"></i>
                                    ${error}
                                </div>
                            </c:if>

                            <!-- Like Button -->
                            <c:choose>
                                <c:when test="${empty existFavourJP}">
                                    <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-favourJP" method="post">
                                        <input type="hidden" name="jobPostingIDF" value="${jobPost.jobPostingID}">
                                        <c:if test="${not empty jobSeekerF}">
                                            <input type="hidden" name="jobSeekerIDF" value="${jobSeekerF.jobSeekerID}">
                                        </c:if>
                                        <button type="submit" class="btn btn-like">
                                            <i class="fas fa-heart"></i>
                                            Like
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-liked" disabled>
                                        <i class="fas fa-heart"></i>
                                        Liked
                                    </button>
                                </c:otherwise>
                            </c:choose>

                            <!-- Apply Button -->
                            <c:choose>
                                <c:when test="${empty existingApplication}">
                                    <c:if test="${not empty isOpenJP}">
                                        <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-application" method="post">
                                            <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                            <c:if test="${not empty jobSeeker}">
                                                <input type="hidden" name="jobSeekerID" value="${jobSeeker.jobSeekerID}">
                                            </c:if>
                                            <c:if test="${not empty cv}">
                                                <input type="hidden" name="cvid" value="${cv.CVID}">
                                            </c:if>
                                            <button type="submit" class="btn btn-apply">
                                                <i class="fas fa-paper-plane"></i>
                                                Apply Job
                                            </button>
                                        </form>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-applied" disabled>
                                        <i class="fas fa-check-circle"></i>
                                        Applied
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </aside>
                </div>
            </c:if>

            <!-- Toast Notification -->
            <c:if test="${not empty notice}">
                <div class="toast" id="liveToast">
                    <i class="fas fa-check-circle"></i>
                    <span>${notice}</span>
                    <button class="toast-close" onclick="this.parentElement.remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            // Generate stars
            const starsContainer = document.getElementById('stars');
            for (let i = 0; i < 100; i++) {
                const star = document.createElement('div');
                star.className = 'star';
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                star.style.animationDelay = Math.random() * 3 + 's';
                starsContainer.appendChild(star);
            }

            // Auto-hide toast after 5 seconds
            const toast = document.getElementById('liveToast');
            if (toast) {
                setTimeout(() => {
                    toast.style.animation = 'slideOutRight 0.3s ease-out';
                    setTimeout(() => toast.remove(), 300);
                }, 5000);
            }
        </script>
    </body>
</html>