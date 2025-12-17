<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.JobPostings"%>
<%@page import="dao.JobPostingsDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản hồi của tôi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: linear-gradient(to bottom, #f8f9fa 0%, #e9ecef 100%);
                color: #212529;
                min-height: 100vh;
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
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.07), 0 1px 3px rgba(0,0,0,0.06);
                max-width: 1200px;
                margin: 30px auto;
            }

            h1 {
                font-size: 2.25rem;
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 10px;
                text-align: center;
                letter-spacing: -0.5px;
                position: relative;
                padding-bottom: 20px;
            }
            
            h1::after {
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
                margin-bottom: 40px;
            }
            
            table {
                border-collapse: separate;
                border-spacing: 0;
                background-color: #fff;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                overflow: hidden;
                width: 100%;
            }
            
            thead th {
                background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);
                color: #2c3e50;
                font-weight: 700;
                padding: 16px 18px;
                border-bottom: 2px solid #dee2e6;
                text-align: left;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            tbody tr {
                background-color: #ffffff;
                border-bottom: 1px solid #f1f3f5;
                transition: all 0.2s ease;
            }
            
            tbody tr:hover {
                background-color: #f8f9fa;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            
            tbody tr:last-child {
                border-bottom: none;
            }
            
            tbody td {
                padding: 16px 18px;
                vertical-align: middle;
                color: #495057;
                font-size: 0.95rem;
            }
            
            tbody td:first-child {
                font-weight: 500;
                color: #2c3e50;
            }
            
            .badge {
                padding: 7px 14px;
                font-size: 0.8rem;
                font-weight: 600;
                border-radius: 6px;
                letter-spacing: 0.3px;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }
            
            .badge i {
                font-size: 0.85rem;
            }
            
            .btn-sm {
                padding: 8px 16px;
                font-size: 0.875rem;
                border-radius: 6px;
                margin-right: 6px;
                font-weight: 500;
                transition: all 0.2s ease;
                border: none;
            }
            
            .btn-warning {
                background-color: #ffc107;
                color: #000;
            }
            
            .btn-warning:hover:not(:disabled) {
                background-color: #e0a800;
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(255,193,7,0.3);
            }
            
            .btn-danger:hover {
                background-color: #bb2d3b;
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(220,53,69,0.3);
            }
            
            .btn-sm:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
            
            .text-decoration-none {
                color: #667eea;
                font-weight: 500;
                transition: all 0.2s ease;
            }
            
            .text-decoration-none:hover {
                color: #5568d3;
                text-decoration: underline !important;
            }
            
            .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            }
            
            .modal-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: #fff;
                border-bottom: none;
                padding: 20px 24px;
                border-radius: 12px 12px 0 0;
            }
            
            .modal-title {
                font-weight: 600;
                font-size: 1.15rem;
            }
            
            .modal-body {
                padding: 24px;
            }
            
            .modal-footer {
                padding: 16px 24px;
                border-top: 1px solid #e9ecef;
            }
            
            .btn-close {
                filter: brightness(0) invert(1);
            }
            
            .form-label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                font-size: 0.95rem;
            }
            
            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 10px 14px;
                font-size: 0.95rem;
                transition: all 0.2s ease;
            }
            
            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102,126,234,0.15);
            }
            
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                padding: 10px 24px;
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.2s ease;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(102,126,234,0.4);
            }
            
            .btn-secondary {
                background-color: #f8f9fa;
                color: #495057;
                border: 2px solid #e9ecef;
                padding: 10px 24px;
                font-weight: 500;
                border-radius: 8px;
                transition: all 0.2s ease;
            }
            
            .btn-secondary:hover {
                background-color: #e9ecef;
                color: #212529;
            }
            
            #back-to-top {
                display: none;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                box-shadow: 0 4px 12px rgba(102,126,234,0.4);
                transition: all 0.3s ease;
                z-index: 999;
            }
            
            #back-to-top:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 16px rgba(102,126,234,0.5);
            }
            
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #6c757d;
            }
            
            .empty-state i {
                font-size: 4rem;
                color: #dee2e6;
                margin-bottom: 20px;
            }
            
            .empty-state h3 {
                font-size: 1.5rem;
                font-weight: 600;
                color: #495057;
                margin-bottom: 10px;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                }
                
                h1 {
                    font-size: 1.75rem;
                }
                
                table {
                    font-size: 0.85rem;
                }
                
                tbody td {
                    padding: 12px;
                }
                
                .btn-sm {
                    padding: 6px 10px;
                    font-size: 0.8rem;
                    display: block;
                    width: 100%;
                    margin-bottom: 6px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
        <!-- Header Area End -->
        
        <div class="container mt-5">
            <h1>Phản hồi của tôi</h1>
            <p class="page-subtitle">Quản lý các phản hồi của bạn về các tin tuyển dụng</p>

            <table class="table table-hover mt-3">
                <thead>
                    <tr>
                        <th>Nội dung phản hồi</th>
                        <th>Tiêu đề công việc</th>
                        <th style="text-align: center;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    JobPostings jobPost = new JobPostings();
                    JobPostingsDAO jobPostDao = new JobPostingsDAO();
                %>
                <c:forEach var="feedback" items="${feedbackList}">
                    <c:if test="${feedback.getStatus() != 4}">
                        <tr>
                            <td>${feedback.getContentFeedback()}</td>
                            <td>
                                <c:set var="jobPostId" value="${feedback.getJobPostingID()}"/>
                                <%
                                    int jobPostId = (Integer) pageContext.getAttribute("jobPostId");
                                    jobPost = jobPostDao.findJobPostingById(jobPostId);
                                    String title = "";
                                    if(jobPost != null){
                                        title = jobPost.getTitle();
                                    }
                                %>
                                <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${feedback.getJobPostingID()}" class="text-decoration-none">
                                    <i class="fa fa-briefcase"></i> <%= title %>
                                </a>
                            </td>
                            <td style="text-align: center;">
                                <button type="button" class="btn btn-warning btn-sm" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#editFeedbackModal" 
                                        data-feedback-id="${feedback.getFeedbackID()}"
                                        data-feedback-content="${feedback.getContentFeedback()}"
                                        <c:if test="${feedback.getStatus() != 1}">disabled</c:if>>
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <form action="feedbackSeeker" method="post" style="display:inline;">
                                    <input type="hidden" name="feedbackId" value="${feedback.getFeedbackID()}"/>
                                    <input type="hidden" name="action" value="delete"/>
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa phản hồi này?');">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${empty feedbackList}">
                <div class="empty-state">
                    <i class="fa fa-comments"></i>
                    <h3>Chưa có phản hồi nào</h3>
                    <p>Bạn chưa có phản hồi nào. Hãy bắt đầu phản hồi về các tin tuyển dụng!</p>
                </div>
            </c:if>
        </div>

        <!-- Edit Feedback Modal -->
        <div class="modal fade" id="editFeedbackModal" tabindex="-1" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="feedbackSeeker" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editFeedbackModalLabel">
                                <i class="fa fa-edit"></i> Chỉnh sửa phản hồi
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editFeedbackContent" class="form-label">
                                    <i class="fa fa-comment"></i> Nội dung phản hồi
                                </label>
                                <textarea class="form-control" id="editFeedbackContent" name="content" rows="5" placeholder="Nhập nội dung phản hồi của bạn..." required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" id="editFeedbackId" name="feedbackId"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="fa fa-times"></i> Hủy
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa fa-save"></i> Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Back to Top Button -->
        <button type="button" class="btn btn-primary position-fixed" id="back-to-top" style="bottom: 20px; right: 20px;">
            <i class="fas fa-arrow-up"></i>
        </button>
        
        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Gán dữ liệu cho modal edit khi nút Edit được ấn
            var editFeedbackModal = document.getElementById('editFeedbackModal');
            editFeedbackModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var feedbackId = button.getAttribute('data-feedback-id');
                var feedbackContent = button.getAttribute('data-feedback-content');

                var modalContent = editFeedbackModal.querySelector('#editFeedbackContent');
                var modalFeedbackId = editFeedbackModal.querySelector('#editFeedbackId');

                modalContent.value = feedbackContent;
                modalFeedbackId.value = feedbackId;
            });
            
            // Back to top button
            const backToTopButton = document.getElementById('back-to-top');

            window.onscroll = function () {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    backToTopButton.style.display = 'block';
                } else {
                    backToTopButton.style.display = 'none';
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
