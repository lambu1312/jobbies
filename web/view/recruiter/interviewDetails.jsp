<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Interview Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .detail-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 30px;
                margin-bottom: 20px;
            }
            .section-title {
                color: #495057;
                font-size: 1.3rem;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e9ecef;
            }
            .info-row {
                margin-bottom: 15px;
            }
            .info-label {
                font-weight: 600;
                color: #6c757d;
                margin-bottom: 5px;
            }
            .info-value {
                color: #212529;
            }
            .status-badge {
                padding: 8px 16px;
                border-radius: 20px;
                font-weight: 500;
                display: inline-block;
            }
            .status-scheduled { background-color: #cfe2ff; color: #084298; }
            .status-rescheduled { background-color: #fff3cd; color: #856404; }
            .status-completed { background-color: #d1e7dd; color: #0f5132; }
            .status-cancelled { background-color: #f8d7da; color: #842029; }
            .type-badge {
                padding: 6px 12px;
                border-radius: 15px;
                font-size: 0.9rem;
            }
            .type-online { background-color: #0d6efd; color: white; }
            .type-offline { background-color: #6c757d; color: white; }
        </style>
    </head>
    <body>
        <jsp:include page="sidebar-re.jsp"/>
        
        <div class="content" style="margin-left: 250px; padding: 30px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-calendar-check me-3"></i>Interview Details</h2>
                <a href="${pageContext.request.contextPath}/interviewManagement" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>

            <!-- Interview Information -->
            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-clock me-2"></i>Interview Information</h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Interview Date</div>
                            <div class="info-value">
                                <i class="fas fa-calendar me-2"></i>
                                <fmt:formatDate value="${interview.interviewDate}" pattern="EEEE, dd MMMM yyyy"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Interview Time</div>
                            <div class="info-value">
                                <i class="fas fa-clock me-2"></i>${interview.interviewTime}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Interview Type</div>
                            <div class="info-value">
                                <span class="type-badge ${interview.interviewType eq 'Online' ? 'type-online' : 'type-offline'}">
                                    ${interview.interviewType}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Status</div>
                            <div class="info-value">
                                <span class="status-badge status-${interview.status.toLowerCase()}">
                                    ${interview.status}
                                </span>
                            </div>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${interview.interviewType eq 'Online'}">
                            <div class="col-12">
                                <div class="info-row">
                                    <div class="info-label">Meeting Link</div>
                                    <div class="info-value">
                                        <a href="${interview.meetingLink}" target="_blank" class="btn btn-sm btn-primary">
                                            <i class="fas fa-video me-2"></i>Join Meeting
                                        </a>
                                        <br><small class="text-muted">${interview.meetingLink}</small>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="info-row">
                                    <div class="info-label">Location</div>
                                    <div class="info-value">
                                        <i class="fas fa-map-marker-alt me-2"></i>${interview.location}
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty interview.notes}">
                        <div class="col-12">
                            <div class="info-row">
                                <div class="info-label">Notes / Instructions</div>
                                <div class="info-value">
                                    <div class="alert alert-info mb-0">
                                        ${interview.notes}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Candidate Information -->
            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-user me-2"></i>Candidate Information</h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Full Name</div>
                            <div class="info-value">
                                <strong>${interview.application.jobSeeker.account.fullName}</strong>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Email</div>
                            <div class="info-value">
                                <i class="fas fa-envelope me-2"></i>
                                <a href="mailto:${interview.application.jobSeeker.account.email}">
                                    ${interview.application.jobSeeker.account.email}
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Phone</div>
                            <div class="info-value">
                                <i class="fas fa-phone me-2"></i>
                                ${interview.application.jobSeeker.account.phone}
                            </div>
                        </div>
                    </div>
                 
                </div>
            </div>

            <!-- Job Posting Information -->
            <div class="detail-card">
                <h3 class="section-title"><i class="fas fa-briefcase me-2"></i>Job Posting Details</h3>
                <div class="row">
                    <div class="col-12">
                        <div class="info-row">
                            <div class="info-label">Job Title</div>
                            <div class="info-value">
                                <h5 class="mb-0">${interview.application.jobPostings.title}</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Location</div>
                            <div class="info-value">
                                <i class="fas fa-map-marker-alt me-2"></i>${interview.application.jobPostings.location}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Salary Range</div>
                            <div class="info-value">
                                <i class="fas fa-dollar-sign me-2"></i>
                                <fmt:formatNumber value="${interview.application.jobPostings.minSalary}" type="number"/> - 
                                <fmt:formatNumber value="${interview.application.jobPostings.maxSalary}" type="number"/>
                                ${interview.application.jobPostings.currency}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">Closing Date</div>
                            <div class="info-value">
                                <i class="fas fa-calendar-times me-2"></i>
                                <fmt:formatDate value="${interview.application.jobPostings.closingDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="info-row">
                            <div class="info-label">Job Description</div>
                            <div class="info-value">
                                <p class="mb-2">${interview.application.jobPostings.description}</p>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>

           
        </div>

       

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
