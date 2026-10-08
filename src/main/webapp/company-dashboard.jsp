<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object companyId = session.getAttribute("companyId");
    String companyEmail = (String) session.getAttribute("companyEmail");

    if (companyId == null) {
        response.sendRedirect("company-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Company Dashboard | HireNest</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #07111f;
            color: #f8fafc;
        }

        .layout {
            min-height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 260px;
            background: #0b1628;
            border-right: 1px solid rgba(255,255,255,.08);
            padding: 28px 18px;
            display: flex;
            flex-direction: column;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 0 12px;
            margin-bottom: 45px;
            font-size: 23px;
            font-weight: 800;
        }

        .logo-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg,#6366f1,#2563eb);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .menu-title {
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            padding: 0 12px;
            margin-bottom: 12px;
        }

        .nav {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .nav a {
            text-decoration: none;
            color: #94a3b8;
            padding: 13px 14px;
            border-radius: 11px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
            transition: .2s;
        }

        .nav a:hover,
        .nav a.active {
            background: rgba(99,102,241,.14);
            color: #fff;
        }

        .nav-icon {
            width: 24px;
            text-align: center;
        }

        .sidebar-bottom {
            margin-top: auto;
        }

        .profile-mini {
            padding: 15px;
            border-radius: 15px;
            background: rgba(255,255,255,.04);
            border: 1px solid rgba(255,255,255,.06);
            margin-bottom: 12px;
        }

        .profile-mini small {
            display: block;
            color: #64748b;
            margin-bottom: 5px;
        }

        .profile-mini span {
            display: block;
            color: #cbd5e1;
            font-size: 13px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .logout {
            display: block;
            text-align: center;
            text-decoration: none;
            padding: 11px;
            border-radius: 10px;
            color: #fca5a5;
            background: rgba(239,68,68,.08);
            font-size: 13px;
        }

        .main {
            flex: 1;
            padding: 35px 42px;
            overflow-y: auto;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .topbar h1 {
            font-size: 29px;
            margin-bottom: 6px;
        }

        .topbar p {
            color: #64748b;
            font-size: 14px;
        }

        .company-badge {
            width: 45px;
            height: 45px;
            border-radius: 14px;
            background: linear-gradient(135deg,#6366f1,#2563eb);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
        }

        .welcome-card {
            position: relative;
            overflow: hidden;
            padding: 35px;
            border-radius: 22px;
            background:
                linear-gradient(
                    135deg,
                    rgba(79,70,229,.9),
                    rgba(37,99,235,.72)
                );
            margin-bottom: 28px;
            box-shadow: 0 20px 50px rgba(37,99,235,.15);
        }

        .welcome-card::after {
            content: "";
            position: absolute;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            right: -90px;
            top: -120px;
            background: rgba(255,255,255,.08);
        }

        .welcome-card h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .welcome-card p {
            color: rgba(255,255,255,.76);
            max-width: 650px;
            line-height: 1.6;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 18px;
            margin-bottom: 30px;
        }

        .action-card {
            text-decoration: none;
            color: white;
            padding: 25px;
            border-radius: 18px;
            background: #0d1a2d;
            border: 1px solid rgba(255,255,255,.07);
            transition: .25s;
        }

        .action-card:hover {
            transform: translateY(-4px);
            border-color: rgba(99,102,241,.4);
            box-shadow: 0 15px 35px rgba(0,0,0,.2);
        }

        .action-icon {
            width: 48px;
            height: 48px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 14px;
            background: rgba(99,102,241,.12);
            margin-bottom: 18px;
            font-size: 21px;
        }

        .action-card h3 {
            font-size: 16px;
            margin-bottom: 7px;
        }

        .action-card p {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .section {
            background: #0b1628;
            border: 1px solid rgba(255,255,255,.06);
            border-radius: 20px;
            padding: 27px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .section-header h2 {
            font-size: 18px;
        }

        .status {
            padding: 7px 12px;
            border-radius: 20px;
            background: rgba(34,197,94,.1);
            color: #86efac;
            font-size: 11px;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #64748b;
        }

        .empty-icon {
            font-size: 34px;
            margin-bottom: 12px;
        }

        @media(max-width: 900px) {
            .sidebar {
                width: 220px;
            }

            .main {
                padding: 28px;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width: 700px) {
            .layout {
                display: block;
            }

            .sidebar {
                width: 100%;
                min-height: auto;
            }

            .sidebar-bottom {
                margin-top: 25px;
            }

            .main {
                padding: 22px;
            }

            .topbar {
                gap: 15px;
            }
        }
    </style>
</head>

<body>

<div class="layout">

    <aside class="sidebar">

        <div>
            <div class="logo">
                <div class="logo-icon">✦</div>
                HireNest
            </div>

            <div class="menu-title">
                Workspace
            </div>

            <nav class="nav">

                <a href="company-dashboard.jsp" class="active">
                    <span class="nav-icon">⌂</span>
                    Dashboard
                </a>

                <a href="company-post-job.jsp">
                    <span class="nav-icon">＋</span>
                    Post a Job
                </a>

                <a href="#">
                    <span class="nav-icon">▣</span>
                    Manage Jobs
                </a>

                <a href="#">
                    <span class="nav-icon">◉</span>
                    Applications
                </a>

                <a href="#">
                    <span class="nav-icon">♙</span>
                    Candidates
                </a>

            </nav>
        </div>

        <div class="sidebar-bottom">

            <div class="profile-mini">
                <small>Signed in as</small>
                <span><%= companyEmail %></span>
            </div>

            <a href="company-logout" class="logout">
                Sign Out
            </a>

        </div>

    </aside>


    <main class="main">

        <div class="topbar">

            <div>
                <h1>Company Dashboard</h1>
                <p>Manage your hiring activity from one place.</p>
            </div>

            <div class="company-badge">
                C
            </div>

        </div>


        <section class="welcome-card">

            <h2>Welcome to HireNest 👋</h2>

            <p>
                Your company workspace is ready. Start by publishing a job
                opportunity and connect with students looking for their next
                career opportunity.
            </p>

        </section>


        <section class="quick-actions">

            <a href="company-post-job.jsp" class="action-card">

                <div class="action-icon">
                    ＋
                </div>

                <h3>Post a New Job</h3>

                <p>
                    Create and publish a new job opportunity for students.
                </p>

            </a>


            <a href="#" class="action-card">

                <div class="action-icon">
                    ▣
                </div>

                <h3>Manage Jobs</h3>

                <p>
                    View, edit and manage the jobs posted by your company.
                </p>

            </a>


            <a href="#" class="action-card">

                <div class="action-icon">
                    ◉
                </div>

                <h3>View Applications</h3>

                <p>
                    Review candidates who have applied to your job openings.
                </p>

            </a>

        </section>


        <section class="section">

            <div class="section-header">

                <h2>Hiring Overview</h2>

                <span class="status">
                    ● Workspace Active
                </span>

            </div>

            <div class="empty">

                <div class="empty-icon">
                    ◫
                </div>

                <p>
                    Your job and application statistics will appear here
                    once you start hiring.
                </p>

            </div>

        </section>

    </main>

</div>

</body>
</html>