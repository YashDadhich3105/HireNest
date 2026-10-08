<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Application" %>

<%
    if (session == null || session.getAttribute("studentId") == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    int totalApplications = applications != null ? applications.size() : 0;
    int acceptedApplications = 0;
    int rejectedApplications = 0;
    int pendingApplications = 0;

    if (applications != null) {
        for (Application app : applications) {

            String appStatus = app.getApplicationStatus();

            if ("Accepted".equalsIgnoreCase(appStatus)) {
                acceptedApplications++;
            } else if ("Rejected".equalsIgnoreCase(appStatus)) {
                rejectedApplications++;
            } else {
                pendingApplications++;
            }
        }
    }

    String studentName =
            session.getAttribute("studentName") != null
                    ? session.getAttribute("studentName").toString()
                    : "Student";

    String avatarLetter =
            studentName.trim().isEmpty()
                    ? "S"
                    : studentName.trim().substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Applications | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background:
                radial-gradient(
                    circle at top left,
                    rgba(99, 102, 241, 0.14),
                    transparent 32%
                ),
                radial-gradient(
                    circle at bottom right,
                    rgba(14, 165, 233, 0.12),
                    transparent 30%
                ),
                #f5f7fb;
            color: #172033;
            min-height: 100vh;
        }

        .navbar {
            height: 76px;
            background: rgba(255, 255, 255, 0.94);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid #e8ebf2;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 6%;

            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .brand-icon {
            width: 42px;
            height: 42px;

            border-radius: 13px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            font-size: 21px;
            font-weight: bold;

            box-shadow:
                0 8px 20px
                rgba(79, 70, 229, 0.25);
        }

        .brand-text {
            font-size: 23px;
            font-weight: 800;
            color: #151a2d;
        }

        .brand-text span {
            color: #5b4ee8;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links a {
            text-decoration: none;
            color: #596174;
            font-size: 14px;
            font-weight: 600;

            padding: 11px 15px;

            border-radius: 10px;

            transition: 0.25s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #5145cd;
            background: #f0efff;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 10px;

            margin-left: 8px;
            padding-left: 16px;

            border-left: 1px solid #e5e7ef;
        }

        .profile-avatar {
            width: 38px;
            height: 38px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #8b5cf6
                );

            color: white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-weight: 700;
        }

        .main {
            width: 88%;
            max-width: 1400px;

            margin: 0 auto;

            padding: 42px 0 70px;
        }

        .hero {
            background:
                linear-gradient(
                    135deg,
                    #171b3a,
                    #30266f 55%,
                    #5145cd
                );

            border-radius: 26px;

            padding: 38px 42px;

            color: white;

            position: relative;
            overflow: hidden;

            box-shadow:
                0 20px 50px
                rgba(48, 38, 111, 0.20);

            margin-bottom: 28px;
        }

        .hero::before {
            content: "";

            position: absolute;

            width: 260px;
            height: 260px;

            border-radius: 50%;

            right: -80px;
            top: -120px;

            background:
                rgba(255, 255, 255, 0.08);
        }

        .hero::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            border-radius: 50%;

            right: 130px;
            bottom: -120px;

            background:
                rgba(255, 255, 255, 0.06);
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-label {
            display: inline-flex;

            padding: 7px 13px;

            border-radius: 30px;

            background:
                rgba(255, 255, 255, 0.12);

            border:
                1px solid
                rgba(255, 255, 255, 0.16);

            font-size: 12px;
            font-weight: 700;

            letter-spacing: 0.5px;

            margin-bottom: 15px;
        }

        .hero h1 {
            font-size: 34px;

            margin-bottom: 10px;

            letter-spacing: -0.7px;
        }

        .hero p {
            color:
                rgba(255, 255, 255, 0.78);

            font-size: 15px;

            max-width: 650px;

            line-height: 1.7;
        }

        .stats {
            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 18px;

            margin-bottom: 30px;
        }

        .stat-card {
            background: white;

            border:
                1px solid
                #e9ecf3;

            border-radius: 18px;

            padding: 22px;

            box-shadow:
                0 8px 25px
                rgba(30, 41, 59, 0.05);

            transition:
                transform 0.25s,
                box-shadow 0.25s;
        }

        .stat-card:hover {
            transform:
                translateY(-4px);

            box-shadow:
                0 15px 32px
                rgba(30, 41, 59, 0.09);
        }

        .stat-top {
            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 14px;
        }

        .stat-icon {
            width: 42px;
            height: 42px;

            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 18px;
            font-weight: bold;
        }

        .purple {
            background: #efedff;
            color: #5b4ee8;
        }

        .green {
            background: #e8f9ef;
            color: #159957;
        }

        .red {
            background: #ffeded;
            color: #dc3b4a;
        }

        .orange {
            background: #fff4df;
            color: #d88900;
        }

        .stat-title {
            color: #72798a;
            font-size: 13px;
            font-weight: 600;
        }

        .stat-value {
            font-size: 27px;
            font-weight: 800;
            color: #171c2f;
        }

        .section-header {
            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 18px;
        }

        .section-header h2 {
            font-size: 22px;
            color: #171c2f;
        }

        .section-header p {
            color: #777f91;
            font-size: 13px;

            margin-top: 5px;
        }

        .browse-btn {
            text-decoration: none;

            background: #5145cd;
            color: white;

            padding: 12px 18px;

            border-radius: 11px;

            font-size: 13px;
            font-weight: 700;

            transition: 0.25s;
        }

        .browse-btn:hover {
            background: #4035b4;

            transform:
                translateY(-2px);
        }

        .alert {
            padding: 14px 18px;

            border-radius: 12px;

            margin-bottom: 22px;

            font-size: 14px;
            font-weight: 600;
        }

        .success {
            background: #eafaf0;
            color: #187443;

            border:
                1px solid
                #c9efd8;
        }

        .error {
            background: #fff0f1;
            color: #b72c3b;

            border:
                1px solid
                #f4c9ce;
        }

        .application-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 20px;
        }

        .application-card {
            background: white;

            border:
                1px solid
                #e7eaf1;

            border-radius: 20px;

            padding: 24px;

            box-shadow:
                0 8px 28px
                rgba(30, 41, 59, 0.05);

            transition: 0.25s;

            position: relative;
            overflow: hidden;
        }

        .application-card:hover {
            transform:
                translateY(-4px);

            box-shadow:
                0 18px 38px
                rgba(30, 41, 59, 0.09);
        }

        .application-card::before {
            content: "";

            position: absolute;

            top: 0;
            left: 0;
            right: 0;

            height: 4px;

            background:
                linear-gradient(
                    90deg,
                    #5145cd,
                    #8b5cf6
                );
        }

        .card-top {
            display: flex;

            justify-content: space-between;
            align-items: flex-start;

            gap: 15px;

            margin-bottom: 20px;
        }

        .job-info h3 {
            font-size: 19px;

            color: #181d30;

            margin-bottom: 7px;
        }

        .company {
            color: #656d80;

            font-size: 13px;

            font-weight: 600;
        }

        .status {
            padding: 7px 12px;

            border-radius: 30px;

            font-size: 11px;
            font-weight: 800;

            white-space: nowrap;

            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-applied {
            background: #fff4df;
            color: #c47700;
        }

        .status-accepted {
            background: #e7f8ee;
            color: #16834b;
        }

        .status-rejected {
            background: #ffebed;
            color: #c53140;
        }

        .status-applied::before {
            content: "•";

            font-size: 17px;

            line-height: 10px;
        }

        .status-accepted::before {
            content: "&#10003;";
        }

        .status-rejected::before {
            content: "&#10005;";
        }

        .details {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 12px;

            padding-top: 18px;

            border-top:
                1px solid
                #edf0f5;
        }

        .detail {
            background: #f8f9fc;

            padding: 12px;

            border-radius: 11px;
        }

        .detail-label {
            display: block;

            color: #8a91a1;

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: 0.5px;

            font-weight: 700;

            margin-bottom: 5px;
        }

        .detail-value {
            color: #343b4d;

            font-size: 13px;

            font-weight: 600;
        }

        .application-footer {
            margin-top: 18px;

            display: flex;

            align-items: center;
            justify-content: space-between;

            color: #858c9b;

            font-size: 11px;
        }

        .application-id {
            font-weight: 700;
        }

        .empty {
            background: white;

            border:
                1px solid
                #e8ebf1;

            border-radius: 22px;

            padding: 65px 25px;

            text-align: center;

            box-shadow:
                0 8px 28px
                rgba(30, 41, 59, 0.04);
        }

        .empty-icon {
            width: 72px;
            height: 72px;

            border-radius: 22px;

            background: #efedff;
            color: #5b4ee8;

            margin:
                0 auto 18px;

            display: flex;

            align-items: center;
            justify-content: center;

            font-size: 30px;
            font-weight: 800;
        }

        .empty h3 {
            font-size: 21px;

            margin-bottom: 9px;
        }

        .empty p {
            color: #7a8190;

            font-size: 14px;

            margin-bottom: 22px;
        }

        .footer {
            text-align: center;

            color: #9298a6;

            font-size: 12px;

            margin-top: 50px;
        }

        @media (max-width: 1000px) {

            .stats {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .application-grid {
                grid-template-columns: 1fr;
            }

            .nav-links a {
                display: none;
            }
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 20px;
            }

            .main {
                width: 92%;

                padding-top: 25px;
            }

            .hero {
                padding: 28px 24px;
            }

            .hero h1 {
                font-size: 27px;
            }

            .stats {
                grid-template-columns:
                    1fr 1fr;

                gap: 10px;
            }

            .stat-card {
                padding: 16px;
            }

            .application-card {
                padding: 20px;
            }

            .card-top {
                flex-direction: column;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .section-header {
                align-items: flex-start;

                gap: 12px;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="student-dashboard.jsp"
       class="brand">

        <div class="brand-icon">
            H
        </div>

        <div class="brand-text">
            Hire<span>Nest</span>
        </div>

    </a>

    <div class="nav-links">

        <a href="student-dashboard.jsp">
            Dashboard
        </a>

        <a href="jobs.jsp">
            Browse Jobs
        </a>

        <a href="student-applications"
           class="active">
            My Applications
        </a>

        <div class="profile">

            <div class="profile-avatar">
                <%= avatarLetter %>
            </div>

        </div>

    </div>

</nav>


<main class="main">


    <section class="hero">

        <div class="hero-content">

            <div class="hero-label">
                APPLICATION CENTER
            </div>

            <h1>
                My Applications
            </h1>

            <p>
                Track all the jobs you have applied for
                and monitor your application status
                from one place.
            </p>

        </div>

    </section>


    <% if (success != null) { %>

        <div class="alert success">

            Application status updated successfully.

        </div>

    <% } %>


    <% if (error != null) { %>

        <div class="alert error">

            Unable to process your request.

        </div>

    <% } %>


    <section class="stats">


        <div class="stat-card">

            <div class="stat-top">

                <span class="stat-title">
                    Total Applications
                </span>

                <div class="stat-icon purple">
                    A
                </div>

            </div>

            <div class="stat-value">
                <%= totalApplications %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <span class="stat-title">
                    Pending
                </span>

                <div class="stat-icon orange">
                    P
                </div>

            </div>

            <div class="stat-value">
                <%= pendingApplications %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <span class="stat-title">
                    Accepted
                </span>

                <div class="stat-icon green">
                    ✓
                </div>

            </div>

            <div class="stat-value">
                <%= acceptedApplications %>
            </div>

        </div>


        <div class="stat-card">

            <div class="stat-top">

                <span class="stat-title">
                    Rejected
                </span>

                <div class="stat-icon red">
                    X
                </div>

            </div>

            <div class="stat-value">
                <%= rejectedApplications %>
            </div>

        </div>

    </section>


    <div class="section-header">

        <div>

            <h2>
                Application History
            </h2>

            <p>
                Review your submitted job applications
                and their latest status.
            </p>

        </div>

        <a href="jobs.jsp"
           class="browse-btn">

            Browse Jobs

        </a>

    </div>


    <% if (applications != null &&
           !applications.isEmpty()) { %>


        <div class="application-grid">


            <% for (Application app : applications) { %>

                <%
                    String status =
                            app.getApplicationStatus();

                    String statusClass =
                            "status-applied";

                    if ("Accepted".equalsIgnoreCase(status)) {

                        statusClass =
                                "status-accepted";

                    } else if ("Rejected".equalsIgnoreCase(status)) {

                        statusClass =
                                "status-rejected";
                    }
                %>


                <div class="application-card">


                    <div class="card-top">


                        <div class="job-info">

                            <h3>

                                <%= app.getJobTitle() != null
                                        ? app.getJobTitle()
                                        : "Job Position" %>

                            </h3>


                            <div class="company">

                                <%= app.getCompanyName() != null
                                        ? app.getCompanyName()
                                        : "Company" %>

                            </div>

                        </div>


                        <span class="status <%= statusClass %>">

                            <%= status != null
                                    ? status
                                    : "Applied" %>

                        </span>


                    </div>


                    <div class="details">


                        <div class="detail">

                            <span class="detail-label">
                                Location
                            </span>

                            <span class="detail-value">

                                <%= app.getLocation() != null
                                        ? app.getLocation()
                                        : "Not specified" %>

                            </span>

                        </div>


                        <div class="detail">

                            <span class="detail-label">
                                Salary
                            </span>

                            <span class="detail-value">

                                <%= app.getSalary() != null
                                        ? app.getSalary()
                                        : "Not specified" %>

                            </span>

                        </div>


                        <div class="detail">

                            <span class="detail-label">
                                Applied On
                            </span>

                            <span class="detail-value">

                                <%= app.getAppliedAt() != null
                                        ? app.getAppliedAt()
                                        : "N/A" %>

                            </span>

                        </div>


                        <div class="detail">

                            <span class="detail-label">
                                Application ID
                            </span>

                            <span class="detail-value">

                                #<%= app.getApplicationId() %>

                            </span>

                        </div>


                    </div>


                    <div class="application-footer">

                        <span>
                            Application submitted through HireNest
                        </span>

                        <span class="application-id">

                            Job #<%= app.getJobId() %>

                        </span>

                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <div class="empty">

            <div class="empty-icon">
                A
            </div>

            <h3>
                No Applications Yet
            </h3>

            <p>
                You haven't applied to any jobs yet.
                Explore available opportunities
                and start your career journey.
            </p>

            <a href="jobs.jsp"
               class="browse-btn">

                Explore Jobs

            </a>

        </div>


    <% } %>


    <div class="footer">

        &copy; 2026 HireNest
        &middot;
        Connecting Students With Opportunities

    </div>


</main>

</body>

</html>