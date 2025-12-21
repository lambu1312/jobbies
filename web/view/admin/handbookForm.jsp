<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Biểu Mẫu Handbook</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background-color: #f5f7fa;
                color: #1a1a1a;
            }

            /* Section Headers */
            h4 {
                color: #1a1a1a;
                font-weight: 700 !important;
                margin-bottom: 30px !important;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Form Labels */
            .form-label {
                font-weight: 600;
                color: #333;
                font-size: 14px;
                margin-bottom: 8px;
            }

            /* Select/Input Fields */
            .form-select,
            .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
                padding: 10px 12px;
                background-color: #f8f9fa;
                color: #1a1a1a;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-select:focus,
            .form-control:focus {
                border-color: #c471f5;
                background-color: #fff;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
                outline: none;
            }

            .form-select option {
                background-color: #fff;
                color: #1a1a1a;
            }

            /* Textarea */
            textarea.form-control {
                min-height: 300px;
                resize: vertical;
            }

            /* Alert */
            .alert {
                border-radius: 8px;
                border: none;
                margin-bottom: 20px;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
            }

            /* Buttons */
            .btn {
                border: none;
                font-weight: 600;
                border-radius: 8px;
                padding: 10px 20px;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(196, 113, 245, 0.3);
                color: white;
                text-decoration: none;
            }

            .btn-secondary {
                background-color: #e0e0e0;
                color: #333;
            }

            .btn-secondary:hover {
                background-color: #d0d0d0;
                transform: translateY(-2px);
                color: #333;
                text-decoration: none;
            }

            /* Image Preview */
            .img-preview {
                max-height: 120px;
                object-fit: cover;
                border-radius: 8px;
                margin-top: 10px;
            }

            /* Form Group */
            .mb-3 {
                margin-bottom: 20px;
            }

            /* Button Container */
            .d-flex {
                gap: 10px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .form-label {
                    font-size: 13px;
                }

                h4 {
                    font-size: 1.5rem;
                }

                .btn {
                    padding: 8px 16px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                    </div>

                    <div class="col-md-10">
                        <div class="container-fluid p-4">
                            <h4 class="mb-4">
                                <i class="fas fa-pen-fancy me-2"></i>
                            ${empty post ? 'Tạo Bài Viết Mới' : 'Chỉnh Sửa Bài Viết'}
                        </h4>

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                            </div>
                        </c:if>

                        <div class="card" style="border: 1px solid #e0e0e0; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <div class="card-body p-4">
                                <form action="${pageContext.request.contextPath}/handbook_admin" method="POST" enctype="multipart/form-data">
                                    <c:choose>
                                        <c:when test="${empty post}">
                                            <input type="hidden" name="action" value="create">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${post.handbookPostID}">
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="mb-3">
                                        <label class="form-label">Tiêu Đề</label>
                                        <input class="form-control" type="text" name="title" value="${empty post ? '' : post.title}" placeholder="Nhập tiêu đề bài viết..." required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Trạng Thái</label>
                                        <select class="form-select" name="status" required>
                                            <option value="Draft" ${(empty post && 'Draft' == 'Draft') || (!empty post && post.status == 'Draft') ? 'selected' : ''}>Nháp</option>
                                            <option value="Published" ${!empty post && post.status == 'Published' ? 'selected' : ''}>Đã Xuất Bản</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Hình Đại Diện</label>
                                        <input class="form-control" type="file" name="thumbnail" accept="image/*">
                                        <c:if test="${not empty post && not empty post.thumbnail}">
                                            <div class="mt-2">
                                                <small class="text-muted">Hình hiện tại:</small>
                                                <img src="${post.thumbnail}" alt="thumbnail" class="img-preview">
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Nội Dung</label>
                                        <textarea class="form-control" name="content" placeholder="Nhập nội dung bài viết..." required>${empty post ? '' : post.content}</textarea>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <button class="btn btn-primary" type="submit">
                                                <i class="fas fa-save me-2"></i>Lưu
                                            </button>
                                            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/handbook_admin">
                                                <i class="fas fa-times me-2"></i>Hủy
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>