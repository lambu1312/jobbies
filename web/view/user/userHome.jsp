<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jobbies - Tìm Việc Làm Mơ Ước</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

        <style>
            /* CRITICAL: Force navbar and dropdown positioning */
            nav.navbar,
            .navbar {
                position: relative !important;
                z-index: 9999 !important;
            }

            .user-dropdown {
                position: relative !important;
                z-index: 10000 !important;
            }

            .user-dropdown .dropdown-menu {
                position: absolute !important;
                top: calc(100% + 0.5rem) !important;
                right: 0 !important;
                z-index: 10001 !important;
                display: block !important;
            }

            .user-dropdown:not(.active) .dropdown-menu {
                opacity: 0 !important;
                visibility: hidden !important;
                pointer-events: none !important;
            }

            .user-dropdown.active .dropdown-menu {
                opacity: 1 !important;
                visibility: visible !important;
                pointer-events: auto !important;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
                background: linear-gradient(135deg, #0a0015 0%, #1a0b2e 50%, #16213e 100%);
                color: #fff;
                overflow-x: hidden;
                min-height: 100vh;
                position: relative;
            }

            /* Animated gradient background */
            body::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background:
                    radial-gradient(circle at 20% 50%, rgba(196, 113, 245, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 80% 80%, rgba(126, 232, 250, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 40% 20%, rgba(250, 113, 205, 0.1) 0%, transparent 50%);
                animation: gradientShift 15s ease infinite;
                z-index: 1;
                pointer-events: none;
            }

            @keyframes gradientShift {
                0%, 100% {
                    transform: scale(1) rotate(0deg);
                    opacity: 1;
                }
                50% {
                    transform: scale(1.1) rotate(5deg);
                    opacity: 0.8;
                }
            }

            /* Floating particles */
            .stars {
                position: fixed;
                width: 100%;
                height: 100%;
                overflow: hidden;
                z-index: 2;
                pointer-events: none;
            }

            .star {
                position: absolute;
                width: 3px;
                height: 3px;
                background: rgba(255, 255, 255, 0.8);
                border-radius: 50%;
                animation: twinkle 4s infinite ease-in-out;
            }

            @keyframes twinkle {
                0%, 100% {
                    opacity: 0.3;
                    transform: scale(1);
                }
                50% {
                    opacity: 1;
                    transform: scale(1.2);
                }
            }

            /* Floating decorations */
            .pixel-decoration {
                position: fixed;
                font-size: 3rem;
                opacity: 0.4;
                z-index: 5;
                animation: float 6s ease-in-out infinite;
                filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.3));
            }

            .deco-1 {
                top: 20%;
                left: 10%;
            }

            .deco-2 {
                top: 60%;
                right: 15%;
                animation-delay: 2s;
            }

            .deco-3 {
                bottom: 15%;
                left: 20%;
                animation-delay: 1s;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px) rotate(0deg);
                }
                50% {
                    transform: translateY(-25px) rotate(10deg);
                }
            }

            /* Side Banners */
            .side-banner {
                position: fixed;
                top: 50%;
                transform: translateY(-50%);
                width: 200px;
                height: 100vh;
                max-height: 800px;
                z-index: 100;
                border-radius: 0;
                overflow: hidden;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
            }

            .side-banner:hover {
                transform: translateY(-50%) scale(1.02);
                box-shadow: 0 0 50px rgba(196, 113, 245, 0.5);
            }

            .banner-left {
                left: 0;
            }

            .banner-right {
                right: 0;
            }

            /* Momo Banner */
            .momo-banner {
                background: linear-gradient(135deg, #a50064 0%, #d82d8b 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 20px;
                text-decoration: none;
                color: white;
                position: relative;
                width: 100%;
                height: 100%;
            }

            .momo-banner::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: radial-gradient(circle at 30% 40%, rgba(255,255,255,0.1) 0%, transparent 60%),
                    radial-gradient(circle at 70% 70%, rgba(255,255,255,0.08) 0%, transparent 50%);
                animation: floatPattern 15s ease-in-out infinite;
            }

            @keyframes floatPattern {
                0%, 100% {
                    transform: translate(0, 0) scale(1);
                }
                50% {
                    transform: translate(10px, -10px) scale(1.1);
                }
            }

            .momo-logo {
                width: 100px;
                height: 100px;
                background: white;
                border-radius: 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 30px;
                font-size: 3.5rem;
                font-weight: 900;
                color: #a50064;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
                position: relative;
                z-index: 1;
            }

            .momo-text {
                text-align: center;
                position: relative;
                z-index: 1;
            }

            .momo-text h3 {
                font-size: 1.5rem;
                font-weight: 800;
                margin-bottom: 15px;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .momo-text p {
                font-size: 0.95rem;
                opacity: 0.95;
                line-height: 1.6;
                margin-bottom: 8px;
            }

            .momo-cta {
                background: white;
                color: #a50064;
                padding: 12px 30px;
                border-radius: 30px;
                font-weight: 700;
                margin-top: 30px;
                font-size: 1rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                position: relative;
                z-index: 1;
            }

            /* Netflix Banner */
            .netflix-banner {
                background: linear-gradient(135deg, #000000 0%, #141414 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 20px;
                text-decoration: none;
                color: white;
                position: relative;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }

            .netflix-banner::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(229, 9, 20, 0.15) 0%, transparent 70%);
                animation: rotate 20s linear infinite;
            }

            @keyframes rotate {
                from {
                    transform: rotate(0deg);
                }
                to {
                    transform: rotate(360deg);
                }
            }

            .netflix-logo {
                width: 140px;
                height: 45px;
                background: #E50914;
                border-radius: 6px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 35px;
                font-size: 2.5rem;
                font-weight: 900;
                color: white;
                letter-spacing: -2px;
                box-shadow: 0 6px 20px rgba(229, 9, 20, 0.6);
                position: relative;
                z-index: 1;
            }

            .netflix-text {
                text-align: center;
                position: relative;
                z-index: 1;
            }

            .netflix-text h3 {
                font-size: 1.4rem;
                font-weight: 800;
                margin-bottom: 18px;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
            }

            .netflix-text p {
                font-size: 0.95rem;
                opacity: 0.9;
                line-height: 1.6;
                margin-bottom: 10px;
            }

            .netflix-cta {
                background: #E50914;
                color: white;
                padding: 12px 30px;
                border-radius: 6px;
                font-weight: 700;
                margin-top: 35px;
                font-size: 1rem;
                box-shadow: 0 4px 15px rgba(229, 9, 20, 0.5);
                position: relative;
                z-index: 1;
            }

            .banner-shine {
                position: absolute;
                top: -100%;
                left: -100%;
                width: 300%;
                height: 300%;
                background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
                animation: shine 3s infinite;
                pointer-events: none;
            }

            @keyframes shine {
                0% {
                    transform: translateX(-100%) translateY(-100%);
                }
                100% {
                    transform: translateX(100%) translateY(100%);
                }
            }

            /* Content wrapper */
            .content-wrapper {
                position: relative;
                z-index: 10;
                margin-left: 200px;
                margin-right: 200px;
                transition: margin 0.3s ease;
            }

            /* Hero Section */
            .hero-section {
                text-align: center;
                padding: 5rem 2rem 3rem;
                margin-top: 0;
            }

            .hero-section h1 {
                font-size: 3.5rem;
                font-weight: 900;
                background: linear-gradient(135deg, #ffffff 0%, #f0f0f0 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
                line-height: 1.2;
                animation: fadeInDown 0.8s ease;
                text-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            @keyframes fadeInDown {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .hero-section p {
                font-size: 1.2rem;
                color: rgba(255, 255, 255, 0.95);
                margin-bottom: 2.5rem;
                max-width: 700px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.8;
                animation: fadeInUp 0.8s ease 0.2s backwards;
                font-weight: 400;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Filter Section */
            .filter-section {
                padding: 0 2rem 2rem;
            }

            .filter-form {
                background: rgba(255, 255, 255, 0.08);
                backdrop-filter: blur(20px);
                border-radius: 24px;
                padding: 2rem;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                max-width: 1400px;
                margin: 0 auto;
                animation: slideUp 0.8s ease;
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .filter-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 1.5rem;
            }

            .filter-icon {
                width: 45px;
                height: 45px;
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.1rem;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4);
            }

            .filter-header h4 {
                font-size: 1.4rem;
                font-weight: 700;
                color: #ffffff;
                margin: 0;
            }

            /* Filter Grid */
            .filter-grid {
                display: grid;
                grid-template-columns: 2fr 1.5fr 1.5fr 2.5fr 1fr;
                gap: 1.2rem;
                align-items: end;
            }

            .filter-grid-row2 {
                display: grid;
                grid-template-columns: 1.5fr 1.5fr auto;
                gap: 1.2rem;
                align-items: end;
                margin-top: 1.2rem;
            }

            .form-label {
                font-size: 0.85rem;
                font-weight: 600;
                color: #e2e8f0;
                margin-bottom: 0.5rem;
                display: block;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-control,
            .form-select {
                background-color: rgba(255, 255, 255, 0.1);
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                color: #ffffff;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                width: 100%;
                font-weight: 500;
            }

            .form-control:focus,
            .form-select:focus {
                background-color: rgba(255, 255, 255, 0.15);
                border-color: #c471f5;
                box-shadow: 0 0 0 4px rgba(196, 113, 245, 0.2);
                outline: none;
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-select option {
                background-color: #1a0b2e;
                color: #fff;
            }

            /* Salary inputs */
            .salary-wrapper {
                display: flex;
                gap: 0.75rem;
                align-items: center;
            }

            .salary-wrapper .form-control {
                flex: 1;
            }

            .salary-separator {
                color: #e2e8f0;
                font-weight: 700;
                font-size: 1.1rem;
            }

            /* Search Button */
            .search-button {
                background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
                border: none;
                border-radius: 12px;
                color: #fff;
                padding: 0.75rem 2rem;
                font-weight: 600;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 6px 20px rgba(196, 113, 245, 0.4);
                white-space: nowrap;
            }

            .search-button:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 30px rgba(196, 113, 245, 0.6);
            }

            .search-button:active {
                transform: translateY(-1px);
            }

            .search-button i {
                font-size: 1.2rem;
            }

            /* Content Section */
            .content-section {
                padding: 3rem 2rem;
                max-width: 1400px;
                margin: 0 auto;
            }

            /* Job Cards Grid */
            .jobs-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 2rem;
                margin-top: 2rem;
            }

            /* Job Card */
            .job-card {
                background: rgba(255, 255, 255, 0.08);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                padding: 1.8rem;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                cursor: pointer;
                position: relative;
                overflow: hidden;
                border: 2px solid rgba(255, 255, 255, 0.1);
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .job-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, #c471f5, #fa71cd);
                transform: scaleX(0);
                transform-origin: left;
                transition: transform 0.4s ease;
            }

            .job-card:hover::before {
                transform: scaleX(1);
            }

            .job-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 25px 60px rgba(196, 113, 245, 0.3);
                border-color: #c471f5;
            }

            .job-card-link {
                text-decoration: none;
                color: inherit;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .card-title {
                font-size: 1.3rem;
                font-weight: 700;
                color: #ffffff;
                margin-bottom: 1.2rem;
                line-height: 1.4;
                transition: color 0.3s ease;
            }

            .job-card:hover .card-title {
                color: #c471f5;
            }

            /* Job Meta Info */
            .job-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 0.6rem;
                margin-bottom: 1rem;
            }

            .badge {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 25px;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .bg-primary {
                background: linear-gradient(135deg, #7ee8fa, #80d0c7) !important;
                color: #000 !important;
            }

            .bg-success {
                background: linear-gradient(135deg, #39ff14, #7ee8fa) !important;
                color: #000 !important;
            }

            .text-muted {
                color: #b8b8d1 !important;
                font-size: 0.9rem;
                margin-top: auto;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 5rem 2rem;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 24px;
                max-width: 600px;
                margin: 2rem auto;
                border: 2px solid rgba(196, 113, 245, 0.3);
            }

            .empty-state-icon {
                width: 120px;
                height: 120px;
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 2rem;
                box-shadow: 0 10px 30px rgba(196, 113, 245, 0.4);
            }

            .empty-state-icon i {
                font-size: 3.5rem;
                color: white;
            }

            .empty-state h4 {
                color: #ffffff;
                font-weight: 700;
                font-size: 1.6rem;
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #b8b8d1;
                font-size: 1.05rem;
                line-height: 1.6;
            }

            /* Pagination */
            .pagination {
                display: flex;
                gap: 0.6rem;
                justify-content: center;
                margin-top: 3rem;
            }

            .page-item .page-link {
                background: rgba(255, 255, 255, 0.08);
                border: 2px solid rgba(255, 255, 255, 0.15);
                border-radius: 12px;
                color: #ffffff;
                padding: 0.6rem 1.1rem;
                font-weight: 600;
                transition: all 0.3s ease;
                min-width: 45px;
                text-align: center;
            }

            .page-item .page-link:hover {
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border-color: transparent;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4);
            }

            .page-item.active .page-link {
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border-color: transparent;
                color: white;
                box-shadow: 0 4px 15px rgba(196, 113, 245, 0.4);
            }

            /* Back to Top Button */
            .back-to-top {
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                width: 55px;
                height: 55px;
                border-radius: 50%;
                background: linear-gradient(135deg, #c471f5, #fa71cd);
                border: none;
                color: white;
                font-size: 1.3rem;
                cursor: pointer;
                box-shadow: 0 6px 20px rgba(196, 113, 245, 0.5);
                transition: all 0.3s ease;
                opacity: 0;
                visibility: hidden;
                z-index: 1000;
            }

            .back-to-top.visible {
                opacity: 1;
                visibility: visible;
            }

            .back-to-top:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(196, 113, 245, 0.7);
            }

            /* Hide banners on smaller screens */
            @media (max-width: 1600px) {
                .side-banner {
                    display: none;
                }

                .content-wrapper {
                    margin-left: 0;
                    margin-right: 0;
                }
            }

            /* Responsive Design */
            @media (max-width: 1200px) {
                .filter-grid {
                    grid-template-columns: 1fr 1fr 1fr;
                }

                .filter-grid-row2 {
                    grid-template-columns: 1fr 1fr;
                }

                .jobs-grid {
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                }
            }

            @media (max-width: 768px) {
                .hero-section {
                    padding: 4rem 1.5rem 2rem;
                }

                .hero-section h1 {
                    font-size: 2.5rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .filter-form {
                    padding: 1.5rem;
                }

                .filter-grid,
                .filter-grid-row2 {
                    grid-template-columns: 1fr;
                }

                .search-button {
                    width: 100%;
                }

                .jobs-grid {
                    grid-template-columns: 1fr;
                    gap: 1.5rem;
                }

                .pixel-decoration {
                    display: none;
                }

                .back-to-top {
                    bottom: 1rem;
                    right: 1rem;
                    width: 50px;
                    height: 50px;
                    font-size: 1.2rem;
                }
            }

            @media (max-width: 480px) {
                .hero-section h1 {
                    font-size: 2rem;
                }

                .filter-form {
                    padding: 1rem;
                }

                .filter-header h4 {
                    font-size: 1.2rem;
                }

                .card-title {
                    font-size: 1.1rem;
                }
            }
            /* =========================
   FILTER UI IMPROVEMENTS
   ========================= */

            .filter-grid > div,
            .filter-grid-row2 > div {
                width: 100%;
            }

            .filter-grid {
                grid-template-columns: repeat(5, 1fr);
            }

            .filter-grid-row2 {
                grid-template-columns: repeat(3, 1fr);
            }

            /* Make all inputs same height */
            .form-control,
            .form-select {
                height: 48px;
            }

            /* Salary inputs aligned like others */
            .salary-wrapper {
                display: grid;
                grid-template-columns: 1fr auto 1fr;
                gap: 0.6rem;
            }

            .salary-separator {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 48px;
                font-weight: 700;
                color: #fff;
                opacity: 0.8;
            }

            /* Currency same width as others */
            .filter-grid .col-md-2 {
                width: 100%;
            }

            /* Search button align bottom */
            .filter-grid-row2 button.search-button {
                height: 48px;
                width: 100%;
            }

            /* Smooth hover for filter box */
            .filter-form:hover {
                box-shadow: 0 25px 80px rgba(196, 113, 245, 0.35);
            }

            /* Responsive fix */
            @media (max-width: 1200px) {
                .filter-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .filter-grid-row2 {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

        </style>
    </head>
    <body>
        <!-- Side Banners -->


        <!-- Stars Background -->
        <div class="stars" id="stars"></div>

        <!-- Floating Decorations -->
        <div class="pixel-decoration deco-1">✨</div>
        <div class="pixel-decoration deco-2">💎</div>
        <div class="pixel-decoration deco-3">🚀</div>

        <div class="content-wrapper">
            <!-- Header -->
            <jsp:include page="../common/user/header-user.jsp"/>

            <!-- Hero Section -->
            <section class="hero-section">
                <h1>Tìm Công Việc Mơ Ước<br>Của Bạn</h1>
                <p>Khám phá hàng nghìn cơ hội việc làm từ các công ty hàng đầu. Bắt đầu hành trình sự nghiệp của bạn ngay hôm nay!</p>
            </section>

            <!-- Filter Section -->
            <section class="filter-section">
                <div class="filter-form">
                    <div class="filter-header">
                        <div class="filter-icon">
                            <i class="fas fa-sliders-h"></i>
                        </div>
                        <h4>Bộ Lọc Tìm Kiếm</h4>
                    </div>

                    <form action="HomeSeeker" method="GET" id="filterForm">
                        <!-- First Row -->
                        <div class="filter-grid">
                            <!-- Search -->
                            <div>
                                <label class="form-label">Tìm kiếm</label>
                                <input type="text" name="search" class="form-control" 
                                       placeholder="Nhập vị trí công việc..." value="${param.search}">
                            </div>

                            <!-- Category -->
                            <div>
                                <label class="form-label">Ngành nghề</label>
                                <select name="filterCategory" class="form-select">
                                    <option value="">Tất cả</option>
                                    <c:forEach var="category" items="${activeCategories}">
                                        <option value="${category.getId()}"
                                                ${category.getId() == param.filterCategory ? 'selected' : ''}>
                                            ${category.getName()}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Location -->
                            <div>
                                <label class="form-label">Địa điểm</label>
                                <input type="text"
                                       name="filterLocation"
                                       class="form-control"
                                       placeholder="Nhập địa điểm..."
                                       value="${param.filterLocation}">
                            </div>


                            <!-- Salary Range -->
                            <div>
                                <label class="form-label">Mức lương</label>
                                <div class="salary-wrapper">
                                    <input type="number" name="minSalary" class="form-control" 
                                           placeholder="Từ" value="${param.minSalary}" min="0" step="100">
                                    <span class="salary-separator">-</span>
                                    <input type="number" name="maxSalary" class="form-control" 
                                           placeholder="Đến" value="${param.maxSalary}" min="0" step="100">
                                </div>
                            </div>

                            <!-- Currency -->
                            <div class="col-md-2">
                                <label class="form-label">Loại Tiền</label>
                                <select class="form-select"
                                        name="filterCurrency">


                                    <option value="all"
                                            ${param.filterCurrency == 'all' || param.filterCurrency == null || param.filterCurrency == '' ? 'selected' : ''}>
                                        Tất Cả
                                    </option>

                                    <option value="VND" ${param.filterCurrency == 'VND' ? 'selected' : ''}>VND (₫)</option>
                                    <option value="USD" ${param.filterCurrency == 'USD' ? 'selected' : ''}>USD ($)</option>
                                    <option value="EUR" ${param.filterCurrency == 'EUR' ? 'selected' : ''}>EUR (€)</option>
                                    <option value="GBP" ${param.filterCurrency == 'GBP' ? 'selected' : ''}>GBP (£)</option>
                                    <option value="JPY" ${param.filterCurrency == 'JPY' ? 'selected' : ''}>JPY (¥)</option>
                                    <option value="AUD" ${param.filterCurrency == 'AUD' ? 'selected' : ''}>AUD (A$)</option>
                                    <option value="CAD" ${param.filterCurrency == 'CAD' ? 'selected' : ''}>CAD (C$)</option>
                                </select>
                            </div>

                        </div>

                        <!-- Second Row -->
                        <div class="filter-grid-row2">
                            <!-- Date From -->
                            <!-- Date From -->
                            <div>
                                <label class="form-label">Từ ngày</label>
                                <input type="date" id="dateFrom" name="dateFrom" class="form-control" value="${param.dateFrom}">
                            </div>

                            <!-- Date To -->
                            <div>
                                <label class="form-label">Đến ngày</label>
                                <input type="date" id="dateTo" name="dateTo" class="form-control" value="${param.dateTo}">
                            </div>


                            <!-- Search Button -->
                            <div>
                                <button type="submit" class="search-button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <div id="date-error" class="alert alert-danger" style="display:none; margin-top:10px;">
                            Từ ngày không được lớn hơn đến ngày
                        </div>
                    </form>
                </div>
            </section>

            <!-- Job Listings Section -->
            <section class="content-section">
                <c:choose>
                    <c:when test="${empty jobPostingsList}">
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <h4>Không tìm thấy công việc</h4>
                            <p>Hãy thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn để tìm thêm cơ hội việc làm phù hợp</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="jobs-grid">
                            <c:forEach var="job" items="${jobPostingsList}">
                                <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${job.getJobPostingID()}" 
                                   class="job-card-link">
                                    <div class="job-card">
                                        <h5 class="card-title">${job.getTitle()}</h5>

                                        <div class="job-meta">
                                            <span class="badge bg-primary">
                                                <i class="fas fa-map-marker-alt"></i>
                                                ${job.getLocation()}
                                            </span>
                                            <span class="badge bg-success">
                                                <i class="fas fa-dollar-sign"></i>
                                                ${job.getMinSalary()} - ${job.getMaxSalary()} ${job.getCurrency()}
                                            </span>
                                        </div>

                                        <p class="text-muted">
                                            <i class="far fa-clock"></i>
                                            Đăng: ${job.getPostedDate()}
                                        </p>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${not empty jobPostingsList}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:if test="${pageControl.getPage() > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                                    <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Footer -->
            <jsp:include page="../common/footer.jsp"/>
        </div>


        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script>
            // Generate stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                if (!starsContainer)
                    return;

                const numberOfStars = 100;
                for (let i = 0; i < numberOfStars; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 3 + 's';
                    starsContainer.appendChild(star);
                }
            }
            createStars();

            // Back to top button (GUARD NULL)
            const backToTopButton = document.getElementById('back-to-top');
            if (backToTopButton) {
                window.addEventListener('scroll', () => {
                    if (window.pageYOffset > 300)
                        backToTopButton.classList.add('visible');
                    else
                        backToTopButton.classList.remove('visible');
                });

                backToTopButton.addEventListener('click', () => {
                    window.scrollTo({top: 0, behavior: 'smooth'});
                });
            }

            ;
            (function () {
                const form = document.getElementById("filterForm");
                const dateFromEl = document.getElementById("dateFrom");
                const dateToEl = document.getElementById("dateTo");
                const dateErrorEl = document.getElementById("date-error");

                function toggleError(show) {
                    if (!dateErrorEl)
                        return;
                    dateErrorEl.style.display = show ? "block" : "none";
                }

                function validateDateRange() {
                    const from = dateFromEl ? dateFromEl.value : "";
                    const to = dateToEl ? dateToEl.value : "";

                    if (!from || !to) {
                        toggleError(false);
                        return true;
                    }

                    // yyyy-MM-dd so sánh string OK
                    if (from > to) {
                        toggleError(true);
                        return false;
                    }

                    toggleError(false);
                    return true;
                }

                if (form) {
                    form.addEventListener("submit", function (e) {
                        if (!validateDateRange()) {
                            e.preventDefault();
                            if (dateErrorEl)
                                dateErrorEl.scrollIntoView({behavior: "smooth", block: "center"});
                        }
                    });
                }

                if (dateFromEl)
                    dateFromEl.addEventListener("change", validateDateRange);
                if (dateToEl)
                    dateToEl.addEventListener("change", validateDateRange);

                // ✅ Nếu reload trang với URL đã sai (dateFrom > dateTo) thì vẫn hiện luôn
                validateDateRange();
            })();
        </script>


    </body>
</html>
