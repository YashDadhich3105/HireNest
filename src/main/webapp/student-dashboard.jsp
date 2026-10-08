<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.hirenest.dao.ResumeDAO" %>
<%@ page import="com.hirenest.dao.NotificationDAO" %>
<%@ page import="com.hirenest.model.Resume" %>

<%
    Object student = session.getAttribute("student");

    if (student == null || session.getAttribute("studentId") == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }

    String studentName = (String) session.getAttribute("studentName");
    String studentEmail = (String) session.getAttribute("studentEmail");

    if (studentName == null || studentName.trim().isEmpty()) {
        studentName = "Student";
    }

    if (studentEmail == null) {
        studentEmail = "";
    }

    int studentId = (Integer) session.getAttribute("studentId");

    ResumeDAO resumeDAO = new ResumeDAO();
    Resume resume = resumeDAO.getResume(studentId);

    NotificationDAO notificationDAO = new NotificationDAO();
    int unreadCount = notificationDAO.getUnreadCount(studentId);

    String resumeSuccess = request.getParameter("resumeSuccess");
    String resumeError = request.getParameter("resumeError");
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background:
                radial-gradient(circle at top left, rgba(102, 93, 245, 0.08), transparent 30%),
                #f5f6fb;
            color: #202336;
            min-height: 100vh;
        }

        .navbar {
            height: 76px;
            background: rgba(255, 255, 255, 0.94);
            backdrop-filter: blur(14px);
            border-bottom: 1px solid #e5e6ee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 25px;
            font-weight: 900;
            letter-spacing: -0.8px;
            color: #17192b;
        }

        .logo span {
            color: #665df5;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .notification-btn {
            position: relative;
            width: 43px;
            height: 43px;
            border-radius: 13px;
            background: #f7f7ff;
            border: 1px solid #e7e6ff;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: #5d55e8;
            font-size: 20px;
            transition: 0.2s;
        }

        .notification-btn:hover {
            background: #6258f5;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(98, 88, 245, 0.22);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            min-width: 19px;
            height: 19px;
            padding: 0 5px;
            border-radius: 20px;
            background: #ef4444;
            color: white;
            border: 2px solid white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 9px;
            font-weight: 900;
            line-height: 1;
        }

        .profile-mini {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 7px 13px 7px 7px;
            background: #f7f7ff;
            border: 1px solid #e7e6ff;
            border-radius: 30px;
        }

        .profile-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 800;
        }

        .profile-mini span {
            font-size: 13px;
            font-weight: 700;
            color: #353750;
        }

        .logout {
            text-decoration: none;
            padding: 10px 17px;
            border-radius: 10px;
            background: #f0efff;
            color: #5d55e8;
            font-size: 13px;
            font-weight: 700;
            transition: 0.2s;
            border: 1px solid #e1dfff;
            cursor: pointer;
        }

        .logout:hover {
            background: #6258f5;
            color: white;
            border-color: #6258f5;
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(98, 88, 245, 0.2);
        }

        .container {
            width: min(1120px, 92%);
            margin: 42px auto 70px;
        }

        .welcome {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            padding: 42px;
            border-radius: 26px;
            margin-bottom: 25px;
            box-shadow: 0 20px 50px rgba(98, 88, 245, 0.22);
        }

        .welcome::before {
            content: "";
            position: absolute;
            width: 230px;
            height: 230px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            right: -70px;
            top: -80px;
        }

        .welcome::after {
            content: "";
            position: absolute;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.06);
            right: 130px;
            bottom: -90px;
        }

        .welcome-content {
            position: relative;
            z-index: 2;
        }

        .welcome-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.13);
            border: 1px solid rgba(255, 255, 255, 0.15);
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 18px;
        }

        .welcome h1 {
            font-size: 36px;
            line-height: 1.15;
            margin-bottom: 12px;
            letter-spacing: -1px;
        }

        .welcome p {
            color: #eeeeff;
            font-size: 15px;
            line-height: 1.7;
            max-width: 600px;
        }

        .email {
            margin-top: 16px;
            font-size: 13px;
            color: #eeeeff;
            opacity: 0.9;
        }

        .section-title {
            margin: 30px 0 15px;
        }

        .section-title h2 {
            font-size: 20px;
            margin-bottom: 5px;
        }

        .section-title p {
            color: #818497;
            font-size: 13px;
        }

        .resume-section {
            background: white;
            border: 1px solid #e5e6ee;
            border-radius: 22px;
            padding: 25px;
            box-shadow: 0 12px 35px rgba(30, 35, 70, 0.06);
            margin-bottom: 30px;
        }

        .resume-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 20px;
        }

        .resume-title {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .resume-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: #eeedff;
            color: #6258f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .resume-title h3 {
            font-size: 17px;
            margin-bottom: 4px;
        }

        .resume-title p {
            color: #858899;
            font-size: 12px;
        }

        .resume-status {
            padding: 7px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
            background: #edf9f2;
            color: #1d8b50;
        }

        .resume-upload {
            border: 2px dashed #dddcef;
            border-radius: 17px;
            padding: 23px;
            background: #fafaff;
        }

        .resume-upload form {
            display: flex;
            align-items: center;
            gap: 14px;
            flex-wrap: wrap;
        }

        .file-input {
            flex: 1;
            min-width: 250px;
            padding: 12px;
            border: 1px solid #dddfea;
            border-radius: 10px;
            background: white;
            font-size: 13px;
            color: #55596e;
        }

        .upload-btn {
            border: none;
            padding: 13px 21px;
            border-radius: 10px;
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(98, 88, 245, 0.2);
            transition: 0.2s;
        }

        .upload-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(98, 88, 245, 0.28);
        }

        .file-note {
            margin-top: 12px;
            color: #8a8d9d;
            font-size: 11px;
        }

        .current-resume {
            margin-top: 18px;
            padding: 15px;
            border-radius: 13px;
            background: #f7f7fc;
            border: 1px solid #e9e9f2;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
        }

        .current-resume-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #ecebff;
            color: #6258f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
        }

        .current-resume-info strong {
            display: block;
            font-size: 13px;
            margin-bottom: 4px;
            max-width: 550px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .current-resume-info span {
            font-size: 11px;
            color: #898c9e;
        }

        .alert {
            padding: 13px 15px;
            border-radius: 11px;
            margin-bottom: 17px;
            font-size: 13px;
            font-weight: 700;
        }

        .alert-success {
            background: #edf9f2;
            color: #237b4b;
            border: 1px solid #ccebd9;
        }

        .alert-error {
            background: #fff1f1;
            color: #bd4242;
            border: 1px solid #f3cccc;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .card {
            background: white;
            border: 1px solid #e5e6ee;
            border-radius: 20px;
            padding: 27px;
            text-decoration: none;
            color: #202336;
            transition: 0.25s;
            box-shadow: 0 12px 35px rgba(30, 35, 70, 0.06);
            position: relative;
            overflow: hidden;
        }

        .card::after {
            content: "";
            position: absolute;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #f5f4ff;
            right: -45px;
            bottom: -45px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(30, 35, 70, 0.11);
            border-color: #dcd9ff;
        }

        .icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: #eeedff;
            color: #6258f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
            margin-bottom: 20px;
            position: relative;
            z-index: 2;
        }

        .notification-card .icon {
            background: #fff1f1;
            color: #ef4444;
        }

        .card h3 {
            margin-bottom: 8px;
            font-size: 17px;
            position: relative;
            z-index: 2;
        }

        .card p {
            color: #777b8e;
            font-size: 13px;
            line-height: 1.6;
            position: relative;
            z-index: 2;
        }

        .arrow {
            margin-top: 17px;
            display: inline-block;
            color: #6258f5;
            font-size: 12px;
            font-weight: 800;
            position: relative;
            z-index: 2;
        }

        .notification-card .arrow {
            color: #ef4444;
        }

        .bell-icon {
            font-size: 20px;
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .notification-btn:hover .bell-icon {
            transform: scale(1.08);
        }

        @media (max-width: 1050px) {

            .cards {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 850px) {

            .resume-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .profile-mini {
                display: none;
            }

            .welcome h1 {
                font-size: 30px;
            }
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 4%;
            }

            .nav-right {
                gap: 8px;
            }

            .logout {
                padding: 9px 12px;
                font-size: 12px;
            }

            .container {
                width: 92%;
                margin-top: 25px;
            }

            .welcome {
                padding: 29px;
                border-radius: 21px;
            }

            .welcome h1 {
                font-size: 27px;
            }

            .resume-section {
                padding: 19px;
            }

            .resume-upload {
                padding: 17px;
            }

            .file-input {
                min-width: 100%;
            }

            .upload-btn {
                width: 100%;
            }

            .current-resume {
                align-items: flex-start;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 23px;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        Hire<span>Nest</span>
    </div>

    <div class="nav-right">

        <a href="notifications"
           class="notification-btn"
           title="Notifications">

            <span class="bell-icon">
                &#128276;
            </span>

            <% if (unreadCount > 0) { %>

                <span class="notification-badge">
                    <%= unreadCount > 99 ? "99+" : unreadCount %>
                </span>

            <% } %>

        </a>

        <div class="profile-mini">

            <div class="profile-avatar">
                <%= studentName.substring(0, 1).toUpperCase() %>
            </div>

            <span>
                <%= studentName %>
            </span>

        </div>

        <a href="student-logout"
           class="logout"
           onclick="return confirmLogout();">

            Logout

        </a>

    </div>

</nav>

<main class="container">

    <section class="welcome">

        <div class="welcome-content">

            <div class="welcome-label">
                Student Dashboard
            </div>

            <h1>
                Welcome, <%= studentName %>
            </h1>

            <p>
                Explore opportunities, manage your applications and build your career with HireNest.
            </p>

            <div class="email">
                <%= studentEmail %>
            </div>

        </div>

    </section>

    <% if (resumeSuccess != null) { %>

        <div class="alert alert-success">
            <%= resumeSuccess %>
        </div>

    <% } %>

    <% if (resumeError != null) { %>

        <div class="alert alert-error">
            <%= resumeError %>
        </div>

    <% } %>

    <section class="resume-section">

        <div class="resume-header">

            <div class="resume-title">

                <div class="resume-icon">
                    📄
                </div>

                <div>

                    <h3>
                        Your Resume
                    </h3>

                    <p>
                        Upload your latest resume to improve your opportunities.
                    </p>

                </div>

            </div>

            <% if (resume != null) { %>

                <div class="resume-status">
                    Resume Uploaded
                </div>

            <% } else { %>

                <div class="resume-status"
                     style="background:#fff6e8;color:#b87513;">
                    Not Uploaded
                </div>

            <% } %>

        </div>

        <div class="resume-upload">

            <form action="upload-resume"
                  method="post"
                  enctype="multipart/form-data">

                <input
                    type="file"
                    name="resume"
                    class="file-input"
                    accept=".pdf,.doc,.docx"
                    required
                >

                <button type="submit" class="upload-btn">
                    Upload Resume
                </button>

            </form>

            <div class="file-note">
                Accepted formats: PDF, DOC, DOCX &nbsp; | &nbsp; Maximum size: 5 MB
            </div>

        </div>

        <% if (resume != null) { %>

            <div class="current-resume">

                <div class="current-resume-info">

                    <div class="file-icon">
                        📎
                    </div>

                    <div>

                        <strong title="<%= resume.getFileName() %>">
                            <%= resume.getFileName() %>
                        </strong>

                        <span>
                            Uploaded on <%= resume.getUploadedAt() %>
                        </span>

                    </div>

                </div>

            </div>

        <% } %>

    </section>

    <div class="section-title">

        <h2>
            Career Center
        </h2>

        <p>
            Everything you need to manage your placement journey.
        </p>

    </div>

    <section class="cards">

        <a href="jobs.jsp" class="card">

            <div class="icon">
                💼
            </div>

            <h3>
                Browse Jobs
            </h3>

            <p>
                Explore job opportunities posted by companies on HireNest.
            </p>

            <span class="arrow">
                Explore opportunities →
            </span>

        </a>

        <a href="student-applications" class="card">

            <div class="icon">
                📋
            </div>

            <h3>
                My Applications
            </h3>

            <p>
                Track the jobs you have applied for and view your application status.
            </p>

            <span class="arrow">
                View applications →
            </span>

        </a>

        <a href="student-profile.jsp" class="card">

            <div class="icon">
                👤
            </div>

            <h3>
                My Profile
            </h3>

            <p>
                View and manage your personal and academic information.
            </p>

            <span class="arrow">
                View profile →
            </span>

        </a>

        <a href="notifications"
           class="card notification-card">

            <div class="icon">
                🔔
            </div>

            <h3>
                Notifications
            </h3>

            <p>
                View important updates about your applications and placement activities.
            </p>

            <span class="arrow">

                <% if (unreadCount > 0) { %>

                    <%= unreadCount %> new notification<%= unreadCount == 1 ? "" : "s" %> →

                <% } else { %>

                    View notifications →

                <% } %>

            </span>

        </a>

    </section>

</main>

<script>

    function confirmLogout() {

        return confirm(
            "Are you sure you want to logout from HireNest?"
        );
    }

</script>

</body>
</html>