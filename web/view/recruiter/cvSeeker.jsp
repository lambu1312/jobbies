<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xem Chi Tiết CV</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
        <style>
            /* Tông màu Tím Hồng chủ đạo */
            :root {
                --primary-purple: #a855f7;
                --primary-pink: #ec4899;
                --gradient-bg: linear-gradient(90deg, #c084fc 0%, #f472b6 100%);
                --text-purple: #7e22ce;
            }

            body {
                background-color: #fdfbff;
            }

            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .content-wrapper {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding-bottom: 40px;
            }

            .cv-container {
                width: 100%;
                max-width: 900px;
                margin-top: 30px;
                padding: 40px;
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(168, 85, 247, 0.15); /* Shadow tím nhạt */
                border: 1px solid #f3e8ff;
            }

            .cv-header {
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 20px;
            }

            .cv-header h2 {
                background: -webkit-linear-gradient(#c026d3, #7e22ce);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-weight: 800;
                font-size: 32px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .cv-details {
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-bottom: 30px;
                background-color: #faf5ff;
                padding: 15px;
                border-radius: 10px;
            }

            .cv-details p {
                margin: 0;
                font-size: 16px;
                color: #555;
            }

            .cv-details label {
                font-weight: 700;
                color: var(--text-purple);
                margin-right: 5px;
            }
/* Preview Section */
            .cv-preview {
                margin-top: 20px;
                text-align: center;
                min-height: 500px;
                background-color: #f9fafb;
                border-radius: 8px;
                border: 1px dashed #d8b4fe;
                padding: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .cv-preview iframe, .cv-preview embed {
                border-radius: 8px;
                border: none;
            }

            /* Buttons */
            .action-buttons {
                margin-top: 40px;
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .download-button {
                display: inline-flex;
                align-items: center;
                background: var(--gradient-bg);
                color: white;
                padding: 12px 30px;
                text-decoration: none;
                border-radius: 50px;
                font-weight: 600;
                font-size: 16px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(236, 72, 153, 0.3);
                border: none;
            }

            .download-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(236, 72, 153, 0.5);
                color: white;
            }

            .download-button i {
                margin-right: 8px;
            }

            .back-button {
                display: inline-flex;
                align-items: center;
                color: #6b7280;
                background-color: white;
                border: 1px solid #d1d5db;
                padding: 12px 30px;
                text-decoration: none;
                font-weight: 600;
                font-size: 16px;
                border-radius: 50px;
                transition: all 0.3s ease;
            }

            .back-button:hover {
                background-color: #f3f4f6;
                color: #374151;
                border-color: #9ca3af;
            }

            .back-button i {
                margin-right: 8px;
            }
        </style>
    </head>
    <body>
        <div class="page-container">
            <%@ include file="../recruiter/sidebar-re.jsp" %>
            <%@ include file="../recruiter/header-re.jsp" %>

            <div class="content-wrapper">
                <div class="cv-container">
                    <div class="cv-header">
                        <h2>Chi Tiết Hồ Sơ (CV)</h2>
                    </div>

                    <div class="cv-details">
                        <p><label><i class="far fa-calendar-alt"></i> Ngày tải lên:</label> <fmt:formatDate value="${cv.uploadDate}" pattern="dd-MM-yyyy" /></p>
<p><label><i class="fas fa-sync-alt"></i> Cập nhật lần cuối:</label> <fmt:formatDate value="${cv.lastUpdated}" pattern="dd-MM-yyyy" /></p>
                    </div>

                    <div class="cv-preview">
                        <c:choose>
                            <c:when test="${fn:endsWith(cv.filePath, '.png') || fn:endsWith(cv.filePath, '.jpg') || fn:endsWith(cv.filePath, '.jpeg')}">
                                <img src="${pageContext.request.contextPath}/${cv.filePath}" alt="CV Image" style="max-width:100%; max-height: 600px; border-radius:8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                            </c:when>

                            <c:when test="${fn:endsWith(cv.filePath, '.pdf')}">
                                <embed src="${pageContext.request.contextPath}/${cv.filePath}" type="application/pdf" width="100%" height="600px" />
                            </c:when>

                            <c:when test="${fn:endsWith(cv.filePath, '.doc') || fn:endsWith(cv.filePath, '.docx')}">
                                <iframe src="https://docs.google.com/viewer?url=${pageContext.request.contextPath}/${cv.filePath}&embedded=true" width="100%" height="600px"></iframe>
                            </c:when>

                            <c:otherwise>
                                <div class="text-muted">
                                    <i class="fas fa-file-invoice fa-3x mb-3"></i>
                                    <p>Không hỗ trợ xem trước định dạng tệp tin này.<br>Vui lòng tải xuống để xem chi tiết.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="action-buttons">
                        <a href="javascript:history.back()" class="back-button">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/downloadCV?cvid=${cv.CVID}" class="download-button">
                            <i class="fas fa-download"></i> Tải Xuống CV
                        </a>
                    </div>
                </div>
            </div>

            <%@ include file="../recruiter/footer-re.jsp" %>
        </div>
    </body>
</html>