<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi Tiết Phỏng Vấn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
                overflow-x: hidden;
                min-height: 100vh;
            }

            /* --- Background Effects (Stars & Floating Icons) --- */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 0;
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
                opacity: 0.1;
                z-index: 0;
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
            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            /* --- Main Content Styling --- */
            .content {
                margin-left: 260px; /* Khớp với sidebar */
                padding: 30px;
                padding-top: 90px;
                position: relative;
                z-index: 10;
            }

            .detail-card {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(196, 113, 245, 0.1);
                padding: 30px;
                margin-bottom: 25px;
                border: 1px solid rgba(255, 255, 255, 0.5);
                transition: transform 0.3s ease;
            }

            .detail-card:hover {
                transform: translateY(-3px);
            }

            .section-title {
                font-size: 1.4rem;
                font-weight: 700;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #f0f0f0;
                /* Gradient Text */
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                display: flex;
                align-items: center;
            }

            .section-title i {
                margin-right: 10px;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .info-row {
                margin-bottom: 20px;
            }

            .info-label {
                font-weight: 600;
                color: #6b7280;
                margin-bottom: 8px;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                color: #1f2937;
                font-size: 1rem;
                font-weight: 500;
            }

            /* --- Badges --- */
            .status-badge {
                padding: 8px 16px;
                border-radius: 30px;
                font-weight: 600;
                display: inline-block;
                font-size: 0.9rem;
            }
            .status-scheduled {
                background-color: #e0f2fe;
                color: #0284c7;
            }
            .status-rescheduled {
                background-color: #fef3c7;
                color: #d97706;
            }
            .status-completed {
                background-color: #dcfce7;
                color: #16a34a;
            }
            .status-cancelled {
                background-color: #fee2e2;
                color: #dc2626;
            }

            .type-badge {
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
            }
            .type-online {
                background-color: #f3e8ff;
                color: #9333ea;
            }
            .type-offline {
                background-color: #fce7f3;
                color: #db2777;
            }

            /* --- Buttons --- */
            .btn-back {
                background: white;
                color: #6b7280;
                border: 1px solid #e5e7eb;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }
            .btn-back:hover {
                background: #f9fafb;
                color: #374151;
                transform: translateX(-3px);
                border-color: #d1d5db;
            }

            .btn-join {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border: none;
                border-radius: 20px;
                padding: 8px 20px;
                font-weight: 600;
                transition: 0.3s;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }
            .btn-join:hover {
                color: white;
                opacity: 0.9;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(196, 113, 245, 0.4);
            }

            .page-heading {
                font-weight: 800;
                font-size: 2rem;
                background: linear-gradient(135deg, #1a0b2e 0%, #2d1b4e 50%, #0a3a52 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .alert-info-custom {
                background-color: #f0f9ff;
                border-left: 4px solid #c471f5;
                color: #0c4a6e;
                border-radius: 8px;
                padding: 15px;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                .content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <div class="stars" id="stars"></div>
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <jsp:include page="sidebar-re.jsp"/>
        <jsp:include page="header-re.jsp"/>

        <div class="content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <h2 class="page-heading"><i class="fas fa-calendar-check me-3"></i>Chi Tiết Phỏng Vấn</h2>
                <a href="${pageContext.request.contextPath}/interviewManagement" class="btn-back">
                    <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
                </a>
            </div>

            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-clock"></i>Thông Tin Phỏng Vấn</h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Ngày Phỏng Vấn</div>
                            <div class="info-value">
                                <i class="fas fa-calendar-day me-2 text-muted"></i>
                                <fmt:formatDate value="${interview.interviewDate}" pattern="EEEE, dd/MM/yyyy"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Giờ Phỏng Vấn</div>
                            <div class="info-value">
                                <i class="fas fa-clock me-2 text-muted"></i>${interview.interviewTime}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Hình Thức</div>
                            <div class="info-value">
                                <span class="type-badge ${interview.interviewType eq 'Online' ? 'type-online' : 'type-offline'}">
                                    ${interview.interviewType eq 'Online' ? 'Trực tuyến (Online)' : 'Tại văn phòng (Offline)'}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Trạng Thái</div>
                            <div class="info-value">
                                <span class="status-badge status-${interview.status.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${interview.status eq 'Scheduled'}">Đã lên lịch</c:when>
                                        <c:when test="${interview.status eq 'Rescheduled'}">Dời lịch</c:when>
                                        <c:when test="${interview.status eq 'Completed'}">Hoàn thành</c:when>
                                        <c:when test="${interview.status eq 'Cancelled'}">Đã hủy</c:when>
                                        <c:otherwise>${interview.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${interview.interviewType eq 'Online'}">
                            <div class="col-12">
                                <div class="info-row">
                                    <div class="info-label">Link Cuộc Họp (Meeting Link)</div>
                                    <div class="info-value d-flex align-items-center flex-wrap gap-3">
                                        <a href="${interview.meetingLink}" target="_blank" class="btn-join">
                                            <i class="fas fa-video me-2"></i> Tham gia ngay
                                        </a>
                                        <small class="text-muted">${interview.meetingLink}</small>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="info-row">
                                    <div class="info-label">Địa Điểm</div>
                                    <div class="info-value">
                                        <i class="fas fa-map-marker-alt me-2 text-danger"></i>${interview.location}
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty interview.notes}">
                        <div class="col-12">
                            <div class="info-row">
                                <div class="info-label">Ghi Chú / Hướng Dẫn</div>
                                <div class="info-value">
                                    <div class="alert alert-info-custom mb-0">
                                        <i class="fas fa-info-circle me-2"></i> ${interview.notes}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-user"></i>Thông Tin Ứng Viên</h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Họ và Tên</div>
                            <div class="info-value">
                                <strong>${interview.application.jobSeeker.account.fullName}</strong>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Email Liên Hệ</div>
                            <div class="info-value">
                                <i class="fas fa-envelope me-2 text-muted"></i>
                                <a href="mailto:${interview.application.jobSeeker.account.email}" class="text-decoration-none text-dark">
                                    ${interview.application.jobSeeker.account.email}
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Số Điện Thoại</div>
                            <div class="info-value">
                                <i class="fas fa-phone me-2 text-muted"></i>
                                ${interview.application.jobSeeker.account.phone}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-briefcase"></i>Chi Tiết Công Việc</h3>
                <div class="row">
                    <div class="col-12">
                        <div class="info-row">
                            <div class="info-label">Vị Trí Ứng Tuyển</div>
                            <div class="info-value">
                                <h5 class="mb-0 fw-bold" style="color: #9333ea;">${interview.application.jobPostings.title}</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Địa Điểm Làm Việc</div>
                            <div class="info-value">
                                <i class="fas fa-map-marker-alt me-2 text-muted"></i>${interview.application.jobPostings.location}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Mức Lương</div>
                            <div class="info-value">
                                <i class="fas fa-dollar-sign me-2 text-success"></i>
                                <fmt:formatNumber value="${interview.application.jobPostings.minSalary}" type="number"/> - 
                                <fmt:formatNumber value="${interview.application.jobPostings.maxSalary}" type="number"/>
                                ${interview.application.jobPostings.currency}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Hạn Nộp Hồ Sơ</div>
                            <div class="info-value">
                                <i class="fas fa-calendar-times me-2 text-danger"></i>
                                <fmt:formatDate value="${interview.application.jobPostings.closingDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="info-row">
                            <div class="info-label">Mô Tả Công Việc</div>
                            <div class="info-value text-secondary">
                                ${interview.application.jobPostings.description}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // JS for background stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 100;
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
        </script>
    </body>
</html>