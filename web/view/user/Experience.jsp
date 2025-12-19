<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seeker's Experience</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
        <style>
/* ===== Global ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

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

/* Character Counter */
.char-counter {
    font-size: 0.85rem;
    color: #6c757d;
    margin-top: 0.25rem;
}

.char-counter.warning {
    color: #ffc107;
}

.char-counter.danger {
    color: #dc3545;
}

.form-control.is-invalid {
    border-color: #dc3545;
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
            <!-- Header Area End -->

            <div class='container mt-5 mb-5'>
                <h1 class="text-center">Kinh nghiệm</h1>

            <c:if test="${not empty errorJobSeeker}">
                <div class="alert alert-danger" role="alert">
                    ${errorJobSeeker} <a href="JobSeekerCheck">Click here!!</a>
                </div>
            </c:if>

            <c:if test="${empty errorJobSeeker}">
                <!-- Display error messages if any -->
                <c:if test="${not empty errorExperience}">
                    <div class="alert alert-danger" role="alert">
                        ${errorExperience}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <!-- Display success messages if any -->
                <c:if test="${not empty successExperience}">
                    <div class="alert alert-success" role="alert">
                        ${successExperience}
                    </div>
                </c:if>

                <!-- Display education details in a table -->
                <c:if test="${not empty wes}">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Tên Công Ty</th>
                                <th>Vị Trí</th>
                                <th>Ngày Bắt Đầu</th>
                                <th>Ngày Kết Thúc</th>
                                <th>Mô Tả</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="we" items="${wes}">
                                <tr>
                                    <td>${we.companyName}</td>
                                    <td>${we.jobTitle}</td>
                                    <td>${we.startDate}</td>
                                    <td><c:if test="${not empty we.endDate}">${we.endDate}</c:if><c:if test="${empty we.endDate}">N/A</c:if></td>
                                    <td>${we.description}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#updateExperienceModal-${we.experienceID}">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(${we.experienceID})">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>

                                <!-- Update Experience Modal -->
                            <div class="modal fade" id="updateExperienceModal-${we.experienceID}" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-xl">
                                    <div class="modal-content">
                                        <div class="modal-header bg-warning text-white">
                                            <h5 class="modal-title" id="updateModalLabel">Cập Nhật Kinh Nghiệm</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="${pageContext.request.contextPath}/experience" method="post" id="updateExperienceForm-${we.experienceID}">
                                                <input type="hidden" name="action" value="update-experience">
                                                <input type="hidden" name="experienceID" value="${we.experienceID}">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="companyName-update-${we.experienceID}">Tên Công Ty</label>
                                                            <input type="text" class="form-control" id="companyName-update-${we.experienceID}" name="companyName" value="${we.companyName}" maxlength="100" required>
                                                            <div class="char-counter">
                                                                <span class="current">0</span>/<span class="max">100</span> ký tự
                                                            </div>
                                                        </div>

                                                        <div class="form-group mb-3">
                                                            <label for="jobTitle-update-${we.experienceID}">Vị Trí</label>
                                                            <input type="text" class="form-control" id="jobTitle-update-${we.experienceID}" name="jobTitle" value="${we.jobTitle}" maxlength="100" required>
                                                            <div class="char-counter">
                                                                <span class="current">0</span>/<span class="max">100</span> ký tự
                                                            </div>
                                                        </div>

                                                        <div class="form-group mb-3">
                                                            <label for="description-update-${we.experienceID}">Mô Tả</label>
                                                            <textarea id="description-update-${we.experienceID}" name="description" class="form-control" placeholder="Link dự án ..." rows="3" maxlength="500" required>${we.description}</textarea>
                                                            <div class="char-counter">
                                                                <span class="current">0</span>/<span class="max">500</span> ký tự
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="startDate-update-${we.experienceID}">Ngày Bắt Đầu</label>
                                                            <input type="date" class="form-control" id="startDate-update-${we.experienceID}" name="startDate" value="${we.startDate}" required>
                                                        </div>

                                                        <div class="form-group mb-3">
                                                            <label for="endDate-update-${we.experienceID}">Ngày Kết Thúc</label>
                                                            <input type="date" class="form-control" id="endDate-update-${we.experienceID}" name="endDate" value="${we.endDate}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" form="updateExperienceForm-${we.experienceID}" class="btn btn-warning">Cập Nhật</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <!-- Button to trigger the modal for adding experience -->
                <button type="button" class="btn btn-success mt-4" data-bs-toggle="modal" data-bs-target="#experienceModal">
                    Thêm
                </button>
            </c:if>

        </div>

        <!-- Modal for adding experience -->
        <div class="modal fade" id="experienceModal" tabindex="-1" aria-labelledby="AddModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="experienceModalLabel">Thêm Kinh Nghiệm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/experience" method="post" id="experienceForm">
                            <input type="hidden" name="action" value="add-experience">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="companyName">Tên Công Ty</label>
                                        <input type="text" class="form-control" id="companyName" name="companyName" value="${sessionScope.companyName}" maxlength="100" required>
                                        <div class="char-counter">
                                            <span class="current">0</span>/<span class="max">100</span> ký tự
                                        </div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="jobTitle">Vị Trí</label>
                                        <input type="text" class="form-control" id="jobTitle" name="jobTitle" value="${sessionScope.jobTitle}" maxlength="100" required>
                                        <div class="char-counter">
                                            <span class="current">0</span>/<span class="max">100</span> ký tự
                                        </div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="description">Mô Tả</label>
                                        <textarea id="description" name="description" class="form-control" placeholder="Thêm mô tả công việc" rows="3" maxlength="500" required>${sessionScope.description}</textarea>
                                        <div class="char-counter">
                                            <span class="current">0</span>/<span class="max">500</span> ký tự
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label for="startDate">Ngày Bắt Đầu</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" value="${sessionScope.startDateStr}" required>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="endDate">Ngày Kết Thúc</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" value="${sessionScope.endDateStr}">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" form="experienceForm" class="btn btn-success">Thêm</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Character counter function
            function updateCharCounter(input) {
                const maxLength = input.getAttribute('maxlength');
                const currentLength = input.value.length;
                const counter = input.parentElement.querySelector('.char-counter');
                
                if (counter) {
                    const currentSpan = counter.querySelector('.current');
                    currentSpan.textContent = currentLength;
                    
                    // Change color based on percentage
                    const percentage = (currentLength / maxLength) * 100;
                    counter.classList.remove('warning', 'danger');
                    
                    if (percentage >= 90) {
                        counter.classList.add('danger');
                        input.classList.add('is-invalid');
                    } else if (percentage >= 75) {
                        counter.classList.add('warning');
                        input.classList.remove('is-invalid');
                    } else {
                        input.classList.remove('is-invalid');
                    }
                }
            }

            // Initialize character counters on page load
            document.addEventListener('DOMContentLoaded', function() {
                const inputs = document.querySelectorAll('input[maxlength], textarea[maxlength]');
                
                inputs.forEach(input => {
                    // Update counter on load
                    updateCharCounter(input);
                    
                    // Update counter on input
                    input.addEventListener('input', function() {
                        updateCharCounter(this);
                    });
                });
            });

            // Update counters when modals are shown
            document.querySelectorAll('.modal').forEach(modal => {
                modal.addEventListener('shown.bs.modal', function() {
                    const inputs = this.querySelectorAll('input[maxlength], textarea[maxlength]');
                    inputs.forEach(input => {
                        updateCharCounter(input);
                    });
                });
            });

            function confirmDelete(experienceID) {
                if (confirm("Bạn có chắc chắn muốn xóa kinh nghiệm này không?")) {
                    const xhr = new XMLHttpRequest();
                    xhr.open("POST", "${pageContext.request.contextPath}/experience", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                alert("Xóa kinh nghiệm thành công.");
                                location.reload();
                            } else {
                                alert("Lỗi khi xóa kinh nghiệm. Vui lòng thử lại.");
                            }
                        }
                    };
                    xhr.send("action=delete-experience&experienceID=" + experienceID);
                }
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>