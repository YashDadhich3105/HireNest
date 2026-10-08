<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HireNest | Your Career Starts Here</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: Inter, "Segoe UI", Arial, sans-serif;
            background:
                radial-gradient(circle at 10% 10%, rgba(56, 189, 248, 0.12), transparent 28%),
                radial-gradient(circle at 90% 20%, rgba(139, 92, 246, 0.12), transparent 30%),
                linear-gradient(135deg, #07111f, #0f1c31 50%, #17243a);
            color: #f8fafc;
            min-height: 100vh;
            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: rgba(56, 189, 248, 0.07);
            filter: blur(80px);
            top: 10%;
            left: -150px;
            pointer-events: none;
        }

        body::after {
            content: "";
            position: fixed;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: rgba(139, 92, 246, 0.07);
            filter: blur(90px);
            bottom: 5%;
            right: -160px;
            pointer-events: none;
        }

        .navbar {
            width: 100%;
            height: 78px;
            padding: 0 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            z-index: 10;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            background: rgba(7, 17, 31, 0.65);
            backdrop-filter: blur(18px);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #38bdf8, #6366f1);
            box-shadow: 0 8px 25px rgba(56, 189, 248, 0.25);
        }

        .brand-icon svg {
            width: 23px;
            height: 23px;
            stroke: white;
        }

        .brand-name {
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .brand-name span {
            color: #38bdf8;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 9px;
            color: #94a3b8;
            font-size: 13px;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #22c55e;
            box-shadow: 0 0 12px rgba(34, 197, 94, 0.8);
        }

        .hero {
            width: 86%;
            max-width: 1250px;
            min-height: calc(100vh - 78px);
            margin: auto;
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
            align-items: center;
            gap: 80px;
            padding: 70px 0 55px;
            position: relative;
            z-index: 1;
        }

        .hero-content {
            animation: fadeUp 0.8s ease forwards;
        }

        .badge {
            width: fit-content;
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 9px 15px;
            border: 1px solid rgba(56, 189, 248, 0.22);
            background: rgba(56, 189, 248, 0.07);
            border-radius: 999px;
            color: #7dd3fc;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.4px;
            margin-bottom: 25px;
        }

        .badge svg {
            width: 15px;
            height: 15px;
        }

        .hero h1 {
            font-size: clamp(48px, 6vw, 78px);
            line-height: 0.98;
            letter-spacing: -4px;
            margin-bottom: 27px;
        }

        .hero h1 .gradient {
            background: linear-gradient(90deg, #38bdf8, #818cf8, #a78bfa);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .hero-description {
            max-width: 650px;
            color: #a9b7ca;
            font-size: 18px;
            line-height: 1.75;
            margin-bottom: 34px;
        }

        .buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
            margin-bottom: 40px;
        }

        .btn {
            min-width: 165px;
            height: 53px;
            padding: 0 22px;
            border-radius: 13px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 14px;
            font-weight: 750;
            transition: all 0.3s ease;
        }

        .btn svg {
            width: 18px;
            height: 18px;
        }

        .btn-primary {
            color: #031525;
            background: linear-gradient(135deg, #38bdf8, #22d3ee);
            box-shadow: 0 12px 30px rgba(34, 211, 238, 0.17);
        }

        .btn-primary:hover {
            transform: translateY(-4px);
            box-shadow: 0 18px 38px rgba(34, 211, 238, 0.28);
        }

        .btn-secondary {
            color: #f8fafc;
            border: 1px solid rgba(148, 163, 184, 0.28);
            background: rgba(255, 255, 255, 0.045);
        }

        .btn-secondary:hover {
            transform: translateY(-4px);
            border-color: rgba(56, 189, 248, 0.45);
            background: rgba(56, 189, 248, 0.08);
        }

        .mini-stats {
            display: flex;
            gap: 30px;
        }

        .stat {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .stat strong {
            font-size: 22px;
        }

        .stat span {
            color: #718198;
            font-size: 12px;
        }

        .divider {
            width: 1px;
            height: 35px;
            background: rgba(255, 255, 255, 0.12);
        }

        .dashboard-card {
            position: relative;
            padding: 25px;
            border-radius: 28px;
            background: linear-gradient(
                145deg,
                rgba(255, 255, 255, 0.11),
                rgba(255, 255, 255, 0.045)
            );
            border: 1px solid rgba(255, 255, 255, 0.13);
            box-shadow:
                0 30px 70px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(25px);
            animation: floating 5s ease-in-out infinite;
        }

        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .card-title-icon {
            width: 39px;
            height: 39px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 11px;
            background: rgba(56, 189, 248, 0.12);
            color: #38bdf8;
        }

        .card-title-icon svg {
            width: 20px;
            height: 20px;
        }

        .card-title strong {
            font-size: 16px;
        }

        .live {
            display: flex;
            align-items: center;
            gap: 7px;
            color: #86efac;
            font-size: 11px;
            font-weight: 700;
        }

        .live-dot {
            width: 7px;
            height: 7px;
            background: #22c55e;
            border-radius: 50%;
            box-shadow: 0 0 10px #22c55e;
        }

        .match-box {
            padding: 22px;
            border-radius: 18px;
            background: rgba(4, 13, 27, 0.45);
            border: 1px solid rgba(255, 255, 255, 0.07);
            margin-bottom: 13px;
        }

        .match-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .company {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .company-logo {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
        }

        .company-logo svg {
            width: 19px;
            height: 19px;
            stroke: white;
        }

        .company-info strong {
            display: block;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .company-info span {
            color: #718198;
            font-size: 11px;
        }

        .match-percent {
            font-size: 17px;
            font-weight: 800;
            color: #67e8f9;
        }

        .progress {
            height: 7px;
            background: #1e293b;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress span {
            display: block;
            height: 100%;
            width: 92%;
            border-radius: inherit;
            background: linear-gradient(90deg, #38bdf8, #818cf8);
        }

        .match-label {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            color: #718198;
            font-size: 10px;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-top: 14px;
        }

        .feature {
            padding: 17px;
            border-radius: 17px;
            background: rgba(255, 255, 255, 0.035);
            border: 1px solid rgba(255, 255, 255, 0.06);
            transition: 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-4px);
            background: rgba(56, 189, 248, 0.07);
            border-color: rgba(56, 189, 248, 0.18);
        }

        .feature-icon {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 11px;
            background: rgba(56, 189, 248, 0.1);
            color: #67e8f9;
            margin-bottom: 12px;
        }

        .feature-icon svg {
            width: 19px;
            height: 19px;
        }

        .feature strong {
            display: block;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .feature small {
            color: #718198;
            font-size: 10px;
            line-height: 1.5;
        }

        .footer {
            text-align: center;
            padding: 22px;
            color: #5f7088;
            font-size: 12px;
            position: relative;
            z-index: 2;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(25px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes floating {
            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-8px);
            }
        }

        @media (max-width: 950px) {
            .hero {
                grid-template-columns: 1fr;
                gap: 55px;
                padding-top: 60px;
            }

            .hero-content {
                text-align: center;
            }

            .badge,
            .buttons {
                margin-left: auto;
                margin-right: auto;
            }

            .hero-description {
                margin-left: auto;
                margin-right: auto;
            }

            .mini-stats {
                justify-content: center;
            }

            .dashboard-card {
                max-width: 560px;
                width: 100%;
                margin: auto;
            }
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 0 20px;
            }

            .nav-right {
                display: none;
            }

            .hero {
                width: 90%;
                padding-top: 45px;
            }

            .hero h1 {
                font-size: 49px;
                letter-spacing: -2.5px;
            }

            .hero-description {
                font-size: 15px;
            }

            .buttons {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
            }

            .mini-stats {
                gap: 17px;
            }

            .dashboard-card {
                padding: 18px;
                border-radius: 22px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">

        <div class="brand">

            <div class="brand-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 7.5h16v12H4z"/>
                    <path d="M8 7.5V5.8A1.8 1.8 0 0 1 9.8 4h4.4A1.8 1.8 0 0 1 16 5.8v1.7"/>
                    <path d="M4 11h16"/>
                    <path d="M10 15h4"/>
                </svg>
            </div>

            <div class="brand-name">
                Hire<span>Nest</span>
            </div>

        </div>

        <div class="nav-right">
            <span class="status-dot"></span>
            Placement platform
        </div>

    </nav>


    <main class="hero">

        <section class="hero-content">

            <div class="badge">

                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 3l2.5 5.5L20 11l-5.5 2.5L12 19l-2.5-5.5L4 11l5.5-2.5L12 3z"/>
                </svg>

                SMART PLACEMENT & RECRUITMENT
            </div>

            <h1>
                Build your future.<br>
                <span class="gradient">Find your opportunity.</span>
            </h1>

            <p class="hero-description">
                HireNest brings students and companies together through
                smarter job discovery, resume analysis and skill-based
                career matching.
            </p>

            <div class="buttons">

                <a href="student-login.jsp" class="btn btn-primary">

                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="8" r="3"/>
                        <path d="M5 20c.7-3.4 3-5 7-5s6.3 1.6 7 5"/>
                    </svg>

                    Student Login

                </a>

                <a href="company-login.jsp" class="btn btn-secondary">

                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="7" width="18" height="13" rx="2"/>
                        <path d="M8 7V5h8v2"/>
                        <path d="M3 12h18"/>
                        <path d="M10 12v2h4v-2"/>
                    </svg>

                    Company Login

                </a>

            </div>

            <div class="mini-stats">

                <div class="stat">
                    <strong>01</strong>
                    <span>Smart Platform</span>
                </div>

                <div class="divider"></div>

                <div class="stat">
                    <strong>02</strong>
                    <span>User Portals</span>
                </div>

                <div class="divider"></div>

                <div class="stat">
                    <strong>∞</strong>
                    <span>Opportunities</span>
                </div>

            </div>

        </section>


        <section class="dashboard-card">

            <div class="card-header">

                <div class="card-title">

                    <div class="card-title-icon">

                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 19V5"/>
                            <path d="M4 19h16"/>
                            <path d="M7 15l3-4 3 2 5-7"/>
                        </svg>

                    </div>

                    <strong>HireNest Intelligence</strong>

                </div>

                <div class="live">
                    <span class="live-dot"></span>
                    ACTIVE
                </div>

            </div>


            <div class="match-box">

                <div class="match-top">

                    <div class="company">

                        <div class="company-logo">

                            <svg viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <path d="M3 21h18"/>
                                <path d="M5 21V5l7-3 7 3v16"/>
                                <path d="M9 9h1"/>
                                <path d="M14 9h1"/>
                                <path d="M9 13h1"/>
                                <path d="M14 13h1"/>
                                <path d="M10 21v-4h4v4"/>
                            </svg>

                        </div>

                        <div class="company-info">
                            <strong>Software Developer</strong>
                            <span>Technology Opportunity</span>
                        </div>

                    </div>

                    <div class="match-percent">
                        92%
                    </div>

                </div>

                <div class="progress">
                    <span></span>
                </div>

                <div class="match-label">
                    <span>Resume compatibility</span>
                    <span>Strong match</span>
                </div>

            </div>


            <div class="feature-grid">

                <div class="feature">

                    <div class="feature-icon">

                        <svg viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="8" r="3"/>
                            <path d="M3 20c.7-3.2 2.7-5 6-5"/>
                            <path d="M16 11a3 3 0 1 0 0-6"/>
                            <path d="M15 15c3.1.2 5 1.8 6 5"/>
                        </svg>

                    </div>

                    <strong>Student Portal</strong>
                    <small>Discover relevant opportunities.</small>

                </div>


                <div class="feature">

                    <div class="feature-icon">

                        <svg viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="7" width="18" height="13" rx="2"/>
                            <path d="M8 7V5h8v2"/>
                            <path d="M3 12h18"/>
                        </svg>

                    </div>

                    <strong>Company Portal</strong>
                    <small>Connect with potential talent.</small>

                </div>


                <div class="feature">

                    <div class="feature-icon">

                        <svg viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round">
                            <path d="M6 2h9l5 5v15H6z"/>
                            <path d="M14 2v6h6"/>
                            <path d="M9 13h6"/>
                            <path d="M9 17h4"/>
                        </svg>

                    </div>

                    <strong>Resume Analyzer</strong>
                    <small>Analyze your resume for roles.</small>

                </div>


                <div class="feature">

                    <div class="feature-icon">

                        <svg viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round">
                            <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/>
                        </svg>

                    </div>

                    <strong>Career Growth</strong>
                    <small>Move closer to your goals.</small>

                </div>

            </div>

        </section>

    </main>


    <footer class="footer">
        © 2026 HireNest · Smart Placement & Recruitment Platform
    </footer>

</body>

</html>