<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("student") != null ||
            session.getAttribute("studentId") != null) {

        response.sendRedirect("student-dashboard.jsp");
        return;
    }

    String error = request.getParameter("error");

    if (error != null) {
        error = error.replace("+", " ");
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Login | HireNest</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background:
                radial-gradient(circle at 10% 20%, rgba(108, 99, 255, 0.12), transparent 30%),
                radial-gradient(circle at 90% 80%, rgba(129, 120, 255, 0.14), transparent 30%),
                linear-gradient(135deg, #f5f3ff, #eef7ff);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
        }

        .container {
            width: 100%;
            max-width: 1050px;
            min-height: 610px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: rgba(255, 255, 255, 0.96);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 90px rgba(30, 35, 70, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        .left {
            position: relative;
            overflow: hidden;
            background: linear-gradient(145deg, #574df0, #756cff 55%, #8b84ff);
            color: white;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .left::before {
            content: "";
            position: absolute;
            width: 260px;
            height: 260px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            top: -80px;
            right: -70px;
        }

        .left::after {
            content: "";
            position: absolute;
            width: 190px;
            height: 190px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.07);
            bottom: -70px;
            left: -50px;
        }

        .left-content {
            position: relative;
            z-index: 2;
        }

        .logo {
            font-size: 31px;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 65px;
        }

        .logo span {
            color: #ddd9ff;
        }

        .welcome-tag {
            display: inline-flex;
            align-items: center;
            width: fit-content;
            padding: 8px 14px;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.13);
            border: 1px solid rgba(255, 255, 255, 0.18);
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 20px;
            letter-spacing: 0.3px;
        }

        .left h1 {
            font-size: 44px;
            line-height: 1.08;
            letter-spacing: -1.2px;
            margin-bottom: 22px;
        }

        .left p {
            color: #eeeeff;
            line-height: 1.8;
            font-size: 15px;
            max-width: 430px;
        }

        .benefits {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 32px;
        }

        .benefit {
            padding: 9px 13px;
            border-radius: 9px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.13);
            font-size: 12px;
            color: #f5f4ff;
        }

        .right {
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 28px;
        }

        .right h2 {
            font-size: 31px;
            color: #17192b;
            margin-bottom: 9px;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: #777b8e;
            font-size: 14px;
            line-height: 1.6;
        }

        .error {
            background: #fff1f4;
            border: 1px solid #ffc8d3;
            color: #bd2344;
            padding: 13px 14px;
            border-radius: 11px;
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .field {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 700;
            color: #33364a;
        }

        .input-wrapper {
            position: relative;
        }

        input {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #dddfea;
            border-radius: 11px;
            outline: none;
            font-size: 14px;
            color: #202236;
            background: #fbfbfe;
            transition: all 0.2s ease;
        }

        input[type="password"] {
            padding-right: 65px;
        }

        input::placeholder {
            color: #a3a6b5;
        }

        input:hover {
            border-color: #c8c8dc;
            background: #ffffff;
        }

        input:focus {
            border-color: #6c63ff;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            width: auto;
            margin: 0;
            padding: 7px 9px;
            background: transparent;
            color: #666a7d;
            font-size: 12px;
            font-weight: 700;
            border: none;
            cursor: pointer;
        }

        .password-toggle:hover {
            transform: translateY(-50%);
            color: #6258f5;
            background: transparent;
        }

        .login-button {
            width: 100%;
            border: none;
            padding: 15px;
            border-radius: 11px;
            background: linear-gradient(135deg, #6258f5, #8178ff);
            color: white;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            margin-top: 5px;
            box-shadow: 0 10px 25px rgba(98, 88, 245, 0.22);
            transition: all 0.2s ease;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 30px rgba(98, 88, 245, 0.28);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .login-button.loading {
            opacity: 0.7;
            cursor: wait;
        }

        .register {
            text-align: center;
            margin-top: 25px;
            color: #777b8e;
            font-size: 14px;
        }

        .register a {
            color: #6258f5;
            font-weight: 700;
            text-decoration: none;
        }

        .register a:hover {
            text-decoration: underline;
        }

        .back {
            text-align: center;
            margin-top: 16px;
        }

        .back a {
            color: #777b8e;
            text-decoration: none;
            font-size: 13px;
            transition: color 0.2s ease;
        }

        .back a:hover {
            color: #6258f5;
        }

        .security-note {
            text-align: center;
            color: #9a9dae;
            font-size: 11px;
            margin-top: 25px;
        }

        @media (max-width: 820px) {

            .container {
                grid-template-columns: 1fr;
                max-width: 600px;
            }

            .left {
                padding: 42px;
                min-height: 360px;
            }

            .logo {
                margin-bottom: 35px;
            }

            .left h1 {
                font-size: 35px;
            }

            .right {
                padding: 42px;
            }
        }

        @media (max-width: 500px) {

            body {
                padding: 14px;
            }

            .container {
                border-radius: 20px;
            }

            .left {
                padding: 30px;
                min-height: 320px;
            }

            .right {
                padding: 30px;
            }

            .left h1 {
                font-size: 30px;
            }

            .right h2 {
                font-size: 27px;
            }

            .benefits {
                display: none;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <section class="left">

        <div class="left-content">

            <div class="logo">
                Hire<span>Nest</span>
            </div>

            <div class="welcome-tag">
                STUDENT PORTAL
            </div>

            <h1>
                Your career journey starts here.
            </h1>

            <p>
                Login to HireNest to discover opportunities,
                apply for jobs and build your professional future
                with smarter career tools.
            </p>

            <div class="benefits">

                <div class="benefit">
                    Find Opportunities
                </div>

                <div class="benefit">
                    Apply Easily
                </div>

                <div class="benefit">
                    Analyze Resume
                </div>

            </div>

        </div>

    </section>

    <section class="right">

        <div class="form-header">

            <h2>
                Student Login
            </h2>

            <p class="subtitle">
                Enter your credentials to access your HireNest account.
            </p>

        </div>

        <% if (error != null && !error.trim().isEmpty()) { %>

            <div class="error">
                <%= error %>
            </div>

        <% } %>

        <form
                action="student-login"
                method="post"
                id="loginForm"
                onsubmit="return validateLogin()">

            <div class="field">

                <label for="email">
                    Email Address
                </label>

                <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        autocomplete="email"
                        maxlength="100"
                        required>

            </div>

            <div class="field">

                <label for="password">
                    Password
                </label>

                <div class="input-wrapper">

                    <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            maxlength="100"
                            required>

                    <button
                            type="button"
                            class="password-toggle"
                            id="passwordToggle"
                            onclick="togglePassword()">
                        Show
                    </button>

                </div>

            </div>

            <button
                    type="submit"
                    class="login-button"
                    id="loginButton">

                Login to HireNest

            </button>

        </form>

        <div class="register">

            Don't have an account?

            <a href="student-register.jsp">
                Create Account
            </a>

        </div>

        <div class="back">

            <a href="index.jsp">
                Back to Home
            </a>

        </div>

        <div class="security-note">
            Your account information is protected by HireNest.
        </div>

    </section>

</div>

<script>

    function togglePassword() {

        const password =
            document.getElementById("password");

        const toggle =
            document.getElementById("passwordToggle");

        if (password.type === "password") {

            password.type = "text";
            toggle.textContent = "Hide";

        } else {

            password.type = "password";
            toggle.textContent = "Show";
        }
    }

    function validateLogin() {

        const email =
            document.getElementById("email");

        const password =
            document.getElementById("password");

        const button =
            document.getElementById("loginButton");

        const emailValue =
            email.value.trim();

        const passwordValue =
            password.value;

        if (emailValue === "") {

            alert("Please enter your email address.");
            email.focus();

            return false;
        }

        if (!email.validity.valid) {

            alert("Please enter a valid email address.");
            email.focus();

            return false;
        }

        if (passwordValue.trim() === "") {

            alert("Please enter your password.");
            password.focus();

            return false;
        }

        button.classList.add("loading");
        button.textContent = "Signing in...";

        return true;
    }

</script>

</body>

</html>