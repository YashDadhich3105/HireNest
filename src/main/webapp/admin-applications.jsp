<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Application" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");

    String search =
            (String) request.getAttribute("search");

    Integer totalApplications =
            (Integer) request.getAttribute("totalApplications");

    Integer acceptedApplications =
            (Integer) request.getAttribute("acceptedApplications");

    Integer rejectedApplications =
            (Integer) request.getAttribute("rejectedApplications");

    Integer pendingApplications =
            (Integer) request.getAttribute("pendingApplications");

    Integer totalStudents =
            (Integer) request.getAttribute("totalStudents");

    Integer totalCompanies =
            (Integer) request.getAttribute("totalCompanies");

    Integer totalJobs =
            (Integer) request.getAttribute("totalJobs");

    Double placementRate =
            (Double) request.getAttribute("placementRate");

    if (totalApplications == null) totalApplications = 0;
    if (acceptedApplications == null) acceptedApplications = 0;
    if (rejectedApplications == null) rejectedApplications = 0;
    if (pendingApplications == null) pendingApplications = 0;
    if (totalStudents == null) totalStudents = 0;
    if (totalCompanies == null) totalCompanies = 0;
    if (totalJobs == null) totalJobs = 0;
    if (placementRate == null) placementRate = 0.0;
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>HireNest | Admin Applications</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #f8fafc, #eef2ff);
            color: #172033;
            min-height: 100vh;
        }

        .navbar {
            min-height: 72px;
            background: rgba(255,255,255,0.97);
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 5%;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 5px 25px rgba(15,23,42,0.06);
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
            color: #4f46e5;
        }

        .logo span {
            color: #111827;
        }

        .nav-links {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }

        .nav-links a {
            text-decoration: none;
            color: #475569;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            transition: 0.25s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            background: #eef2ff;
            color: #4f46e5;
        }

        .logout {
            background: #111827 !important;
            color: white !important;
        }

        .container {
            width: 92%;
            max-width: 1500px;
            margin: 35px auto 60px;
        }

        .hero {
            margin-bottom: 28px;
        }

        .hero h1 {
            font-size: 34px;
            margin-bottom: 8px;
        }

        .hero p {
            color: #64748b;
            font-size: 15px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.06);
            position: relative;
            overflow: hidden;
        }

        .stat-card::after {
            content: "";
            position: absolute;
            width: 90px;
            height: 90px;
            border-radius: 50%;
            right: -30px;
            top: -30px;
            background: #eef2ff;
        }

        .stat-title {
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
            position: relative;
            z-index: 2;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            margin-top: 8px;
            position: relative;
            z-index: 2;
        }

        .analytics {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .chart-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.06);
        }

        .chart-card h3 {
            margin-bottom: 20px;
            font-size: 19px;
        }

        .bar {
            margin: 18px 0;
        }

        .bar-label {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 7px;
        }

        .bar-track {
            height: 12px;
            background: #e5e7eb;
            border-radius: 20px;
            overflow: hidden;
        }

        .bar-fill {
            height: 100%;
            border-radius: 20px;
        }

        .accepted {
            background: #10b981;
        }

        .rejected {
            background: #ef4444;
        }

        .pending {
            background: #f59e0b;
        }

        .overview-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .overview-item {
            background: #f8fafc;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
        }

        .overview-item strong {
            display: block;
            font-size: 27px;
            margin-bottom: 5px;
        }

        .overview-item span {
            color: #64748b;
            font-size: 13px;
        }

        .table-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 10px 35px rgba(15,23,42,0.07);
        }

        .table-header {
            padding: 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-header h2 {
            font-size: 21px;
        }

        .search {
            display: flex;
            gap: 8px;
        }

        .search input {
            width: 300px;
            padding: 12px 15px;
            border: 1px solid #d1d5db;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
        }

        .search input:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px #eef2ff;
        }

        .search button {
            border: none;
            background: #4f46e5;
            color: white;
            padding: 12px 20px;
            border-radius: 11px;
            cursor: pointer;
            font-weight: 700;
        }

        .search button:hover {
            background: #4338ca;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        th {
            background: #f8fafc;
            padding: 15px;
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .5px;
            color: #64748b;
        }

        td {
            padding: 16px 15px;
            border-top: 1px solid #f1f5f9;
            font-size: 14px;
        }

        tr:hover td {
            background: #fafbff;
        }

        .student {
            font-weight: 700;
        }

        .email {
            color: #64748b;
            font-size: 12px;
            margin-top: 3px;
        }

        .status {
            display: inline-flex;
            padding: 6px 11px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 800;
        }

        .status.accepted {
            background: #dcfce7;
            color: #15803d;
        }

        .status.rejected {
            background: #fee2e2;
            color: #b91c1c;
        }

        .status.applied {
            background: #fef3c7;
            color: #b45309;
        }

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .empty h3 {
            color: #334155;
            margin-bottom: 8px;
        }

        @media(max-width: 1000px) {

            .stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .analytics {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width: 700px) {

            .navbar {
                padding: 15px;
                flex-direction: column;
                gap: 12px;
            }

            .nav-links {
                justify-content: center;
            }

            .hero h1 {
                font-size: 28px;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .overview-grid {
                grid-template-columns: 1fr;
            }

            .table-header {
                flex-direction: column;
                align-items: stretch;
            }

            .search {
                width: 100%;
            }

            .search input {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        Hire<span>Nest</span>
    </div>

    <div class="nav-links">

        <a href="admin-dashboard">
            Dashboard
        </a>

        <a href="admin-students">
            Students
        </a>

        <a href="admin-companies">
            Companies
        </a>

        <a href="admin-jobs">
            Jobs
        </a>

        <a href="admin-applications" class="active">
            Applications
        </a>

        <a href="admin-logout" class="logout">
            Logout
        </a>

    </div>

</nav>

<main class="container">

    <section class="hero">

        <h1>
            Application Management
        </h1>

        <p>
            Monitor applications, placements and recruitment activity.
        </p>

    </section>
<section class="stats">

    <div class="stat-card">

        <div class="stat-title">
            Total Applications
        </div>

        <div class="stat-value">
            <%= totalApplications %>
        </div>

    </div>

    <div class="stat-card">

        <div class="stat-icon">
            &#127881;
        </div>

        <div class="stat-title">
            Accepted
        </div>

        <div class="stat-value">
            <%= acceptedApplications %>
        </div>

    </div>

    <div class="stat-card">

        <div class="stat-title">
            Pending
        </div>

        <div class="stat-value">
            <%= pendingApplications %>
        </div>

    </div>

    <div class="stat-card">

        <div class="stat-title">
            Placement Rate
        </div>

        <div class="stat-value">
            <%= String.format("%.1f", placementRate) %>%
        </div>

    </div>

</section>
    <section class="analytics">

        <div class="chart-card">

            <h3>
                Application Status
            </h3>

            <div class="bar">

                <div class="bar-label">

                    <span>
                        Accepted
                    </span>

                    <span>
                        <%= acceptedApplications %>
                    </span>

                </div>

                <div class="bar-track">

                    <%
                        int acceptedWidth = 0;

                        if (totalApplications > 0) {
                            acceptedWidth =
                                    (acceptedApplications * 100)
                                            / totalApplications;
                        }
                    %>

                    <div class="bar-fill accepted"
                         style="width:<%= acceptedWidth %>%">
                    </div>

                </div>

            </div>

            <div class="bar">

                <div class="bar-label">

                    <span>
                        Pending
                    </span>

                    <span>
                        <%= pendingApplications %>
                    </span>

                </div>

                <div class="bar-track">

                    <%
                        int pendingWidth = 0;

                        if (totalApplications > 0) {
                            pendingWidth =
                                    (pendingApplications * 100)
                                            / totalApplications;
                        }
                    %>

                    <div class="bar-fill pending"
                         style="width:<%= pendingWidth %>%">
                    </div>

                </div>

            </div>

            <div class="bar">

                <div class="bar-label">

                    <span>
                        Rejected
                    </span>

                    <span>
                        <%= rejectedApplications %>
                    </span>

                </div>

                <div class="bar-track">

                    <%
                        int rejectedWidth = 0;

                        if (totalApplications > 0) {
                            rejectedWidth =
                                    (rejectedApplications * 100)
                                            / totalApplications;
                        }
                    %>

                    <div class="bar-fill rejected"
                         style="width:<%= rejectedWidth %>%">
                    </div>

                </div>

            </div>

        </div>

        <div class="chart-card">

            <h3>
                HireNest Overview
            </h3>

            <div class="overview-grid">

                <div class="overview-item">

                    <strong>
                        <%= totalStudents %>
                    </strong>

                    <span>
                        Students
                    </span>

                </div>

                <div class="overview-item">

                    <strong>
                        <%= totalCompanies %>
                    </strong>

                    <span>
                        Companies
                    </span>

                </div>

                <div class="overview-item">

                    <strong>
                        <%= totalJobs %>
                    </strong>

                    <span>
                        Jobs
                    </span>

                </div>

            </div>

        </div>

    </section>

    <section class="table-card">

        <div class="table-header">

            <h2>
                All Applications
            </h2>

            <form
                    class="search"
                    action="admin-applications"
                    method="get">

                <input
                        type="text"
                        name="search"
                        value="<%= search == null ? "" : search %>"
                        placeholder="Search student, company, job...">

                <button type="submit">
                    Search
                </button>

            </form>

        </div>

        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>ID</th>
                    <th>Student</th>
                    <th>Job</th>
                    <th>Company</th>
                    <th>Location</th>
                    <th>CGPA</th>
                    <th>Status</th>
                    <th>Applied At</th>

                </tr>

                </thead>

                <tbody>

                <%
                    if (applications != null &&
                            !applications.isEmpty()) {

                        for (Application app : applications) {
                %>

                <tr>

                    <td>
                        #<%= app.getApplicationId() %>
                    </td>

                    <td>

                        <div class="student">
                            <%= app.getStudentName() %>
                        </div>

                        <div class="email">
                            <%= app.getStudentEmail() %>
                        </div>

                    </td>

                    <td>
                        <strong>
                            <%= app.getJobTitle() %>
                        </strong>
                    </td>

                    <td>
                        <%= app.getCompanyName() %>
                    </td>

                    <td>
                        <%= app.getLocation() %>
                    </td>

                    <td>
                        <%= app.getStudentCgpa() %>
                    </td>

                    <td>

                        <%
                            String status =
                                    app.getApplicationStatus();

                            if ("Accepted".equalsIgnoreCase(status)) {
                        %>

                        <span class="status accepted">
                            Accepted
                        </span>

                        <%
                            } else if ("Rejected".equalsIgnoreCase(status)) {
                        %>

                        <span class="status rejected">
                            Rejected
                        </span>

                        <%
                            } else {
                        %>

                        <span class="status applied">
                            <%= status %>
                        </span>

                        <%
                            }
                        %>

                    </td>

                    <td>
                        <%= app.getAppliedAt() %>
                    </td>

                </tr>

                <%
                        }

                    } else {
                %>

                <tr>

                    <td colspan="8">

                        <div class="empty">

                            <h3>
                                No Applications Found
                            </h3>

                            <p>
                                There are currently no applications matching your search.
                            </p>

                        </div>

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </section>

</main>

</body>
</html>