<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Application" %>

<%
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }

    String studentName =
            (String) session.getAttribute("studentName");

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");
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
            font-family: Arial, sans-serif;
            background: #f5f6fb;
            color: #17192b;
            min-height: 100vh;
        }

        .navbar {
            height: 76px;
            background: white;
            border-bottom: 1px solid #e7e8ef;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            color: #17192b;
            text-decoration: none;
        }

        .logo span {
            color: #6258f5;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome {
            color: #666b80;
            font-size: 14px;
        }

        .dashboard-btn {
            text-decoration: none;
            background: #eeedff;
            color: #6258f5;
            padding: 10px 17px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: bold;
        }

        .page {
            width: min(1100px, 92%);
            margin: 55px auto;
        }

        .hero {
            margin-bottom: 30px;
        }

        .eyebrow {
            display: inline-block;
            padding: 8px 13px;
            background: #eeedff;
            color: #6258f5;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 15px;
        }

        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #777b8e;
            line-height: 1.6;
            font-size: 15px;
        }

        .count {
            margin-top: 18px;
            color: #6258f5;
            font-weight: bold;
            font-size: 14px;
        }

        .application-card {
            background: white;
            border: 1px solid #e4e6ef;
            border-radius: 20px;
            padding: 27px;
            margin-bottom: 20px;
            box-shadow: 0 15px 45px rgba(30, 35, 70, 0.07);
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }

        .job-title {
            font-size: 23px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .company {
            color: #6258f5;
            font-weight: bold;
            font-size: 14px;
        }

        .details {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .detail {
            background: #f5f5fb;
            padding: 9px 13px;
            border-radius: 9px;
            color: #62677b;
            font-size: 13px;
        }

        .divider {
            height: 1px;
            background: #ececf2;
            margin: 22px 0;
        }

        .bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .applied-date {
            color: #777b8e;
            font-size: 13px;
        }

        .status {
            padding: 9px 15px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
        }

        .status-applied {
            background: #eeedff;
            color: #6258f5;
        }

        .status-accepted {
            background: #e8f8ef;
            color: #17864b;
        }

        .status-rejected {
            background: #fff0f3;
            color: #c72545;
        }

        .empty {
            background: white;
            border: 1px solid #e4e6ef;
            border-radius: 20px;
            padding: 70px 30px;
            text-align: center;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 18px;
        }

        .empty h2 {
            margin-bottom: 10px;
        }

        .empty p {
            color: #777b8e;
            margin-bottom: 25px;
        }

        .browse-btn {
            display: inline-block;
            text-decoration: none;
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            padding: 13px 22px;
            border-radius: 11px;
            font-size: 14px;
            font-weight: bold;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 5%;
            }

            .welcome {
                display: none;
            }

            .page {
                width: 94%;
                margin-top: 35px;
            }

            h1 {
                font-size: 32px;
            }

            .top {
                flex-direction: column;
            }

            .bottom {
                flex-direction: column;
                align-items: flex-start;
            }

        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="student-dashboard.jsp" class="logo">
        Hire<span>Nest</span>
    </a>

    <div class="nav-right">

        <div class="welcome">
            Welcome, <%= studentName %>
        </div>

        <a href="student-dashboard.jsp"
           class="dashboard-btn">
            Dashboard
        </a>

    </div>

</nav>

<main class="page">

    <section class="hero">

        <div class="eyebrow">
            APPLICATION TRACKER
        </div>

        <h1>My Applications</h1>

        <p class="subtitle">
            Track the jobs you have applied for and monitor
            your application status.
        </p>

        <div class="count">
            <%= applications != null ? applications.size() : 0 %>
            application(s)
        </div>

    </section>

    <% if (applications == null || applications.isEmpty()) { %>

        <div class="empty">

            <div class="empty-icon">📄</div>

            <h2>No Applications Yet</h2>

            <p>
                You haven't applied for any jobs yet.
                Explore available opportunities and apply for your next role.
            </p>

            <a href="student-jobs"
               class="browse-btn">
                Browse Jobs →
            </a>

        </div>

    <% } else { %>

        <% for (Application application : applications) { %>

            <div class="application-card">

                <div class="top">

                    <div>

                        <div class="job-title">
                            <%= application.getJobTitle() %>
                        </div>

                        <div class="company">
                            <%= application.getCompanyName() %>
                        </div>

                    </div>

                    <%
                        String status =
                                application.getApplicationStatus();

                        String statusClass = "status-applied";

                        if ("Accepted".equalsIgnoreCase(status)) {
                            statusClass = "status-accepted";
                        } else if ("Rejected".equalsIgnoreCase(status)) {
                            statusClass = "status-rejected";
                        }
                    %>

                    <div class="status <%= statusClass %>">
                        <%= status %>
                    </div>

                </div>

                <div class="details">

                    <% if (application.getLocation() != null
                            && !application.getLocation().trim().isEmpty()) { %>

                        <div class="detail">
                            📍 <%= application.getLocation() %>
                        </div>

                    <% } %>

                    <% if (application.getSalary() != null
                            && !application.getSalary().trim().isEmpty()) { %>

                        <div class="detail">
                            💰 <%= application.getSalary() %>
                        </div>

                    <% } %>

                </div>

                <div class="divider"></div>

                <div class="bottom">

                    <div class="applied-date">

                        Applied on:
                        <strong>
                            <%= application.getAppliedAt() %>
                        </strong>

                    </div>

                    <div class="status <%= statusClass %>">
                        <%= status %>
                    </div>

                </div>

            </div>

        <% } %>

    <% } %>

</main>

</body>

</html>
