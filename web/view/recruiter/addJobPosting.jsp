}<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="https://cdn.tiny.cloud/1/vaugmbxpwey72le9o04xzdbx0pb0cgxv4ysvnlmu1qnlmngd/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

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
            <form id="jobPostingForm" action="${pageContext.request.contextPath}/jobPost?action=add-jp" method="POST" onsubmit="return validateForm()">
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
                    <textarea id="jobDescription" name="jobDescription" class="form-control" placeholder="Nhập mô tả công việc (Tối đa 100 chữ)" rows="6">${fn:escapeXml(jobDescription)}</textarea>
                </div>

                <!-- Requirements -->
                <div class="form-group">
                    <label for="jobRequirements">Yêu Cầu Công Việc:</label>
                    <textarea id="jobRequirements" name="jobRequirements" class="form-control" placeholder="Nhập yêu cầu công việc (Tối đa 100 chữ)" rows="6">${fn:escapeXml(jobRequirements)}</textarea>
                </div>

                <!-- Two-column row for Min Salary, Max Salary -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="currency">Loại Tiền Tệ:</label>
                            <select id="currency" name="currency" class="form-select" required>
                                <option value="USD" <c:if test="${currency == 'USD'}">selected</c:if>>USD ($)</option>
                                <option value="VND" <c:if test="${currency == 'VND'}">selected</c:if>>VND (₫)</option>
                                <option value="EUR" <c:if test="${currency == 'EUR'}">selected</c:if>>EUR (€)</option>
                                <option value="GBP" <c:if test="${currency == 'GBP'}">selected</c:if>>GBP (£)</option>
                                <option value="JPY" <c:if test="${currency == 'JPY'}">selected</c:if>>JPY (¥)</option>
                                <option value="AUD" <c:if test="${currency == 'AUD'}">selected</c:if>>AUD (A$)</option>
                                <option value="CAD" <c:if test="${currency == 'CAD'}">selected</c:if>>CAD (C$)</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="minSalary">Lương Tối Thiểu:</label>
                            <input type="number" id="minSalary" name="minSalary" class="form-control" placeholder="Nhập lương tối thiểu" value="${minSalary}" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="maxSalary">Lương Tối Đa:</label>
                            <input type="number" id="maxSalary" name="maxSalary" class="form-control" placeholder="Nhập lương tối đa" value="${maxSalary}" required>
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
        let aiGenerateTimeout = null;
        let lastGeneratedTitle = '';
        
        // Auto-generate AI suggestions when job title changes
        document.addEventListener('DOMContentLoaded', function() {
            const jobTitleInput = document.getElementById('jobTitle');
            
            jobTitleInput.addEventListener('input', function() {
                const jobTitle = this.value.trim();
                
                // Clear previous timeout
                if (aiGenerateTimeout) {
                    clearTimeout(aiGenerateTimeout);
                }
                
                // Set new timeout (wait 1.5 seconds after user stops typing)
                if (jobTitle && jobTitle !== lastGeneratedTitle && jobTitle.length >= 3) {
                    aiGenerateTimeout = setTimeout(() => {
                        getAISuggestions();
                    }, 1500);
                }
            });
        });
        
        // Function to get AI suggestions for job description and requirements
        async function getAISuggestions() {
            const jobTitle = document.getElementById('jobTitle').value.trim();
            
            if (!jobTitle || jobTitle.length < 3) {
                return;
            }
            
            // Don't regenerate if it's the same title
            if (jobTitle === lastGeneratedTitle) {
                return;
            }
            
            lastGeneratedTitle = jobTitle;
            
            // Show loading indicator in hint
            const hintElement = document.querySelector('.ai-hint');
            const originalHint = hintElement.innerHTML;
            hintElement.innerHTML = '<i class="fas fa-spinner fa-spin"></i> AI đang tạo nội dung...';
            hintElement.style.color = '#667eea';
            
            try {
                const response = await fetch('${pageContext.request.contextPath}/GeminiAISuggestion', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ jobTitle: jobTitle })
                });
                
                const data = await response.json();
                
                if (response.ok && data.description && data.requirements) {
                    // Set content to TinyMCE editors
                    tinymce.get('jobDescription').setContent(data.description);
                    tinymce.get('jobRequirements').setContent(data.requirements);
                    
                    // Always AI generated content (no templates)
                    hintElement.innerHTML = '<i class="fas fa-check-circle"></i> Nội dung AI được tạo thành công!';
                    hintElement.style.color = '#28a745';
                    showNotification('✨ Gợi ý AI được tạo cho "' + jobTitle + '"', 'success');
                } else if (data.error) {
                    // AI service unavailable
                    hintElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Dịch vụ AI không khả dụng';
                    hintElement.style.color = '#dc3545';
                    
                    if (data.retryable) {
                        showNotification('⚠️ ' + data.error + ' Nhấp vào nút để thử lại.', 'warning');
                        // Reset lastGeneratedTitle so user can retry
                        lastGeneratedTitle = '';
                    } else {
                        showNotification('❌ ' + data.error, 'error');
                    }
                } else {
                    hintElement.innerHTML = originalHint;
                    hintElement.style.color = '#667eea';
                    showNotification('⚠️ Định dạng phản hồi không mong muốn. Vui lòng thử lại.', 'warning');
                    lastGeneratedTitle = '';
                }
            } catch (error) {
                console.error('Error:', error);
                hintElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Lỗi kết nối';
                hintElement.style.color = '#dc3545';
                showNotification('❌ Lỗi mạng. Vui lòng kiểm tra kết nối và thử lại.', 'error');
                lastGeneratedTitle = '';
            }
        }
        
        // Show notification function
        function showNotification(message, type) {
            // Remove existing notifications
            const existingAlert = document.querySelector('.ai-notification');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            // Create new notification
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : type === 'warning' ? 'warning' : type === 'info' ? 'info' : 'danger') + ' ai-notification';
            alertDiv.style.cssText = 'position: fixed; top: 100px; right: 20px; z-index: 9999; min-width: 300px; animation: slideIn 0.3s ease;';
            alertDiv.innerHTML = message;
            
            document.body.appendChild(alertDiv);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                alertDiv.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => alertDiv.remove(), 300);
            }, 5000);
        }
        
        // Add CSS animation
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
        
        function clearForm() {
            // Manually reset each input field by ID
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

            // Manually clear TinyMCE fields
            tinymce.get("jobDescription").setContent('');
            tinymce.get("jobRequirements").setContent('');
        }

        // Initialize TinyMCE with required validation check
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

        // Character counter and validation for textareas
        document.addEventListener('DOMContentLoaded', function() {
            const descriptionField = document.getElementById('jobDescription');
            const requirementsField = document.getElementById('jobRequirements');
            const maxWords = 100;

            // Function to count words (separated by spaces)
            function countWords(text) {
                return text.trim().split(/\s+/).filter(word => word.length > 0).length;
            }

            // Function to handle textarea input
            function handleTextareaInput(textarea) {
                textarea.addEventListener('input', function() {
                    const wordCount = countWords(this.value);
                    if (wordCount > maxWords) {
                        // Remove excess words
                        const words = this.value.trim().split(/\s+/);
                        this.value = words.slice(0, maxWords).join(' ');
                    }
                });

                // Handle paste events
                textarea.addEventListener('paste', function(e) {
                    e.preventDefault();
                    const pastedText = (e.clipboardData || window.clipboardData).getData('text');
                    const currentText = this.value;
                    const currentWordCount = countWords(currentText);
                    const pastedWordCount = countWords(pastedText);

                    if (currentWordCount + pastedWordCount > maxWords) {
                        alert('Nội dung dán quá dài! Tối đa là ' + maxWords + ' chữ.');
                        return false;
                    }

                    // Insert the pasted text
                    const start = this.selectionStart;
                    const end = this.selectionEnd;
                    const newText = currentText.substring(0, start) + pastedText + currentText.substring(end);
                    const finalWordCount = countWords(newText);

                    if (finalWordCount > maxWords) {
                        alert('Nội dung dán quá dài! Tối đa là ' + maxWords + ' chữ.');
                        return false;
                    }

                    this.value = newText;
                    this.selectionStart = this.selectionEnd = start + pastedText.length;
                });
            }

            handleTextareaInput(descriptionField);
            handleTextareaInput(requirementsField);
        });
    </script>

</body>
</html>