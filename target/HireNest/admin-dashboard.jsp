<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String adminName =
            (String) session.getAttribute("adminName");

    Integer totalStudents =
            (Integer) request.getAttribute("totalStudents");

    Integer totalCompanies =
            (Integer) request.getAttribute("totalCompanies");

    Integer totalJobs =
            (Integer) request.getAttribute("totalJobs");

    Integer totalApplications =
            (Integer) request.getAttribute("totalApplications");

    Integer totalResumes =
            (Integer) request.getAttribute("totalResumes");

    Integer totalNotifications =
            (Integer) request.getAttribute("totalNotifications");

    Integer acceptedApplications =
            (Integer) request.getAttribute("acceptedApplications");

    Integer rejectedApplications =
            (Integer) request.getAttribute("rejectedApplications");

    Integer pendingApplications =
            (Integer) request.getAttribute("pendingApplications");

    if (totalStudents == null) totalStudents = 0;
    if (totalCompanies == null) totalCompanies = 0;
    if (totalJobs == null) totalJobs = 0;
    if (totalApplications == null) totalApplications = 0;
    if (totalResumes == null) totalResumes = 0;
    if (totalNotifications == null) totalNotifications = 0;
    if (acceptedApplications == null) acceptedApplications = 0;
    if (rejectedApplications == null) rejectedApplications = 0;
    if (pendingApplications == null) pendingApplications = 0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
            color: #172033;
        }

        .navbar {
            height: 72px;
            background: #101828;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 35px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
        }

        .brand span {
            color: #64d8ff;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .admin-name {
            color: #cbd5e1;
            font-size: 14px;
        }

        .logout {
            text-decoration: none;
            color: white;
            background: #ef4444;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 14px;
            font-weight: 700;
        }

        .container {
            max-width: 1400px;
            margin: auto;
            padding: 40px 30px;
        }

        .welcome {
            margin-bottom: 35px;
        }

        .welcome h1 {
            font-size: 34px;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #697386;
        }

        .stats {
            display: grid;
            grid-template-columns:
                repeat(3, minmax(0, 1fr));
            gap: 22px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            border: 1px solid #e7ebf2;
            box-shadow: 0 8px 25px rgba(16,24,40,0.05);
            transition: 0.25s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(16,24,40,0.09);
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eef5ff;
            font-size: 22px;
        }

        .stat-label {
            color: #697386;
            font-size: 14px;
            margin-top: 18px;
        }

        .stat-number {
            font-size: 34px;
            font-weight: 800;
            margin-top: 7px;
        }

        .section-title {
            font-size: 23px;
            margin-bottom: 18px;
        }

        .quick-grid {
            display: grid;
            grid-template-columns:
                repeat(4, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 35px;
        }

        .quick-card {
            text-decoration: none;
            color: #172033;
            background: white;
            padding: 25px;
            border-radius: 18px;
            border: 1px solid #e7ebf2;
            transition: 0.25s;
        }

        .quick-card:hover {
            transform: translateY(-3px);
            border-color: #64d8ff;
            box-shadow: 0 10px 25px rgba(16,24,40,0.07);
        }

        .quick-icon {
            font-size: 28px;
            margin-bottom: 15px;
        }

        .quick-card h3 {
            margin-bottom: 7px;
        }

        .quick-card p {
            color: #697386;
            font-size: 13px;
            line-height: 1.5;
        }

        .application-summary {
            display: grid;
            grid-template-columns:
                repeat(3, 1fr);
            gap: 18px;
        }

        .summary {
            background: white;
            border: 1px solid #e7ebf2;
            border-radius: 18px;
            padding: 25px;
        }

        .summary h3 {
            font-size: 15px;
            color: #697386;
            margin-bottom: 10px;
        }

        .summary strong {
            font-size: 30px;
        }

        @media(max-width: 1000px) {

            .stats {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .quick-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }
        }

        @media(max-width: 650px) {

            .navbar {
                padding: 0 18px;
            }

            .admin-name {
                display: none;
            }

            .container {
                padding: 25px 18px;
            }

            .stats,
            .quick-grid,
            .application-summary {
                grid-template-columns: 1fr;
            }

            .welcome h1 {
                font-size: 27px;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="brand">
        Hire<span>Nest</span>
        Admin
    </div>

    <div class="nav-right">

        <span class="admin-name">
            Welcome, <%= adminName %>
        </span>

        <a
                href="admin-logout"
                class="logout">

            Logout

        </a>

    </div>

</nav>

<main class="container">

    <section class="welcome">

        <h1>Admin Dashboard</h1>

        <p>
            Monitor and manage the complete HireNest
            placement ecosystem.
        </p>

    </section>

    <section class="stats">

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">👨‍🎓</div>
            </div>

            <div class="stat-label">
                Total Students
            </div>

            <div class="stat-number">
                <%= totalStudents %>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">🏢</div>
            </div>

            <div class="stat-label">
                Total Companies
            </div>

            <div class="stat-number">
                <%= totalCompanies %>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">💼</div>
            </div>

            <div class="stat-label">
                Total Jobs
            </div>

            <div class="stat-number">
                <%= totalJobs %>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">📝</div>
            </div>

            <div class="stat-label">
                Total Applications
            </div>

            <div class="stat-number">
                <%= totalApplications %>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">📄</div>
            </div>

            <div class="stat-label">
                Resumes Uploaded
            </div>

            <div class="stat-number">
                <%= totalResumes %>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-top">
                <div class="stat-icon">🔔</div>
            </div>

            <div class="stat-label">
                Notifications
            </div>

            <div class="stat-number">
                <%= totalNotifications %>
            </div>

        </div>

    </section>

    <h2 class="section-title">
        Management
    </h2>

    <section class="quick-grid">

        <a href="admin-students" class="quick-card">

            <div class="quick-icon">👨‍🎓</div>

            <h3>Manage Students</h3>

            <p>
                View and manage registered students.
            </p>

        </a>

        <a href="admin-companies" class="quick-card">

            <div class="quick-icon">🏢</div>

            <h3>Manage Companies</h3>

            <p>
                View and manage registered companies.
            </p>

        </a>

        <a href="admin-jobs" class="quick-card">

            <div class="quick-icon">💼</div>

            <h3>Manage Jobs</h3>

            <p>
                Monitor all jobs posted on HireNest.
            </p>

        </a>

        <a href="admin-applications" class="quick-card">

            <div class="quick-icon">📋</div>

            <h3>Applications</h3>

            <p>
                Monitor student job applications.
            </p>

        </a>

    </section>

    <h2 class="section-title">
        Application Overview
    </h2>

    <section class="application-summary">

        <div class="summary">

            <h3>Accepted</h3>

            <strong>
                <%= acceptedApplications %>
            </strong>

        </div>

        <div class="summary">

            <h3>Pending</h3>

            <strong>
                <%= pendingApplications %>
            </strong>

        </div>

        <div class="summary">

            <h3>Rejected</h3>

            <strong>
                <%= rejectedApplications %>
            </strong>

        </div>

    </section>

</main>

</body>

</html>