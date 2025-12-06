<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Job Posting</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/vaugmbxpwey72le9o04xzdbx0pb0cgxv4ysvnlmu1qnlmngd/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            /* Flexbox layout for body and content */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Container for page content */
            .page-container {
                display: flex;
                flex: 1;
            }

            /* Sidebar and Header are included as fixed elements */

            /* Job Posting Container */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 260px; /* Adjust for sidebar */
                margin-top: 80px; /* Adjust for header */
                box-sizing: border-box;
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: calc(100vh - 80px);
            }

            .job-posting-content {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 1000px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .job-posting-content:hover {
                transform: scale(1.02);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            }

            .job-posting-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .job-posting-header h2 {
                color: #007b5e;
                font-weight: bold;
            }

            /* Form grid layout */
            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 20px;
            }

            /* Full-width fields */
            .full-width {
                grid-column: 1 / -1;
            }

            .form-group {
                margin-bottom: 15px;
                display: flex;
                flex-direction: column;
            }

            .form-label {
                font-weight: bold;
                color: #007b5e;
                margin-bottom: 5px;
            }

            .form-control {
                border-radius: 5px;
                padding: 10px;
                font-size: 14px;
                width: 100%;
                background-color: #f0f8f5;
                border: 1px solid #ddd;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-control:focus {
                border-color: #007b5e;
                box-shadow: 0 0 5px rgba(0, 123, 94, 0.3);
            }

            .form-control.is-invalid {
                border-color: #dc3545 !important;
                background-color: #fff5f5;
            }

            .form-control.is-invalid:focus {
                box-shadow: 0 0 5px rgba(220, 53, 69, 0.3) !important;
            }

            /* Error messages */
            .error-message {
                color: #dc3545;
                font-size: 13px;
                margin-top: 5px;
                display: none;
            }

            .field-hint {
                color: #dc3545;
                font-size: 12px;
                margin-top: 5px;
                font-style: italic;
            }

            /* Buttons */
            .btn-save {
                background-color: #007b5e;
                color: white;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
                border: none;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .btn-save:hover {
                background-color: #005f46;
                transform: scale(1.05);
            }

            /* Back Button Styling */
            .btn-back {
                display: flex;
                align-items: center;
                color: #007b5e;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
                margin-bottom: 20px;
                transition: color 0.3s ease;
            }

            .btn-back i {
                margin-right: 8px;
            }

            .btn-back:hover {
                text-decoration: underline;
                color: #005f46;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <div class="page-container">
            <!-- Main content for Editing Job Posting -->
            <div class="job-posting-container">
                <div class="job-posting-content">
                    <!-- Back button with icon -->
                    <a href="${pageContext.request.contextPath}/jobPost" class="btn-back" style="text-decoration: none;">
                        <i class="fas fa-arrow-left"></i> Back to Manage
                    </a>

                    <div class="job-posting-header">
                        <h2>Edit Job Posting</h2>
                    </div>
                    <form id="jobForm" action="${pageContext.request.contextPath}/jobPost?action=updateJobPost" method="post">
                        <!-- Grid layout for form -->
                        <div class="form-grid">
                            <input type="hidden" id="JobPostingID" name="JobPostingID" 
                                   value="${param.JobPostingID != null ? param.JobPostingID : jobPost.getJobPostingID()}">

                            <div class="form-group">
                                <label for="jobTitle" class="form-label">Job Title</label>
                                <input type="text" id="jobTitle" name="jobTitle" class="form-control" 
                                       value="${param.jobTitle != null ? param.jobTitle : jobPost.getTitle()}" required>
                                <span class="field-hint">This field is required. Cannot be empty or contain only spaces.</span>
                                <span class="error-message" data-field="jobTitle">Job Title is required and cannot be empty or whitespace only.</span>
                            </div>

                            <!-- Job Location -->
                            <div class="form-group">
                                <label for="jobLocation" class="form-label">Location</label>
                                <input type="text" id="jobLocation" name="jobLocation" class="form-control" 
                                       value="${param.jobLocation != null ? param.jobLocation : jobPost.getLocation()}" required>
                                <span class="field-hint">This field is required. Cannot be empty or contain only spaces.</span>
                                <span class="error-message" data-field="jobLocation">Location is required and cannot be empty or whitespace only.</span>
                            </div>

                            <!-- Job Description (Full-width) -->
                            <div class="form-group full-width">
                                <label for="jobDescription" class="form-label">Job Description</label>
                                <textarea id="jobDescription" name="jobDescription" class="form-control" rows="6">${fn:escapeXml(param.jobDescription != null ? param.jobDescription : jobPost.getDescription())}</textarea>
                                <span class="field-hint">This field is required. Cannot be empty or contain only spaces.</span>
                                <span class="error-message" data-field="jobDescription">Job Description is required and cannot be empty or whitespace only.</span>
                            </div>

                            <!-- Job Requirements (Full-width) -->
                            <div class="form-group full-width">
                                <label for="jobRequirements" class="form-label">Job Requirements</label>
                                <textarea id="jobRequirements" name="jobRequirements" class="form-control" rows="6">${fn:escapeXml(param.jobRequirements != null ? param.jobRequirements : jobPost.getRequirements())}</textarea>
                                <span class="field-hint">This field is required. Cannot be empty or contain only spaces.</span>
                                <span class="error-message" data-field="jobRequirements">Job Requirements are required and cannot be empty or whitespace only.</span>
                            </div>

                            <!-- Job Salary -->
                            <div class="form-group">
                                <label for="minSalary" class="form-label">Min Salary $</label>
                                <input type="number" id="minSalary" name="minSalary" class="form-control" 
                                       value="${param.minSalary != null ? param.minSalary : jobPost.getMinSalary()}" required>
                                <span class="error-message" data-field="minSalary">Min Salary is required.</span>
                            </div>
                            <div class="form-group">
                                <label for="maxSalary" class="form-label">Max Salary $</label>
                                <input type="number" id="maxSalary" name="maxSalary" class="form-control" 
                                       value="${param.maxSalary != null ? param.maxSalary : jobPost.getMaxSalary()}" required>
                                <span class="error-message" data-field="maxSalary">Max Salary is required.</span>
                            </div>

                            <div class="form-group">
                                <label for="jobCategory" class="form-label">Job Category</label>
                                <select id="jobCategory" name="jobCategory" class="form-control" required>
                                    <option value="">Select Job Category</option>
                                    <c:forEach var="category" items="${jobCategories}">
                                        <c:if test="${category.status == true}">
                                            <option value="${category.getId()}" 
                                                    <c:if test="${category.getId() == selectedJobCategory}">selected</c:if>>
                                                ${category.getName()}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                                <span class="error-message" data-field="jobCategory">Job Category is required.</span>
                            </div>

                            <!-- Job Status -->
                            <div class="form-group">
                                <label for="jobStatus" class="form-label">Status</label>
                                <select id="jobStatus" name="jobStatus" class="form-control" required>
                                    <option value="Open" ${param.jobStatus == 'Open' ? 'selected' : (jobPost.getStatus() == 'Open' ? 'selected' : '')}>Open</option>
                                    <option value="Closed" ${param.jobStatus == 'Closed' ? 'selected' : (jobPost.getStatus() == 'Closed' ? 'selected' : '')}>Closed</option>
                                </select>
                            </div>

                            <!-- Posted Date -->
                            <div class="form-group">
                                <label for="postedDate" class="form-label">Posted Date</label>
                                <input type="date" id="postedDate" name="postedDate" class="form-control" 
                                       value="${param.postedDate != null ? param.postedDate : jobPost.getPostedDate()}" required>
                                <span class="error-message" data-field="postedDate">Posted Date is required.</span>
                            </div>

                            <!-- Closing Date -->
                            <div class="form-group">
                                <label for="closingDate" class="form-label">Closing Date</label>
                                <input type="date" id="closingDate" name="closingDate" class="form-control" 
                                       value="${param.closingDate != null ? param.closingDate : jobPost.getClosingDate()}" required>
                                <span class="error-message" data-field="closingDate">Closing Date is required.</span>
                            </div>
                        </div>

                        <!-- Error Messages -->
                        <c:if test="${not empty eM}">
                            <div class="alert alert-danger" role="alert">
                                <ul>
                                    <c:forEach var="error" items="${eM}">
                                        <li>${error}</li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </c:if>

                        <!-- Save Button -->
                        <button type="submit" class="btn-save">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
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

            // Helper function to trim and check if empty
            function isFieldEmpty(value) {
                return value === null || value === undefined || value.trim() === '';
            }

            // Validation function for text inputs
            function validateTextField(fieldId) {
                const field = document.getElementById(fieldId);
                const errorElement = document.querySelector(`.error-message[data-field="${fieldId}"]`);
                const value = field.value;

                if (isFieldEmpty(value)) {
                    field.classList.add('is-invalid');
                    if (errorElement) {
                        errorElement.style.display = 'block';
                    }
                    return false;
                } else {
                    field.classList.remove('is-invalid');
                    if (errorElement) {
                        errorElement.style.display = 'none';
                    }
                    return true;
                }
            }

            // Add real-time validation on blur and input events
            document.addEventListener('DOMContentLoaded', function() {
                const textFields = ['jobTitle', 'jobLocation', 'minSalary', 'maxSalary', 'postedDate', 'closingDate'];
                const textareaFields = ['jobDescription', 'jobRequirements'];

                // Real-time validation for text inputs
                textFields.forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    if (field) {
                        field.addEventListener('blur', function() {
                            validateTextField(fieldId);
                        });
                        field.addEventListener('input', function() {
                            if (!isFieldEmpty(this.value)) {
                                this.classList.remove('is-invalid');
                                const errorElement = document.querySelector(`.error-message[data-field="${fieldId}"]`);
                                if (errorElement) {
                                    errorElement.style.display = 'none';
                                }
                            }
                        });
                    }
                });

                // Real-time validation for textareas
                textareaFields.forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    if (field) {
                        field.addEventListener('blur', function() {
                            const editorContent = tinymce.get(fieldId);
                            let content = '';
                            if (editorContent) {
                                content = editorContent.getContent({ format: 'text' });
                            } else {
                                content = this.value;
                            }

                            const errorElement = document.querySelector(`.error-message[data-field="${fieldId}"]`);
                            if (isFieldEmpty(content)) {
                                field.classList.add('is-invalid');
                                if (errorElement) {
                                    errorElement.style.display = 'block';
                                }
                            } else {
                                field.classList.remove('is-invalid');
                                if (errorElement) {
                                    errorElement.style.display = 'none';
                                }
                            }
                        });
                    }
                });
            });

            // Form submission validation
            function validateForm() {
                let isValid = true;
                const textFields = ['jobTitle', 'jobLocation', 'minSalary', 'maxSalary', 'postedDate', 'closingDate'];
                const textareaFields = ['jobDescription', 'jobRequirements'];

                // Validate text fields
                textFields.forEach(fieldId => {
                    if (!validateTextField(fieldId)) {
                        isValid = false;
                    }
                });

                // Validate textarea fields
                textareaFields.forEach(fieldId => {
                    const field = document.getElementById(fieldId);
                    const errorElement = document.querySelector(`.error-message[data-field="${fieldId}"]`);
                    
                    let content = '';
                    const editor = tinymce.get(fieldId);
                    if (editor) {
                        content = editor.getContent({ format: 'text' });
                    } else {
                        content = field.value;
                    }

                    if (isFieldEmpty(content)) {
                        field.classList.add('is-invalid');
                        if (errorElement) {
                            errorElement.style.display = 'block';
                        }
                        isValid = false;
                    } else {
                        field.classList.remove('is-invalid');
                        if (errorElement) {
                            errorElement.style.display = 'none';
                        }
                    }
                });

                // Validate select fields
                const jobCategory = document.getElementById('jobCategory');
                if (jobCategory && jobCategory.value === '') {
                    jobCategory.classList.add('is-invalid');
                    const errorElement = document.querySelector(`.error-message[data-field="jobCategory"]`);
                    if (errorElement) {
                        errorElement.style.display = 'block';
                    }
                    isValid = false;
                } else if (jobCategory) {
                    jobCategory.classList.remove('is-invalid');
                    const errorElement = document.querySelector(`.error-message[data-field="jobCategory"]`);
                    if (errorElement) {
                        errorElement.style.display = 'none';
                    }
                }

                return isValid;
            }

            // Attach validation to form submission
            document.getElementById('jobForm').addEventListener('submit', function(event) {
                if (!validateForm()) {
                    event.preventDefault();
                    alert('Please fill in all required fields correctly. Empty or whitespace-only values are not allowed.');
                }
            });
        </script>
    </body>
</html>