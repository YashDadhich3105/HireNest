<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.hirenest.model.Job" %>
<%@ page import="com.hirenest.dao.JobDAO" %>
<%@ page import="com.hirenest.dao.ApplicationDAO" %>

<%!
    private String safe(String value) {
        if (value == null || value.trim().isEmpty()) {
            return "Not specified";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
    if (session == null ||
            session.getAttribute("studentId") == null) {

        response.sendRedirect("student-login.jsp");
        return;
    }

    int studentId =
            (Integer) session.getAttribute("studentId");

    JobDAO jobDAO = new JobDAO();
    ApplicationDAO applicationDAO =
            new ApplicationDAO();

    List<Job> jobs =
            jobDAO.getAllJobs();

    Set<Integer> appliedJobIds =
            applicationDAO.getAppliedJobIds(studentId);

    String studentName =
            (String) session.getAttribute("studentName");

    if (studentName == null) {
        studentName = "Student";
    }
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
    font-family: "Segoe UI", Arial, sans-serif;
    background:
        radial-gradient(
            circle at 10% 0%,
            rgba(99,102,241,0.12),
            transparent 30%
        ),
        radial-gradient(
            circle at 90% 20%,
            rgba(124,58,237,0.10),
            transparent 30%
        ),
        #f8fafc;
    color: #172033;
    min-height: 100vh;
}

.navbar {
    height: 74px;
    background: rgba(255,255,255,0.94);
    backdrop-filter: blur(14px);
    border-bottom: 1px solid rgba(15,23,42,0.07);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 7%;
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 5px 25px rgba(15,23,42,0.06);
}

.brand {
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 11px;
    color: #4f46e5;
    font-size: 24px;
    font-weight: 900;
}

.brand-icon {
    width: 42px;
    height: 42px;
    border-radius: 13px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(
        135deg,
        #4f46e5,
        #7c3aed
    );
    color: white;
    box-shadow:
        0 8px 20px rgba(79,70,229,0.25);
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 12px;
}

.welcome {
    color: #64748b;
    font-size: 13px;
    font-weight: 600;
}

.nav-btn {
    text-decoration: none;
    padding: 10px 17px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 800;
    transition: 0.25s;
}

.nav-btn.dashboard {
    background: #eef2ff;
    color: #4f46e5;
}

.nav-btn.dashboard:hover {
    background: #e0e7ff;
    transform: translateY(-1px);
}

.hero {
    max-width: 1180px;
    margin: auto;
    padding: 55px 25px 30px;
}

.hero-badge {
    display: inline-flex;
    padding: 8px 15px;
    border-radius: 50px;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 12px;
    font-weight: 900;
    letter-spacing: 0.4px;
    margin-bottom: 17px;
}

.hero h1 {
    font-size: 43px;
    line-height: 1.15;
    letter-spacing: -1px;
    margin-bottom: 13px;
}

.hero h1 span {
    color: #4f46e5;
}

.hero p {
    color: #64748b;
    max-width: 650px;
    line-height: 1.7;
    font-size: 15px;
}

.stats {
    max-width: 1180px;
    margin: 0 auto 25px;
    padding: 0 25px;
    display: flex;
    gap: 14px;
}

.stat {
    background: white;
    border: 1px solid rgba(15,23,42,0.06);
    border-radius: 15px;
    padding: 13px 19px;
    box-shadow: 0 8px 25px rgba(15,23,42,0.05);
}

.stat-number {
    color: #4f46e5;
    font-size: 19px;
    font-weight: 900;
}

.stat-label {
    color: #64748b;
    font-size: 11px;
    margin-top: 2px;
}

.jobs-container {
    max-width: 1180px;
    margin: auto;
    padding: 0 25px 50px;
}

.jobs-grid {
    display: grid;
    grid-template-columns:
        repeat(2, minmax(0, 1fr));
    gap: 22px;
}

.job-card {
    background: rgba(255,255,255,0.96);
    border: 1px solid rgba(15,23,42,0.07);
    border-radius: 22px;
    padding: 25px;
    box-shadow:
        0 12px 35px rgba(15,23,42,0.06);
    transition:
        transform 0.25s,
        box-shadow 0.25s;
    position: relative;
    overflow: hidden;
}

.job-card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background:
        linear-gradient(
            90deg,
            #4f46e5,
            #7c3aed
        );
}

