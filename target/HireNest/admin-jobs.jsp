<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Job" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<Job> jobs =
            (List<Job>) request.getAttribute("jobs");

    String search =
            (String) request.getAttribute("search");

    if (jobs == null) {
        jobs = new java.util.ArrayList<>();
    }

    if (search == null) {
        search = "";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Jobs | HireNest</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
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
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
        }

        .brand span {
            color: #64d8ff;
        }

        .nav-links {
            display: flex;
            gap: 12px;
        }

        .nav-links a {
            text-decoration: none;
            color: #dce3ef;
            padding: 9px 14px;
            border-radius: 8px;
            font-size: 14px;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.08);
        }

        .container {
            max-width: 1450px;
            margin: auto;
            padding: 35px 25px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 6px;
        }

        .header p {
            color: #697386;
        }

        .search {
            display: flex;
            gap: 10px;
        }

        .search input {
            width: 300px;
            padding: 13px 15px;
            border: 1px solid #dce2ea;
            border-radius: 10px;
            outline: none;
            background: white;
        }

        .search button {
            border: none;
            padding: 13px 20px;
            border-radius: 10px;
            background: #101828;
            color: white;
            font-weight: 700;
            cursor: pointer;
        }

        .table-wrapper {
            background: white;
            border-radius: 18px;
            border: 1px solid #e4e8ef;
            overflow-x: auto;
            box-shadow: 0 8px 25px rgba(16,24,40,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        th {
            text-align: left;
            padding: 17px;
            background: #f8fafc;
            color: #596579;
            font-size: 13px;
            text-transform: uppercase;
        }

        td {
            padding: 17px;
            border-top: 1px solid #edf0f4;
            font-size: 14px;
            vertical-align: top;
        }

        .job-title {
            font-weight: 700;
        }

        .company {
            color: #3157a6;
            font-weight: 600;
        }

        .muted {
            color: #718096;
        }

        .description {
            max-width: 250px;
            line-height: 1.5;
        }

        .skill {
            display: inline-block;
            background: #eef5ff;
            color: #3157a6;
            padding: 5px 8px;
            border-radius: 8px;
            font-size: 11px;
            margin: 2px;
        }

        .delete-btn {
            border: none;
            background: #fee2e2;
            color: #dc2626;
            padding: 9px 13px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
        }

        .delete-btn:hover {
            background: #fecaca;
        }

        .empty {
            padding: 60px;
            text-align: center;
            color: #718096;
        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="brand">
        Hire<span>Nest</span> Admin
    </div>

    <div class="nav-links">

        <a href="admin-dashboard">Dashboard</a>

        <a href="admin-students">Students</a>

        <a href="admin-companies">Companies</a>

        <a href="admin-applications">Applications</a>

        <a href="admin-logout">Logout</a>

    </div>

</nav>

<main class="container">

    <div class="header">

        <div>

            <h1>Manage Jobs</h1>

            <p>
                Monitor and manage all jobs posted by companies.
            </p>

        </div>

        <form
                action="admin-jobs"
                method="get"
                class="search">

            <input
                    type="text"
                    name="search"
                    value="<%= search %>"
                    placeholder="Search jobs..."
            >

            <button type="submit">
                Search
            </button>

        </form>

    </div>

    <div class="table-wrapper">

        <% if (jobs.isEmpty()) { %>

            <div class="empty">
                No jobs found.
            </div>

        <% } else { %>

        <table>

            <thead>

            <tr>
                <th>ID</th>
                <th>Job</th>
                <th>Company</th>
                <th>Location</th>
                <th>Salary</th>
                <th>Skills</th>
                <th>Deadline</th>
                <th>Action</th>
            </tr>

            </thead>

            <tbody>

            <% for (Job job : jobs) { %>

            <tr>

                <td>
                    #<%= job.getJobId() %>
                </td>

                <td>

                    <div class="job-title">
                        <%= job.getJobTitle() %>
                    </div>

                    <div class="muted description">
                        <%= job.getJobDescription() %>
                    </div>

                </td>

                <td class="company">
                    <%= job.getCompanyName() %>
                </td>

                <td>
                    <%= job.getLocation() %>
                </td>

                <td>
                    <%= job.getSalary() %>
                </td>

                <td>

                    <%
                        String skills =
                                job.getSkillsRequired();

                        if (skills != null &&
                                !skills.trim().isEmpty()) {

                            String[] skillList =
                                    skills.split(",");
                    %>

                        <% for (String skill : skillList) { %>

                            <span class="skill">
                                <%= skill.trim() %>
                            </span>

                        <% } %>

                    <% } else { %>

                        <span class="muted">
                            Not specified
                        </span>

                    <% } %>

                </td>

                <td>
                    <%= job.getApplicationDeadline() %>
                </td>

                <td>

                    <form
                            action="admin-jobs"
                            method="post"
                            onsubmit="return confirm('Delete this job? Related applications may also be affected.');">

                        <input
                                type="hidden"
                                name="action"
                                value="delete">

                        <input
                                type="hidden"
                                name="jobId"
                                value="<%= job.getJobId() %>">

                        <button
                                type="submit"
                                class="delete-btn">

                            Delete

                        </button>

                    </form>

                </td>

            </tr>

            <% } %>

            </tbody>

        </table>

        <% } %>

    </div>

</main>

</body>

</html>