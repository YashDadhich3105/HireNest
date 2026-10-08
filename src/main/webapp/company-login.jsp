<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Company Login | HireNest</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background:
                radial-gradient(circle at 10% 15%, rgba(99,102,241,.18), transparent 30%),
                radial-gradient(circle at 90% 85%, rgba(14,165,233,.15), transparent 30%),
                #07111f;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
        }

        .login-container {
            width: 100%;
            max-width: 1050px;
            min-height: 620px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: rgba(15,23,42,.84);
            border: 1px solid rgba(255,255,255,.1);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(0,0,0,.45);
            backdrop-filter: blur(20px);
        }

        .left-panel {
            padding: 55px;
            background:
                linear-gradient(
                    145deg,
                    rgba(37,99,235,.92),
                    rgba(79,70,229,.85),
                    rgba(15,23,42,.95)
                );
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 25px;
            font-weight: 800;
        }

        .logo-icon {
            width: 46px;
            height: 46px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 14px;
            background: rgba(255,255,255,.14);
            border: 1px solid rgba(255,255,255,.2);
        }

        .hero {
            margin-top: 60px;
        }

        .hero h1 {
            font-size: 45px;
            line-height: 1.08;
            margin-bottom: 20px;
        }

        .hero p {
            max-width: 430px;
            color: rgba(255,255,255,.76);
            line-height: 1.7;
            font-size: 15px;
        }

        .stats {
            display: flex;
            gap: 35px;
            margin-top: 38px;
        }

        .stat strong {
            display: block;
            font-size: 25px;
        }

        .stat span {
            color: rgba(255,255,255,.58);
            font-size: 12px;
        }

        .footer {
            color: rgba(255,255,255,.5);
            font-size: 12px;
        }

        .right-panel {
            padding: 65px 55px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .heading {
            margin-bottom: 32px;
        }

        .heading h2 {
            font-size: 31px;
            margin-bottom: 8px;
        }

        .heading p {
            color: #94a3b8;
            font-size: 14px;
        }

        .success {
            padding: 13px 15px;
            margin-bottom: 20px;
            border-radius: 11px;
            background: rgba(34,197,94,.1);
            border: 1px solid rgba(34,197,94,.25);
            color: #86efac;
            font-size: 13px;
        }

        .error {
            padding: 13px 15px;
            margin-bottom: 20px;
            border-radius: 11px;
            background: rgba(239,68,68,.1);
            border: 1px solid rgba(239,68,68,.25);
            color: #fca5a5;
            font-size: 13px;
        }

        .field {
            margin-bottom: 21px;
        }

        label {
            display: block;
            color: #cbd5e1;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            height: 51px;
            padding: 0 15px;
            border-radius: 12px;
            border: 1px solid rgba(148,163,184,.18);
            background: rgba(15,23,42,.82);
            color: white;
            outline: none;
            font-size: 14px;
            transition: .25s;
        }

        input::placeholder {
            color: #64748b;
        }

        input:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99,102,241,.12);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper input {
            padding-right: 50px;
        }

        .show-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            color: #94a3b8;
            cursor: pointer;
            font-size: 17px;
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 3px 0 24px;
            font-size: 12px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #94a3b8;
        }

        .remember input {
            width: 15px;
            height: 15px;
        }

        .forgot {
            color: #818cf8;
            text-decoration: none;
        }

        .forgot:hover {
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            height: 52px;
            border: none;
            border-radius: 13px;
            background: linear-gradient(135deg,#6366f1,#2563eb);
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: .25s;
            box-shadow: 0 12px 30px rgba(37,99,235,.25);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 16px 35px rgba(37,99,235,.38);
        }

        .register {
            text-align: center;
            margin-top: 25px;
            color: #94a3b8;
            font-size: 13px;
        }

        .register a {
            color: #818cf8;
            text-decoration: none;
            font-weight: 700;
        }

        @media(max-width: 800px) {
            .login-container {
                grid-template-columns: 1fr;
            }

            .left-panel {
                padding: 35px;
            }

            .right-panel {
                padding: 40px 30px;
            }

            .hero {
                margin-top: 35px;
            }

            .hero h1 {
                font-size: 35px;
            }
        }
    </style>
</head>

<body>

<div class="login-container">

    <section class="left-panel">

        <div>
            <div class="logo">
                <div class="logo-icon">✦</div>
                HireNest
            </div>

            <div class="hero">

                <h1>
                    Welcome back,
                    <br>
                    Hiring Partner.
                </h1>

                <p>
                    Access your company workspace, publish new opportunities,
                    review applications and discover talented candidates.
                </p>

                <div class="stats">

                    <div class="stat">
                        <strong>01</strong>
                        <span>Company Workspace</span>
                    </div>

                    <div class="stat">
                        <strong>24/7</strong>
                        <span>Talent Access</span>
                    </div>

                    <div class="stat">
                        <strong>∞</strong>
                        <span>Opportunities</span>
                    </div>

                </div>

            </div>
        </div>

        <div class="footer">
            © 2026 HireNest
        </div>

    </section>


    <section class="right-panel">

        <div class="heading">
            <h2>Company Sign In</h2>
            <p>Enter your credentials to access your dashboard.</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>

        <% if (error != null) { %>
            <div class="error">
                <%= error %>
            </div>
        <% } %>

        <% if ("true".equals(request.getParameter("registered"))) { %>
            <div class="success">
                ✓ Registration successful. You can now sign in.
            </div>
        <% } %>

        <form action="company-login" method="post">

            <div class="field">
                <label>Company Email</label>

                <input
                    type="email"
                    name="email"
                    placeholder="company@example.com"
                    required>
            </div>

            <div class="field">
                <label>Password</label>

                <div class="password-wrapper">

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required>

                    <button
                        type="button"
                        class="show-password"
                        onclick="togglePassword()">
                        ◉
                    </button>

                </div>
            </div>

            <div class="options">

                <label class="remember">
                    <input type="checkbox">
                    Remember me
                </label>

                <a href="#" class="forgot">
                    Forgot password?
                </a>

            </div>

            <button type="submit" class="login-btn">
                Sign In to HireNest
            </button>

        </form>

        <div class="register">
            Don't have a company account?
            <a href="company-register.jsp">Create one</a>
        </div>

    </section>

</div>

<script>
    function togglePassword() {

        const password =
            document.getElementById("password");

        if (password.type === "password") {
            password.type = "text";
        } else {
            password.type = "password";
        }
    }
</script>

</body>
</html>