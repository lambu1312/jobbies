<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-wrapper">
                <div class="footer-section">
                    <div class="footer-logo">JOBBIES</div>
                    <p class="footer-description">Your trusted platform for finding the perfect job and building your
                        future 🚀</p>
                    <div class="social-links">
                        <a href="#" class="social-link" aria-label="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="Twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="LinkedIn">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </div>
                </div>

                <div class="footer-section">
                    <h4 class="footer-title">Contact Us</h4>
                    <ul class="footer-links">
                        <li>
                            <a href="#" class="footer-link">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>Thach That district, Ha Noi city</span>
                            </a>
                        </li>
                        <li>
                            <a href="tel:+840123456789" class="footer-link">
                                <i class="fas fa-phone"></i>
                                <span>+(84) 012-345-6789</span>
                            </a>
                        </li>
                        <li>
                            <a href="mailto:cthang998@gmail.com" class="footer-link">
                                <i class="fas fa-envelope"></i>
                                <span>cthang998@gmail.com</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4 class="footer-title">Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/home" class="footer-link">Browse Jobs</a></li>
                        <li><a href="#" class="footer-link">For Employers</a></li>
                        <li><a href="#" class="footer-link">About Us</a></li>
                        <li><a href="#" class="footer-link">Blog & News</a></li>
                        <li><a href="#" class="footer-link">Contact</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4 class="footer-title">Resources</h4>
                    <ul class="footer-links">
                        <li><a href="#" class="footer-link">Career Advice</a></li>
                        <li><a href="#" class="footer-link">Job Alerts</a></li>
                        <li><a href="#" class="footer-link">FAQ</a></li>
                        <li><a href="#" class="footer-link">Privacy Policy</a></li>
                        <li><a href="#" class="footer-link">Terms of Service</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="footer-copyright">
                <p>Copyright © 2025 All Rights Reserved by <span class="gradient-text">Group 3 - SWP391.M.BL5</span></p>
                <p class="made-with">Made with 💜 and ✨</p>
            </div>
        </div>
                        
    </footer>
                        
                        

    <style>
        .footer {
            position: relative;
            z-index: 10;
            margin-top: 4rem;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(30px);
            border-top: 2px solid rgba(196, 113, 245, 0.3);
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .footer-wrapper {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
        }

        .footer-section {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer-logo {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, #c471f5 0%, #fa71cd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }

        .footer-description {
            color: #b8b8d1;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }

        .social-links {
            display: flex;
            gap: 1rem;
        }

        .social-link {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s;
        }

        .social-link:hover {
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            border-color: transparent;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(196, 113, 245, 0.4);
            color: #fff;
        }

        .footer-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #fff 0%, #c471f5 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 0.8rem;
        }

        .footer-link {
            color: #b8b8d1;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .footer-link:hover {
            color: #c471f5;
            transform: translateX(5px);
            text-shadow: 0 0 10px rgba(196, 113, 245, 0.5);
        }

        .footer-link i {
            font-size: 0.9rem;
            width: 20px;
        }

        .footer-bottom {
            background: rgba(0, 0, 0, 0.2);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.5rem 2rem;
        }

        .footer-copyright {
            max-width: 1400px;
            margin: 0 auto;
            text-align: center;
            color: #b8b8d1;
            font-size: 0.9rem;
        }

        .footer-copyright p {
            margin: 0.3rem 0;
        }

        .gradient-text {
            background: linear-gradient(135deg, #c471f5, #fa71cd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
        }

        .made-with {
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }

        @media (max-width: 768px) {
            .footer-wrapper {
                grid-template-columns: 1fr;
                gap: 2rem;
                text-align: center;
            }

            .social-links {
                justify-content: center;
            }

            .footer-link {
                justify-content: center;
            }

            .footer-link:hover {
                transform: translateX(0) scale(1.05);
            }
        }
    </style>

    <!-- Chatbot Widget -->
    <%@ include file="chatbot-component.jsp" %>
  