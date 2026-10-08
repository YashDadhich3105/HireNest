<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hirenest.model.Student" %>

<%
    if (session == null ||
            session.getAttribute("studentId") == null) {

        response.sendRedirect("student-login.jsp");
        return;
    }

    Student student =
            (Student) request.getAttribute("student");

    if (student == null) {

        response.sendRedirect("student-profile");
        return;
    }

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");

    String fullName =
            student.getFullName() != null
                    ? student.getFullName()
                    : "";

    String email =
            student.getEmail() != null
                    ? student.getEmail()
                    : "";

    String phone =
            student.getPhone() != null
                    ? student.getPhone()
                    : "";

    String course =
            student.getCourse() != null
                    ? student.getCourse()
                    : "";

    String branch =
            student.getBranch() != null
                    ? student.getBranch()
                    : "";
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Profile | HireNest</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    min-height: 100vh;
    color: #172033;
    background:
        radial-gradient(
            circle at top left,
            rgba(99,102,241,0.13),
            transparent 32%
        ),
        radial-gradient(
            circle at bottom right,
            rgba(124,58,237,0.10),
            transparent 32%
        ),
        #f8fafc;
}

.navbar {
    height: 74px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 7%;
    background: rgba(255,255,255,0.95);
    backdrop-filter: blur(15px);
    border-bottom: 1px solid rgba(15,23,42,0.07);
    box-shadow: 0 5px 25px rgba(15,23,42,0.06);
    position: sticky;
    top: 0;
    z-index: 100;
}

.brand {
    text-decoration: none;
    color: #4f46e5;
    display: flex;
    align-items: center;
    gap: 11px;
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
    color: white;
    background: linear-gradient(
        135deg,
        #4f46e5,
        #7c3aed
    );
    box-shadow:
        0 8px 20px rgba(79,70,229,0.25);
}

.nav-actions {
    display: flex;
    gap: 10px;
}

.nav-btn {
    text-decoration: none;
    padding: 10px 16px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 800;
    transition: 0.25s;
}

.nav-btn.secondary {
    background: #f1f5f9;
    color: #475569;
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
        0 7px 18px rgba(79,70,229,0.20);
}

.nav-btn.primary:hover {
    transform: translateY(-2px);
}

.container {
    max-width: 1050px;
    margin: auto;
    padding: 50px 25px 60px;
}

.header {
    text-align: center;
    margin-bottom: 32px;
}

.badge {
    display: inline-flex;
    padding: 8px 15px;
    border-radius: 50px;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 12px;
    font-weight: 900;
    margin-bottom: 14px;
}

.header h1 {
    font-size: 40px;
    letter-spacing: -1px;
    margin-bottom: 9px;
}

.header h1 span {
    color: #4f46e5;
}

.header p {
    color: #64748b;
    font-size: 14px;
}

.alert {
    max-width: 850px;
    margin: 0 auto 20px;
    padding: 14px 18px;
    border-radius: 12px;
    font-size: 13px;
    font-weight: 700;
}

.alert.success {
    background: #dcfce7;
    color: #166534;
    border: 1px solid #bbf7d0;
}

.alert.error {
    background: #fee2e2;
    color: #991b1b;
    border: 1px solid #fecaca;
}

.profile-card {
    background: white;
    border: 1px solid rgba(15,23,42,0.07);
    border-radius: 28px;
    box-shadow:
        0 20px 55px rgba(15,23,42,0.08);
    overflow: hidden;
}

.profile-top {
    padding: 32px;
    display: flex;
    align-items: center;
    gap: 20px;
    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #f5f3ff
        );
    border-bottom: 1px solid #e2e8f0;
}

.avatar {
    width: 76px;
    height: 76px;
    border-radius: 22px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 29px;
    font-weight: 900;
    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );
    box-shadow:
        0 12px 28px rgba(79,70,229,0.25);
}

.profile-top h2 {
    font-size: 23px;
    margin-bottom: 4px;
}

.profile-top p {
    color: #64748b;
    font-size: 13px;
}

.form-area {
    padding: 34px;
}

.form-title {
    font-size: 18px;
    font-weight: 900;
    margin-bottom: 22px;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 7px;
}

.form-group.full {
    grid-column: 1 / -1;
}

label {
    color: #334155;
    font-size: 12px;
    font-weight: 900;
}

input {
    width: 100%;
    height: 47px;
    border: 1px solid #dbe3ee;
    border-radius: 11px;
    padding: 0 14px;
    outline: none;
    color: #172033;
    background: #fff;
    font-family: inherit;
    font-size: 13px;
    transition: 0.2s;
}

input:focus {
    border-color: #6366f1;
    box-shadow:
        0 0 0 4px rgba(99,102,241,0.10);
}

