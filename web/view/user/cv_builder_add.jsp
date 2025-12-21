<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo CV Mới</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --color-primary: #667eea;
                --color-primary-dark: #5568d3;
                --color-secondary: #764ba2;
                --color-text-primary: #0A0E27;
                --color-text-secondary: #5B6B8C;
                --color-border: #E4E8F0;
                --color-background: #FAFBFC;
                --color-surface: #FFFFFF;
                --color-success: #0EA770;
                --color-success-light: #E8F7F0;
                --color-danger: #E03E52;
                --color-danger-light: #FFEBEE;
                --color-info: #667eea;
                --color-info-light: #E0E7FF;
                --shadow-sm: 0 1px 2px rgba(10, 14, 39, 0.03);
                --shadow-md: 0 4px 12px rgba(10, 14, 39, 0.06);
                --shadow-lg: 0 12px 32px rgba(10, 14, 39, 0.08);
                --radius-sm: 8px;
                --radius-md: 12px;
                --radius-lg: 16px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                background: var(--color-background);
                color: var(--color-text-primary);
                line-height: 1.6;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            .page-header {
                margin-bottom: 2rem;
                animation: fadeInUp 0.6s ease-out;
                text-align: center;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .page-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--color-text-primary);
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
            }

            .page-title i {
                background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .alert {
                padding: 1rem 1.25rem;
                border-radius: var(--radius-md);
                margin-bottom: 2rem;
                display: flex;
                align-items: flex-start;
                gap: 0.875rem;
                font-size: 0.9375rem;
                border: 1px solid;
                animation: slideInRight 0.4s ease-out;
            }

            @keyframes slideInRight {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .alert i {
                flex-shrink: 0;
                margin-top: 0.125rem;
            }

            .alert-success {
                background: var(--color-success-light);
                border-color: var(--color-success);
                color: var(--color-success);
            }

            .form-card {
                background: var(--color-surface);
                border-radius: var(--radius-lg);
                border: 1px solid var(--color-border);
                padding: 2rem;
                box-shadow: var(--shadow-md);
                animation: fadeInUp 0.6s ease-out 0.1s both;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                font-weight: 600;
                color: var(--color-text-primary);
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
            }

            .form-control {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid var(--color-border);
                border-radius: var(--radius-sm);
                font-size: 0.9375rem;
                color: var(--color-text-primary);
                background-color: var(--color-surface);
                transition: all 0.2s ease;
                font-family: inherit;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            select.form-control {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%235B6B8C' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 0.75rem center;
                background-size: 16px 12px;
                padding-right: 2.5rem;
                appearance: none;
                cursor: pointer;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }

            .form-hint {
                font-size: 0.8125rem;
                color: var(--color-text-secondary);
                margin-top: 0.5rem;
            }

            .error-message {
                font-size: 0.8125rem;
                color: var(--color-danger);
                margin-top: 0.5rem;
                display: none;
                align-items: center;
                gap: 0.375rem;
                animation: slideInRight 0.3s ease-out;
            }

            .error-message i {
                font-size: 0.75rem;
            }

            .error-message.show {
                display: flex;
            }

            .form-control.error {
                border-color: var(--color-danger);
                background-color: #FFF5F5;
            }

            .form-control.error:focus {
                border-color: var(--color-danger);
                box-shadow: 0 0 0 3px rgba(224, 62, 82, 0.1);
            }

            .divider {
                height: 1px;
                background: var(--color-border);
                margin: 2rem 0;
            }

            .section-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 1.5rem;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .section-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--color-text-primary);
            }

            .section-card {
                background: linear-gradient(to bottom, #F8FAFC, #FFFFFF);
                border: 1px solid var(--color-border);
                border-radius: var(--radius-md);
                padding: 1.5rem;
                margin-bottom: 1rem;
                animation: fadeInUp 0.4s ease-out;
                transition: all 0.2s ease;
            }

            .section-card:hover {
                box-shadow: var(--shadow-sm);
            }

            .section-card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 1rem;
            }

            .section-card-body {
                flex: 1;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.625rem 1.125rem;
                border-radius: var(--radius-sm);
                font-weight: 500;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                border: 1px solid;
                white-space: nowrap;
                background: none;
            }

            .btn i {
                font-size: 0.875rem;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
                color: white;
                border-color: var(--color-primary);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--color-primary-dark), #6842a0);
                border-color: var(--color-primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            }

            .btn-secondary {
                background: var(--color-surface);
                color: var(--color-primary);
                border-color: var(--color-primary);
            }

            .btn-secondary:hover {
                background: var(--color-info-light);
                border-color: var(--color-primary-dark);
                color: var(--color-primary-dark);
            }

            .btn-danger {
                background: var(--color-surface);
                color: var(--color-danger);
                border-color: var(--color-danger);
            }

            .btn-danger:hover {
                background: var(--color-danger);
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(224, 62, 82, 0.25);
            }

            .btn-outline {
                background: var(--color-surface);
                color: var(--color-text-secondary);
                border-color: var(--color-border);
            }

            .btn-outline:hover {
                background: #F8FAFC;
                border-color: var(--color-primary);
                color: var(--color-primary);
            }

            .form-actions {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-wrap: wrap;
                padding-top: 1.5rem;
                border-top: 1px solid var(--color-border);
            }

            .link-group {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-left: auto;
                flex-wrap: wrap;
            }

            .link-action {
                color: var(--color-text-secondary);
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                gap: 0.375rem;
                padding: 0.5rem 0.75rem;
                border-radius: var(--radius-sm);
            }

            .link-action:hover {
                color: var(--color-primary);
                background: var(--color-info-light);
            }

            .link-action i {
                font-size: 0.875rem;
            }

            @keyframes fadeOut {
                from {
                    opacity: 1;
                    transform: scale(1);
                }
                to {
                    opacity: 0;
                    transform: scale(0.95);
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 2rem 1rem;
                }

                .form-card {
                    padding: 1.5rem;
                }

                .page-title {
                    font-size: 1.75rem;
                }

                .section-header {
                    flex-direction: column;
                    align-items: stretch;
                }

                .section-card-header {
                    flex-direction: column;
                }

                .form-actions {
                    flex-direction: column;
                    align-items: stretch;
                }

                .link-group {
                    margin-left: 0;
                    flex-direction: column;
                    width: 100%;
                }

                .btn,
                .link-action {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>

    <body>

        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class="container">
                <div class="page-header">
                    <h1 class="page-title">
                        <i class="fas fa-plus-circle"></i> Tạo CV Mới
                    </h1>
                </div>

            <c:if test="${param.saved == '1'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>Lưu thành công!</span>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/cv/save" accept-charset="UTF-8">

                <div class="form-card">
                    <div class="form-group">
                        <label class="form-label">Tiêu Đề CV *</label>
                        <input type="text" name="title" id="title" class="form-control"
                               placeholder="VD: Thực tập sinh Marketing" />
                        <div class="error-message" id="title-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Tiêu đề CV không được để trống</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Template</label>
                        <select name="template" class="form-control">
                            <option value="TEMPLATE_1">Template 1 (1 cột)</option>
                            <option value="TEMPLATE_2">Template 2 (2 cột)</option>
                        </select>
                        <div class="form-hint">Template 1 = Bố cục 1 cột; Template 2 = Bố cục 2 cột với sidebar</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tóm Tắt Về Bản Thân *</label>
                        <textarea name="summary" id="summary" rows="5" class="form-control" 
                                  placeholder="Giới thiệu ngắn gọn về bản thân, kinh nghiệm và mục tiêu nghề nghiệp..."></textarea>
                        <div class="error-message" id="summary-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Tóm tắt về bản thân không được để trống</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Kỹ Năng *</label>
                        <textarea name="skills" id="skills" rows="3" class="form-control" 
                                  placeholder="VD: Microsoft Office, Marketing, SEO, Photoshop, ..."></textarea>
                        <div class="error-message" id="skills-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Kỹ năng không được để trống</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Liên Kết & Chứng Chỉ *</label>
                        <textarea name="links" id="links" rows="4" class="form-control" 
                                  placeholder="Mỗi dòng một link hoặc chứng chỉ..."></textarea>
                        <div class="error-message" id="links-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Liên kết & Chứng chỉ không được để trống</span>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="section-header">
                        <h2 class="section-title">Các Phần Tùy Chỉnh</h2>
                        <button type="button" class="btn btn-secondary" onclick="addSection()">
                            <i class="fas fa-plus"></i>
                            Thêm Phần
                        </button>
                    </div>
                    <div class="form-hint" style="margin-bottom: 1.5rem;">
                        Bạn có thể thêm nhiều mục như: HỌC VẤN, KINH NGHIỆM, HOẠT ĐỘNG, CHỨNG CHỈ, DỰ ÁN...
                    </div>

                    <div id="sectionsWrap">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Lưu CV
                        </button>

                        <a class="btn btn-outline" href="${pageContext.request.contextPath}/cv/list">
                            <i class="fas fa-arrow-left"></i>
                            Quay Lại
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <script>
            const notEmptyRegex = /\S+/;
            const MAX_WORDS = 124;

            function countWords(text) {
                if (!text)
                    return 0;
                return text.trim().split(/\s+/).filter(Boolean).length;
            }

            function validateField(field, errorId) {
                const value = field.value || "";
                const words = countWords(value);

                if (!notEmptyRegex.test(value)) {
                    showError(field, errorId); // dùng message trong HTML sẵn có
                    return false;
                }

                if (words > MAX_WORDS) {
                    showError(field, errorId, `Không được vượt quá ${MAX_WORDS} từ`);
                    return false;
                }

                hideError(field, errorId);
                return true;
            }

        // Validation function
            function validateForm(event) {
                event.preventDefault();

                let isValid = true;

                const title = document.getElementById('title');
                const summary = document.getElementById('summary');
                const skills = document.getElementById('skills');
                const links = document.getElementById('links');

                if (!validateField(title, 'title-error'))
                    isValid = false;
                if (!validateField(summary, 'summary-error'))
                    isValid = false;
                if (!validateField(skills, 'skills-error'))
                    isValid = false;
                if (!validateField(links, 'links-error'))
                    isValid = false;

                if (isValid) {
                    event.target.submit();
                } else {
                    const firstError = document.querySelector('.form-control.error');
                    if (firstError) {
                        firstError.scrollIntoView({behavior: 'smooth', block: 'center'});
                    }
                }
            }

            function showError(field, errorId, message) {
                field.classList.add('error');
                const errorMsg = document.getElementById(errorId);
                if (errorMsg) {
                    errorMsg.classList.add('show');

                    // nếu truyền message thì đổi nội dung span, còn không thì giữ mặc định
                    if (message) {
                        const span = errorMsg.querySelector('span');
                        if (span)
                            span.textContent = message;
                    }
                }
            }

            function hideError(field, errorId) {
                field.classList.remove('error');
                const errorMsg = document.getElementById(errorId);
                if (errorMsg) {
                    errorMsg.classList.remove('show');
                }
            }

        // Remove error on input (realtime)
            function setupInputListeners() {
                const fields = [
                    {field: 'title', error: 'title-error'},
                    {field: 'summary', error: 'summary-error'},
                    {field: 'skills', error: 'skills-error'},
                    {field: 'links', error: 'links-error'}
                ];

                fields.forEach(item => {
                    const field = document.getElementById(item.field);
                    if (!field)
                        return;

                    field.addEventListener('input', function () {
                        const value = this.value || "";
                        const words = countWords(value);

                        if (!notEmptyRegex.test(value)) {
                            // rỗng -> giữ message default trong HTML
                            showError(this, item.error);
                        } else if (words > MAX_WORDS) {
                            showError(this, item.error, `Không được vượt quá ${MAX_WORDS} từ`);
                        } else {
                            hideError(this, item.error);
                        }
                    });
                });
            }

            function removeSection(btn) {
                const card = btn.closest('.section-card');
                if (card) {
                    card.style.animation = 'fadeOut 0.3s ease-out';
                    setTimeout(() => card.remove(), 300);
                }
            }

            function addSection() {
                const wrap = document.getElementById('sectionsWrap');
                const div = document.createElement('div');
                div.className = 'section-card';
                div.innerHTML = `
                <div class="section-card-header">
                    <div class="section-card-body">
                        <div class="form-group" style="margin-bottom: 1rem;">
                            <label class="form-label">Tiêu Đề Phần</label>
                            <input type="text" name="sectionTitle" class="form-control"
                                   placeholder="VD: KINH NGHIỆM LÀM VIỆC"/>
                        </div>

                        <div class="form-group" style="margin-bottom: 0;">
                            <label class="form-label">Nội Dung</label>
                            <textarea name="sectionContent" rows="6" class="form-control"
                                      placeholder="Nhập nội dung chi tiết..."></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-danger" onclick="removeSection(this)">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `;
                wrap.appendChild(div);

                const input = div.querySelector('input[name="sectionTitle"]');
                if (input) {
                    input.focus();
                    input.scrollIntoView({behavior: 'smooth', block: 'center'});
                }
            }

        // Khởi tạo 1 section mặc định khi trang load
            window.addEventListener('DOMContentLoaded', function () {
                addSection();

                const form = document.querySelector('form');
                if (form)
                    form.addEventListener('submit', validateForm);

                setupInputListeners();
            });
        </script>


        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

    </body>
</html>