.job-card:hover {
    transform: translateY(-5px);
    box-shadow:
        0 20px 45px rgba(15,23,42,0.10);
}

.job-top {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 15px;
}

.job-title {
    font-size: 21px;
    font-weight: 900;
    color: #172033;
    margin-bottom: 6px;
}

.company-name {
    color: #4f46e5;
    font-size: 13px;
    font-weight: 800;
}

.job-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin: 18px 0;
}

.meta {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 7px 10px;
    border-radius: 9px;
    color: #475569;
    font-size: 12px;
    font-weight: 700;
}

.section-title {
    color: #334155;
    font-size: 11px;
    font-weight: 900;
    text-transform: uppercase;
    letter-spacing: 0.7px;
    margin-bottom: 8px;
}

.description {
    color: #64748b;
    font-size: 13px;
    line-height: 1.65;
    margin-bottom: 17px;
}

.skills-box {
    display: flex;
    flex-wrap: wrap;
    gap: 7px;
    margin-bottom: 19px;
}

.skill {
    background: #eef2ff;
    color: #4338ca;
    border: 1px solid #c7d2fe;
    padding: 6px 9px;
    border-radius: 8px;
    font-size: 11px;
    font-weight: 800;
}

.eligibility {
    color: #64748b;
    background: #f8fafc;
    border-radius: 11px;
    padding: 11px;
    font-size: 12px;
    line-height: 1.6;
    margin-bottom: 18px;
}

.deadline {
    color: #64748b;
    font-size: 11px;
    margin-bottom: 17px;
}

.actions {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}

.btn {
    border: none;
    min-height: 43px;
    border-radius: 11px;
    font-family: inherit;
    font-size: 12px;
    font-weight: 900;
    cursor: pointer;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.25s;
}

.btn:hover {
    transform: translateY(-2px);
}

.btn-apply {
    color: white;
    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );
    box-shadow:
        0 7px 18px rgba(79,70,229,0.20);
}

.btn-applied {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #bbf7d0;
    cursor: default;
}

.btn-applied:hover {
    transform: none;
}

.btn-analyze {
    color: #4f46e5;
    background: #eef2ff;
    border: 1px solid #c7d2fe;
}

.btn-analyze:hover {
    background: #e0e7ff;
}

.empty-state {
    background: white;
    border-radius: 22px;
    padding: 65px 30px;
    text-align: center;
    border: 1px solid #e2e8f0;
    box-shadow: 0 15px 40px rgba(15,23,42,0.06);
}

.empty-icon {
    width: 65px;
    height: 65px;
    border-radius: 18px;
    margin: 0 auto 17px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 27px;
    font-weight: 900;
}

.empty-state h2 {
    font-size: 22px;
    margin-bottom: 8px;
}

.empty-state p {
    color: #64748b;
    font-size: 14px;
}

.footer {
    text-align: center;
    padding: 25px;
    color: #94a3b8;
    font-size: 12px;
}

@media (max-width: 850px) {

    .jobs-grid {
        grid-template-columns: 1fr;
    }

    .hero h1 {
        font-size: 34px;
    }

    .navbar {
        padding: 0 20px;
    }

    .welcome {
        display: none;
    }
}

