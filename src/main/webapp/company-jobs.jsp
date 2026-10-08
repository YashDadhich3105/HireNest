<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Job" %>
<%@ page import="com.hirenest.dao.JobDAO" %>

<%
    Object companyIdObj = session.getAttribute("companyId");

    if (companyIdObj == null) {
        response.sendRedirect("company-login.jsp");
        return;
    }

    int companyId = (Integer) companyIdObj;

    JobDAO jobDAO = new JobDAO();
    List<Job> jobs = jobDAO.getJobsByCompany(companyId);

    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Jobs | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f6fb;
            color: #202336;
            min-height: 100vh;
        }

        .navbar {
            height: 72px;
            background: white;
            border-bottom: 1px solid #e5e6ed;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
        }

        .brand {
            text-decoration: none;
            font-size: 24px;
            font-weight: 800;
            color: #101322;
        }

        .brand span {
            color: #6c63ff;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-links a {
            text-decoration: none;
            color: #555b70;
            font-size: 14px;
            font-weight: 600;
            padding: 10px 15px;
            border-radius: 10px;
        }

        .nav-links a:hover {
            background: #f0efff;
            color: #6c63ff;
        }

        .container {
            width: min(1100px, 92%);
            margin: 50px auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 38px;
            margin-bottom: 8px;
        }

        .header p {
            color: #73788c;
            font-size: 15px;
        }

        .post-btn {
            text-decoration: none;
            background: linear-gradient(135deg, #6c63ff, #887cff);
            color: white;
            padding: 13px 20px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            box-shadow: 0 10px 25px rgba(108, 99, 255, 0.22);
        }

        .post-btn:hover {
            transform: translateY(-1px);
        }

        .success {
            background: #eafaf0;
            border: 1px solid #bce8ca;
            color: #16733a;
            padding: 14px 17px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .empty {
            background: white;
            border: 1px solid #e4e6ef;
            border-radius: 20px;
            padding: 60px 30px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(25, 29, 55, 0.06);
        }

        .empty-icon {
            width: 65px;
            height: 65px;
            border-radius: 18px;
            background: #eeedff;
            color: #6c63ff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 28px;
            font-weight: 800;
        }

        .empty h2 {
            margin-bottom: 10px;
        }

        .empty p {
            color: #73788c;
            margin-bottom: 25px;
        }

        .job-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px;
        }

        .job-card {
            background: white;
            border: 1px solid #e4e6ef;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 15px 40px rgba(25, 29, 55, 0.06);
            transition: 0.25s ease;
        }

        .job-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 45px rgba(25, 29, 55, 0.10);
        }

        .job-title {
            font-size: 22px;
            margin-bottom: 15px;
            color: #101322;
        }

        .job-info {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 18px;
        }

        .tag {
            background: #f0efff;
            color: #5c54dc;
            padding: 7px 10px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
        }

        .description {
            color: #62677a;
            line-height: 1.6;
            font-size: 14px;
            margin-bottom: 18px;
        }

        .requirements {
            border-top: 1px solid #eeeeF3;
            padding-top: 18px;
        }

        .requirements strong {
            display: block;
            font-size: 13px;
            margin-bottom: 7px;
        }

        .requirements p {
            color: #73788c;
            font-size: 13px;
            line-height: 1.5;
        }

        .deadline {
            margin-top: 18px;
            padding-top: 15px;
            border-top: 1px solid #eeeeF3;
            font-size: 13px;
            color: #73788c;
        }

        .deadline strong {
            color: #303447;
        }

        @media (max-width: 750px) {

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .job-grid {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 0 4%;
            }

            .nav-links a {
                padding: 8px;
            }

            .container {
                width: 94%;
                margin-top: 35px;
            }

            .header h1 {
                font-size: 30px;
            }

        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="company-dashboard.jsp" class="brand">
        Hire<span>Nest</span>
    </a>

    <div class="nav-links">

        <a href="company-dashboard.jsp">
            Dashboard
        </a>

        <a href="company-post-job.jsp">
            Post Job
        </a>

        <a href="company-logout">
            Logout
        </a>

    </div>

</nav>


<main class="container">

    <div class="header">

        <div>

            <h1>My Jobs</h1>

            <p>
                Manage the job opportunities posted by your company.
            </p>

        </div>

        <a href="company-post-job.jsp"
           class="post-btn">
            + Post New Job
        </a>

    </div>


    <% if (success != null && !success.trim().isEmpty()) { %>

        <div class="success">
            <%= success %>
        </div>

    <% } %>


    <% if (jobs == null || jobs.isEmpty()) { %>

        <div class="empty">

            <div class="empty-icon">
                +
            </div>

            <h2>No Jobs Posted Yet</h2>

            <p>
                Start by creating your first job opportunity.
            </p>

            <a href="company-post-job.jsp"
               class="post-btn">
                Post Your First Job
            </a>

        </div>

    <% } else { %>

        <div class="job-grid">

            <% for (Job job : jobs) { %>

                <div class="job-card">

                    <h2 class="job-title">
                        <%= job.getJobTitle() %>
                    </h2>

                    <div class="job-info">

                        <% if (job.getLocation() != null &&
                               !job.getLocation().trim().isEmpty()) { %>

                            <span class="tag">
                                📍 <%= job.getLocation() %>
                            </span>

                        <% } %>


                        <% if (job.getSalary() != null &&
                               !job.getSalary().trim().isEmpty()) { %>

                            <span class="tag">
                                ₹ <%= job.getSalary() %>
                            </span>

                        <% } %>

                    </div>


                    <% if (job.getJobDescription() != null &&
                           !job.getJobDescription().trim().isEmpty()) { %>

                        <div class="description">
                            <%= job.getJobDescription() %>
                        </div>

                    <% } %>


                    <% if (job.getSkillsRequired() != null &&
                           !job.getSkillsRequired().trim().isEmpty()) { %>

                        <div class="requirements">

                            <strong>
                                Required Skills
                            </strong>

                            <p>
                                <%= job.getSkillsRequired() %>
                            </p>

                        </div>

                    <% } %>


                    <% if (job.getEligibilityCriteria() != null &&
                           !job.getEligibilityCriteria().trim().isEmpty()) { %>

                        <div class="requirements">

                            <strong>
                                Eligibility
                            </strong>

                            <p>
                                <%= job.getEligibilityCriteria() %>
                            </p>

                        </div>

                    <% } %>


                    <% if (job.getApplicationDeadline() != null) { %>

                        <div class="deadline">

                            <strong>
                                Application Deadline:
                            </strong>

                            <%= job.getApplicationDeadline() %>

                        </div>

                    <% } %>

                </div>

            <% } %>

        </div>

    <% } %>

</main>

</body>

</html>