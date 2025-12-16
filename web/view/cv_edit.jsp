<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${cv == null ? "Create CV" : "Edit CV"} - Jobbies</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
            color: #fff;
            overflow-x: hidden;
            min-height: 100vh;
            padding: 2rem;
        }

        .stars {
            position: fixed;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
            top: 0;
            left: 0;
        }

        .star {
            position: absolute;
            width: 2px;
            height: 2px;
            background: #fff;
            border-radius: 50%;
            animation: twinkle 3s infinite;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        .container {
            position: relative;
            z-index: 10;
            max-width: 900px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, #fff 0%, #c471f5 50%, #fa71cd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .subtitle {
            color: #b8b8d1;
            font-size: 1.1rem;
        }

        .success-message {
            background: rgba(57, 255, 20, 0.15);
            border: 2px solid rgba(57, 255, 20, 0.5);
            border-radius: 15px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            color: #39ff14;
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 25px;
            padding: 3rem;
            box-shadow: 0 20px 60px rgba(196, 113, 245, 0.2);
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 0.8rem;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-input,
        .form-textarea,
        .form-select {
            width: 100%;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 1rem 1.5rem;
            color: #fff;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s;
            outline: none;
        }

        .form-input:focus,
        .form-textarea:focus,
        .form-select:focus {
            border-color: #c471f5;
            background: rgba(196, 113, 245, 0.1);
            box-shadow: 0 0 20px rgba(196, 113, 245, 0.3);
        }

        .form-input::placeholder,
        .form-textarea::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg width='12' height='8' viewBox='0 0 12 8' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L6 6L11 1' stroke='%23fff' stroke-width='2' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1.5rem center;
            padding-right: 3.5rem;
        }

        .form-select option {
            background: #1a0b2e;
            color: #fff;
        }

        .form-hint {
            font-size: 0.85rem;
            color: #b8b8d1;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .template-preview {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .template-option {
            flex: 1;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .template-option:hover {
            border-color: #c471f5;
            background: rgba(196, 113, 245, 0.1);
            transform: translateY(-5px);
        }

        .template-option.selected {
            border-color: #39ff14;
            background: rgba(57, 255, 20, 0.1);
            box-shadow: 0 0 20px rgba(57, 255, 20, 0.3);
        }

        .template-icon {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .template-name {
            font-weight: 600;
            color: #fff;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn-primary {
            flex: 1;
            padding: 1.2rem 2.5rem;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            border: none;
            border-radius: 50px;
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(196, 113, 245, 0.6);
        }

        .btn-secondary {
            padding: 1.2rem 2rem;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }

        .btn-download {
            padding: 1.2rem 2rem;
            background: rgba(57, 255, 20, 0.1);
            border: 2px solid rgba(57, 255, 20, 0.3);
            border-radius: 50px;
            color: #39ff14;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-download:hover {
            background: rgba(57, 255, 20, 0.2);
            border-color: #39ff14;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(57, 255, 20, 0.3);
        }

        .character-count {
            text-align: right;
            font-size: 0.8rem;
            color: #b8b8d1;
            margin-top: 0.3rem;
        }

        @media (max-width: 768px) {
            .form-card {
                padding: 2rem 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .template-preview {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>
    
    <jsp:include page="../view/common/user/header-user.jsp"/>

    <div class="container">
        <div class="header">
            <h1 class="page-title">${cv == null ? "✨ Create New CV" : "✏️ Edit CV"}</h1>
            <p class="subtitle">${cv == null ? "Tạo CV chuyên nghiệp trong vài phút" : "Cập nhật thông tin CV của bạn"}</p>
        </div>

        <c:if test="${param.saved == 1}">
            <div class="success-message">
                <span style="font-size: 1.5rem;">✅</span>
                <span>CV đã được lưu thành công!</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/cv/save" method="post" class="form-card">
            <c:if test="${cv != null}">
                <input type="hidden" name="cvid" value="${cv.cvId}"/>
            </c:if>

            <div class="form-group">
                <label class="form-label">
                    📝 CV Title
                </label>
                <input 
                    type="text" 
                    name="title" 
                    class="form-input"
                    value="${cv != null ? cv.title : ''}"
                    placeholder="e.g. Senior Frontend Developer CV"
                    required
                    maxlength="100"
                    oninput="updateCharCount(this, 'titleCount', 100)"
                />
                <div class="character-count" id="titleCount">0/100</div>
            </div>

            <div class="form-group">
                <label class="form-label">
                    🎨 Choose Template
                </label>
                <select name="template" class="form-select" id="templateSelect">
                    <option value="TEMPLATE_1" ${cv != null && cv.templateCode=='TEMPLATE_1' ? 'selected':''}>Modern Professional</option>
                    <option value="TEMPLATE_2" ${cv != null && cv.templateCode=='TEMPLATE_2' ? 'selected':''}>Creative Designer</option>
                </select>
                <div class="form-hint">💡 Chọn template phù hợp với ngành nghề của bạn</div>
            </div>

            <div class="form-group">
                <label class="form-label">
                    💬 Professional Summary
                </label>
                <textarea 
                    name="summary" 
                    class="form-textarea"
                    placeholder="Viết một đoạn giới thiệu ngắn về bản thân, kinh nghiệm và mục tiêu nghề nghiệp của bạn..."
                    maxlength="500"
                    oninput="updateCharCount(this, 'summaryCount', 500)"
                >${cv != null ? cv.summary : ''}</textarea>
                <div class="character-count" id="summaryCount">0/500</div>
                <div class="form-hint">💡 2-4 câu ngắn gọn, highlight điểm mạnh của bạn</div>
            </div>

            <div class="form-group">
                <label class="form-label">
                    🚀 Skills
                </label>
                <input 
                    type="text" 
                    name="skills" 
                    class="form-input"
                    value="${cv != null ? cv.skills : ''}"
                    placeholder="JavaScript, React, Node.js, Python, UI/UX Design..."
                />
                <div class="form-hint">💡 Ngăn cách bằng dấu phẩy (,)</div>
            </div>

            <div class="form-group">
                <label class="form-label">
                    🔗 Links & Social Media
                </label>
                <textarea 
                    name="links" 
                    class="form-textarea"
                    placeholder="https://github.com/yourname
https://linkedin.com/in/yourname
https://yourportfolio.com"
                    style="min-height: 100px;"
                >${cv != null ? cv.links : ''}</textarea>
                <div class="form-hint">💡 Mỗi link trên một dòng riêng</div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-primary">
                    💾 Save CV
                </button>
                <a href="${pageContext.request.contextPath}/cv/list" class="btn-secondary">
                    ← Back to List
                </a>
                <c:if test="${cv != null}">
                    <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}" class="btn-download">
                        ⬇️ Download PDF
                    </a>
                </c:if>
            </div>
        </form>
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

        // Character count function
        function updateCharCount(input, counterId, maxLength) {
            const count = input.value.length;
            const counter = document.getElementById(counterId);
            counter.textContent = count + '/' + maxLength;
            
            if (count > maxLength * 0.9) {
                counter.style.color = '#fa71cd';
            } else {
                counter.style.color = '#b8b8d1';
            }
        }

        // Initialize character counts on page load
        window.addEventListener('DOMContentLoaded', function() {
            const titleInput = document.querySelector('input[name="title"]');
            const summaryInput = document.querySelector('textarea[name="summary"]');
            
            if (titleInput) {
                updateCharCount(titleInput, 'titleCount', 100);
            }
            if (summaryInput) {
                updateCharCount(summaryInput, 'summaryCount', 500);
            }
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const title = document.querySelector('input[name="title"]').value.trim();
            
            if (!title) {
                e.preventDefault();
                alert('⚠️ Vui lòng nhập tiêu đề cho CV!');
                return false;
            }
        });
    </script>
</body>
</html>