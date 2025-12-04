<%-- 
    Document   : breadcrumb-area
    Created on : Sep 15, 2024, 3:06:42 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="rts__section breadcrumb__background">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 position-relative d-flex justify-content-between align-items-center">
                <div class="breadcrumb__area max-content breadcrumb__padding z-2">
                    <h1 class="breadcrumb-title h3 mb-3">Blog 2</h1>
                    <nav>
                        <ul class="breadcrumb m-0 lh-1">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Blog 2</li>
                        </ul>
                    </nav>                  
                </div>
                <div class="breadcrumb__area__shape d-flex gap-4 justify-content-end align-items-center">
                    <div class="shape__one common">
                        <img src="${pageContext.request.contextPath}/assets/img/breadcrumb/shape-1.svg" alt="">
                    </div>
                    <div class="shape__two common">
                        <img src="${pageContext.request.contextPath}/assets/img/breadcrumb/shape-2.svg" alt="">
                    </div>
                    <div class="shape__three common">
                        <img src="${pageContext.request.contextPath}/assets/img/breadcrumb/shape-3.svg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
