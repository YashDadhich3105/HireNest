<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.hirenest.model.Job" %>
<%@ page import="com.hirenest.dao.JobDAO" %>
<%@ page import="com.hirenest.dao.ApplicationDAO" %>

<%
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }

    int studentId = (Integer) session.getAttribute("studentId");

    String studentName = (String) session.getAttribute("studentName");

    if (studentName == null || studentName.trim().isEmpty()) {
        studentName = "Student";
    }

    JobDAO jobDAO = new JobDAO();
    ApplicationDAO applicationDAO = new ApplicationDAO();

    List<Job> jobs = jobDAO.getAllJobs();

    Set<Integer> appliedJobIds =
            applicationDAO.getAppliedJobIds(studentId);

    String applied = request.getParameter("applied");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Browse Jobs | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: #f5f6fb;
            color: #17192b;
        }

        .navbar {
            height: 74px;
            background: white;
            border-bottom: 1px solid #e5e6ef;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
        }

        .logo {
            font-size: 25px;
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
            color: #777b8e;
            font-size: 14px;
        }

        .dashboard {
            text-decoration: none;
            color: #6258f5;
            background: #efedff;
            padding: 10px 17px;
            border-radius: 10px;
            font-weight: bold;
            font-size: 13px;
        }

        .dashboard:hover {
            background: #e4e1ff;
        }

        .container {
            width: min(1085px, 92%);
            margin: 45px auto 80px;
        }

        .eyebrow {
            display: inline-block;
            padding: 8px 13px;
            border-radius: 20px;
            background: #eeecff;
            color: #6258f5;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 14px;
        }

        h1 {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .intro {
            color: #70758a;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .count {
            color: #6258f5;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .message {
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: bold;
        }

        .success {
            background: #eafaf1;
            border: 1px solid #bce8cf;
            color: #18864b;
        }

        .error {
            background: #fff0f3;
            border: 1px solid #ffc7d1;
            color: #c72545;
        }

        .job-card {
            background: white;
            border: 1px solid #e4e5ee;
            border-radius: 22px;
            padding: 30px 27px 25px;
            margin-bottom: 23px;
            box-shadow: 0 15px 40px rgba(30, 35, 70, 0.07);
        }

        .job-title {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .company {
            color: #6258f5;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .details {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 22px;
        }

        .badge {
            background: #f3f2fb;
            color: #555a70;
            padding: 9px 13px;
            border-radius: 9px;
            font-size: 13px;
        }

        .section-title {
            font-size: 12px;
            font-weight: bold;
            color: #44485b;
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .skills {
            color: #6e7387;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 23px;
        }

        .description {
            color: #6e7387;
            font-size: 14px;
            line-height: 1.7;
            margin-bottom: 22px;
        }

        .bottom {
            border-top: 1px solid #ececf2;
            padding-top: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .deadline {
            color: #777b8e;
            font-size: 13px;
        }

        .deadline strong {
            color: #555a70;
        }

        .apply-button {
            border: none;
            border-radius: 12px;
            padding: 12px 22px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            min-width: 125px;
        }

        .apply {
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            box-shadow: 0 8px 20px rgba(98, 88, 245, 0.25);
        }

        .apply:hover {
            transform: translateY(-1px);
        }

        .applied {
            background: #e9f8ef;
            color: #18864b;
            border: 1px solid #b9e5ca;
            cursor: default;
        }

        .empty {
            background: white;
            border-radius: 20px;
            padding: 50px;
            text-align: center;
            color: #777b8e;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 4%;
            }

            .welcome {
                display: none;
            }

            .container {
                width: 94%;
                margin-top: 30px;
            }

            h1 {
                font-size: 32px;
            }

            .job-card {
                padding: 22px;
            }

            .bottom {
                flex-direction: column;
                align-items: stretch;
            }

            .apply-button {
                width: 100%;
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

        <span class="welcome">
            Welcome, <%= studentName %>
        </span>

        <a href="student-dashboard.jsp"
           class="dashboard">
            Dashboard
        </a>

    </div>

</nav>

<main class="container">

    <div class="eyebrow">
        CAREER OPPORTUNITIES
    </div>

    <h1>
        Find your next opportunity.
    </h1>

    <p class="intro">
        Explore the latest jobs posted by companies on HireNest
        and find an opportunity that matches your skills.
    </p>

    <% if ("true".equals(applied)) { %>

        <div class="message success">
            ✓ Application submitted successfully.
        </div>

    <% } %>

    <% if ("already-applied".equals(error)) { %>

        <div class="message error">
            You have already applied for this job.
        </div>

    <% } else if ("invalid-job".equals(error)) { %>

        <div class="message error">
            Invalid job selected.
        </div>

    <% } else if ("server-error".equals(error)) { %>

        <div class="message error">
            Something went wrong while submitting your application.
        </div>

    <% } else if (error != null) { %>

        <div class="message error">
            <%= error %>
        </div>

    <% } %>

    <div class="count">
        <%= jobs.size() %> job(s) available
    </div>

    <% if (jobs.isEmpty()) { %>

        <div class="empty">
            No jobs are currently available.
        </div>

    <% } else { %>

        <% for (Job job : jobs) { %>

            <div class="job-card">

                <h2 class="job-title">
                    <%= job.getJobTitle() %>
                </h2>

                <div class="company">
                    HireNest Company
                </div>

                <div class="details">

                    <% if (job.getLocation() != null &&
                           !job.getLocation().trim().isEmpty()) { %>

                        <span class="badge">
                            📍 <%= job.getLocation() %>
                        </span>

                    <% } %>

                    <% if (job.getSalary() != null &&
                           !job.getSalary().trim().isEmpty()) { %>

                        <span class="badge">
                            💰 <%= job.getSalary() %>
                        </span>

                    <% } %>

                </div>

                <% if (job.getJobDescription() != null &&
                       !job.getJobDescription().trim().isEmpty()) { %>

                    <div class="section-title">
                        Job Description
                    </div>

                    <div class="description">
                        <%= job.getJobDescription() %>
                    </div>

                <% } %>

                <% if (job.getSkillsRequired() != null &&
                       !job.getSkillsRequired().trim().isEmpty()) { %>

                    <div class="section-title">
                        Required Skills
                    </div>

                    <div class="skills">
                        <%= job.getSkillsRequired() %>
                    </div>

                <% } %>

                <div class="bottom">

                    <div class="deadline">

                        <% if (job.getApplicationDeadline() != null) { %>

                            Application deadline:
                            <strong>
                                <%= job.getApplicationDeadline() %>
                            </strong>

                        <% } else { %>

                            No deadline specified

                        <% } %>

                    </div>

                    <% if (appliedJobIds.contains(job.getJobId())) { %>

                        <button
                                type="button"
                                class="apply-button applied"
                                disabled>
                            ✓ Applied
                        </button>

                    <% } else { %>

                        <form action="apply-job" method="post">

                            <input
                                    type="hidden"
                                    name="jobId"
                                    value="<%= job.getJobId() %>">

                            <button
                                    type="submit"
                                    class="apply-button apply">
                                Apply Now →
                            </button>

                        </form>

                    <% } %>

                </div>

            </div>

        <% } %>

    <% } %>

</main>

</body>
</html>