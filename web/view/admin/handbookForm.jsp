<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Handbook Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/admin/header-admin.jsp"></jsp:include>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
            </div>

            <div class="col-md-10">
                <div class="container" style="margin-top: 20px; margin-bottom: 40px;">
                    <h4 class="mb-4">${empty post ? 'Create Post' : 'Edit Post'}</h4>

                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger">${param.error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/handbook_admin" method="POST" enctype="multipart/form-data">
                        <c:choose>
                            <c:when test="${empty post}">
                                <input type="hidden" name="action" value="create">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${post.handbookPostID}">
                            </c:otherwise>
                        </c:choose>

                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input class="form-control" type="text" name="title" value="${empty post ? '' : post.title}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" name="status">
                                <option value="Draft" ${(empty post && 'Draft' == 'Draft') || (!empty post && post.status == 'Draft') ? 'selected' : ''}>Draft</option>
                                <option value="Published" ${!empty post && post.status == 'Published' ? 'selected' : ''}>Published</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Thumbnail</label>
                            <input class="form-control" type="file" name="thumbnail" accept="image/*">
                            <c:if test="${not empty post && not empty post.thumbnail}">
                                <div class="mt-2">
                                    <img src="${post.thumbnail}" alt="thumbnail" style="max-height: 120px; object-fit: cover;">
                                </div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Content</label>
                            <textarea class="form-control" rows="10" name="content" required>${empty post ? '' : post.content}</textarea>
                        </div>

                        <div class="d-flex" style="gap: 10px;">
                            <button class="btn btn-primary" type="submit">Save</button>
                            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/handbook_admin">Cancel</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
