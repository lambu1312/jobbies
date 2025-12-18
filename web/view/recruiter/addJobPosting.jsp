<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Bài Đăng Công Việc</title>
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

            .btn-success,
            .btn-secondary {
                padding: 12px 28px;
                font-size: 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 600;
                border: none;
            }

            .btn-success {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                color: white;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
                color: white;
            }

            .btn-secondary {
                background-color: #e0e0e0;
                color: #333;
            }

            .btn-secondary:hover {
                background-color: #d0d0d0;
                transform: translateY(-2px);
            }

            /* Checkbox styling */
            .form-check {
                margin-top: 20px;
                margin-bottom: 20px;
            }

            .form-check-input {
                width: 18px;
                height: 18px;
                margin-top: 3px;
                border: 1.5px solid #c471f5;
                border-radius: 4px;
                cursor: pointer;
                accent-color: #c471f5;
            }

            .form-check-input:checked {
                background-color: #c471f5;
                border-color: #c471f5;
            }

            .form-check-label {
                margin-left: 8px;
                font-size: 14px;
                color: #666;
                cursor: pointer;
            }

            /* AI Auto-generate hint */
            .ai-hint {
                font-size: 12px;
                color: #667eea;
                margin-top: 6px;
                display: block;
                font-weight: 500;
            }

            .ai-hint i {
                margin-right: 5px;
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

                .btn-success,
                .btn-secondary {
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

                .btn-success,
                .btn-secondary {
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
                <form id="jobPostingForm" action="${pageContext.request.contextPath}/jobPost?action=add-jp" method="POST" onsubmit="return validateFormWithSalary()">
                    <h2>Thêm Bài Đăng Công Việc</h2>

                    <!-- Title -->
                    <div class="form-group">
                        <label for="jobTitle">Tiêu Đề Công Việc:</label>
                        <input type="text" id="jobTitle" name="jobTitle" class="form-control" placeholder="Nhập tiêu đề công việc (ví dụ: Lập trình viên Java Senior)" value="${fn:escapeXml(jobTitle)}" required>
                        <small class="ai-hint"><i class="fas fa-wand-magic-sparkles"></i> AI sẽ tự động tạo mô tả và yêu cầu khi bạn nhập tiêu đề</small>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="jobDescription">Mô Tả Công Việc:</label>
                        <textarea id="jobDescription" name="jobDescription" class="form-control" placeholder="Nhập mô tả công việc" rows="6">${fn:escapeXml(jobDescription)}</textarea>
                    </div>

                    <!-- Requirements -->
                    <div class="form-group">
                        <label for="jobRequirements">Yêu Cầu Công Việc:</label>
                        <textarea id="jobRequirements" name="jobRequirements" class="form-control" placeholder="Nhập yêu cầu công việc" rows="6">${fn:escapeXml(jobRequirements)}</textarea>
                    </div>

                    <!-- Salary Row -->
                    <!-- Thay thế phần Salary Row cũ bằng này -->

                    <!-- Salary Row -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="currency">Loại Tiền Tệ:</label>
                                <select id="currency" name="currency" class="form-select" required>
                                    <option value="VND">VND (₫)</option>
                                    <option value="USD">USD ($)</option>
                                    <option value="EUR">EUR (€)</option>
                                    <option value="GBP">GBP (£)</option>
                                    <option value="JPY">JPY (¥)</option>
                                    <option value="AUD">AUD (A$)</option>
                                    <option value="CAD">CAD (C$)</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="minSalary">Lương Tối Thiểu:</label>
                                <!-- Thay type="number" thành type="text" -->
                                <input type="text" id="minSalary" name="minSalary" class="form-control" 
                                       placeholder="Nhập lương tối thiểu (ví dụ: 20000000)" 
                                       value="${minSalary}" required
                                       inputmode="numeric"
                                       pattern="[0-9]*">
                                <small style="color: #666; font-size: 12px;">Chỉ nhập số, không có dấu phân cách</small>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="maxSalary">Lương Tối Đa:</label>
                                <!-- Thay type="number" thành type="text" -->
                                <input type="text" id="maxSalary" name="maxSalary" class="form-control" 
                                       placeholder="Nhập lương tối đa (ví dụ: 30000000)" 
                                       value="${maxSalary}" required
                                       inputmode="numeric"
                                       pattern="[0-9]*">
                                <small style="color: #666; font-size: 12px;">Chỉ nhập số, không có dấu phân cách</small>
                            </div>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="form-group">
                        <label for="jobLocation">Địa Điểm:</label>
                        <input type="text" id="jobLocation" name="jobLocation" class="form-control" placeholder="Nhập địa điểm công việc" value="${fn:escapeXml(jobLocation)}" required>
                    </div>

                    <!-- Status and Posted Date -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="jobStatus">Trạng Thái:</label>
                                <select id="jobStatus" name="jobStatus" class="form-select" required>
                                    <option value="Open" <c:if test="${jobStatus == 'Open'}">selected</c:if>>Mở</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="postedDate">Ngày Đăng:</label>
                                    <input type="date" id="postedDate" name="postedDate" class="form-control" value="${postedDate}" required>
                            </div>
                        </div>
                    </div>

                    <!-- Closing Date and Category -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="closingDate">Ngày Đóng:</label>
                                <input type="date" id="closingDate" name="closingDate" class="form-control" value="${closingDate}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="jobCategory">Danh Mục Công Việc:</label>
                                <select id="jobCategory" name="jobCategory" class="form-select" required>
                                    <option value="">Chọn Danh Mục</option>
                                    <c:forEach var="category" items="${jobCategories}">
                                        <c:if test="${category.status == true}">
                                            <option value="${category.id}" <c:if test="${category.id == selectedJobCategory}">selected</c:if>>${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check">
                        <input type="checkbox" id="jobPathAgreement" name="jobPathAgreement" class="form-check-input" required>
                        <label class="form-check-label" for="jobPathAgreement">
                            Tôi đã đọc và đồng ý với Điều Khoản Dịch Vụ của Jobbies
                        </label>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty erMess}">
                        <div class="alert alert-danger" role="alert">
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
                            ${successPost}
                        </div>
                    </c:if>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-success">Lưu Công Việc</button>
                        <button type="button" class="btn btn-secondary" onclick="clearForm()">Đặt Lại</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript to handle form reset and validation -->
        <script>
            // Global variables
            const MAX_CHARS = 5000;
            let aiGenerateTimeout = null;
            let lastGeneratedTitle = '';
            let tinymceReady = false;

            // Initialize TinyMCE FIRST
            tinymce.init({
                selector: 'textarea',
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                branding: false,
                height: 300,
                setup: function (editor) {
                    editor.on('keydown', function (e) {
                        blockExcessInput(editor, e);
                    });
                    editor.on('keyup', function () {
                        enforceCharLimit(editor);
                    });
                    editor.on('change', function () {
                        tinymce.triggerSave();
                        enforceCharLimit(editor);
                    });
                    editor.on('paste', function (e) {
                        e.preventDefault();
                        const pastedText = e.clipboardData.getData('text');
                        const currentContent = editor.getContent({format: 'text'});
                        const newContent = currentContent + pastedText;

                        if (newContent.length > MAX_CHARS) {
                            const allowedText = pastedText.substring(0, MAX_CHARS - currentContent.length);
                            editor.insertContent(allowedText);
                        } else {
                            editor.insertContent(pastedText);
                        }
                    });
                },
                init_instance_callback: function (editor) {
                    console.log('✅ TinyMCE initialized:', editor.id);
                    if (tinymce.get('jobDescription') && tinymce.get('jobRequirements')) {
                        tinymceReady = true;
                        console.log('✅ All TinyMCE editors ready!');
                    }
                }
            });

            // Block excess input BEFORE it's added
            function blockExcessInput(editor, e) {
                const content = editor.getContent({format: 'text'});

                if (content.length >= MAX_CHARS) {
                    const allowedKeys = [8, 13, 46]; // Backspace, Enter, Delete
                    const ctrlKeys = [65, 67, 88]; // Ctrl+A, Ctrl+C, Ctrl+X

                    if (!e.ctrlKey && !allowedKeys.includes(e.keyCode) && !ctrlKeys.includes(e.keyCode)) {
                        e.preventDefault();
                        return false;
                    }
                }
            }

            // Enforce character limit STRICTLY
            function enforceCharLimit(editor) {
                const content = editor.getContent({format: 'text'});

                if (content.length > MAX_CHARS) {
                    const truncated = content.substring(0, MAX_CHARS);
                    editor.setContent(truncated, {format: 'text'});
                    editor.undoManager.clear();
                }
            }

            // Wait for DOM and TinyMCE to be fully loaded
            document.addEventListener('DOMContentLoaded', function () {
                console.log('📄 DOM Content Loaded');

                setTimeout(function () {
                    let editorCount = 0;
                    let maxWait = 100;
                    let checkInterval = setInterval(function () {
                        editorCount++;
                        const desc = tinymce.get('jobDescription');
                        const req = tinymce.get('jobRequirements');

                        if (desc && req) {
                            console.log('✅ All TinyMCE editors confirmed ready!');
                            tinymceReady = true;
                            clearInterval(checkInterval);
                            setupJobTitleListener();
                        } else if (editorCount >= maxWait) {
                            console.warn('⚠️ TinyMCE timeout, attempting anyway');
                            clearInterval(checkInterval);
                            tinymceReady = true;
                            setupJobTitleListener();
                        }
                    }, 100);
                }, 1000);
            });

            // Setup the job title input listener
            function setupJobTitleListener() {
                const jobTitleInput = document.getElementById('jobTitle');

                jobTitleInput.addEventListener('input', function () {
                    const jobTitle = this.value.trim();

                    if (aiGenerateTimeout) {
                        clearTimeout(aiGenerateTimeout);
                    }

                    if (jobTitle && jobTitle !== lastGeneratedTitle && jobTitle.length >= 3) {
                        aiGenerateTimeout = setTimeout(() => {
                            getAISuggestions();
                        }, 2000);
                    }
                });
            }

            // Function to get AI suggestions
            async function getAISuggestions() {
                const jobTitle = document.getElementById('jobTitle').value.trim();

                if (!jobTitle || jobTitle.length < 3) {
                    return;
                }

                if (jobTitle === lastGeneratedTitle) {
                    return;
                }

                if (!tinymceReady) {
                    setTimeout(() => getAISuggestions(), 500);
                    return;
                }

                lastGeneratedTitle = jobTitle;

                const hintElement = document.querySelector('.ai-hint');
                if (!hintElement) {
                    return;
                }

                const originalHint = hintElement.innerHTML;
                hintElement.innerHTML = '<i class="fas fa-spinner fa-spin"></i> AI đang tạo nội dung...';
                hintElement.style.color = '#667eea';

                try {
                    const response = await fetch('${pageContext.request.contextPath}/GeminiAISuggestion', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({jobTitle: jobTitle})
                    });
                    const data = await response.json();

                    if (response.ok && data.description && data.requirements) {
                        const descEditor = tinymce.get('jobDescription');
                        const reqEditor = tinymce.get('jobRequirements');

                        if (descEditor && reqEditor) {
                            const descText = stripHTML(data.description).substring(0, MAX_CHARS);
                            const reqText = stripHTML(data.requirements).substring(0, MAX_CHARS);

                            descEditor.setContent(descText, {format: 'text'});
                            reqEditor.setContent(reqText, {format: 'text'});
                            descEditor.undoManager.clear();
                            reqEditor.undoManager.clear();

                            hintElement.innerHTML = '<i class="fas fa-check-circle"></i> Nội dung AI được tạo thành công!';
                            hintElement.style.color = '#28a745';
                            showNotification('✨ Gợi ý AI được tạo cho "' + jobTitle + '"', 'success');
                        } else {
                            hintElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Lỗi trình soạn thảo';
                            hintElement.style.color = '#dc3545';
                            showNotification('❌ Lỗi: Trình soạn thảo chưa sẵn sàng', 'error');
                            lastGeneratedTitle = '';
                        }
                    } else if (data.error) {
                        hintElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i> ' + data.error;
                        hintElement.style.color = '#dc3545';
                        showNotification('❌ ' + data.error, 'error');
                        if (!data.retryable) {
                            lastGeneratedTitle = jobTitle;
                        }
                    } else {
                        hintElement.innerHTML = originalHint;
                        hintElement.style.color = '#667eea';
                        showNotification('⚠️ Định dạng phản hồi không mong muốn', 'warning');
                        lastGeneratedTitle = '';
                    }
                } catch (error) {
                    hintElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Lỗi kết nối';
                    hintElement.style.color = '#dc3545';
                    showNotification('❌ Lỗi mạng: ' + error.message, 'error');
                    lastGeneratedTitle = '';
                }
            }

            // Strip HTML tags
            function stripHTML(html) {
                const tmp = document.createElement('DIV');
                tmp.innerHTML = html;
                return tmp.textContent || tmp.innerText || '';
            }

            // Show notification function
            function showNotification(message, type) {
                const existingAlert = document.querySelector('.ai-notification');
                if (existingAlert) {
                    existingAlert.remove();
                }

                const alertDiv = document.createElement('div');
                const typeClass = type === 'success' ? 'success' :
                        type === 'warning' ? 'warning' :
                        type === 'info' ? 'info' : 'danger';

                alertDiv.className = 'alert alert-' + typeClass + ' ai-notification';
                alertDiv.style.cssText = 'position: fixed; top: 100px; right: 20px; z-index: 9999; min-width: 300px; animation: slideIn 0.3s ease;';
                alertDiv.innerHTML = message;

                document.body.appendChild(alertDiv);

                setTimeout(() => {
                    alertDiv.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => alertDiv.remove(), 300);
                }, 5000);
            }

            // Add CSS animations
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideIn {
                    from { transform: translateX(400px); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes slideOut {
                    from { transform: translateX(0); opacity: 1; }
                    to { transform: translateX(400px); opacity: 0; }
                }
            `;
            document.head.appendChild(style);

            // Clear form function
            function clearForm() {
                document.getElementById("jobTitle").value = '';
                document.getElementById("minSalary").value = '';
                document.getElementById("maxSalary").value = '';
                document.getElementById("currency").selectedIndex = 0;
                document.getElementById("jobLocation").value = '';
                document.getElementById("postedDate").value = '';
                document.getElementById("closingDate").value = '';
                document.getElementById("jobStatus").selectedIndex = 0;
                document.getElementById("jobCategory").selectedIndex = 0;
                document.getElementById("jobPathAgreement").checked = false;

                const descEditor = tinymce.get("jobDescription");
                const reqEditor = tinymce.get("jobRequirements");
                if (descEditor) {
                    descEditor.setContent('');
                    descEditor.undoManager.clear();
                }
                if (reqEditor) {
                    reqEditor.setContent('');
                    reqEditor.undoManager.clear();
                }

                lastGeneratedTitle = '';
            }

            // Validate salary TRƯỚC khi submit
// Validate salary TRƯỚC khi submit
            function validateSalary() {
                const minSalaryStr = document.getElementById("minSalary").value.trim();
                const maxSalaryStr = document.getElementById("maxSalary").value.trim();

                // Kiểm tra rỗng
                if (!minSalaryStr || !maxSalaryStr) {
                    alert("❌ Vui lòng nhập Lương Tối Thiểu và Tối Đa!");
                    return false;
                }

                // Kiểm tra chỉ chứa số (không được có dấu, chữ cái, etc)
                if (!/^\d+$/.test(minSalaryStr) || !/^\d+$/.test(maxSalaryStr)) {
                    alert("❌ Lương chỉ được chứa chữ số!");
                    return false;
                }

                // Chuyển thành BigInt để xử lý số lớn (8+ chữ số)
                let minSalary, maxSalary;
                try {
                    minSalary = BigInt(minSalaryStr);
                    maxSalary = BigInt(maxSalaryStr);
                } catch (e) {
                    alert("❌ Lương không hợp lệ!");
                    return false;
                }

                // Kiểm tra âm
                if (minSalary < 0n || maxSalary < 0n) {
                    alert("❌ Lương không thể là số âm!");
                    return false;
                }

                // KIỂM TRA CHÍNH: minSalary <= maxSalary
                if (minSalary > maxSalary) {
                    alert("❌ Lương Tối Thiểu không được vượt quá Lương Tối Đa!\n\nVí dụ:\n- VND: 20000000 đến 30000000\n- USD: 1000 đến 2000");
                    return false;
                }

                return true;
            }

// Validate form đầy đủ trước submit
            function validateFormWithSalary() {
                // Kiểm tra salary trước
                if (!validateSalary()) {
                    return false;
                }

                // Kiểm tra description và requirements
                const descEditor = tinymce.get("jobDescription");
                const reqEditor = tinymce.get("jobRequirements");

                let description = descEditor ? descEditor.getContent({format: 'text'}) : '';
                let requirements = reqEditor ? reqEditor.getContent({format: 'text'}) : '';

                if (!description.trim()) {
                    alert("❌ Vui lòng nhập Mô Tả Công Việc!");
                    return false;
                }

                if (!requirements.trim()) {
                    alert("❌ Vui lòng nhập Yêu Cầu Công Việc!");
                    return false;
                }

                if (description.length > MAX_CHARS) {
                    alert("❌ Mô tả vượt quá giới hạn!");
                    return false;
                }

                if (requirements.length > MAX_CHARS) {
                    alert("❌ Yêu cầu vượt quá giới hạn!");
                    return false;
                }

                return true;
            }
        </script>

    </body>
</html>