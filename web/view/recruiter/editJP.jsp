<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Bài Đăng - Jobbies</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/1af9q7p79qcrurx9hkvj3z4dn90yr8d6lwb5fdyny56uqoh9/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8eef5 50%, #f0f5fb 100%);
                color: #1a1a1a;
            }

            /* General form container styles */
            .job-posting-container {
                flex: 1;
                padding: 40px;
                margin-left: 260px;
                margin-top: 80px;
                box-sizing: border-box;
                background: transparent;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: calc(100vh - 80px);
            }

            /* Form card styling with hover effect */
            .job-posting-card {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 12px;
                border: 1px solid rgba(196, 113, 245, 0.2);
                max-width: 850px;
                width: 100%;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
            }

            .job-posting-card:hover {
                border-color: rgba(196, 113, 245, 0.4);
                box-shadow: 0 8px 30px rgba(196, 113, 245, 0.15);
            }

            /* Title styling */
            .job-posting-card h2 {
                text-align: center;
                margin-bottom: 30px;
                font-weight: 700;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-size: 28px;
            }

            /* Back button styling */
            .btn-back {
                background-color: #fff;
                border: 1.5px solid #c471f5;
                color: #c471f5;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                margin-bottom: 20px;
            }

            .btn-back:hover {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                border-color: transparent;
                text-decoration: none;
            }

            /* Label and input field styling with hover effect */
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
                color: #333;
            }

            .form-control,
            .form-select {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
                padding: 12px 14px;
                font-size: 14px;
                background-color: #f8f9fa;
                transition: all 0.3s ease;
                margin-bottom: 20px;
                color: #1a1a1a;
            }

            .form-control::placeholder {
                color: #999;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #c471f5;
                background-color: #fff;
                box-shadow: 0 0 15px rgba(196, 113, 245, 0.2);
                outline: none;
            }

            .form-select {
                padding: 10px 14px;
            }

            .form-select option {
                background-color: #fff;
                color: #1a1a1a;
            }

            /* Textarea styling */
            textarea.form-control {
                resize: vertical;
                min-height: 120px;
            }

            /* Button styling with hover effect */
            .btn-group {
                display: flex;
                justify-content: flex-start;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-save {
                padding: 12px 28px;
                font-size: 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 600;
                border: none;
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
                cursor: pointer;
            }

            .btn-save:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
                color: white;
            }

            /* Error and success message styling */
            .alert {
                margin-top: 20px;
                border-radius: 8px;
                border: none;
                font-size: 14px;
            }

            .alert-danger {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
                border-left: 4px solid #dc3545;
            }

            .alert-success {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
                border-left: 4px solid #28a745;
            }

            .alert ul {
                margin: 0;
                padding-left: 20px;
            }

            .alert li {
                margin-bottom: 5px;
            }

            /* Row spacing */
            .row {
                margin-bottom: 0;
            }

            .col-md-4,
            .col-md-6 {
                margin-bottom: 0;
            }

            /* Mobile Responsive */
            @media (max-width: 1200px) {
                .job-posting-container {
                    margin-left: 0;
                }
            }

            @media (max-width: 768px) {
                .job-posting-container {
                    padding: 20px;
                    margin-top: 60px;
                }

                .job-posting-card {
                    padding: 25px;
                }

                .job-posting-card h2 {
                    font-size: 22px;
                    margin-bottom: 20px;
                }

                .form-control,
                .form-select {
                    font-size: 13px;
                    padding: 10px 12px;
                }

                .btn-group {
                    flex-wrap: wrap;
                    gap: 10px;
                }

                .btn-save {
                    padding: 10px 20px;
                    font-size: 14px;
                    flex: 1;
                    min-width: 100px;
                }
            }

            @media (max-width: 480px) {
                .job-posting-container {
                    padding: 15px;
                }

                .job-posting-card {
                    padding: 20px;
                }

                .job-posting-card h2 {
                    font-size: 18px;
                    margin-bottom: 15px;
                }

                .form-group label {
                    font-size: 13px;
                }

                .form-control,
                .form-select {
                    font-size: 12px;
                    padding: 10px;
                    margin-bottom: 15px;
                }

                .btn-save {
                    padding: 10px 16px;
                    font-size: 13px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Job Posting Form -->
        <div class="job-posting-container">
            <div class="job-posting-card">
                <a href="${pageContext.request.contextPath}/jobPost" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay Lại
                </a>
                <h2>Chỉnh Sửa Bài Đăng Công Việc</h2>

                <!-- Display error message if login fails -->
                <c:if test="${not empty eM}">
                    <div class="alert alert-danger" role="alert">
                        <ul>
                            <c:forEach var="error" items="${eM}">
                                <li>${error}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>

                <!-- Edit Job Posting Form -->
                <form id="jobForm" action="${pageContext.request.contextPath}/jobPost?action=updateJobPost" method="post" onsubmit="return validateForm()">
                    <input type="hidden" id="JobPostingID" name="JobPostingID" 
                           value="${param.JobPostingID != null ? param.JobPostingID : jobPost.getJobPostingID()}">

                    <!-- Job Title -->
                    <div class="form-group">
                        <label for="jobTitle">Tiêu Đề Công Việc:</label>
                        <input type="text" id="jobTitle" name="jobTitle" class="form-control" 
                               value="${param.jobTitle != null ? param.jobTitle : jobPost.getTitle()}" 
                               placeholder="Nhập tiêu đề công việc" required>
                    </div>

                    <!-- Job Location -->
                    <div class="form-group">
                        <label for="jobLocation">Địa Điểm:</label>
                        <input type="text" id="jobLocation" name="jobLocation" class="form-control" 
                               value="${param.jobLocation != null ? param.jobLocation : jobPost.getLocation()}" 
                               placeholder="Nhập địa điểm công việc" required>
                    </div>

                    <!-- Job Description -->
                    <div class="form-group">
                        <label for="jobDescription">Mô Tả Công Việc:</label>
                        <textarea id="jobDescription" name="jobDescription" class="form-control" rows="6">${fn:escapeXml(param.jobDescription != null ? param.jobDescription : jobPost.getDescription())}</textarea>
                    </div>

                    <!-- Job Requirements -->
                    <div class="form-group">
                        <label for="jobRequirements">Yêu Cầu Công Việc:</label>
                        <textarea id="jobRequirements" name="jobRequirements" class="form-control" rows="6">${fn:escapeXml(param.jobRequirements != null ? param.jobRequirements : jobPost.getRequirements())}</textarea>
                    </div>

                    <!-- Salary Row -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="currency">Loại Tiền Tệ:</label>
                                <select id="currency" name="currency" class="form-select" required>
                                    <option value="USD" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'USD' ? 'selected' : ''}>USD ($)</option>
                                    <option value="VND" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'VND' ? 'selected' : ''}>VND (₫)</option>
                                    <option value="EUR" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'EUR' ? 'selected' : ''}>EUR (€)</option>
                                    <option value="GBP" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'GBP' ? 'selected' : ''}>GBP (£)</option>
                                    <option value="JPY" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'JPY' ? 'selected' : ''}>JPY (¥)</option>
                                    <option value="AUD" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'AUD' ? 'selected' : ''}>AUD (A$)</option>
                                    <option value="CAD" ${(param.currency != null ? param.currency : jobPost.getCurrency()) == 'CAD' ? 'selected' : ''}>CAD (C$)</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="minSalary">Lương Tối Thiểu:</label>
                                <input type="number" id="minSalary" name="minSalary" class="form-control" 
                                       value="${param.minSalary != null ? param.minSalary : jobPost.getMinSalary()}" 
                                       placeholder="Nhập lương tối thiểu" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="maxSalary">Lương Tối Đa:</label>
                                <input type="number" id="maxSalary" name="maxSalary" class="form-control" 
                                       value="${param.maxSalary != null ? param.maxSalary : jobPost.getMaxSalary()}" 
                                       placeholder="Nhập lương tối đa" required>
                            </div>
                        </div>
                    </div>

                    <!-- Job Category -->
                    <div class="form-group">
                        <label for="jobCategory">Danh Mục Công Việc:</label>
                        <select id="jobCategory" name="jobCategory" class="form-select" required>
                            <option value="">Chọn Danh Mục</option>
                            <c:forEach var="category" items="${jobCategories}">
                                <c:if test="${category.status == true}">
                                    <option value="${category.getId()}" 
                                            <c:if test="${category.getId() == selectedJobCategory}">selected</c:if>>
                                        ${category.getName()}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Status and Posted Date Row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="jobStatus">Trạng Thái:</label>
                                <select id="jobStatus" name="jobStatus" class="form-select" required>
                                    <option value="Open" ${param.jobStatus == 'Open' ? 'selected' : (jobPost.getStatus() == 'Open' ? 'selected' : '')}>Mở</option>
                                    <option value="Closed" ${param.jobStatus == 'Closed' ? 'selected' : (jobPost.getStatus() == 'Closed' ? 'selected' : '')}>Đóng</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="postedDate">Ngày Đăng:</label>
                                <input type="date" id="postedDate" name="postedDate" class="form-control" 
                                       value="${param.postedDate != null ? param.postedDate : jobPost.getPostedDate()}" required>
                            </div>
                        </div>
                    </div>

                    <!-- Closing Date Row -->
                    <div class="form-group">
                        <label for="closingDate">Ngày Đóng:</label>
                        <input type="date" id="closingDate" name="closingDate" class="form-control" 
                               value="${param.closingDate != null ? param.closingDate : jobPost.getClosingDate()}" required>
                    </div>

                    <!-- Save Button -->
                    <div class="btn-group">
                        <button type="submit" class="btn-save">
                            <i class="fas fa-save"></i> Lưu Thay Đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <script>
            tinymce.init({
                selector: 'textarea',
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                branding: false,
                height: 300,
                setup: function (editor) {
                    editor.on('change', function () {
                        tinymce.triggerSave();
                    });
                }
            });

            // Validation function
            function validateForm() {
                const descEditor = tinymce.get("jobDescription");
                const reqEditor = tinymce.get("jobRequirements");
                
                let description = descEditor ? descEditor.getContent({format: 'text'}) : document.getElementById("jobDescription").value.trim();
                let requirements = reqEditor ? reqEditor.getContent({format: 'text'}) : document.getElementById("jobRequirements").value.trim();

                if (!description.trim()) {
                    alert("❌ Vui lòng nhập Mô Tả Công Việc!");
                    return false;
                }

                if (!requirements.trim()) {
                    alert("❌ Vui lòng nhập Yêu Cầu Công Việc!");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>