<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Học vấn - Jobbies</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* ===== Global ===== */
            nav.navbar,
            .navbar {
                position: relative !important;
                z-index: 9999 !important;
            }

            .user-dropdown {
                position: relative !important;
                z-index: 10000 !important;
            }

            .user-dropdown .dropdown-menu {
                position: absolute !important;
                top: calc(100% + 0.5rem) !important;
                right: 0 !important;
                z-index: 10001 !important;
                display: block !important;
            }

            .user-dropdown:not(.active) .dropdown-menu {
                opacity: 0 !important;
                visibility: hidden !important;
                pointer-events: none !important;
            }

            .user-dropdown.active .dropdown-menu {
                opacity: 1 !important;
                visibility: visible !important;
                pointer-events: auto !important;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: #f8f9fa !important;
                color: #212529;
                min-height: 100vh;
            }

            /* ===== Container ===== */
            .container {
                background: #ffffff;
                padding: 2rem;
                border-radius: 20px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            }

            /* ===== Page Title ===== */
            h1 {
                font-size: 2.2rem;
                font-weight: 900;
                text-align: center;
                margin-bottom: 2rem;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                position: relative;
            }

            h1::after {
                content: '';
                display: block;
                width: 60px;
                height: 4px;
                margin: 12px auto 0;
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border-radius: 10px;
            }

            /* ===== Alerts ===== */
            .alert {
                border-radius: 15px;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            }

            /* ===== Table ===== */
            .table-bordered {
                background: #ffffff !important;
                border: 2px solid #dee2e6 !important;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            }

            .table-bordered thead th {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%) !important;
                color: #ffffff !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 1.1rem;
                border: none !important;
                font-size: 0.9rem;
            }

            .table-bordered tbody tr {
                transition: all 0.2s;
            }

            .table-bordered tbody tr:hover {
                background: #f8f4ff;
            }

            .table-bordered tbody td {
                padding: 1.1rem;
                vertical-align: middle;
                border: none !important;
                color: #212529;
            }

            /* ===== Image Thumbnail ===== */
            img.img-thumbnail {
                border-radius: 12px;
                border: 2px solid #c471f5;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 2px 8px rgba(196, 113, 245, 0.3);
            }

            img.img-thumbnail:hover {
                transform: scale(1.05);
            }

            /* ===== Buttons ===== */
            .btn {
                border-radius: 30px !important;
                font-weight: 700 !important;
                transition: all 0.3s !important;
            }

            /* Add Education */
            .btn-success {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
                border: none !important;
                color: #ffffff !important;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3) !important;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4) !important;
            }

            /* Edit */
            .btn-info {
                background: linear-gradient(135deg, #7ee8fa 0%, #5ec9db 100%) !important;
                border: none !important;
                color: #000000 !important;
                box-shadow: 0 3px 10px rgba(126, 232, 250, 0.3) !important;
            }

            .btn-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(126, 232, 250, 0.4) !important;
            }

            /* Delete */
            .btn-danger {
                background: linear-gradient(135deg, #ff6b6b 0%, #dc3545 100%) !important;
                border: none !important;
                color: #ffffff !important;
                box-shadow: 0 3px 10px rgba(220, 53, 69, 0.3) !important;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4) !important;
            }

            /* ===== Modal ===== */
            .modal-content {
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            }

            .modal-header {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: #ffffff;
                border-bottom: none;
                border-radius: 20px 20px 0 0;
            }

            .modal-title {
                font-weight: 800;
            }

            /* ===== Form ===== */
            .form-control,
            .form-select {
                border-radius: 12px;
                border: 2px solid #dee2e6;
                padding: 0.7rem 1rem;
                transition: all 0.3s;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #c471f5;
                box-shadow: 0 0 0 0.2rem rgba(196, 113, 245, 0.25);
            }

            /* ===== Responsive ===== */
            @media (max-width: 768px) {
                h1 {
                    font-size: 1.7rem;
                }

                .container {
                    padding: 90px;
                }

                .table {
                    font-size: 0.85rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class='container mt-5 mb-5'>
                <h1>Hồ Sơ Học Vấn 📚</h1>

            <c:if test="${not empty errorJobSeeker}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    Không tìm thấy thông tin học vấn cho người tìm việc này. <a href="JobSeekerCheck" style="color: #ff6b6b; font-weight: bold;">Nhấn vào đây để cập nhật!</a>
                </div>
            </c:if>

            <c:if test="${empty errorJobSeeker}">
                <!-- Display success messages outside modal -->
                <c:if test="${not empty successEducation}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle"></i>
                        ${successEducation}
                    </div>
                </c:if>

                <!-- Display education details in a table -->
                <c:if test="${not empty edus}">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Trường</th>
                                <th>Bằng cấp</th>
                                <th>Chuyên ngành</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Hình ảnh bằng cấp</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="edu" items="${edus}">
                                <tr>
                                    <td>${edu.institution}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${edu.degree == 'Cử nhân'}">Cử nhân</c:when>
                                            <c:when test="${edu.degree == 'Thạc sĩ'}">Thạc sĩ</c:when>
                                            <c:when test="${edu.degree == 'Tiến sĩ'}">Tiến sĩ</c:when>
                                            <c:otherwise>${edu.degree}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${edu.fieldOfStudy}</td>
                                    <td>${edu.startDate}</td>
                                    <td><c:if test="${not empty edu.endDate}">${edu.endDate}</c:if><c:if test="${empty edu.endDate}">Chưa có</c:if></td>
                                    <td><img src="${edu.getDegreeImg()}" alt="Bằng cấp" class="img-fluid img-thumbnail" style="max-width: 100px;"
                                             data-bs-toggle="modal" data-bs-target="#imageModal" onclick="showImage('${edu.getDegreeImg()}')"></td>
                                    <td>
                                        <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#updateEducationModal-${edu.educationID}">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(${edu.educationID})">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>

                                <!-- Update Education Modal -->
                            <div class="modal fade" id="updateEducationModal-${edu.educationID}" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-xl">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="updateModalLabel">Cập nhật học vấn</h5>
                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Error messages in update modal -->
                                            <c:if test="${param.educationID == edu.educationID && not empty errorEducation}">
                                                <div class="alert alert-danger" role="alert">
                                                    <i class="fas fa-exclamation-circle"></i>
                                                    ${errorEducation}
                                                </div>
                                            </c:if>

                                            <form action="${pageContext.request.contextPath}/education" method="post" id="updateEducationForm-${edu.educationID}" enctype="multipart/form-data" onsubmit="return validateUpdateForm(${edu.educationID})">
                                                <input type="hidden" name="action" value="update-education">
                                                <input type="hidden" name="educationID" value="${edu.educationID}">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="institution-${edu.educationID}" class="form-label">Trường</label>
                                                            <input type="text" class="form-control" id="institution-${edu.educationID}" name="institution" value="${edu.institution}" required>
                                                        </div>

                                                        <div class="form-group mb-3">
                                                            <label for="degree-${edu.educationID}" class="form-label">Bằng cấp</label>
                                                            <select class="form-select" id="degree-${edu.educationID}" name="degree" required>
                                                                <option value="Cử nhân" <c:if test="${edu.degree == 'Cử nhân'}">selected</c:if>>Cử nhân</option>
                                                                <option value="Thạc sĩ" <c:if test="${edu.degree == 'Thạc sĩ'}">selected</c:if>>Thạc sĩ</option>
                                                                <option value="Tiến sĩ" <c:if test="${edu.degree == 'Tiến sĩ'}">selected</c:if>>Tiến sĩ</option>
                                                                <option value="Khác" <c:if test="${edu.degree == 'Khác'}">selected</c:if>>Khác</option>
                                                                </select>
                                                            </div>

                                                            <div class="form-group mb-3">
                                                                <label for="fieldofstudy-${edu.educationID}" class="form-label">Chuyên ngành</label>
                                                            <input type="text" class="form-control" id="fieldofstudy-${edu.educationID}" name="fieldofstudy" value="${edu.fieldOfStudy}" required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="startDate-${edu.educationID}" class="form-label">Ngày bắt đầu</label>
                                                            <input type="date" class="form-control" id="startDate-${edu.educationID}" name="startDate" value="${edu.startDate}" required>
                                                        </div>

                                                        <div class="form-group mb-3">
                                                            <label for="endDate-${edu.educationID}" class="form-label">Ngày kết thúc</label>
                                                            <input type="date" class="form-control" id="endDate-${edu.educationID}" name="endDate" value="${edu.endDate}">
                                                            <div id="dateError-${edu.educationID}" class="text-danger mt-2" style="display: none;">
                                                                <i class="fas fa-exclamation-circle"></i>
                                                                Ngày kết thúc phải sau ngày bắt đầu ít nhất 2 năm.
                                                            </div>
                                                        </div>
                                                        <span style="color: #39ff14; font-style: italic">Nếu bạn chưa tốt nghiệp và vẫn đang học, bạn có thể nhập ngày dự kiến tốt nghiệp.</span>
                                                        <div class="form-group mb-3">
                                                            <label for="certificate-${edu.educationID}" class="form-label">Tải lên bằng cấp</label>
                                                            <input type="file" class="form-control" id="certificate-${edu.educationID}" name="degreeImg" accept="image/*" required>
                                                            <small class="text-muted">Chỉ chấp nhận JPG/PNG, dung lượng tối đa 200KB</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" form="updateEducationForm-${edu.educationID}" class="btn btn-success">
                                                <i class="fas fa-check"></i>
                                                Cập nhật
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <!-- Button to trigger the modal for adding education -->
                <button type="button" class="btn btn-success mt-4" data-bs-toggle="modal" data-bs-target="#educationModal">
                    <i class="fas fa-plus"></i>
                    Thêm học vấn
                </button>
            </c:if>
        </div>

        <!-- Modal for adding education -->
        <div class="modal fade" id="educationModal" tabindex="-1" aria-labelledby="AddModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="educationModalLabel">Thêm học vấn</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Error messages in add modal -->
                        <c:if test="${not empty errorEducation && empty successEducation}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle"></i>
                                <c:choose>
                                    <c:when test="${errorEducation == 'End date must be at least 2 years after the start date.'}" >
                                        Ngày kết thúc phải sau ngày bắt đầu ít nhất 2 năm.
                                    </c:when>
                                    <c:otherwise>
                                        ${errorEducation}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle"></i>
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/education" method="post" id="educationForm" enctype="multipart/form-data" onsubmit="return validateAddForm()">
                            <input type="hidden" name="action" value="add-education">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="institution" class="form-label">Trường</label>
                                        <input type="text" class="form-control" id="institution" name="institution" value="${sessionScope.institution}" required>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="degree" class="form-label">Bằng cấp</label>
                                        <select class="form-select" id="degree" name="degree" required>
                                            <option value="Cử nhân" <c:if test="${sessionScope.degree == 'Cử nhân'}">selected</c:if>>Cử nhân</option>
                                            <option value="Thạc sĩ" <c:if test="${sessionScope.degree == 'Thạc sĩ'}">selected</c:if>>Thạc sĩ</option>
                                            <option value="Tiến sĩ" <c:if test="${sessionScope.degree == 'Tiến sĩ'}">selected</c:if>>Tiến sĩ</option>
                                            <option value="Khác" <c:if test="${sessionScope.degree == 'Khác'}">selected</c:if>>Khác</option>
                                            </select>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="fieldofstudy" class="form-label">Chuyên ngành</label>
                                            <input type="text" class="form-control" id="fieldofstudy" name="fieldofstudy" value="${sessionScope.fieldofstudy}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" value="${sessionScope.startDateStr}" required>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="endDate" class="form-label">Ngày kết thúc</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" value="${sessionScope.endDateStr}" required>
                                        <div id="dateError" class="text-danger mt-2" style="display: none;">
                                            <i class="fas fa-exclamation-circle"></i>
                                            Ngày kết thúc phải sau ngày bắt đầu ít nhất 2 năm.
                                        </div>
                                    </div>
                                    <span style="color: #39ff14; font-style: italic">Nếu bạn chưa tốt nghiệp và vẫn đang học, bạn có thể nhập ngày dự kiến tốt nghiệp.</span>
                                    <div class="form-group mb-3">
                                        <label for="degreeImg" class="form-label">Tải lên bằng cấp</label>
                                        <input type="file" class="form-control" id="degreeImg" name="degreeImg" accept="image/*" required>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" form="educationForm" class="btn btn-success" id="submitEducationForm">
                            <i class="fas fa-plus"></i>
                            Thêm học vấn
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Image Modal -->
        <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">Hình ảnh bằng cấp</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="modalImage" src="" alt="Hình ảnh" class="img-fluid">
                    </div>
                </div>
            </div>
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
            const MAX_FILE_SIZE = 200 * 1024; // 200KB

// Validate image helper function
            function validateImage(input) {
                if (!input.files || !input.files[0])
                    return true;

                const file = input.files[0];

                // Check dung lượng
                if (file.size > MAX_FILE_SIZE) {
                    alert("❌ Ảnh vượt quá 200KB. Vui lòng chọn ảnh nhỏ hơn.");
                    input.value = ""; // XÓA FILE VỪA CHỌN
                    return false;
                }

                // Check định dạng
                const allowedTypes = ["image/jpeg", "image/png"];
                if (!allowedTypes.includes(file.type)) {
                    alert("❌ Chỉ chấp nhận ảnh JPG hoặc PNG.");
                    input.value = "";
                    return false;
                }

                return true;
            }

// Validate add form
            function validateAddForm() {
                // Validate dates
                const startDate = new Date(document.getElementById('startDate').value);
                const endDate = new Date(document.getElementById('endDate').value);
                const dateError = document.getElementById('dateError');

                // Calculate difference in years
                const yearDiff = (endDate - startDate) / (1000 * 60 * 60 * 24 * 365.25);

                if (yearDiff < 2) {
                    dateError.style.display = 'block';
                    return false;
                }

                dateError.style.display = 'none';

                // Validate image
                const fileInput = document.getElementById('degreeImg');
                if (!validateImage(fileInput)) {
                    return false;
                }

                return true;
            }

// Validate update form
            function validateUpdateForm(eduId) {
                // Validate dates
                const startDate = new Date(document.getElementById('startDate-' + eduId).value);
                const endDate = new Date(document.getElementById('endDate-' + eduId).value);
                const dateError = document.getElementById('dateError-' + eduId);

                // Calculate difference in years
                const yearDiff = (endDate - startDate) / (1000 * 60 * 60 * 24 * 365.25);

                if (yearDiff < 2) {
                    dateError.style.display = 'block';
                    return false;
                }

                dateError.style.display = 'none';

                // Validate image
                const fileInput = document.getElementById('certificate-' + eduId);
                if (!validateImage(fileInput)) {
                    return false;
                }

                return true;
            }
            
// Show image in modal
            function showImage(imageUrl) {
                document.getElementById('modalImage').src = imageUrl;
            }

// Handle modal z-index for proper layering
            document.addEventListener('DOMContentLoaded', function () {
                const modals = document.querySelectorAll('.modal');
                modals.forEach(function (modal) {
                    modal.addEventListener('show.bs.modal', function () {
                        this.style.zIndex = '10050';
                        setTimeout(function () {
                            const backdrop = document.querySelector('.modal-backdrop');
                            if (backdrop)
                                backdrop.style.zIndex = '10040';
                        }, 10);
                    });
                });

                // Add real-time validation on file input
                document.querySelectorAll('input[type="file"]').forEach(function (input) {
                    input.addEventListener('change', function () {
                        validateImage(this);
                    });
                });
            });

            // Auto-open modal if there's an error
            window.addEventListener('load', function () {
            <c:if test="${not empty errorEducation && empty successEducation}">
                var addModal = new bootstrap.Modal(document.getElementById('educationModal'));
                addModal.show();
            </c:if>
            });

            function confirmDelete(educationID) {
                if (confirm("Bạn có chắc chắn muốn xóa hồ sơ học vấn này không?")) {
                    const xhr = new XMLHttpRequest();
                    xhr.open("POST", "${pageContext.request.contextPath}/education", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                alert("Đã xóa hồ sơ học vấn thành công.");
                                location.reload();
                            } else {
                                alert("Lỗi khi xóa hồ sơ học vấn. Vui lòng thử lại.");
                            }
                        }
                    };
                    xhr.send("action=delete-education&educationID=" + educationID);
                }
            }

            function showImage(imageUrl) {
                document.getElementById('modalImage').src = imageUrl;
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const modals = document.querySelectorAll('.modal');
                modals.forEach(function (modal) {
                    modal.addEventListener('show.bs.modal', function () {
                        this.style.zIndex = '10050';
                        setTimeout(function () {
                            const backdrop = document.querySelector('.modal-backdrop');
                            if (backdrop)
                                backdrop.style.zIndex = '10040';
                        }, 10);
                    });
                });
            });

        </script>
    </body>
</html>