<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@page import="model.Job_Posting_Category" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Job Detail - Jobbies</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

                            0%,
                            100% {
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

                            0%,
                            100% {
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
                            position: relative;
                            z-index: 10;
                            max-width: 1200px;
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        .breadcrumb {
                            display: flex;
                            gap: 0.5rem;
                            align-items: center;
                            margin-bottom: 2rem;
                            color: #b8b8d1;
                            font-size: 0.9rem;
                        }

                        .breadcrumb a {
                            color: #c471f5;
                            text-decoration: none;
                            transition: all 0.3s;
                        }

                        .breadcrumb a:hover {
                            text-shadow: 0 0 10px rgba(196, 113, 245, 0.8);
                        }

                        .job-detail-wrapper {
                            display: grid;
                            grid-template-columns: 1fr 350px;
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

                        .job-header {
                            margin-bottom: 2rem;
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

                        .status-badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.5rem 1rem;
                            border-radius: 20px;
                            font-size: 0.85rem;
                            font-weight: 700;
                        }

                        .status-active {
                            background: rgba(57, 255, 20, 0.2);
                            color: #39ff14;
                            border: 1px solid #39ff14;
                        }

                        .status-closed {
                            background: rgba(255, 107, 107, 0.2);
                            color: #ff6b6b;
                            border: 1px solid #ff6b6b;
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

                        .card-content p {
                            margin-bottom: 1rem;
                        }

                        .sidebar {
                            display: flex;
                            flex-direction: column;
                            gap: 1.5rem;
                        }

                        .apply-card {
                            background: linear-gradient(135deg, rgba(196, 113, 245, 0.15), rgba(250, 113, 205, 0.15));
                            border: 2px solid rgba(196, 113, 245, 0.5);
                            position: sticky;
                            top: 2rem;
                        }

                        .apply-card .card-header {
                            border-bottom-color: rgba(196, 113, 245, 0.5);
                        }

                        .apply-button {
                            width: 100%;
                            padding: 1rem;
                            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                            border: none;
                            border-radius: 15px;
                            color: #fff;
                            font-weight: 700;
                            font-size: 1.1rem;
                            cursor: pointer;
                            transition: all 0.3s;
                            box-shadow: 0 5px 20px rgba(196, 113, 245, 0.4);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 0.5rem;
                        }

                        .apply-button:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 8px 25px rgba(196, 113, 245, 0.6);
                        }

                        .login-notice {
                            color: #e0e0e0;
                            line-height: 1.6;
                            text-align: center;
                        }

                        .login-notice a {
                            color: #c471f5;
                            text-decoration: none;
                            font-weight: 700;
                            transition: all 0.3s;
                        }

                        .login-notice a:hover {
                            text-shadow: 0 0 10px rgba(196, 113, 245, 0.8);
                        }

                        .info-card {
                            background: rgba(126, 232, 250, 0.1);
                            border-color: rgba(126, 232, 250, 0.3);
                        }

                        .info-list {
                            list-style: none;
                            padding: 0;
                            margin: 0;
                        }

                        .info-list li {
                            padding: 0.8rem 0;
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            display: flex;
                            align-items: center;
                            gap: 0.8rem;
                        }

                        .info-list li:last-child {
                            border-bottom: none;
                        }

                        .info-list i {
                            color: #7ee8fa;
                            width: 24px;
                            text-align: center;
                        }

                        .error-message {
                            background: rgba(255, 107, 107, 0.1);
                            border: 1px solid rgba(255, 107, 107, 0.3);
                            border-radius: 10px;
                            padding: 1rem;
                            color: #ff6b6b;
                            text-align: center;
                            font-weight: 600;
                        }

                        @media (max-width: 1024px) {
                            .job-detail-wrapper {
                                grid-template-columns: 1fr;
                            }

                            .apply-card {
                                position: static;
                            }
                        }

                        @media (max-width: 768px) {
                            .container {
                                padding: 1rem;
                            }

                            .job-title {
                                font-size: 2rem;
                            }

                            .job-meta {
                                grid-template-columns: 1fr;
                            }

                            .card {
                                padding: 1.5rem;
                            }
                        }
                    </style>
                </head>

                <body>
                    <div class="stars" id="stars"></div>

                    <div class="pixel-decoration deco-1">✨</div>
                    <div class="pixel-decoration deco-2">💎</div>
                    <div class="pixel-decoration deco-3">🚀</div>

                    <!-- Header -->
                    <jsp:include page="../view/common/header-area.jsp"></jsp:include>

                    <div class="container">
                        <!-- Breadcrumb -->
                        <nav class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/home">
                                <i class="fas fa-home"></i> Home
                            </a>
                            <span>/</span>
                            <a href="${pageContext.request.contextPath}/home">Jobs</a>
                            <span>/</span>
                            <span>Job Details</span>
                        </nav>

                        <c:choose>
                            <c:when test="${not empty jobPost}">
                                <div class="job-detail-wrapper">
                                    <!-- Main Content -->
                                    <div class="job-main">
                                        <!-- Job Header Card -->
                                        <div class="card">
                                            <div class="job-header">
                                                <h1 class="job-title">${jobPost.getTitle()}</h1>

                                                <div class="job-meta">
                                                    <div class="meta-item">
                                                        <i class="fas fa-calendar-alt"></i>
                                                        <div>
                                                            <span class="meta-label">Ngày Đăng:</span>
                                                            <span class="meta-value">${jobPost.getPostedDate()}</span>
                                                        </div>
                                                    </div>

                                                    <div class="meta-item">
                                                        <i class="fas fa-hourglass-end"></i>
                                                        <div>
                                                            <span class="meta-label">Hạn:</span>
                                                            <span class="meta-value">${jobPost.getClosingDate()}</span>
                                                        </div>
                                                    </div>

                                                    <div class="meta-item">
                                                        <i class="fas fa-map-marker-alt"></i>
                                                        <div>
                                                            <span class="meta-label">Địa điểm:</span>
                                                            <span class="meta-value">${jobPost.getLocation()}</span>
                                                        </div>
                                                    </div>

                                                    <div class="meta-item">
                                                        <i class="fas fa-dollar-sign"></i>
                                                        <div>
                                                            <span class="meta-label">Lương:</span>
                                                            <div class="salary-display">
                                                                <div class="salary-amount">
                                                                    ${jobPost.getMinSalary()} - ${jobPost.getMaxSalary()}
                                                                </div>
                                                                <div class="salary-currency">
                                                                    <c:choose>
                                                                        <c:when test="${jobPost.getCurrency() == 'USD'}">
                                                                            💵 USD ($)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'VND'}">
                                                                            🇻🇳 VND (₫)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'EUR'}">
                                                                            💶 EUR (€)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'GBP'}">
                                                                            💷 GBP (£)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'JPY'}">
                                                                            🇯🇵 JPY (¥)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'AUD'}">
                                                                            🇦🇺 AUD (A$)
                                                                        </c:when>
                                                                        <c:when test="${jobPost.getCurrency() == 'CAD'}">
                                                                            🇨🇦 CAD (C$)
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${jobPost.getCurrency()}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="meta-item">
                                                        <i class="fas fa-list"></i>
                                                        <div>
                                                            <span class="meta-label">Danh mục:</span>
                                                            <span class="meta-value">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${category != 'This category was deleted!'}">
                                                                        ${category.name}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span style="color: #ff6b6b;">Deleted
                                                                            Category</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="meta-item">
                                                        <i class="fas fa-circle"></i>
                                                        <div>
                                                            <span class="meta-label">Trạng thái:</span>
                                                            <span
                                                                class="status-badge ${jobPost.getStatus() == 'Active' ? 'status-active' : 'status-closed'}">
                                                                ${jobPost.getStatus()}
                                                            </span>
                                                        </div>
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
                                                ${jobPost.getDescription()}
                                            </div>
                                        </div>

                                        <!-- Requirements Card -->
                                        <div class="card">
                                            <div class="card-header">
                                                <i class="fas fa-clipboard-check"></i>
                                                <h5>Requirements</h5>
                                            </div>
                                            <div class="card-content">
                                                ${jobPost.getRequirements()}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Sidebar -->
                                    <aside class="sidebar">
                                        <c:choose>
                                            <c:when test="${empty sessionScope.account}">
                                                <!-- Login Notice Card -->
                                                <div class="card apply-card">
                                                    <div class="card-header">
                                                        <i class="fas fa-briefcase"></i>
                                                        <h5>Apply for this Job</h5>
                                                    </div>
                                                    <div class="login-notice">
                                                        <p>🔒 You must be logged in with a Seeker role to apply for this
                                                            job.</p>
                                                        <a href="${pageContext.request.contextPath}/authen">
                                                            <button class="apply-button">
                                                                <i class="fas fa-sign-in-alt"></i>
                                                                Login to Apply
                                                            </button>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Apply Button Card -->
                                                <div class="card apply-card">
                                                    <div class="card-header">
                                                        <i class="fas fa-briefcase"></i>
                                                        <h5>Apply Now</h5>
                                                    </div>
                                                    <button class="apply-button" onclick="applyJob()">
                                                        <i class="fas fa-paper-plane"></i>
                                                        Submit Application
                                                    </button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Job Info Card -->
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <i class="fas fa-info-circle"></i>
                                                <h5>Job Information</h5>
                                            </div>
                                            <ul class="info-list">
                                                <li>
                                                    <i class="fas fa-building"></i>
                                                    <div>
                                                        <div class="meta-label">Company</div>
                                                        <div class="meta-value">TechVibe Co.</div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <i class="fas fa-users"></i>
                                                    <div>
                                                        <div class="meta-label">Job Type</div>
                                                        <div class="meta-value">Full-time</div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <i class="fas fa-layer-group"></i>
                                                    <div>
                                                        <div class="meta-label">Experience</div>
                                                        <div class="meta-value">2-3 years</div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <i class="fas fa-clock"></i>
                                                    <div>
                                                        <div class="meta-label">Posted</div>
                                                        <div class="meta-value">${jobPost.getPostedDate()}</div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </aside>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="error-message">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    Job posting not found or has been removed.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Footer -->
                    <jsp:include page="../view/common/footer.jsp"></jsp:include>

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

                        // Apply job function
                        function applyJob() {
                            alert('🎉 Application submitted successfully! (Demo)');
                        }
                    </script>
                </body>

                </html>