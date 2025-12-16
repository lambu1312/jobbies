<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My CVs - Jobbies</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                overflow-x: hidden;
                min-height: 100vh;
            }

            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
                top: 0;
                left: 0;
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

            .container {
                position: relative;
                z-index: 10;
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
                margin-top: 100px;
            }

            .header {
                text-align: center;
                margin-bottom: 3rem;
            }

            .page-title {
                font-size: 3rem;
                font-weight: 900;
                background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1rem;
                animation: float 6s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-10px);
                }
            }

            .subtitle {
                color: #b8b8d1;
                font-size: 1.1rem;
            }

            .error-message {
                background: rgba(255, 77, 77, 0.15);
                border: 2px solid rgba(255, 77, 77, 0.5);
                border-radius: 15px;
                padding: 1rem 1.5rem;
                margin-bottom: 2rem;
                color: #ff6b6b;
                backdrop-filter: blur(10px);
                animation: shake 0.5s;
            }

            @keyframes shake {
                0%, 100% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-10px);
                }
                75% {
                    transform: translateX(10px);
                }
            }

            .action-bar {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 2rem;
            }

            .create-btn {
                padding: 1rem 2.5rem;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                border-radius: 50px;
                color: #fff;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.3s;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
            }

            .create-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
            }

            .cv-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 2rem;
            }

            .cv-card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 20px;
                padding: 2rem;
                transition: all 0.3s;
                position: relative;
                overflow: hidden;
            }

            .cv-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(196, 113, 245, 0.2), transparent);
                transition: left 0.5s;
            }

            .cv-card:hover::before {
                left: 100%;
            }

            .cv-card:hover {
                transform: translateY(-10px);
                border-color: #c471f5;
                box-shadow: 0 20px 60px rgba(196, 113, 245, 0.4);
            }

            .cv-card.default {
                border: 2px solid #39ff14;
                box-shadow: 0 0 30px rgba(57, 255, 20, 0.3);
            }

            .cv-header {
                display: flex;
                justify-content: space-between;
                align-items: start;
                margin-bottom: 1.5rem;
            }

            .cv-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                color: #fff;
            }

            .cv-template {
                color: #c471f5;
                font-weight: 600;
                font-size: 0.9rem;
            }

            .default-badge {
                background: linear-gradient(135deg, #39ff14, #7ee8fa);
                color: #000;
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                gap: 0.3rem;
            }

            .cv-meta {
                display: flex;
                gap: 1.5rem;
                margin-bottom: 1.5rem;
                color: #b8b8d1;
                font-size: 0.9rem;
            }

            .cv-meta-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .cv-actions {
                display: flex;
                gap: 0.8rem;
                flex-wrap: wrap;
            }

            .action-link {
                padding: 0.6rem 1.2rem;
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 25px;
                color: #fff;
                text-decoration: none;
                font-weight: 600;
                font-size: 0.85rem;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 0.4rem;
            }

            .action-link:hover {
                background: rgba(196, 113, 245, 0.2);
                border-color: #c471f5;
                transform: translateY(-2px);
            }

            .set-default-btn {
                padding: 0.6rem 1.2rem;
                background: rgba(57, 255, 20, 0.1);
                border: 1px solid rgba(57, 255, 20, 0.3);
                border-radius: 25px;
                color: #39ff14;
                font-weight: 600;
                font-size: 0.85rem;
                cursor: pointer;
                transition: all 0.3s;
            }

            .set-default-btn:hover {
                background: rgba(57, 255, 20, 0.2);
                border-color: #39ff14;
                transform: translateY(-2px);
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: rgba(255, 255, 255, 0.03);
                border: 2px dashed rgba(255, 255, 255, 0.2);
                border-radius: 20px;
                margin-top: 2rem;
            }

            .empty-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
                animation: float 3s ease-in-out infinite;
            }

            .empty-text {
                color: #b8b8d1;
                font-size: 1.2rem;
                margin-bottom: 2rem;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                    margin-top: 80px;
                }

                .page-title {
                    font-size: 2rem;
                }

                .cv-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>

        <div class="stars" id="stars"></div>
        
        <!-- Header -->
        <jsp:include page="../view/common/user/header-user.jsp"/>
        
        <div class="container">
            <div class="header">
                <h1 class="page-title">📄 My CVs</h1>
                <p class="subtitle">Manage and create your professional CVs</p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠️ ${error}
                </div>
            </c:if>

            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/cv/edit" class="create-btn">
                    ✨ Create New CV
                </a>
            </div>

            <c:choose>
                <c:when test="${empty cvs}">
                    <div class="empty-state">
                        <div class="empty-icon">📋</div>
                        <p class="empty-text">You don't have any CVs yet. Create your first CV now!</p>
                        <a href="${pageContext.request.contextPath}/cv/edit" class="create-btn">
                            🚀 Create CV Now
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cv-grid">
                        <c:forEach items="${cvs}" var="cv">
                            <div class="cv-card ${cv.isDefault ? 'default' : ''}">
                                <div class="cv-header">
                                    <div>
                                        <div class="cv-title">${cv.title}</div>
                                        <div class="cv-template">📝 ${cv.templateCode}</div>
                                    </div>
                                    <c:if test="${cv.isDefault}">
                                        <div class="default-badge">
                                            ✅ Default
                                        </div>
                                    </c:if>
                                </div>

                                <div class="cv-meta">
                                    <div class="cv-meta-item">
                                        🕐 ${cv.lastUpdated}
                                    </div>
                                </div>

                                <div class="cv-actions">
                                    <a href="${pageContext.request.contextPath}/cv/edit?cvid=${cv.cvId}" class="action-link">
                                        ✏️ Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" class="action-link">
                                        ⬇️ Download PDF
                                    </a>
                                    <c:if test="${!cv.isDefault}">
                                        <form action="${pageContext.request.contextPath}/cv/default" method="post" style="display:inline">
                                            <input type="hidden" name="cvid" value="${cv.cvId}"/>
                                            <button type="submit" class="set-default-btn">
                                                ⭐ Set Default
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

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
        </script>
    </body>
</html>