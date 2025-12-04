<footer class="rts__section footer__home__one" style="background-color: #495057; color: #f8f9fa; border-top: 5px solid #28a745;">
    <div class="container">
        <div class="row">
            <div class="footer__wrapper d-flex flex-wrap justify-content-between pt-60 pb-60">
                <div class="rts__footer__widget text-center text-md-start mb-4 mt-3">
                    <a href="index.html" class="footer__logo" aria-label="logo">
                        <img src="${pageContext.request.contextPath}/assets/img/logo/header__one_dark.svg" width="160" height="40" alt="logo">
                    </a>
                    <p class="mt-3">Your trusted platform for job seekers and employers.</p>
                </div>

                <div class="rts__footer__widget mb-4">
                    <div class="font-20 fw-medium mb-3 h6">Contact Us</div>
                    <ul class="list-unstyled mb-3">
                        <li><a href="#" style="color: #f8f9fa; text-decoration: none" class="footer-link"><i class="fa-light fa-location-dot"></i> Thach That district, Ha Noi city</a></li>
                        <li><a href="callto:+880171234578" style="color: #f8f9fa; text-decoration: none" class="footer-link"><i class="fa-light fa-phone"></i> +(61) 545-432-234</a></li>
                        <li><a href="mailto:vanctquantrivien@gmail.com" style="color: #f8f9fa; text-decoration: none" class="footer-link"><i class="fa-light fa-envelope"></i> vanctquantrivien@gmail.com</a></li>
                    </ul>
                </div>

                <!--                <div class="rts__footer__widget mb-4">
                                    <div class="font-20 fw-medium mb-3 h6">Quick Links</div>
                                    <ul class="list-unstyled">
                                        <li><a href="job-list-1.html" aria-label="footer__menu__link" style="color: #f8f9fa;" class="footer-link">Browse Jobs</a></li>
                                        <li><a href="candidate-1.html" aria-label="footer__menu__link" style="color: #f8f9fa;" class="footer-link">Browse Candidates</a></li>
                                        <li><a href="blog-1.html" aria-label="footer__menu__link" style="color: #f8f9fa;" class="footer-link">Blog & News</a></li>
                                        <li><a href="faq.html" aria-label="footer__menu__link" style="color: #f8f9fa;" class="footer-link">FAQ</a></li>
                                        <li><a href="#" aria-label="footer__menu__link" style="color: #f8f9fa;" class="footer-link">Job Alerts</a></li>
                                    </ul>
                                </div>-->
            </div>
        </div>
    </div>
    <div class="rts__copyright" style="background-color: #6c757d; border-top: 1px solid #28a745;">
        <div class="container">
            <p class="text-center fw-medium py-4 mb-0">
                Copyright &copy; 2024 All Rights Reserved by Group 4 - SE1868-NJ
            </p>
        </div>
    </div>
</footer>

<style>
    /* Ensures the page-wrapper takes up at least 100% of the viewport height */
    html, body {
        height: 100%;
        margin: 0;
    }

    .page-wrapper {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .content {
        flex: 1; /* This makes the main content area grow to fill space */
    }

    .rts__section.footer__home__one {
        background-color: #495057;
        color: #f8f9fa;
        border-top: 5px solid #28a745;
    }

    .footer__wrapper {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        padding-top: 60px;
        padding-bottom: 60px;
    }

    .footer__link {
        transition: color 0.3s ease, transform 0.3s ease;
    }

    .footer__link:hover {
        color: #28a745;
        transform: scale(1.05);
    }

    @media (max-width: 768px) {
        .footer__wrapper {
            flex-direction: column;
            align-items: center;
        }
    }

</style>