@media (max-width: 550px) {

    .actions {
        grid-template-columns: 1fr;
    }

    .stats {
        flex-wrap: wrap;
    }

    .hero {
        padding-top: 35px;
    }

    .job-card {
        padding: 20px;
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

    <div class="nav-right">

        <span class="welcome">
            Welcome, <%= safe(studentName) %>
        </span>

        <a href="student-dashboard.jsp"
           class="nav-btn dashboard">
            Dashboard
        </a>

    </div>

</nav>

<section class="hero">

    <div class="hero-badge">
        CAREER OPPORTUNITIES
    </div>

    <h1>
        Find Your Next
        <span>Opportunity.</span>
    </h1>

    <p>
        Discover jobs posted by companies on HireNest.
        Apply to opportunities and analyze how well your
        resume matches each position.
    </p>

</section>

<div class="stats">

    <div class="stat">

        <div class="stat-number">
            <%= jobs.size() %>
        </div>

        <div class="stat-label">
            Available Jobs
        </div>

    </div>

    <div class="stat">

        <div class="stat-number">
            <%= appliedJobIds.size() %>
        </div>

        <div class="stat-label">
            Jobs Applied
        </div>

    </div>

</div>

<main class="jobs-container">

<%
    if (jobs.isEmpty()) {
%>

    <div class="empty-state">

        <div class="empty-icon">
            J
        </div>

        <h2>
            No Jobs Available
        </h2>

        <p>
            There are currently no job opportunities
            posted by companies.
        </p>

    </div>

<%
    } else {
%>

    <div class="jobs-grid">

<%
        for (Job job : jobs) {

            boolean alreadyApplied =
                    appliedJobIds.contains(
                            job.getJobId()
                    );

            String skills =
                    job.getSkillsRequired();

            String[] skillList =
                    skills != null &&
                    !skills.trim().isEmpty()
                            ? skills.split("[,;|]+")
                            : new String[0];
%>

        <article class="job-card">

            <div class="job-top">

                <div>

                    <div class="job-title">
                        <%= safe(job.getJobTitle()) %>
                    </div>

                    <div class="company-name">
                        HireNest Company
                    </div>

                </div>

            </div>

            <div class="job-meta">

                <div class="meta">
                    Location:
                    <%= safe(job.getLocation()) %>
                </div>

                <div class="meta">
                    Salary:
                    <%= safe(job.getSalary()) %>
                </div>

            </div>

            <div class="section-title">
                Job Description
            </div>

            <div class="description">
                <%= safe(job.getJobDescription()) %>
            </div>

            <div class="section-title">
                Required Skills
            </div>

            <div class="skills-box">

<%
            if (skillList.length == 0) {
%>

                <span class="skill">
                    Not specified
                </span>

<%
            } else {

                for (String skill : skillList) {
%>

                <span class="skill">
                    <%= safe(skill.trim()) %>
                </span>

<%
                }
            }
%>

            </div>

            <div class="section-title">
                Eligibility
            </div>

            <div class="eligibility">
                <%= safe(job.getEligibilityCriteria()) %>
            </div>

            <div class="deadline">

                Application Deadline:
                <strong>
                    <%= job.getApplicationDeadline() != null
                            ? job.getApplicationDeadline()
                            : "Not specified" %>
                </strong>

            </div>

            <div class="actions">

<%
            if (alreadyApplied) {
%>

                <div class="btn btn-applied">
                    Applied
                </div>

<%
            } else {
%>

                <form action="apply-job"
                      method="post"
                      style="margin:0;">

                    <input
                        type="hidden"
                        name="jobId"
                        value="<%= job.getJobId() %>">

                    <button
                        type="submit"
                        class="btn btn-apply"
                        style="width:100%;">

                        Apply Now

                    </button>

                </form>

<%
            }
%>

                <form
                    action="analyze-resume"
                    method="post"
                    style="margin:0;">

                    <input
                        type="hidden"
                        name="jobId"
                        value="<%= job.getJobId() %>">

                    <button
                        type="submit"
                        class="btn btn-analyze"
                        style="width:100%;">

                        Analyze Resume

                    </button>

                </form>

            </div>

        </article>

<%
        }
%>

    </div>

<%
    }
%>

</main>

<footer class="footer">

    HireNest &copy; 2026
    &nbsp;•&nbsp;
    Smart Career &amp; Placement Platform

</footer>

</body>
</html>