<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Lịch Phỏng Vấn</title>
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
                0%, 100% { opacity: 0.3; }
                50% { opacity: 1; }
            }
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.1;
                z-index: 0;
                animation: float 4s ease-in-out infinite;
            }
            .deco-1 { top: 20%; left: 10%; }
            .deco-2 { top: 60%; right: 15%; animation-delay: 2s; }
            .deco-3 { bottom: 15%; left: 20%; animation-delay: 1s; }
            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }

            /* --- Main Content Styling --- */
            .content {
                margin-left: 260px; /* Khớp với sidebar */
                padding: 30px;
                padding-top: 90px; /* Tránh header */
                position: relative;
                z-index: 10;
            }

            .page-header {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                padding: 30px;
                border-radius: 15px;
                margin-bottom: 30px;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.3);
                border: 1px solid rgba(255,255,255,0.2);
            }

            .filter-card {
                background: rgba(255, 255, 255, 0.95);
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                margin-bottom: 25px;
                border: 1px solid rgba(0,0,0,0.05);
            }

            .interview-table {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0,0,0,0.05);
            }

            .interview-table table {
                margin-bottom: 0;
            }

            .interview-table th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                padding: 15px;
                border: none;
            }

            .interview-table td {
                padding: 15px;
                vertical-align: middle;
                border-bottom: 1px solid #f0f0f0;
                font-size: 0.9rem;
            }

            .interview-table tr:hover {
                background-color: rgba(196, 113, 245, 0.05);
            }

            /* --- Badges --- */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }
            .status-scheduled { background-color: #e0f2fe; color: #0284c7; } /* Xanh dương nhạt */
            .status-rescheduled { background-color: #fef3c7; color: #d97706; } /* Vàng */
            .status-completed { background-color: #dcfce7; color: #16a34a; } /* Xanh lá */
            .status-cancelled { background-color: #fee2e2; color: #dc2626; } /* Đỏ */

            .interview-type-badge {
                padding: 4px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 500;
            }
            .type-online { background-color: #f3e8ff; color: #9333ea; } /* Tím nhạt */
            .type-offline { background-color: #fce7f3; color: #db2777; } /* Hồng nhạt */

            /* --- Buttons & Inputs --- */
            .btn-action {
                padding: 6px 12px;
                margin: 2px;
                font-size: 0.85rem;
                border-radius: 8px;
                border: none;
                transition: 0.3s;
            }
            
            .btn-primary, .btn-info {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                color: white;
                box-shadow: 0 4px 10px rgba(196, 113, 245, 0.3);
            }
            
            .btn-primary:hover, .btn-info:hover {
                opacity: 0.9;
                color: white;
                transform: translateY(-1px);
            }

            .btn-info {
                background: white;
                color: #c471f5;
                border: 1px solid #fa71cd;
                box-shadow: none;
            }
            .btn-info:hover {
                background: #fdf2f8;
                color: #fa71cd;
            }

            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #e5e5e5;
                padding: 10px;
            }
            .form-control:focus, .form-select:focus {
                border-color: #fa71cd;
                box-shadow: 0 0 0 0.2rem rgba(250, 113, 205, 0.25);
            }

            /* Pagination Styling */
            .page-item.active .page-link {
                background-color: #fa71cd;
                border-color: #fa71cd;
            }
            .page-link {
                color: #c471f5;
            }
            
            /* Responsive */
            @media (max-width: 1200px) {
                .content { margin-left: 0; }
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
            <div class="page-header">
                <h1><i class="fas fa-calendar-check me-3"></i>Quản Lý Lịch Phỏng Vấn</h1>
                <p class="mb-0">Theo dõi và cập nhật trạng thái các cuộc phỏng vấn</p>
            </div>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            <c:if test="${param.success eq 'interview_updated'}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>Cập nhật phỏng vấn thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success eq 'interview_deleted'}">
                <div class="alert alert-warning alert-dismissible fade show">
                    <i class="fas fa-trash me-2"></i>Đã xóa cuộc phỏng vấn!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="filter-card">
                <form method="get" action="${pageContext.request.contextPath}/interviewManagement">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-search me-2"></i>Tìm kiếm ứng viên</label>
                            <input type="text" class="form-control" name="searchName" 
                                   value="${searchName}" placeholder="Nhập tên ứng viên...">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-briefcase me-2"></i>Vị trí công việc</label>
                            <select class="form-select" name="jobFilter">
                                <option value="all" ${jobFilter eq 'all' || empty jobFilter ? 'selected' : ''}>Tất cả vị trí</option>
                                <c:forEach var="job" items="${allJobPostings}">
                                    <option value="${job.jobPostingID}" ${jobFilter == String.valueOf(job.jobPostingID) ? 'selected' : ''}>
                                        ${job.title}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label"><i class="fas fa-filter me-2"></i>Trạng thái</label>
                            <select class="form-select" name="statusFilter">
                                <option value="all" ${statusFilter eq 'all' || empty statusFilter ? 'selected' : ''}>Tất cả</option>
                                <option value="Scheduled" ${statusFilter eq 'Scheduled' ? 'selected' : ''}>Đã lên lịch</option>
                                <option value="Rescheduled" ${statusFilter eq 'Rescheduled' ? 'selected' : ''}>Dời lịch</option>
                                <option value="Completed" ${statusFilter eq 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                                <option value="Cancelled" ${statusFilter eq 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label"><i class="fas fa-calendar me-2"></i>Ngày</label>
                            <input type="date" class="form-control" name="dateFilter" value="${dateFilter}">
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Lọc
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="interview-table">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Ứng Viên</th>
                            <th>Vị Trí Ứng Tuyển</th>
                            <th>Ngày & Giờ</th>
                            <th>Hình Thức</th>
                            <th>Địa Điểm / Link</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="interview" items="${interviews}">
                            <tr>
                                <td>
                                    <strong>${interview.application.jobSeeker.account.fullName}</strong><br>
                                    <small class="text-muted">${interview.application.jobSeeker.account.email}</small>
                                </td>
                                <td>${interview.application.jobPostings.title}</td>
                                <td>
                                    <i class="fas fa-calendar me-2 text-muted"></i>
                                    <fmt:formatDate value="${interview.interviewDate}" pattern="dd/MM/yyyy"/><br>
                                    <i class="fas fa-clock me-2 text-muted"></i>${interview.interviewTime}
                                </td>
                                <td>
                                    <span class="interview-type-badge ${interview.interviewType eq 'Online' ? 'type-online' : 'type-offline'}">
                                        ${interview.interviewType eq 'Online' ? 'Trực tuyến' : 'Tại văn phòng'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${interview.interviewType eq 'Online'}">
                                            <a href="${interview.meetingLink}" target="_blank" class="text-decoration-none" style="color: #9333ea;">
                                                <i class="fas fa-link me-1"></i>Link cuộc họp
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-map-marker-alt me-1 text-muted"></i>${interview.location}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="status-badge status-${interview.status.toLowerCase()}">
                                        <c:choose>
                                            <c:when test="${interview.status eq 'Scheduled'}">Đã lên lịch</c:when>
                                            <c:when test="${interview.status eq 'Rescheduled'}">Dời lịch</c:when>
                                            <c:when test="${interview.status eq 'Completed'}">Hoàn thành</c:when>
                                            <c:when test="${interview.status eq 'Cancelled'}">Đã hủy</c:when>
                                            <c:otherwise>${interview.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-info btn-action" 
                                            onclick="event.preventDefault(); event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/interviewDetails?interviewId=${interview.interviewID}';">
                                        <i class="fas fa-eye"></i> Xem
                                    </button>
                                    <button type="button" class="btn btn-sm btn-primary btn-action"
                                            data-bs-toggle="modal" data-bs-target="#editInterviewModal"
                                            onclick="editInterview(${interview.interviewID}, ${interview.application.applicationID}, '${interview.interviewDate}', '${interview.interviewTime}', '${interview.location}', '${interview.interviewType}', '${interview.meetingLink}', '${interview.notes}', '${interview.status}')">
                                        <i class="fas fa-edit"></i> Sửa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty interviews}">
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">Không tìm thấy lịch phỏng vấn nào</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <c:if test="${totalPages > 1}">
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div class="text-muted">
                        Hiển thị ${(currentPage - 1) * 10 + 1} đến ${(currentPage - 1) * 10 + interviews.size()} trong tổng số ${totalRecords} cuộc phỏng vấn
                    </div>
                    <nav>
                        <ul class="pagination mb-0">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                    Trước
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                    Sau
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>

        <div class="modal fade" id="editInterviewModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header text-white" style="background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Chỉnh Sửa Lịch Phỏng Vấn</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editInterviewForm" action="${pageContext.request.contextPath}/scheduleInterview" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="interviewId" id="editInterviewId">
                            <input type="hidden" name="jobPostId" value="0">
                            <input type="hidden" name="returnTo" value="management">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày phỏng vấn <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="editInterviewDate" name="interviewDate" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Giờ phỏng vấn <span class="text-danger">*</span></label>
                                    <input type="time" class="form-control" id="editInterviewTime" name="interviewTime" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Hình thức phỏng vấn <span class="text-danger">*</span></label>
                                <select class="form-select" id="editInterviewType" name="interviewType" onchange="toggleEditFields()" required>
                                    <option value="Online">Trực tuyến (Online)</option>
                                    <option value="Offline">Tại văn phòng (Offline)</option>
                                </select>
                            </div>
                            
                            <div class="mb-3" id="editLocationField">
                                <label class="form-label">Địa điểm</label>
                                <input type="text" class="form-control" id="editLocation" name="location" placeholder="Nhập địa chỉ văn phòng...">
                            </div>
                            
                            <div class="mb-3" id="editMeetingLinkField">
                                <label class="form-label">Link cuộc họp</label>
                                <input type="url" class="form-control" id="editMeetingLink" name="meetingLink" placeholder="https://...">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea class="form-control" id="editNotes" name="notes" rows="3" placeholder="Ghi chú thêm..."></textarea>
                            </div>
                            
                            <input type="hidden" id="editStatus" name="status">
                            
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" onclick="deleteInterviewFromModal()">
                                    <i class="fas fa-trash"></i> Xóa Lịch
                                </button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Cập Nhật
                                </button>
                            </div>
                        </form>
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

            // JS for Edit Modal Logic
            function editInterview(interviewId, applicationId, interviewDate, interviewTime, location, interviewType, meetingLink, notes, status) {
                if (interviewDate && interviewDate.includes(' ')) {
                    interviewDate = interviewDate.split(' ')[0];
                }
                
                document.getElementById('editInterviewId').value = interviewId;
                document.getElementById('editInterviewDate').value = interviewDate;
                document.getElementById('editInterviewTime').value = interviewTime || '';
                document.getElementById('editLocation').value = location || '';
                document.getElementById('editInterviewType').value = interviewType || 'Offline';
                document.getElementById('editMeetingLink').value = meetingLink || '';
                document.getElementById('editNotes').value = notes || '';
                document.getElementById('editStatus').value = status || 'Scheduled';
                
                toggleEditFields();
            }
            
            function toggleEditFields() {
                const type = document.getElementById('editInterviewType').value;
                const locationField = document.getElementById('editLocationField');
                const meetingLinkField = document.getElementById('editMeetingLinkField');
                
                if (type === 'Online') {
                    meetingLinkField.style.display = 'block';
                    locationField.style.display = 'none';
                } else {
                    meetingLinkField.style.display = 'none';
                    locationField.style.display = 'block';
                }
            }
            
            function deleteInterviewFromModal() {
                if (confirm('Bạn có chắc chắn muốn xóa lịch phỏng vấn này không?')) {
                    const interviewId = document.getElementById('editInterviewId').value;
                    window.location.href = '${pageContext.request.contextPath}/scheduleInterview?action=delete&interviewId=' + interviewId + '&jobPostId=0&returnTo=management';
                }
            }
        </script>
    </body>
</html>