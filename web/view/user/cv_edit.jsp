<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${cv == null}">Create CV</c:when><c:otherwise>Edit CV</c:otherwise></c:choose></title>
    <style>
        body { font-family: Arial, sans-serif; margin: 16px; }
        h1 { margin: 0 0 12px 0; }
        .msg-success { color: green; margin: 8px 0; font-weight: 600; }
        label { display: block; margin: 10px 0 4px; font-weight: 600; }
        input[type="text"], select, textarea { width: 720px; max-width: 95vw; padding: 6px; }
        textarea { resize: vertical; }
        .row { margin-bottom: 10px; }
        .hr { margin: 14px 0; border-top: 1px solid #ddd; }
        .btn { padding: 6px 10px; cursor: pointer; }
        .btn-secondary { background: #fff; border: 1px solid #aaa; }
        .btn-danger { background: #fff; border: 1px solid #c55; color: #b00; }
        .btn-primary { background: #0b5; border: 1px solid #0a4; color: #fff; }
        .actions a { margin-right: 10px; text-decoration: none; }
        .actions a:hover { text-decoration: underline; }
        .section-card {
            border: 1px solid #ddd;
            padding: 12px;
            margin: 12px 0;
            border-radius: 6px;
            max-width: 980px;
        }
        .section-card .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
        }
        .section-card input[type="text"] { width: 520px; max-width: 80vw; }
        .section-card textarea { width: 900px; max-width: 95vw; }
        .small { color: #666; font-size: 12px; margin-top: 4px; }
        .top-actions { margin-top: 8px; }
    </style>
</head>

<body>

<c:choose>
    <c:when test="${cv == null}">
        <h1>Create CV</h1>
    </c:when>
    <c:otherwise>
        <h1>Edit CV</h1>
    </c:otherwise>
</c:choose>

<c:if test="${param.saved == '1'}">
    <div class="msg-success">Saved!</div>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/cv/save" accept-charset="UTF-8">
    <!-- CVID (để update) -->
    <c:if test="${cv != null}">
        <input type="hidden" name="cvid" value="${cv.cvId}" />
    </c:if>

    <div class="row">
        <label>Title</label>
        <input type="text" name="title"
               value="<c:out value='${cv != null ? cv.title : ""}'/>"
               placeholder="VD: Thực tập sinh Marketing" required />
    </div>

    <div class="row">
        <label>Template</label>
        <select name="template">
            <option value="TEMPLATE_1"
                <c:if test="${cv != null && cv.templateCode != null && cv.templateCode.equalsIgnoreCase('TEMPLATE_1')}">selected</c:if>>
                Template 1
            </option>
            <option value="TEMPLATE_2"
                <c:if test="${cv != null && cv.templateCode != null && cv.templateCode.equalsIgnoreCase('TEMPLATE_2')}">selected</c:if>>
                Template 2
            </option>
        </select>
        <div class="small">Template 1 = 1 cột; Template 2 = 2 cột (sidebar + main).</div>
    </div>

    <div class="row">
        <label>Summary</label>
        <textarea name="summary" rows="5" placeholder="Giới thiệu ngắn về bạn..."><c:out value="${cv != null ? cv.summary : ''}"/></textarea>
    </div>

    <div class="row">
        <label>Skills</label>
        <textarea name="skills" rows="3" placeholder="VD: Excel, Marketing, SEO, ..."><c:out value="${cv != null ? cv.skills : ''}"/></textarea>
    </div>

    <div class="row">
        <label>Links</label>
        <textarea name="links" rows="4" placeholder="Mỗi dòng 1 link hoặc 1 chứng chỉ..."><c:out value="${cv != null ? cv.links : ''}"/></textarea>
    </div>

    <div class="hr"></div>

    <h2>Custom Sections</h2>
    <div class="small">Bạn có thể thêm nhiều mục như: HỌC VẤN, KINH NGHIỆM, HOẠT ĐỘNG, CHỨNG CHỈ, DỰ ÁN...</div>

    <!-- Các section đã lưu trong DB -->
    <div id="sectionsWrap">
        <c:forEach items="${sections}" var="s">
            <div class="section-card">
                <div class="head">
                    <div>
                        <label style="margin-top:0">Section title</label>
                        <input type="text" name="sectionTitle" value="<c:out value='${s.title}'/>" placeholder="VD: HOẠT ĐỘNG" />
                    </div>
                    <button type="button" class="btn btn-danger" onclick="removeSection(this)">Remove</button>
                </div>

                <label>Content</label>
                <textarea name="sectionContent" rows="6" placeholder="Nhập nội dung..."><c:out value="${s.content}"/></textarea>
            </div>
        </c:forEach>
    </div>

    <!-- Nút thêm section -->
    <button type="button" class="btn btn-secondary" onclick="addSection()">+ Add Section</button>

    <div class="hr"></div>

    <div class="top-actions">
        <button type="submit" class="btn btn-primary">Save</button>

        <a class="actions" href="${pageContext.request.contextPath}/cv/list">Back</a>

        <!-- Chỉ hiển thị khi đã có cvId -->
        <c:if test="${cv != null}">
            <span class="actions">
                |
                <a href="${pageContext.request.contextPath}/cv/preview?cvid=${cv.cvId}" target="_blank">👁 Xem trước</a>
                |
                <a href="${pageContext.request.contextPath}/cv/download?cvid=${cv.cvId}">⬇ Download PDF</a>
            </span>
        </c:if>
    </div>
</form>

<!-- Template section mới (client side) -->
<script>
function removeSection(btn){
    const card = btn.closest('.section-card');
    if(card) card.remove();
}

function addSection(){
    const wrap = document.getElementById('sectionsWrap');
    const div = document.createElement('div');
    div.className = 'section-card';
    div.innerHTML = `
        <div class="head">
            <div>
                <label style="margin-top:0">Section title</label>
                <input type="text" name="sectionTitle" placeholder="VD: KINH NGHIỆM LÀM VIỆC"/>
            </div>
            <button type="button" class="btn btn-danger" onclick="removeSection(this)">Remove</button>
        </div>

        <label>Content</label>
        <textarea name="sectionContent" rows="6" placeholder="Nhập nội dung..."></textarea>
    `;
    wrap.appendChild(div);

    // focus input title
    const input = div.querySelector('input[name="sectionTitle"]');
    if(input) input.focus();
}
</script>

</body>
</html>
