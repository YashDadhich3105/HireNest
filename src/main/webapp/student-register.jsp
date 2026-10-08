<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HireNest | Student Registration</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                radial-gradient(circle at 10% 20%, rgba(56,189,248,.18), transparent 30%),
                radial-gradient(circle at 90% 80%, rgba(139,92,246,.18), transparent 30%),
                linear-gradient(135deg, #07111f, #101b31, #071827);
            color: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            overflow-x: hidden;
        }

        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(2px);
            pointer-events: none;
            animation: float 8s ease-in-out infinite;
        }

        .orb.one {
            width: 220px;
            height: 220px;
            background: rgba(14,165,233,.12);
            top: 5%;
            left: 5%;
        }

        .orb.two {
            width: 280px;
            height: 280px;
            background: rgba(124,58,237,.12);
            bottom: 0;
            right: 3%;
            animation-delay: 2s;
        }

        @keyframes float {
            0%,100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-25px);
            }
        }

        .container {
            width: 100%;
            max-width: 1050px;
            display: grid;
            grid-template-columns: .85fr 1.15fr;
            border: 1px solid rgba(255,255,255,.12);
            border-radius: 30px;
            overflow: hidden;
            background: rgba(255,255,255,.07);
            backdrop-filter: blur(25px);
            box-shadow: 0 30px 90px rgba(0,0,0,.4);
            position: relative;
            z-index: 2;
        }

        .intro {
            padding: 55px 45px;
            background: linear-gradient(
                145deg,
                rgba(14,165,233,.18),
                rgba(99,102,241,.08)
            );
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            font-size: 34px;
            font-weight: 800;
            margin-bottom: 25px;
        }

        .logo span {
            color: #38bdf8;
        }

        .intro h1 {
            font-size: 43px;
            line-height: 1.08;
            margin-bottom: 20px;
        }

        .intro h1 span {
            color: #38bdf8;
        }

        .intro p {
            color: #a8b6ca;
            line-height: 1.8;
            font-size: 16px;
            margin-bottom: 35px;
        }

        .benefits {
            display: grid;
            gap: 14px;
        }

        .benefit {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px;
            border-radius: 14px;
            background: rgba(255,255,255,.05);
            border: 1px solid rgba(255,255,255,.07);
        }

        .benefit-icon {
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            background: rgba(56,189,248,.13);
            color: #38bdf8;
            font-weight: 700;
        }

        .benefit strong {
            display: block;
            margin-bottom: 3px;
        }

        .benefit small {
            color: #8fa1b8;
        }

        .form-section {
            padding: 45px;
            background: rgba(15,23,42,.42);
        }

        .form-header {
            margin-bottom: 28px;
        }

        .form-header h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .form-header p {
            color: #91a1b8;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .field.full {
            grid-column: 1 / -1;
        }

        label {
            color: #dbe7f5;
            font-size: 14px;
            font-weight: 600;
        }

        input,
        select {
            width: 100%;
            padding: 14px 15px;
            border-radius: 12px;
            border: 1px solid rgba(148,163,184,.22);
            background: rgba(15,23,42,.7);
            color: white;
            outline: none;
            transition: .25s;
        }

        input::placeholder {
            color: #64748b;
        }

        input:focus,
        select:focus {
            border-color: #38bdf8;
            box-shadow: 0 0 0 4px rgba(56,189,248,.10);
        }

        select option {
            background: #0f172a;
        }

        .password-box {
            position: relative;
        }

        .password-box input {
            padding-right: 48px;
        }

        .toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #94a3b8;
            user-select: none;
        }

        .message {
            margin-bottom: 20px;
            padding: 12px 15px;
            border-radius: 10px;
            background: rgba(239,68,68,.12);
            border: 1px solid rgba(239,68,68,.25);
            color: #fca5a5;
        }

        .submit-btn {
            width: 100%;
            margin-top: 25px;
            padding: 16px;
            border: none;
            border-radius: 13px;
            background: linear-gradient(135deg, #0ea5e9, #6366f1);
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: .25s;
            box-shadow: 0 10px 30px rgba(14,165,233,.18);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(14,165,233,.28);
        }

        .login-link {
            text-align: center;
            margin-top: 22px;
            color: #94a3b8;
            font-size: 14px;
        }

        .login-link a {
            color: #38bdf8;
            text-decoration: none;
            font-weight: 700;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media(max-width: 850px) {

            .container {
                grid-template-columns: 1fr;
            }

            .intro {
                padding: 35px;
            }

            .intro h1 {
                font-size: 34px;
            }

            .form-section {
                padding: 35px;
            }
        }

        @media(max-width: 550px) {

            .form-grid {
                grid-template-columns: 1fr;
            }

            .field.full {
                grid-column: auto;
            }

            .intro,
            .form-section {
                padding: 25px;
            }
        }

    </style>
</head>

<body>

<div class="orb one"></div>
<div class="orb two"></div>

<div class="container">

    <section class="intro">

        <div class="logo">
            Hire<span>Nest</span>
        </div>

        <h1>
            Build your career.
            <span>Find your opportunity.</span>
        </h1>

        <p>
            Create your student profile and connect with companies,
            jobs and opportunities that match your skills and career goals.
        </p>

        <div class="benefits">

            <div class="benefit">
                <div class="benefit-icon">01</div>
                <div>
                    <strong>Discover Jobs</strong>
                    <small>Explore opportunities from companies.</small>
                </div>
            </div>

            <div class="benefit">
                <div class="benefit-icon">02</div>
                <div>
                    <strong>Build Your Profile</strong>
                    <small>Showcase your education and skills.</small>
                </div>
            </div>

            <div class="benefit">
                <div class="benefit-icon">03</div>
                <div>
                    <strong>Apply Easily</strong>
                    <small>Apply for suitable opportunities.</small>
                </div>
            </div>

        </div>

    </section>

    <section class="form-section">

        <div class="form-header">
            <h2>Create Student Account</h2>
            <p>Enter your details to get started with HireNest.</p>
        </div>

        <%
            String error = request.getParameter("error");

            if ("email".equals(error)) {
        %>

            <div class="message">
                An account with this email already exists.
            </div>

        <%
            } else if ("missing".equals(error)) {
        %>

            <div class="message">
                Please fill in all required fields.
            </div>

        <%
            } else if ("invalid".equals(error)) {
        %>

            <div class="message">
                Please enter valid CGPA and graduation year.
            </div>

        <%
            } else if ("failed".equals(error)) {
        %>

            <div class="message">
                Registration failed. Please try again.
            </div>

        <%
            }
        %>

        <form action="student-register" method="post">

            <div class="form-grid">

                <div class="field full">
                    <label>Full Name</label>
                    <input
                        type="text"
                        name="fullName"
                        placeholder="Enter your full name"
                        required>
                </div>

                <div class="field">
                    <label>Email Address</label>
                    <input
                        type="email"
                        name="email"
                        placeholder="you@example.com"
                        required>
                </div>

                <div class="field">
                    <label>Phone Number</label>
                    <input
                        type="tel"
                        name="phone"
                        placeholder="Enter phone number"
                        required>
                </div>

                <div class="field full">
                    <label>Password</label>

                    <div class="password-box">
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create a strong password"
                            minlength="6"
                            required>

                        <span
                            class="toggle"
                            onclick="togglePassword()">
                            Show
                        </span>
                    </div>
                </div>

                <div class="field">
                    <label>Course</label>

                    <select name="course" required>
                        <option value="">Select course</option>
                        <option>B.Tech</option>
                        <option>B.E.</option>
                        <option>BCA</option>
                        <option>MCA</option>
                        <option>M.Tech</option>
                        <option>MBA</option>
                        <option>Other</option>
                    </select>
                </div>

                <div class="field">
                    <label>Branch</label>

                    <input
                        type="text"
                        name="branch"
                        placeholder="e.g. Information Technology"
                        required>
                </div>

                <div class="field">
                    <label>CGPA</label>

                    <input
                        type="number"
                        name="cgpa"
                        min="0"
                        max="10"
                        step="0.01"
                        placeholder="e.g. 8.25"
                        required>
                </div>

                <div class="field">
                    <label>Graduation Year</label>

                    <input
                        type="number"
                        name="graduationYear"
                        min="2020"
                        max="2035"
                        placeholder="e.g. 2027"
                        required>
                </div>

            </div>

            <button class="submit-btn" type="submit">
                Create Student Account →
            </button>

        </form>

        <div class="login-link">
            Already have an account?
            <a href="student-login.jsp">Student Login</a>
        </div>

    </section>

</div>

<script>

function togglePassword() {

    const password = document.getElementById("password");
    const toggle = document.querySelector(".toggle");

    if (password.type === "password") {
        password.type = "text";
        toggle.textContent = "Hide";
    } else {
        password.type = "password";
        toggle.textContent = "Show";
    }
}

</script>

</body>
</html>