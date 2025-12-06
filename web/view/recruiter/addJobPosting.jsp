<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm tin tuyển dụng - Jobbies</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.tiny.cloud/1/vaugmbxpwey72le9o04xzdbx0pb0cgxv4ysvnlmu1qnlmngd/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: #f5f7fa;
                color: #333;
            }
            .job-posting-container {
                flex: 1;
                padding: 3rem 2rem;
                margin-left: 260px;
                margin-top: 80px;
                background: #f5f7fa;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }
            .job-posting-card {
                background: #fff;
                padding: 3rem;
                border-radius: 20px;
                border: 1px solid #e0e0e0;
                max-width: 900px;
                width: 100%;
                box-shadow: 0 5px 30px rgba(0, 0, 0, 0.1);
            }
            .btn-back {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 2rem;
                padding: 0.6rem 1.2rem;
                background: #f0f0f0;
                border: 1px solid #e0e0e0;
                color: #333;
                border-radius: 10px;
                text-decoration: none;
                font-weight: 600;
            }
            .job-posting-card h2 {
                text-align: center;
                margin-bottom: 2.5rem;
                font-weight: 900;
                font-size: 2.5rem;
                background: linear-gradient(135deg, #333 0%, #c471f5 50%, #7ee8fa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .form-group {
                position: relative;
                margin-bottom: 1.5rem;
            }
            .form-group label {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 700;
                margin-bottom: 0.8rem;
                font-size: 0.95rem;
                color: #333;
            }
            .form-group label i {
                color: #c471f5;
            }
            .required-asterisk {
                color: #d32f2f;
                font-weight: bold;
            }
            .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 12px;
                padding: 0.9rem 1.2rem;
                font-size: 1rem;
                background: #f8f9ff;
                color: #333;
                font-weight: 500;
            }
            .form-control:focus {
                border-color: #c471f5;
                background: #fff;
                box-shadow: 0 0 0 4px rgba(196, 113, 245, 0.1);
                outline: none;
                padding-right: 120px !important;
            }
            .form-control.is-invalid {
                border-color: #d32f2f;
                background-color: #fff5f5;
            }
            .invalid-feedback {
                display: none;
                color: #d32f2f;
                font-size: 0.85rem;
                margin-top: 0.5rem;
            }
            .invalid-feedback.show {
                display: block;
            }
            .ai-suggestion-btn {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: linear-gradient(135deg, #4a6cf7, #6a11cb);
                color: white;
                border: none;
                border-radius: 20px;
                padding: 5px 15px;
                font-size: 12px;
                font-weight: 600;
                cursor: pointer;
                display: none;
                align-items: center;
                gap: 5px;
                transition: all 0.3s ease;
                z-index: 10;
            }

            .ai-suggestion-btn:hover {
                background: linear-gradient(135deg, #3a5ce4, #5a0bc0);
                transform: translateY(-50%) scale(1.02);
            }

            .ai-suggestion-btn:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }

            .ai-suggestion-btn i {
                font-size: 14px;
            }

            /* Ensure form group has relative positioning */
            .form-group {
                position: relative;
            }
            .tox-tinymce {
                border-color: #e0e0e0 !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        <%@ include file="../recruiter/header-re.jsp" %>

        <div class="job-posting-container">
            <div class="job-posting-card">
                <a href="${pageContext.request.contextPath}/jobPost" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>

                <h2>Thêm tin tuyển dụng mới</h2>

                <form id="jobPostingForm" action="${pageContext.request.contextPath}/jobPost?action=add-jp" method="POST" onsubmit="return validateForm()">

                    <!-- Title với AI Button -->
                    <div class="form-group">
                        <label for="jobTitle">
                            <i class="fas fa-briefcase"></i>
                            Tiêu đề công việc
                            <span class="required-asterisk">*</span>
                        </label>
                        <div style="position: relative;">
                            <input type="text" id="jobTitle" name="jobTitle" class="form-control" placeholder="Ví dụ: Senior Backend Developer" value="${fn:escapeXml(jobTitle)}" style="padding-right: 120px !important;">
                            <button type="button" id="aiSuggestBtn" class="ai-suggestion-btn" style="display: none;">
                                <i class="fas fa-wand-magic-sparkles"></i> AI Gợi ý
                            </button>
                        </div>
                        <div class="invalid-feedback" id="jobTitleError"></div>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="jobDescription">
                            <i class="fas fa-align-left"></i>
                            Mô tả công việc
                            <span class="required-asterisk">*</span>
                        </label>
                        <textarea id="jobDescription" name="jobDescription" class="form-control" placeholder="Mô tả chi tiết về công việc..." rows="6">${fn:escapeXml(jobDescription)}</textarea>
                        <div class="invalid-feedback" id="jobDescriptionError"></div>
                    </div>

                    <!-- Requirements -->
                    <div class="form-group">
                        <label for="jobRequirements">
                            <i class="fas fa-tasks"></i>
                            Yêu cầu công việc
                            <span class="required-asterisk">*</span>
                        </label>
                        <textarea id="jobRequirements" name="jobRequirements" class="form-control" placeholder="Các yêu cầu về kinh nghiệm, kỹ năng..." rows="6">${fn:escapeXml(jobRequirements)}</textarea>
                        <div class="invalid-feedback" id="jobRequirementsError"></div>
                    </div>

                    <!-- Salary Range -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="minSalary">
                                    <i class="fas fa-dollar-sign"></i>
                                    Mức lương tối thiểu
                                    <span class="required-asterisk">*</span>
                                </label>
                                <div class="salary-input-wrapper">
                                    <input type="number" id="minSalary" name="minSalary" class="form-control" placeholder="Nhập số tiền" value="${minSalary}" min="0" step="0.01">
                                    <span class="currency-unit">USD</span>
                                </div>
                                <div class="invalid-feedback" id="minSalaryError"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="maxSalary">
                                    <i class="fas fa-dollar-sign"></i>
                                    Mức lương tối đa
                                    <span class="required-asterisk">*</span>
                                </label>
                                <div class="salary-input-wrapper">
                                    <input type="number" id="maxSalary" name="maxSalary" class="form-control" placeholder="Nhập số tiền" value="${maxSalary}" min="0" step="0.01">
                                    <span class="currency-unit">USD</span>
                                </div>
                                <div class="invalid-feedback" id="maxSalaryError"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="form-group">
                        <label for="jobLocation">
                            <i class="fas fa-map-marker-alt"></i>
                            Vị trí tuyển dụng
                            <span class="required-asterisk">*</span>
                        </label>
                        <input type="text" id="jobLocation" name="jobLocation" class="form-control" placeholder="Ví dụ: Hà Nội, TP. Hồ Chí Minh" value="${fn:escapeXml(jobLocation)}">
                        <div class="invalid-feedback" id="jobLocationError"></div>
                    </div>

                    <!-- Status and Posted Date -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="jobStatus">
                                    <i class="fas fa-toggle-on"></i>
                                    Trạng thái
                                    <span class="required-asterisk">*</span>
                                </label>
                                <select id="jobStatus" name="jobStatus" class="form-select">
                                    <option value="">-- Chọn trạng thái --</option>
                                    <option value="Open" <c:if test="${jobStatus == 'Open'}">selected</c:if>>Còn tuyển</option>
                                    </select>
                                    <div class="invalid-feedback" id="jobStatusError"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="postedDate">
                                        <i class="fas fa-calendar-alt"></i>
                                        Ngày đăng
                                        <span class="required-asterisk">*</span>
                                    </label>
                                    <input type="date" id="postedDate" name="postedDate" class="form-control" value="${postedDate}">
                                <div class="invalid-feedback" id="postedDateError"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Closing Date and Category -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="closingDate">
                                    <i class="fas fa-calendar-times"></i>
                                    Ngày kết thúc
                                    <span class="required-asterisk">*</span>
                                </label>
                                <input type="date" id="closingDate" name="closingDate" class="form-control" value="${closingDate}">
                                <div class="invalid-feedback" id="closingDateError"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="jobCategory">
                                    <i class="fas fa-tag"></i>
                                    Hạng mục công việc
                                    <span class="required-asterisk">*</span>
                                </label>
                                <select id="jobCategory" name="jobCategory" class="form-select">
                                    <option value="">-- Chọn hạng mục --</option>
                                    <c:forEach var="category" items="${jobCategories}">
                                        <c:if test="${category.status == true}">
                                            <option value="${category.id}" <c:if test="${category.id == selectedJobCategory}">selected</c:if>>${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback" id="jobCategoryError"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check">
                        <input type="checkbox" id="jobPathAgreement" name="jobPathAgreement" class="form-check-input">
                        <label class="form-check-label" for="jobPathAgreement">
                            Tôi đã đọc và đồng ý với <strong>điều khoản và dịch vụ</strong> của Jobbies
                            <span class="required-asterisk">*</span>
                        </label>
                        <div class="checkbox-error" id="checkboxError"></div>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty erMess}">
                        <div class="alert alert-danger" role="alert">
                            <strong>❌ Lỗi:</strong>
                            <ul>
                                <c:forEach var="error" items="${erMess}">
                                    <li>${error}</li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <!-- Success Message -->
                    <c:if test="${not empty successPost}">
                        <div class="alert alert-success">
                            <strong>✅ Thành công:</strong> ${successPost}
                        </div>
                    </c:if>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn-success" id="submitBtn">
                            <i class="fas fa-paper-plane"></i>
                            Đăng tuyển
                        </button>
                        <button type="button" class="btn-secondary" onclick="clearForm()">
                            <i class="fas fa-redo"></i>
                            Xóa thông tin
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>

        <script>
            tinymce.init({
                selector: '#jobDescription, #jobRequirements',
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

            function isEmptyOrWhitespace(str) {
                return !str || str.trim().length === 0;
            }

            function showError(elementId, message) {
                const element = document.getElementById(elementId);
                const errorDiv = document.getElementById(elementId + 'Error');
                if (element)
                    element.classList.add('is-invalid');
                if (errorDiv) {
                    errorDiv.textContent = message;
                    errorDiv.classList.add('show');
                }
            }

            function clearError(elementId) {
                const element = document.getElementById(elementId);
                const errorDiv = document.getElementById(elementId + 'Error');
                if (element)
                    element.classList.remove('is-invalid');
                if (errorDiv) {
                    errorDiv.textContent = '';
                    errorDiv.classList.remove('show');
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const jobTitleInput = document.getElementById('jobTitle');
                const aiBtn = document.getElementById('aiSuggestBtn');

                jobTitleInput.addEventListener('input', function () {
                    aiBtn.style.display = this.value.trim().length > 0 ? 'flex' : 'none';
                });

                aiBtn.addEventListener('click', async function (e) {
                    e.preventDefault();
                    const jobTitle = jobTitleInput.value.trim();

                    if (!jobTitle) {
                        alert('Vui lòng nhập tiêu đề công việc');
                        return;
                    }

                    this.disabled = true;
                    const originalHtml = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tạo...';

                    try {
                        const response = await fetch('${pageContext.request.contextPath}/aiJobSuggestion', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'jobTitle=' + encodeURIComponent(jobTitle)
                        });

                        if (!response.ok) {
                            const errorText = await response.text();
                            throw new Error(`HTTP ${response.status}: ${errorText}`);
                        }

                        const suggestion = await response.json();

                        if (suggestion.description && suggestion.requirements) {
                            tinymce.get('jobDescription').setContent(suggestion.description);
                            tinymce.get('jobRequirements').setContent(suggestion.requirements);

                            const alertDiv = document.createElement('div');
                            alertDiv.className = 'alert alert-success';
                            alertDiv.innerHTML = '✅ AI đã tạo gợi ý thành công!';
                            document.getElementById('jobPostingForm').insertBefore(alertDiv, document.getElementById('jobPostingForm').firstChild);
                            setTimeout(() => alertDiv.remove(), 3000);
                        } else if (suggestion.error) {
                            alert('Lỗi: ' + suggestion.error);
                        }
                    } catch (error) {
                        alert('Lỗi: ' + error.message);
                    } finally {
                        this.disabled = false;
                        this.innerHTML = originalHtml;
                    }
                });
            });

            function clearForm() {
                document.getElementById("jobTitle").value = '';
                document.getElementById("minSalary").value = '';
                document.getElementById("maxSalary").value = '';
                document.getElementById("jobLocation").value = '';
                document.getElementById("postedDate").value = '';
                document.getElementById("closingDate").value = '';
                document.getElementById("jobStatus").selectedIndex = 0;
                document.getElementById("jobCategory").selectedIndex = 0;
                document.getElementById("jobPathAgreement").checked = false;

                if (tinymce.get("jobDescription"))
                    tinymce.get("jobDescription").setContent('');
                if (tinymce.get("jobRequirements"))
                    tinymce.get("jobRequirements").setContent('');

                document.querySelectorAll('.form-control, .form-select, .form-check-input').forEach(el => {
                    el.classList.remove('is-invalid');
                });
                document.querySelectorAll('.invalid-feedback, .checkbox-error').forEach(el => {
                    el.classList.remove('show');
                    el.textContent = '';
                });
            }

            function validateForm() {
                let isValid = true;

                const jobTitle = document.getElementById('jobTitle').value;
                if (isEmptyOrWhitespace(jobTitle)) {
                    showError('jobTitle', 'Nhập tiêu đề công việc');
                    isValid = false;
                } else {
                    clearError('jobTitle');
                }

                const desc = tinymce.get('jobDescription');
                const description = desc ? desc.getContent({format: 'text'}).trim() : '';
                if (isEmptyOrWhitespace(description) || description.length < 10) {
                    showError('jobDescription', 'Mô tả >= 10 ký tự');
                    isValid = false;
                } else {
                    clearError('jobDescription');
                }

                const req = tinymce.get('jobRequirements');
                const requirements = req ? req.getContent({format: 'text'}).trim() : '';
                if (isEmptyOrWhitespace(requirements) || requirements.length < 10) {
                    showError('jobRequirements', 'Yêu cầu >= 10 ký tự');
                    isValid = false;
                } else {
                    clearError('jobRequirements');
                }

                const minSal = document.getElementById('minSalary').value;
                if (isEmptyOrWhitespace(minSal)) {
                    showError('minSalary', 'Nhập min salary');
                    isValid = false;
                } else {
                    clearError('minSalary');
                }

                const maxSal = document.getElementById('maxSalary').value;
                if (isEmptyOrWhitespace(maxSal)) {
                    showError('maxSalary', 'Nhập max salary');
                    isValid = false;
                } else if (parseFloat(minSal) > parseFloat(maxSal)) {
                    showError('maxSalary', 'Max >= Min');
                    isValid = false;
                } else {
                    clearError('maxSalary');
                }

                const location = document.getElementById('jobLocation').value;
                if (isEmptyOrWhitespace(location)) {
                    showError('jobLocation', 'Nhập vị trí');
                    isValid = false;
                } else {
                    clearError('jobLocation');
                }

                const status = document.getElementById('jobStatus').value;
                if (isEmptyOrWhitespace(status)) {
                    showError('jobStatus', 'Chọn trạng thái');
                    isValid = false;
                } else {
                    clearError('jobStatus');
                }

                const posted = document.getElementById('postedDate').value;
                if (isEmptyOrWhitespace(posted)) {
                    showError('postedDate', 'Chọn ngày đăng');
                    isValid = false;
                } else {
                    clearError('postedDate');
                }

                const closing = document.getElementById('closingDate').value;
                if (isEmptyOrWhitespace(closing)) {
                    showError('closingDate', 'Chọn ngày kết thúc');
                    isValid = false;
                } else if (posted && new Date(closing) < new Date(posted)) {
                    showError('closingDate', 'Closing >= Posted');
                    isValid = false;
                } else {
                    clearError('closingDate');
                }

                const category = document.getElementById('jobCategory').value;
                if (isEmptyOrWhitespace(category)) {
                    showError('jobCategory', 'Chọn hạng mục');
                    isValid = false;
                } else {
                    clearError('jobCategory');
                }

                const checkbox = document.getElementById('jobPathAgreement');
                if (!checkbox.checked) {
                    checkbox.classList.add('is-invalid');
                    document.getElementById('checkboxError').textContent = 'Đồng ý điều khoản';
                    document.getElementById('checkboxError').classList.add('show');
                    isValid = false;
                } else {
                    checkbox.classList.remove('is-invalid');
                    document.getElementById('checkboxError').textContent = '';
                    document.getElementById('checkboxError').classList.remove('show');
                }

                return isValid;
            }
        </script>
        <script>
            // Hàm gọi AI gợi ý
            async function getAIJobSuggestion() {
                const jobTitle = document.getElementById('jobTitle').value.trim();
                const descriptionEditor = tinymce.get('jobDescription');
                const requirementsEditor = tinymce.get('jobRequirements');
                const aiButton = document.getElementById('aiSuggestBtn');

                if (!jobTitle) {
                    showAIMessage('Vui lòng nhập tiêu đề công việc trước', 'warning');
                    return;
                }

                try {
                    // Lưu trạng thái ban đầu của nút
                    const originalButtonText = aiButton.innerHTML;
                    aiButton.disabled = true;
                    aiButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tạo...';

                    // Hiển thị thông báo đang tải
                    showAIMessage('Đang tạo gợi ý bằng AI, vui lòng chờ...', 'info');

                    // Gọi API
                    const response = await fetch('${pageContext.request.contextPath}/aiJobSuggestion', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ jobTitle: jobTitle })
                    });

                    if (!response.ok) {
                        const errorData = await response.json();
                        throw new Error(errorData.error || 'Có lỗi xảy ra khi gọi API');
                    }

                    const data = await response.json();

                    // Cập nhật nội dung vào các trường
                    if (data.description && descriptionEditor) {
                        descriptionEditor.setContent(data.description);
                        hideError('jobDescription');
                    }

                    if (data.requirements && requirementsEditor) {
                        requirementsEditor.setContent(data.requirements);
                        hideError('jobRequirements');
                    }

                    // Hiển thị thông báo thành công
                    showAIMessage('Đã tạo gợi ý thành công!', 'success');
                } catch (error) {
                    console.error('Lỗi khi gọi AI Suggestion:', error);
                    showAIMessage('Lỗi: ' + (error.message || 'Không thể kết nối đến máy chủ'), 'danger');
                } finally {
                    // Khôi phục trạng thái nút
                    const aiButton = document.getElementById('aiSuggestBtn');
                    if (aiButton) {
                        aiButton.disabled = false;
                        aiButton.innerHTML = '<i class="fas fa-wand-magic-sparkles"></i> AI Gợi ý';
                    }
                }
            }

            // Hàm hiển thị thông báo
            function showAIMessage(message, type) {
                // Xóa thông báo cũ nếu có
                const oldMessage = document.getElementById('aiMessage');
                if (oldMessage) {
                    oldMessage.remove();
                }

                // Tạo thông báo mới
                const messageDiv = document.createElement('div');
                messageDiv.id = 'aiMessage';
                messageDiv.className = `alert alert-${type} mt-3`;
                messageDiv.innerHTML = message;

                // Thêm vào DOM
                const form = document.querySelector('form');
                form.insertBefore(messageDiv, form.firstChild);

                // Tự động ẩn sau 5 giây
                setTimeout(() => {
                    messageDiv.remove();
                }, 5000);
            }

            // Thêm sự kiện khi trang tải xong
            document.addEventListener('DOMContentLoaded', function () {
                // Khởi tạo sự kiện sau khi TinyMCE đã sẵn sàng
                const initAIFeature = () => {
                    // Thêm sự kiện click cho nút AI gợi ý
                    const aiButton = document.getElementById('aiSuggestBtn');
                    if (aiButton) {
                        aiButton.addEventListener('click', getAIJobSuggestion);

                        // Hiển thị nút nếu đã có nội dung trong jobTitle
                        const jobTitleInput = document.getElementById('jobTitle');
                        if (jobTitleInput && jobTitleInput.value.trim()) {
                            aiButton.style.display = 'flex';
                        }
                    }

                    // Hiển thị/ẩn nút AI khi nhập tiêu đề
                    const jobTitleInput = document.getElementById('jobTitle');
                    if (jobTitleInput) {
                        jobTitleInput.addEventListener('input', function () {
                            const aiButton = document.getElementById('aiSuggestBtn');
                            if (aiButton) {
                                aiButton.style.display = this.value.trim() ? 'flex' : 'none';
                            }
                        });
                    }
                };

                // Đợi cho đến khi TinyMCE được khởi tạo xong
                if (typeof tinymce !== 'undefined') {
                    tinymce.on('init', function() {
                        initAIFeature();
                    });
                } else {
                    initAIFeature();
                }
            });
        </script>
    </body>
</html>