input[type="email"] {
    background: #fafafa;
}

.hint {
    color: #94a3b8;
    font-size: 11px;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 28px;
    padding-top: 25px;
    border-top: 1px solid #eef2f7;
}

.cancel-btn,
.save-btn {
    min-height: 44px;
    padding: 0 22px;
    border-radius: 11px;
    font-family: inherit;
    font-size: 13px;
    font-weight: 900;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: 0.25s;
}

.cancel-btn {
    background: #f1f5f9;
    color: #475569;
}

.cancel-btn:hover {
    background: #e2e8f0;
}

.save-btn {
    border: none;
    color: white;
    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );
    box-shadow:
        0 8px 20px rgba(79,70,229,0.22);
}

.save-btn:hover {
    transform: translateY(-2px);
}

.footer {
    text-align: center;
    padding: 25px;
    color: #94a3b8;
    font-size: 12px;
}

@media (max-width: 700px) {

    .navbar {
        padding: 0 20px;
    }

    .nav-btn.secondary {
        display: none;
    }

    .container {
        padding: 35px 15px;
    }

    .header h1 {
        font-size: 32px;
    }

    .profile-top {
        padding: 25px;
    }

    .form-area {
        padding: 25px;
    }

    .form-grid {
        grid-template-columns: 1fr;
    }

    .form-group.full {
        grid-column: auto;
    }

    .form-actions {
        flex-direction: column;
    }

    .cancel-btn,
    .save-btn {
        width: 100%;
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

<main class="container">

    <section class="header">

        <div class="badge">
            STUDENT PROFILE
        </div>

        <h1>
            My <span>Profile</span>
        </h1>

        <p>
            Keep your career information updated on HireNest.
        </p>

    </section>

<%
    if (success != null) {
%>

    <div class="alert success">
        <%= success %>
    </div>

<%
    }

    if (error != null) {
%>

    <div class="alert error">
        <%= error %>
    </div>

<%
    }
%>

    <section class="profile-card">

        <div class="profile-top">

            <div class="avatar">
                <%= fullName.isEmpty()
                        ? "S"
                        : fullName.substring(0, 1).toUpperCase() %>
            </div>

            <div>

                <h2>
                    <%= fullName %>
                </h2>

                <p>
                    <%= email %>
                </p>

            </div>

        </div>

        <div class="form-area">

            <div class="form-title">
                Personal &amp; Academic Information
            </div>

            <form
                action="student-profile"
                method="post">

                <div class="form-grid">

                    <div class="form-group full">

                        <label for="fullName">
                            Full Name
                        </label>

                        <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            value="<%= fullName %>"
                            required
                            maxlength="100">

                    </div>

                    <div class="form-group">

                        <label for="email">
                            Email Address
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            value="<%= email %>"
                            required
                            maxlength="150">

                    </div>

                    <div class="form-group">

                        <label for="phone">
                            Phone Number
                        </label>

                        <input
                            type="text"
                            id="phone"
                            name="phone"
                            value="<%= phone %>"
                            maxlength="20">

                    </div>

                    <div class="form-group">

                        <label for="course">
                            Course
                        </label>

                        <input
                            type="text"
                            id="course"
                            name="course"
                            value="<%= course %>"
                            maxlength="100">

                    </div>

                    <div class="form-group">

                        <label for="branch">
                            Branch
                        </label>

                        <input
                            type="text"
                            id="branch"
                            name="branch"
                            value="<%= branch %>"
                            maxlength="100">

                    </div>

                    <div class="form-group">

                        <label for="cgpa">
                            CGPA
                        </label>

                        <input
                            type="number"
                            id="cgpa"
                            name="cgpa"
                            value="<%= student.getCgpa() %>"
                            min="0"
                            max="10"
                            step="0.01"
                            required>

                        <span class="hint">
                            Enter CGPA between 0 and 10.
                        </span>

                    </div>

                    <div class="form-group">

                        <label for="graduationYear">
                            Graduation Year
                        </label>

                        <input
                            type="number"
                            id="graduationYear"
                            name="graduationYear"
                            value="<%= student.getGraduationYear() %>"
                            min="2000"
                            max="2100"
                            required>

                    </div>

                </div>

                <div class="form-actions">

                    <a
                        href="student-dashboard.jsp"
                        class="cancel-btn">

                        Cancel

                    </a>

                    <button
                        type="submit"
                        class="save-btn">

                        Save Changes

                    </button>

                </div>

            </form>

        </div>

    </section>

</main>

<footer class="footer">

    HireNest &copy; 2026
    &nbsp;•&nbsp;
    Smart Career &amp; Placement Platform

</footer>

</body>

</html>