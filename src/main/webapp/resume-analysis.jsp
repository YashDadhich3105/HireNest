<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hirenest.model.ResumeAnalysis" %>
<%@ page import="com.hirenest.model.Job" %>
<%@ page import="com.hirenest.model.Resume" %>

<%
    ResumeAnalysis analysis =
            (ResumeAnalysis) request.getAttribute("analysis");

    Job job =
            (Job) request.getAttribute("job");

    Resume resume =
            (Resume) request.getAttribute("resume");

    if (analysis == null || job == null || resume == null) {
        response.sendRedirect("jobs.jsp");
        return;
    }

    double matchPercentage =
            analysis.getMatchPercentage();

    String matchClass;

    if (matchPercentage >= 80) {
        matchClass = "excellent";
    } else if (matchPercentage >= 60) {
        matchClass = "good";
    } else if (matchPercentage >= 40) {
        matchClass = "average";
    } else {
        matchClass = "low";
    }

    String[] matchedSkills =
            analysis.getMatchedSkills() != null &&
            !analysis.getMatchedSkills().equals("None")
                    ? analysis.getMatchedSkills().split(",")
                    : new String[0];

    String[] missingSkills =
            analysis.getMissingSkills() != null &&
            !analysis.getMissingSkills().equals("None")
                    ? analysis.getMissingSkills().split(",")
                    : new String[0];
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Resume Analysis | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background:
                radial-gradient(
                    circle at top left,
                    #eef2ff,
                    transparent 35%
                ),
                radial-gradient(
                    circle at bottom right,
                    #dbeafe,
                    transparent 35%
                ),
                #f8fafc;

            min-height: 100vh;
            color: #172033;
        }

        .navbar {
            height: 72px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            background: rgba(255, 255, 255, 0.92);

            border-bottom:
                1px solid rgba(15, 23, 42, 0.08);

            box-shadow:
                0 5px 25px rgba(15, 23, 42, 0.06);

            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;

            font-size: 25px;
            font-weight: 800;

            color: #4f46e5;

            text-decoration: none;
        }

        .brand-icon {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 13px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            font-size: 20px;

            box-shadow:
                0 8px 20px rgba(79, 70, 229, 0.28);
        }

        .nav-actions {
            display: flex;
            gap: 12px;
        }

        .nav-btn {
            text-decoration: none;

            padding: 10px 18px;

            border-radius: 10px;

            font-size: 14px;
            font-weight: 700;

            transition: 0.25s;
        }

        .nav-btn.secondary {
            color: #475569;
            background: #f1f5f9;
        }

        .nav-btn.secondary:hover {
            background: #e2e8f0;
        }

        .nav-btn.primary {
            color: white;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            box-shadow:
                0 6px 18px rgba(79, 70, 229, 0.22);
        }

        .nav-btn.primary:hover {
            transform: translateY(-2px);
        }

        .hero {
            max-width: 1180px;

            margin: 0 auto;

            padding: 55px 25px 25px;

            text-align: center;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;

            padding: 8px 16px;

            border-radius: 50px;

            background: #eef2ff;
            color: #4f46e5;

            font-size: 13px;
            font-weight: 800;

            margin-bottom: 18px;
        }

        .hero h1 {
            font-size: 42px;
            line-height: 1.15;

            margin-bottom: 12px;

            letter-spacing: -1px;
        }

        .hero h1 span {
            color: #4f46e5;
        }

        .hero p {
            color: #64748b;
            font-size: 16px;
        }

        .container {
            max-width: 1180px;

            margin: 0 auto;

            padding: 25px;
        }

        .score-card {
            background: white;

            border-radius: 28px;

            padding: 38px;

            display: grid;

            grid-template-columns:
                280px
                1fr;

            gap: 45px;

            align-items: center;

            box-shadow:
                0 20px 60px rgba(15, 23, 42, 0.09);

            border:
                1px solid rgba(15, 23, 42, 0.06);

            margin-bottom: 25px;
        }

        .score-circle {
            width: 230px;
            height: 230px;

            margin: auto;

            border-radius: 50%;

            display: flex;
            flex-direction: column;

            align-items: center;
            justify-content: center;

            position: relative;

            background:
                conic-gradient(
                    #4f46e5
                    <%= matchPercentage %>%,
                    #e2e8f0
                    <%= matchPercentage %>%
                );

            box-shadow:
                0 15px 40px rgba(79, 70, 229, 0.20);
        }

        .score-circle::before {
            content: "";

            position: absolute;

            width: 178px;
            height: 178px;

            border-radius: 50%;

            background: white;
        }

        .score-number {
            position: relative;
            z-index: 1;

            font-size: 48px;
            font-weight: 900;

            color: #1e293b;
        }

        .score-label {
            position: relative;
            z-index: 1;

            color: #64748b;

            font-size: 13px;
            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 1px;
        }

        .score-content h2 {
            font-size: 27px;
            margin-bottom: 12px;
        }

        .score-content h2 span {
            color: #4f46e5;
        }

        .score-message {
            color: #64748b;

            line-height: 1.7;

            margin-bottom: 20px;
        }

        .status {
            display: inline-flex;

            align-items: center;

            padding: 9px 16px;

            border-radius: 50px;

            font-size: 13px;
            font-weight: 800;
        }

        .status.excellent {
            background: #dcfce7;
            color: #15803d;
        }

        .status.good {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status.average {
            background: #fef3c7;
            color: #b45309;
        }

        .status.low {
            background: #fee2e2;
            color: #b91c1c;
        }

        .grid {
            display: grid;

            grid-template-columns:
                1fr
                1fr;

            gap: 25px;

            margin-bottom: 25px;
        }

        .card {
            background: white;

            border-radius: 22px;

            padding: 28px;

            box-shadow:
                0 12px 35px rgba(15, 23, 42, 0.07);

            border:
                1px solid rgba(15, 23, 42, 0.06);
        }

        .card-header {
            display: flex;
            align-items: center;

            gap: 12px;

            margin-bottom: 22px;
        }

        .card-icon {
            width: 42px;
            height: 42px;

            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 19px;
        }

        .matched-icon {
            background: #dcfce7;
        }

        .missing-icon {
            background: #fee2e2;
        }

        .job-icon {
            background: #eef2ff;
        }

        .resume-icon {
            background: #fef3c7;
        }

        .card-header h3 {
            font-size: 19px;
        }

        .skills {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .skill {
            padding: 9px 13px;

            border-radius: 10px;

            font-size: 13px;
            font-weight: 700;
        }

        .skill.matched {
            background: #ecfdf5;
            color: #047857;

            border:
                1px solid #bbf7d0;
        }

        .skill.missing {
            background: #fef2f2;
            color: #b91c1c;

            border:
                1px solid #fecaca;
        }

        .empty {
            color: #64748b;

            font-size: 14px;

            padding: 10px 0;
        }

        .details {
            display: grid;

            gap: 15px;
        }

        .detail {
            display: flex;
            justify-content: space-between;

            gap: 20px;

            padding-bottom: 13px;

            border-bottom:
                1px solid #f1f5f9;
        }

        .detail:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .detail-label {
            color: #64748b;
            font-size: 13px;
        }

        .detail-value {
            color: #1e293b;

            font-size: 14px;
            font-weight: 700;

            text-align: right;
        }

        .recommendation {
            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            border:
                1px solid #ddd6fe;

            border-radius: 22px;

            padding: 30px;

            margin-bottom: 25px;
        }

        .recommendation-header {
            display: flex;
            align-items: center;

            gap: 12px;

            margin-bottom: 15px;
        }

        .recommendation-icon {
            width: 45px;
            height: 45px;

            border-radius: 13px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #7c3aed;

            color: white;

            font-size: 20px;
        }

        .recommendation h3 {
            color: #312e81;
            font-size: 20px;
        }

        .recommendation p {
            color: #4338ca;

            line-height: 1.8;

            font-size: 15px;
        }

        .actions {
            display: flex;

            justify-content: center;

            gap: 14px;

            padding: 10px 0 45px;
        }

        .action-btn {
            text-decoration: none;

            padding: 13px 24px;

            border-radius: 12px;

            font-size: 14px;
            font-weight: 800;

            transition: 0.25s;
        }

        .action-btn.primary {
            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            box-shadow:
                0 8px 22px rgba(79, 70, 229, 0.23);
        }

        .action-btn.secondary {
            background: white;

            color: #475569;

            border:
                1px solid #e2e8f0;
        }

        .action-btn:hover {
            transform: translateY(-2px);
        }

        .footer {
            text-align: center;

            padding: 25px;

            color: #94a3b8;

            font-size: 13px;
        }

        @media (max-width: 800px) {

            .score-card {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .grid {
                grid-template-columns: 1fr;
            }

            .hero h1 {
                font-size: 32px;
            }

            .navbar {
                padding: 0 20px;
            }

            .brand {
                font-size: 21px;
            }

            .nav-btn {
                padding: 9px 12px;
            }

            .score-card {
                padding: 25px;
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

        HireNest

    </a>

    <div class="nav-actions">

        <a href="jobs.jsp"
           class="nav-btn secondary">
            Browse Jobs
        </a>

        <a href="student-dashboard.jsp"
           class="nav-btn primary">
            Dashboard
        </a>

    </div>

</nav>

<section class="hero">

    <div class="hero-badge">
        Resume Intelligence
    </div>

    <h1>
        Your Resume
        <span>Analysis</span>
    </h1>

    <p>
        See how well your resume matches this job opportunity.
    </p>

</section>

<main class="container">

    <section class="score-card">

        <div class="score-circle">

            <div class="score-number">
                <%= String.format("%.0f", matchPercentage) %>%
            </div>

            <div class="score-label">
                Match Score
            </div>

        </div>

        <div class="score-content">

            <h2>
                Resume Match:
                <span>
                    <%= String.format("%.2f", matchPercentage) %>%
                </span>
            </h2>

            <p class="score-message">

                Your resume was analyzed against the
                skills required for
                <strong>
                    <%= job.getJobTitle() %>
                </strong>.

            </p>

            <div class="status <%= matchClass %>">

                <%
                    if (matchPercentage >= 80) {
                %>
                    Excellent Match
                <%
                    } else if (matchPercentage >= 60) {
                %>
                    Good Match
                <%
                    } else if (matchPercentage >= 40) {
                %>
                    Moderate Match
                <%
                    } else {
                %>
                    Needs Improvement
                <%
                    }
                %>

            </div>

        </div>

    </section>

    <section class="grid">

        <div class="card">

            <div class="card-header">

                <div class="card-icon matched-icon">
                    +
                </div>

                <h3>
                    Matched Skills
                </h3>

            </div>

            <div class="skills">

                <%
                    if (matchedSkills.length == 0) {
                %>

                    <div class="empty">
                        No matching skills were detected.
                    </div>

                <%
                    } else {

                        for (String skill :
                                matchedSkills) {
                %>

                    <span class="skill matched">
                        <%= skill.trim() %>
                    </span>

                <%
                        }
                    }
                %>

            </div>

        </div>

        <div class="card">

            <div class="card-header">

                <div class="card-icon missing-icon">
                    !
                </div>

                <h3>
                    Missing Skills
                </h3>

            </div>

            <div class="skills">

                <%
                    if (missingSkills.length == 0) {
                %>

                    <div class="empty">
                        Excellent! No missing skills detected.
                    </div>

                <%
                    } else {

                        for (String skill :
                                missingSkills) {
                %>

                    <span class="skill missing">
                        <%= skill.trim() %>
                    </span>

                <%
                        }
                    }
                %>

            </div>

        </div>

    </section>

    <section class="grid">

        <div class="card">

            <div class="card-header">

                <div class="card-icon job-icon">
                    J
                </div>

                <h3>
                    Job Details
                </h3>

            </div>

            <div class="details">

                <div class="detail">

                    <span class="detail-label">
                        Position
                    </span>

                    <span class="detail-value">
                        <%= job.getJobTitle() %>
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Location
                    </span>

                    <span class="detail-value">
                        <%= job.getLocation() != null
                                ? job.getLocation()
                                : "Not specified" %>
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Salary
                    </span>

                    <span class="detail-value">
                        <%= job.getSalary() != null
                                ? job.getSalary()
                                : "Not specified" %>
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Required Skills
                    </span>

                    <span class="detail-value">
                        <%= job.getSkillsRequired() %>
                    </span>

                </div>

            </div>

        </div>

        <div class="card">

            <div class="card-header">

                <div class="card-icon resume-icon">
                    R
                </div>

                <h3>
                    Analyzed Resume
                </h3>

            </div>

            <div class="details">

                <div class="detail">

                    <span class="detail-label">
                        File Name
                    </span>

                    <span class="detail-value">
                        <%= resume.getFileName() %>
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Resume Status
                    </span>

                    <span class="detail-value">
                        Successfully Analyzed
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Match Score
                    </span>

                    <span class="detail-value">
                        <%= String.format(
                                "%.2f",
                                matchPercentage
                        ) %>%
                    </span>

                </div>

                <div class="detail">

                    <span class="detail-label">
                        Analysis ID
                    </span>

                    <span class="detail-value">
                        #<%= analysis.getAnalysisId() %>
                    </span>

                </div>

            </div>

        </div>

    </section>

    <section class="recommendation">

        <div class="recommendation-header">

            <div class="recommendation-icon">
                *
            </div>

            <h3>
                Career Recommendation
            </h3>

        </div>

        <p>
            <%= analysis.getRecommendations() %>
        </p>

    </section>

    <div class="actions">

        <a href="jobs.jsp"
           class="action-btn secondary">
            Back to Jobs
        </a>

        <a href="student-dashboard.jsp"
           class="action-btn primary">
            Go to Dashboard
        </a>

    </div>

</main>

<footer class="footer">

    HireNest &copy; 2026
    &nbsp;•&nbsp;
    Smart Career &amp; Placement Platform

</footer>

</body>

</html>