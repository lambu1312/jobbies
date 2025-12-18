<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Interview Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
            }
            .content {
                margin-left: 280px;
                padding: 30px;
            }
            .page-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                border-radius: 15px;
                margin-bottom: 30px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            .filter-card {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 25px;
            }
            .interview-table {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .interview-table table {
                margin-bottom: 0;
            }
            .interview-table th {
                background-color: #667eea;
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                padding: 15px;
                border: none;
            }
            .interview-table td {
                padding: 15px;
                vertical-align: middle;
            }
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
            }
            .status-scheduled {
                background-color: #d1ecf1;
                color: #0c5460;
            }
            .status-rescheduled {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }
            .status-cancelled {
                background-color: #f8d7da;
                color: #721c24;
            }
            .btn-action {
                padding: 6px 12px;
                margin: 2px;
                font-size: 0.85rem;
                border-radius: 5px;
            }
            .interview-type-badge {
                padding: 4px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 500;
            }
            .type-online {
                background-color: #e3f2fd;
                color: #1976d2;
            }
            .type-offline {
                background-color: #f3e5f5;
                color: #7b1fa2;
            }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar-re.jsp"/>
        
        <div class="content">
            <div class="page-header">
                <h1><i class="fas fa-calendar-check me-3"></i>Interview Management</h1>
                <p class="mb-0">Manage all scheduled interviews and their statuses</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            <c:if test="${param.success eq 'interview_updated'}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>Interview updated successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success eq 'interview_deleted'}">
                <div class="alert alert-warning alert-dismissible fade show">
                    <i class="fas fa-trash me-2"></i>Interview deleted successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Filter Section -->
            <div class="filter-card">
                <form method="get" action="${pageContext.request.contextPath}/interviewManagement">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-search me-2"></i>Search Candidate</label>
                            <input type="text" class="form-control" name="searchName" 
                                   value="${searchName}" placeholder="Enter candidate name...">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-briefcase me-2"></i>Job Position</label>
                            <select class="form-select" name="jobFilter">
                                <option value="all" ${jobFilter eq 'all' || empty jobFilter ? 'selected' : ''}>All Positions</option>
                                <c:forEach var="job" items="${allJobPostings}">
                                    <option value="${job.jobPostingID}" ${jobFilter == String.valueOf(job.jobPostingID) ? 'selected' : ''}>
                                        ${job.title}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label"><i class="fas fa-filter me-2"></i>Status</label>
                            <select class="form-select" name="statusFilter">
                                <option value="all" ${statusFilter eq 'all' || empty statusFilter ? 'selected' : ''}>All Status</option>
                                <option value="Scheduled" ${statusFilter eq 'Scheduled' ? 'selected' : ''}>Scheduled</option>
                                <option value="Rescheduled" ${statusFilter eq 'Rescheduled' ? 'selected' : ''}>Rescheduled</option>
                                <option value="Completed" ${statusFilter eq 'Completed' ? 'selected' : ''}>Completed</option>
                                <option value="Cancelled" ${statusFilter eq 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label"><i class="fas fa-calendar me-2"></i>Date</label>
                            <input type="date" class="form-control" name="dateFilter" value="${dateFilter}">
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Filter
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Interviews Table -->
            <div class="interview-table">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Candidate</th>
                            <th>Job Position</th>
                            <th>Date & Time</th>
                            <th>Type</th>
                            <th>Location/Link</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="interview" items="${interviews}">
                            <tr>
                                <td>
                                    <strong>${interview.application.jobSeeker.account.fullName}</strong><br>
                                    <small class="text-muted">${interview.application.jobSeeker.account.email}</small>
                                </td>
                                <td>${interview.application.jobPostings.title}</td>
                                <td>
                                    <i class="fas fa-calendar me-2"></i>
                                    <fmt:formatDate value="${interview.interviewDate}" pattern="dd/MM/yyyy"/><br>
                                    <i class="fas fa-clock me-2"></i>${interview.interviewTime}
                                </td>
                                <td>
                                    <span class="interview-type-badge ${interview.interviewType eq 'Online' ? 'type-online' : 'type-offline'}">
                                        ${interview.interviewType}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${interview.interviewType eq 'Online'}">
                                            <a href="${interview.meetingLink}" target="_blank" class="text-primary">
                                                <i class="fas fa-link me-1"></i>Meeting Link
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-map-marker-alt me-1"></i>${interview.location}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="status-badge status-${interview.status.toLowerCase()}">
                                        ${interview.status}
                                    </span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-info btn-action" 
                                            onclick="event.preventDefault(); event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/interviewDetails?interviewId=${interview.interviewID}';">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                    <button type="button" class="btn btn-sm btn-primary btn-action"
                                            data-bs-toggle="modal" data-bs-target="#editInterviewModal"
                                            onclick="editInterview(${interview.interviewID}, ${interview.application.applicationID}, '${interview.interviewDate}', '${interview.interviewTime}', '${interview.location}', '${interview.interviewType}', '${interview.meetingLink}', '${interview.notes}', '${interview.status}')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty interviews}">
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No interviews found</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div class="text-muted">
                        Showing ${(currentPage - 1) * 10 + 1} to ${(currentPage - 1) * 10 + interviews.size()} of ${totalRecords} interviews
                    </div>
                    <nav>
                        <ul class="pagination mb-0">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage - 1}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                    Previous
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${currentPage + 1}&statusFilter=${statusFilter}&searchName=${searchName}&dateFilter=${dateFilter}&jobFilter=${jobFilter}">
                                    Next
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>

        <!-- Edit Interview Modal -->
        <div class="modal fade" id="editInterviewModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Interview</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editInterviewForm" action="${pageContext.request.contextPath}/scheduleInterview" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="interviewId" id="editInterviewId">
                            <input type="hidden" name="jobPostId" value="0">
                            <input type="hidden" name="returnTo" value="management">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Interview Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="editInterviewDate" name="interviewDate" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Interview Time <span class="text-danger">*</span></label>
                                    <input type="time" class="form-control" id="editInterviewTime" name="interviewTime" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Interview Type <span class="text-danger">*</span></label>
                                <select class="form-select" id="editInterviewType" name="interviewType" onchange="toggleEditFields()" required>
                                    <option value="Online">Online</option>
                                    <option value="Offline">Offline</option>
                                </select>
                            </div>
                            
                            <div class="mb-3" id="editLocationField">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" id="editLocation" name="location">
                            </div>
                            
                            <div class="mb-3" id="editMeetingLinkField">
                                <label class="form-label">Meeting Link</label>
                                <input type="url" class="form-control" id="editMeetingLink" name="meetingLink">
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Notes</label>
                                <textarea class="form-control" id="editNotes" name="notes" rows="3"></textarea>
                            </div>
                            
                            <input type="hidden" id="editStatus" name="status">
                            
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" onclick="deleteInterviewFromModal()">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Update Interview
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function viewInterview(interviewId, applicationId, interviewDate, interviewTime, location, interviewType, meetingLink, notes, status) {
                if (interviewDate && interviewDate.includes(' ')) {
                    interviewDate = interviewDate.split(' ')[0];
                }
                
                const dateParts = interviewDate.split('-');
                const formattedDate = dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                
                let content = '<div class="row">';
                content += '<div class="col-md-6 mb-3"><strong>Date:</strong> ' + formattedDate + '</div>';
                content += '<div class="col-md-6 mb-3"><strong>Time:</strong> ' + (interviewTime || 'N/A') + '</div>';
                content += '<div class="col-md-6 mb-3"><strong>Type:</strong> <span class="interview-type-badge ' + (interviewType === 'Online' ? 'type-online' : 'type-offline') + '">' + interviewType + '</span></div>';
                content += '<div class="col-md-6 mb-3"><strong>Status:</strong> <span class="status-badge status-' + status.toLowerCase() + '">' + status + '</span></div>';
                
                if (interviewType === 'Online' && meetingLink) {
                    content += '<div class="col-12 mb-3"><strong>Meeting Link:</strong><br><a href="' + meetingLink + '" target="_blank">' + meetingLink + '</a></div>';
                } else if (location) {
                    content += '<div class="col-12 mb-3"><strong>Location:</strong><br>' + location + '</div>';
                }
                
                if (notes) {
                    content += '<div class="col-12 mb-3"><strong>Notes:</strong><br>' + notes + '</div>';
                }
                content += '</div>';
                
                document.getElementById('viewInterviewContent').innerHTML = content;
            }
            
            function editInterview(interviewId, applicationId, interviewDate, interviewTime, location, interviewType, meetingLink, notes, status) {
                if (interviewDate && interviewDate.includes(' ')) {
                    interviewDate = interviewDate.split(' ')[0];
                }
                
                document.getElementById('editInterviewId').value = interviewId;
                document.getElementById('editInterviewDate').value = interviewDate;
                document.getElementById('editInterviewTime').value = interviewTime || '';
                document.getElementById('editLocation').value = location || '';
                document.getElementById('editInterviewType').value = interviewType || 'Offline';
                document.getElementById('editMeetingLink').value = meetingLink || '';
                document.getElementById('editNotes').value = notes || '';
                document.getElementById('editStatus').value = status || 'Scheduled';
                
                toggleEditFields();
            }
            
            function toggleEditFields() {
                const type = document.getElementById('editInterviewType').value;
                const locationField = document.getElementById('editLocationField');
                const meetingLinkField = document.getElementById('editMeetingLinkField');
                
                if (type === 'Online') {
                    meetingLinkField.style.display = 'block';
                    locationField.style.display = 'none';
                } else {
                    meetingLinkField.style.display = 'none';
                    locationField.style.display = 'block';
                }
            }
            
            function deleteInterviewFromModal() {
                if (confirm('Are you sure you want to delete this interview?')) {
                    const interviewId = document.getElementById('editInterviewId').value;
                    window.location.href = '${pageContext.request.contextPath}/scheduleInterview?action=delete&interviewId=' + interviewId + '&jobPostId=0&returnTo=management';
                }
            }
        </script>
    </body>
</html>
