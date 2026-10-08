<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Login | HireNest</title>

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
                radial-gradient(circle at top left, #263b72, transparent 40%),
                radial-gradient(circle at bottom right, #153d55, transparent 40%),
                #070b16;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
        }

        .wrapper {
            width: 100%;
            max-width: 1050px;
            min-height: 620px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: rgba(255,255,255,0.07);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(0,0,0,0.45);
            backdrop-filter: blur(20px);
        }

        .left {
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background:
                linear-gradient(
                    145deg,
                    rgba(63,81,181,0.38),
                    rgba(0,188,212,0.12)
                );
        }

        .brand {
            font-size: 38px;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .brand span {
            color: #64d8ff;
        }

        .left h1 {
            font-size: 48px;
            line-height: 1.08;
            margin-bottom: 22px;
        }

        .left p {
            color: #c7d0e5;
            line-height: 1.8;
            font-size: 16px;
            max-width: 430px;
        }

        .feature {
            display: flex;
            gap: 14px;
            align-items: center;
            margin-top: 32px;
            color: #dce6f7;
        }

        .feature-icon {
            width: 44px;
            height: 44px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(100,216,255,0.12);
            border: 1px solid rgba(100,216,255,0.2);
            font-size: 20px;
        }

        .right {
            padding: 60px;
            background: rgba(5,10,22,0.65);
            display: flex;
            align-items: center;
        }

        .login-box {
            width: 100%;
            max-width: 400px;
            margin: auto;
        }

        .admin-icon {
            width: 70px;
            height: 70px;
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #64d8ff, #6078ff);
            font-size: 30px;
            margin-bottom: 25px;
            box-shadow: 0 15px 40px rgba(100,216,255,0.2);
        }

        .login-box h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .login-box > p {
            color: #8995ad;
            margin-bottom: 32px;
        }

        .message {
            padding: 14px 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 14px;
            background: rgba(255,70,90,0.12);
            border: 1px solid rgba(255,70,90,0.25);
            color: #ff9ca8;
        }

        .field {
            margin-bottom: 20px;
        }

        .field label {
            display: block;
            margin-bottom: 9px;
            color: #d7deeb;
            font-size: 14px;
            font-weight: 600;
        }

        .field input {
            width: 100%;
            padding: 15px 16px;
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 13px;
            background: rgba(255,255,255,0.055);
            color: white;
            outline: none;
            font-size: 15px;
            transition: 0.25s;
        }

        .field input:focus {
            border-color: #64d8ff;
            box-shadow: 0 0 0 4px rgba(100,216,255,0.08);
        }

        .login-btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 13px;
            background: linear-gradient(135deg, #64d8ff, #6078ff);
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 8px;
            transition: 0.25s;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(96,120,255,0.28);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #8995ad;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link:hover {
            color: #64d8ff;
        }

        @media(max-width: 800px) {

            .wrapper {
                grid-template-columns: 1fr;
            }

            .left {
                display: none;
            }

            .right {
                padding: 40px 25px;
            }
        }

    </style>

</head>

<body>

<div class="wrapper">

    <div class="left">

        <div class="brand">
            Hire<span>Nest</span>
        </div>

        <h1>
            Control the entire placement ecosystem.
        </h1>

        <p>
            Manage students, companies, jobs and applications
            from one centralized administrative dashboard.
        </p>

        <div class="feature">
            <div class="feature-icon">📊</div>
            <span>Placement analytics and insights</span>
        </div>

        <div class="feature">
            <div class="feature-icon">👥</div>
            <span>Student and company management</span>
        </div>

        <div class="feature">
            <div class="feature-icon">🛡️</div>
            <span>Secure administrative access</span>
        </div>

    </div>

    <div class="right">

        <div class="login-box">

            <div class="admin-icon">🔐</div>

            <h2>Admin Login</h2>

            <p>
                Sign in to your HireNest control center.
            </p>

            <%
                String error = request.getParameter("error");

                if (error != null) {
            %>

                <div class="message">
                    <%= error %>
                </div>

            <%
                }
            %>

            <form action="admin-login" method="post">

                <div class="field">

                    <label>Email Address</label>

                    <input
                            type="email"
                            name="email"
                            placeholder="admin@hirenest.com"
                            required
                    >

                </div>

                <div class="field">

                    <label>Password</label>

                    <input
                            type="password"
                            name="password"
                            placeholder="Enter your password"
                            required
                    >

                </div>

                <button
                        type="submit"
                        class="login-btn">

                    Sign In to Admin Panel

                </button>

            </form>

            <a href="index.jsp" class="back-link">
                ← Back to HireNest
            </a>

        </div>

    </div>

</div>

</body>
</html>