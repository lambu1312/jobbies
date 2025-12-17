<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.JobPostings" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ứng dụng của tôi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Custom styles */
            body {
                font-family: 'Inter', system-ui, sans-serif;
                background-color: #f3e9e9;
                color: #333;
                min-height: 100vh;
            }

            h1 {
                font-size: 2rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 30px;
                text-align: center;
            }
            
            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            
            table {
                border-collapse: collapse;
                background-color: #fff;
            }
            
            thead th {
                background-color: #f8f9fa;
                color: #495057;
                font-weight: 600;
                padding: 14px;
                border-bottom: 2px solid #dee2e6;
                text-align: left;
            }
            
            tbody tr {
                background-color: #ffffff;
                border-bottom: 1px solid #e9ecef;
                transition: background-color 0.2s;
            }
            
            tbody tr:hover {
                background-color: #f8f9fa;
            }
            
            tbody td {
                padding: 14px;
                vertical-align: middle;
                color: #495057;
            }
            
            .badge {
                padding: 6px 12px;
                font-size: 0.875rem;
                font-weight: 500;
                border-radius: 4px;
            }
            
            .form-select {
                max-width: 300px;
                border: 1px solid #ced4da;
                padding: 8px 12px;
                border-radius: 4px;
            }
            
            .form-select:focus {
                border-color: #86b7fe;
                box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
            }
            
            .btn-sm {
                padding: 6px 14px;
                font-size: 0.875rem;
                border-radius: 4px;
                margin-right: 5px;
            }
            
            .modal-content {
                color: #333;
                border-radius: 8px;
            }
            
            .modal-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }
            
            .page-link {
                color: #495057;
                border: 1px solid #dee2e6;
            }
            
            .page-link:hover {
                background-color: #e9ecef;
                color: #495057;
            }
            
            .page-item.active .page-link {
                background-color: #0d6efd;
                border-color: #0d6efd;
                color: #fff;
            }
            
            .alert {
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
         <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- Header Area End -->

            <div class="container mt-5 mb-5">
                <h1>Ứng dụng của tôi</h1>

                <!-- Display error or success message if any -->
            <c:if test="${not empty errorApplication}">
                <div class="alert alert-danger" role="alert">
                    ${errorApplication}
                </div>
            </c:if>

            <c:if test="${not empty successApplication}">
                <div class="alert alert-success" role="alert">
                    ${successApplication}
                </div>
            </c:if>

            <!-- Applications Table -->
            <c:if test="${not empty applications}">
                <form action="application" method="GET" class="mb-4">
                    <select name="status" class="form-select" onchange="this.form.submit()">
                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                        <option value="3" ${param.status == '3' ? 'selected' : ''}>Chưa giải quyết</option>
                        <option value="2" ${param.status == '2' ? 'selected' : ''}>Đậu</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Loại</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã Hủy</option>
                    </select>
                </form>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Chức danh</th>
                            <th>Ngày nộp đơn</th>
                            <th>Trạng Thái</th>
                            <th>Hoạt động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}">
                            <tr>
                                <td><c:out value="${jobPostingMap[app.applicationID]}" /></td>
                                <td>${app.appliedDate}</td>
                                <td>
                                    <!-- Display the violation message if it exists, otherwise display the status badge -->
                                    <c:choose>
                                        <c:when test="${applicationStatusMap[app.applicationID] == 'Violate'}">
                                            <span class="badge bg-warning text-dark"><i class="fa-solid fa-triangle-exclamation"></i> Vi Phạm</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${app.status == 3}">
                                                    <span class="badge bg-info text-dark"><i class="fa fa-clock"></i> Chưa Giải Quyết</span>
                                                </c:when>
                                                <c:when test="${app.status == 2}">
                                                    <span class="badge bg-success"><i class="fa fa-check-circle"></i> Đậu </span>
                                                </c:when>
                                                <c:when test="${app.status == 1}">
                                                    <span class="badge bg-danger"><i class="fa fa-times-circle"></i> Loại</span>
                                                </c:when>
                                                <c:when test="${app.status == 0}">
                                                    <span class="badge bg-secondary"><i class="fa fa-ban"></i> Đã Hủy</span>
                                                </c:when>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <!-- View Button: Disabled if the job posting is "Violate" -->
                                    <button type="button" 
                                            class="btn btn-info btn-sm" 
                                            onclick="window.location.href = '${pageContext.request.contextPath}/ViewDetailApplication?action=details&applicationId=${app.applicationID}'"
                                            <c:if test="${applicationStatusMap[app.applicationID] == 'Violate'}">disabled</c:if>>
                                                <i class="fa-solid fa-eye"></i> Xem
                                            </button>

                                            <!-- Cancel Button: Disabled if the application status is not Pending (3) or the job posting is "Violate" -->
                                            <button type="button" 
                                                    class="btn btn-danger btn-sm" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#cancelApplicationModal-${app.applicationID}"
                                            <c:if test="${app.status != 3 || applicationStatusMap[app.applicationID] == 'Violate'}">disabled</c:if>>
                                                <i class="fa fa-ban"></i> Hủy bỏ
                                            </button>
                                    </td>

                                </tr>

                                <!-- Modal for Cancel Application -->
                            <div class="modal fade" id="cancelApplicationModal-${app.applicationID}" tabindex="-1" aria-labelledby="cancelModalLabel-${app.applicationID}" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="cancelModalLabel-${app.applicationID}">Hủy đơn đăng ký</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/application" method="post">
                                        <div class="modal-body">
                                            <p>Bạn có chắc chắn muốn hủy đơn đăng ký này không?</p>
                                            <input type="hidden" name="action" value="cancel-application">
                                            <input type="hidden" name="applicationId" value="${app.applicationID}">
                                            <input type="hidden" name="status" value="0">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-danger">Xác nhận Hủy</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- End of Modal -->
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <!-- Pagination -->
            <nav aria-label="Page navigation" class="footer-container">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${currentPage - 1}&status=${selectedStatus}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${i}&status=${selectedStatus}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/application?page=${currentPage + 1}&status=${selectedStatus}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>


        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <!-- Bootstrap and JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
