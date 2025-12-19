<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
            color: #fff;
            overflow-x: hidden;
            min-height: 100vh;
        }

        .handbook-container {
            position: relative;
            z-index: 2;
        }

        .handbook-title {
            font-weight: 900;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .glass {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.12);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.35);
            border-radius: 16px;
        }

        .back-link {
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            font-weight: 700;
        }

        .back-link:hover {
            color: #fff;
            text-shadow: 0 0 18px rgba(196, 113, 245, 0.6);
        }

        .content {
            white-space: pre-wrap;
            line-height: 1.9;
            color: rgba(255, 255, 255, 0.9);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header-area.jsp"></jsp:include>

    <div class="container handbook-container" style="margin-top: 40px; margin-bottom: 60px;">
        <a class="back-link" href="${pageContext.request.contextPath}/handbook">&laquo; Quay lại danh sách</a>

        <h1 class="handbook-title mt-3">${post.title}</h1>

        <c:if test="${not empty post.thumbnail}">
            <img src="${post.thumbnail}" alt="thumbnail" class="img-fluid rounded mt-3 mb-4" style="max-height: 420px; object-fit: cover; width: 100%;">
        </c:if>

        <div class="glass p-4">
            <div class="content">${post.content}</div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>
