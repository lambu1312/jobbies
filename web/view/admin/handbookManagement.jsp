<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Handbook Management</title>
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
                <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                    <h6 class="fw-medium mb-30 text-center fs-2">HANDBOOK MANAGEMENT</h6>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <form action="${pageContext.request.contextPath}/handbook_admin" method="GET" class="d-flex align-items-center" style="gap: 8px;">
                            <select class="form-select" name="status" style="width: 180px;">
                                <option value="" ${empty status ? 'selected' : ''}>All</option>
                                <option value="Draft" ${status == 'Draft' ? 'selected' : ''}>Draft</option>
                                <option value="Published" ${status == 'Published' ? 'selected' : ''}>Published</option>
                            </select>
                            <input class="form-control" type="text" name="search" placeholder="Search title..." value="${search}" style="width: 360px;">
                            <button class="btn btn-primary" type="submit">Filter</button>
                        </form>

                        <a class="btn btn-success" href="${pageContext.request.contextPath}/handbook_admin?action=create">+ New post</a>
                    </div>

                    <table class="table table-bordered" style="text-align: center; vertical-align: middle;">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Status</th>
                                <th>Updated</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${posts}" var="p">
                                <tr>
                                    <td>${p.handbookPostID}</td>
                                    <td style="text-align: left;">${p.title}</td>
                                    <td>
                                        <span class="badge ${p.status == 'Published' ? 'bg-success' : 'bg-secondary'}">${p.status}</span>
                                    </td>
                                    <td>${p.updatedAt}</td>
                                    <td>
                                        <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/handbook_admin?action=edit&id=${p.handbookPostID}">Edit</a>
                                        <form action="${pageContext.request.contextPath}/handbook_admin" method="POST" style="display: inline;" onsubmit="return confirm('Delete this post?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${p.handbookPostID}">
                                            <button class="btn btn-sm btn-danger" type="submit">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${pageControl.totalPages > 1}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${pageControl.page > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page-1}">Previous</a>
                                    </li>
                                </c:if>

                                <c:set var="startPage" value="${pageControl.page - 2 > 0 ? pageControl.page - 2 : 1}" />
                                <c:set var="endPage" value="${startPage + 4 <= pageControl.totalPages ? startPage + 4 : pageControl.totalPages}" />

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == pageControl.page ? 'active' : ''}">
                                        <a class="page-link" href="${pageControl.urlPattern}page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${pageControl.page < pageControl.totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page+1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
