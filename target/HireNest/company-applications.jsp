<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Application" %>

<%
    Object companyIdObject = session.getAttribute("companyId");

    if (companyIdObject == null) {
        response.sendRedirect("company-login.jsp");
        return;
    }

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");

    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Applications | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #6c63ff;
            --primary-dark: #5148e5;
            --dark: #111322;
            --text: #25283a;
            --muted: #777c91;
            --border: #e7e8f0;
            --background: #f5f6fb;
            --white: #ffffff;
            --green: #138a55;
            --green-bg: #e9f8f0;
            --red: #d43855;
            --red-bg: #fff0f3;
            --blue: #3d68d8;
            --blue-bg: #edf3ff;
        }

        body {
            min-height: 100vh;
            font-family: Arial, sans-serif;
            color: var(--text);
            background:
                radial-gradient(
                    circle at 5% 5%,
                    rgba(108, 99, 255, 0.13),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 95% 10%,
                    rgba(55, 190, 255, 0.10),
                    transparent 25%
                ),
                var(--background);
        }

        .navbar {
            height: 76px;
            padding: 0 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255,255,255,0.90);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--dark);
        }

        .brand-icon {
            width: 43px;
            height: 43px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 800;
            background: linear-gradient(135deg, #6c63ff, #8d7dff);
            box-shadow: 0 8px 22px rgba(108,99,255,0.28);
        }

        .brand-name {
            font-size: 22px;
            font-weight: 800;
        }

        .brand-name span {
            color: var(--primary);
        }

        .nav-link {
            text-decoration: none;
            color: #555a70;
            font-size: 14px;
            font-weight: 700;
            padding: 11px 17px;
            border-radius: 11px;
            transition: 0.25s;
        }

        .nav-link:hover {
            color: var(--primary);
            background: #f0efff;
        }

        .page {
            width: min(1250px, 92%);
            margin: 50px auto 80px;
        }

        .hero {
            margin-bottom: 30px;
        }

        .eyebrow {
            display: inline-flex;
            padding: 8px 13px;
            border-radius: 999px;
            background: #eeedff;
            color: var(--primary);
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        h1 {
            font-size: clamp(32px, 5vw, 48px);
            line-height: 1.08;
            color: var(--dark);
            margin-bottom: 12px;
        }

        .hero p {
            max-width: 700px;
            color: var(--muted);
            line-height: 1.7;
            font-size: 15px;
        }

        .message {
            padding: 14px 17px;
            border-radius: 13px;
            margin-bottom: 22px;
            font-size: 14px;
            font-weight: 600;
        }

        .success {
            background: var(--green-bg);
            border: 1px solid #bce8d2;
            color: var(--green);
        }

        .error {
            background: var(--red-bg);
            border: 1px solid #ffc7d2;
            color: var(--red);
        }

        .applications {
            display: grid;
            gap: 20px;
        }

        .application-card {
            background: rgba(255,255,255,0.95);
            border: 1px solid var(--border);
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 18px 55px rgba(25,29,55,0.07);
            transition: 0.25s ease;
        }

        .application-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 24px 65px rgba(25,29,55,0.11);
        }

        .top {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            align-items: flex-start;
            margin-bottom: 22px;
        }

        .job-title {
            font-size: 21px;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 7px;
        }

        .student-name {
            color: var(--primary);
            font-size: 14px;
            font-weight: 700;
        }

        .status {
            padding: 8px 13px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            white-space: nowrap;
        }

        .status-applied {
            background: var(--blue-bg);
            color: var(--blue);
        }

        .status-accepted {
            background: var(--green-bg);
            color: var(--green);
        }

        .status-rejected {
            background: var(--red-bg);
            color: var(--red);
        }

        .details {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            padding: 18px;
            border-radius: 15px;
            background: #fafaff;
            border: 1px solid #eeeef5;
        }

        .detail {
            min-width: 0;
        }

        .detail-label {
            color: #9297a9;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .detail-value {
            color: #33374b;
            font-size: 13px;
            font-weight: 700;
            word-break: break-word;
        }

        .candidate-section {
            margin-top: 18px;
            padding: 20px;
            border-radius: 16px;
            background: linear-gradient(
                135deg,
                #f8f7ff,
                #f8fbff
            );
            border: 1px solid #e9e8f5;
        }

        .candidate-title {
            font-size: 14px;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 15px;
        }

        .candidate-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .candidate-item {
            min-width: 0;
        }

        .candidate-label {
            font-size: 10px;
            font-weight: 800;
            color: #969bad;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .candidate-value {
            font-size: 13px;
            font-weight: 700;
            color: #33374b;
            word-break: break-word;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .action-form {
            margin: 0;
        }

        .btn {
            border: none;
            cursor: pointer;
            padding: 11px 17px;
            border-radius: 11px;
            font-size: 13px;
            font-weight: 800;
            transition: 0.25s ease;
        }

        .btn-accept {
            color: white;
            background: linear-gradient(
                135deg,
                #159b61,
                #25b979
            );
            box-shadow: 0 8px 18px rgba(21,155,97,0.20);
        }

        .btn-accept:hover {
            transform: translateY(-2px);
        }

        .btn-reject {
            color: var(--red);
            background: var(--red-bg);
            border: 1px solid #ffc7d2;
        }

        .btn-reject:hover {
            background: #ffe4e9;
        }

        .empty {
            background: rgba(255,255,255,0.95);
            border: 1px solid var(--border);
            border-radius: 22px;
            padding: 70px 25px;
            text-align: center;
            box-shadow: 0 18px 55px rgba(25,29,55,0.07);
        }

        .empty-icon {
            width: 65px;
            height: 65px;
            margin: 0 auto 18px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eeedff;
            color: var(--primary);
            font-size: 28px;
            font-weight: 800;
        }

        .empty h2 {
            color: var(--dark);
            margin-bottom: 9px;
        }

        .empty p {
            color: var(--muted);
            font-size: 14px;
        }

        @media (max-width: 950px) {

            .details {
                grid-template-columns: repeat(2, 1fr);
            }

            .candidate-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 5%;
            }

            .brand-name {
                font-size: 19px;
            }

            .nav-link {
                padding: 8px;
            }

            .page {
                width: 94%;
                margin-top: 35px;
            }

            .top {
                flex-direction: column;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .candidate-grid {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="company-dashboard.jsp" class="brand">

        <div class="brand-icon">H</div>

        <div class="brand-name">
            Hire<span>Nest</span>
        </div>

    </a>

    <a href="company-dashboard.jsp" class="nav-link">
        ← Dashboard
    </a>

</nav>

<main class="page">

    <section class="hero">

        <div class="eyebrow">
            ✦ Candidate Management
        </div>

        <h1>Job Applications</h1>

        <p>
            Review candidates who have applied to your job listings
            and manage their application status from one place.
        </p>

    </section>

    <% if (success != null) { %>

        <div class="message success">
            ✓ <%= success %>
        </div>

    <% } %>

    <% if (error != null) { %>

        <div class="message error">
            ⚠ <%= error %>
        </div>

    <% } %>

    <% if (applications == null || applications.isEmpty()) { %>

        <div class="empty">

            <div class="empty-icon">
                ✓
            </div>

            <h2>No Applications Yet</h2>

            <p>
                Applications from students will appear here when they
                apply for your job listings.
            </p>

        </div>

    <% } else { %>

        <div class="applications">

            <% for (Application app : applications) { %>

                <%
                    String status = app.getApplicationStatus();

                    String statusClass = "status-applied";

                    if ("Accepted".equalsIgnoreCase(status)) {
                        statusClass = "status-accepted";
                    } else if ("Rejected".equalsIgnoreCase(status)) {
                        statusClass = "status-rejected";
                    }
                %>

                <article class="application-card">

                    <div class="top">

                        <div>

                            <div class="job-title">
                                <%= app.getJobTitle() != null
                                        ? app.getJobTitle()
                                        : "Job Position" %>
                            </div>

                            <div class="student-name">
                                <%= app.getStudentName() != null
                                        ? app.getStudentName()
                                        : "Student ID: " + app.getStudentId() %>
                            </div>

                        </div>

                        <div class="status <%= statusClass %>">
                            <%= status != null ? status : "Applied" %>
                        </div>

                    </div>

                    <div class="details">

                        <div class="detail">

                            <div class="detail-label">
                                Location
                            </div>

                            <div class="detail-value">
                                <%= app.getLocation() != null
                                        ? app.getLocation()
                                        : "Not specified" %>
                            </div>

                        </div>

                        <div class="detail">

                            <div class="detail-label">
                                Salary
                            </div>

                            <div class="detail-value">
                                <%= app.getSalary() != null
                                        ? app.getSalary()
                                        : "Not specified" %>
                            </div>

                        </div>

                        <div class="detail">

                            <div class="detail-label">
                                Applied On
                            </div>

                            <div class="detail-value">
                                <%= app.getAppliedAt() != null
                                        ? app.getAppliedAt()
                                        : "Not available" %>
                            </div>

                        </div>

                        <div class="detail">

                            <div class="detail-label">
                                Application ID
                            </div>

                            <div class="detail-value">
                                #<%= app.getApplicationId() %>
                            </div>

                        </div>

                    </div>

                    <div class="candidate-section">

                        <div class="candidate-title">
                            Candidate Information
                        </div>

                        <div class="candidate-grid">

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Full Name
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentName() != null
                                            ? app.getStudentName()
                                            : "Not available" %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Email
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentEmail() != null
                                            ? app.getStudentEmail()
                                            : "Not available" %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Phone
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentPhone() != null
                                            ? app.getStudentPhone()
                                            : "Not available" %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Course
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentCourse() != null
                                            ? app.getStudentCourse()
                                            : "Not available" %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Branch
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentBranch() != null
                                            ? app.getStudentBranch()
                                            : "Not available" %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    CGPA
                                </div>

                                <div class="candidate-value">
                                    <%= String.format(
                                            "%.2f",
                                            app.getStudentCgpa()
                                    ) %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Graduation Year
                                </div>

                                <div class="candidate-value">
                                    <%= app.getStudentGraduationYear() %>
                                </div>

                            </div>

                            <div class="candidate-item">

                                <div class="candidate-label">
                                    Student ID
                                </div>

                                <div class="candidate-value">
                                    #<%= app.getStudentId() %>
                                </div>

                            </div>

                        </div>

                    </div>

                    <% if (!"Accepted".equalsIgnoreCase(status)
                            && !"Rejected".equalsIgnoreCase(status)) { %>

                        <div class="actions">

                            <form
                                    class="action-form"
                                    action="company-applications"
                                    method="post">

                                <input
                                        type="hidden"
                                        name="applicationId"
                                        value="<%= app.getApplicationId() %>">

                                <input
                                        type="hidden"
                                        name="status"
                                        value="Rejected">

                                <button
                                        type="submit"
                                        class="btn btn-reject">

                                    Reject

                                </button>

                            </form>

                            <form
                                    class="action-form"
                                    action="company-applications"
                                    method="post">

                                <input
                                        type="hidden"
                                        name="applicationId"
                                        value="<%= app.getApplicationId() %>">

                                <input
                                        type="hidden"
                                        name="status"
                                        value="Accepted">

                                <button
                                        type="submit"
                                        class="btn btn-accept">

                                    Accept

                                </button>

                            </form>

                        </div>

                    <% } %>

                </article>

            <% } %>

        </div>

    <% } %>

</main>

</body>

</html>