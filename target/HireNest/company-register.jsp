<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Company Registration | HireNest</title>

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
                radial-gradient(circle at 15% 20%, rgba(99, 102, 241, 0.18), transparent 30%),
                radial-gradient(circle at 85% 80%, rgba(14, 165, 233, 0.16), transparent 30%),
                #07111f;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .container {
            width: 100%;
            max-width: 1100px;
            display: grid;
            grid-template-columns: 0.9fr 1.1fr;
            background: rgba(15, 23, 42, 0.82);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(20px);
        }

        .brand-panel {
            padding: 55px 45px;
            background:
                linear-gradient(
                    145deg,
                    rgba(37, 99, 235, 0.9),
                    rgba(79, 70, 229, 0.82),
                    rgba(30, 41, 59, 0.95)
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
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.16);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 23px;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .brand-content {
            margin-top: 70px;
        }

        .brand-content h1 {
            font-size: 43px;
            line-height: 1.08;
            margin-bottom: 22px;
        }

        .brand-content p {
            color: rgba(255,255,255,0.78);
            font-size: 16px;
            line-height: 1.7;
        }

        .features {
            margin-top: 35px;
            display: grid;
            gap: 16px;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 13px;
            color: rgba(255,255,255,0.88);
            font-size: 14px;
        }

        .feature-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255,255,255,0.13);
        }

        .brand-footer {
            margin-top: 50px;
            color: rgba(255,255,255,0.55);
            font-size: 13px;
        }

        .form-panel {
            padding: 48px;
            background: rgba(8, 15, 29, 0.75);
        }

        .form-header {
            margin-bottom: 30px;
        }

        .form-header h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .form-header p {
            color: #94a3b8;
            font-size: 14px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 19px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .field.full {
            grid-column: span 2;
        }

        label {
            color: #cbd5e1;
            font-size: 13px;
            font-weight: 600;
        }

        input,
        textarea {
            width: 100%;
            border: 1px solid rgba(148, 163, 184, 0.18);
            background: rgba(15, 23, 42, 0.8);
            color: white;
            border-radius: 12px;
            padding: 13px 15px;
            outline: none;
            font-size: 14px;
            transition: 0.25s;
        }

        input {
            height: 48px;
        }

        textarea {
            min-height: 105px;
            resize: vertical;
        }

        input::placeholder,
        textarea::placeholder {
            color: #64748b;
        }

        input:focus,
        textarea:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99,102,241,0.12);
        }

        .password-box {
            position: relative;
        }

        .password-box input {
            padding-right: 50px;
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            color: #94a3b8;
            cursor: pointer;
            font-size: 17px;
        }

        .terms {
            margin-top: 22px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            color: #94a3b8;
            font-size: 12px;
            line-height: 1.5;
        }

        .terms input {
            width: 15px;
            height: 15px;
            margin-top: 2px;
        }

        .register-btn {
            width: 100%;
            height: 52px;
            margin-top: 24px;
            border: none;
            border-radius: 13px;
            background: linear-gradient(135deg, #6366f1, #2563eb);
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.25s;
            box-shadow: 0 12px 30px rgba(37,99,235,0.25);
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 16px 35px rgba(37,99,235,0.38);
        }

        .login-link {
            text-align: center;
            margin-top: 22px;
            color: #94a3b8;
            font-size: 13px;
        }

        .login-link a {
            color: #818cf8;
            text-decoration: none;
            font-weight: 700;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error {
            margin-bottom: 20px;
            padding: 12px 15px;
            border-radius: 10px;
            background: rgba(239,68,68,0.12);
            border: 1px solid rgba(239,68,68,0.25);
            color: #fca5a5;
            font-size: 13px;
        }

        @media (max-width: 850px) {
            .container {
                grid-template-columns: 1fr;
            }

            .brand-panel {
                padding: 35px;
            }

            .brand-content {
                margin-top: 35px;
            }

            .brand-content h1 {
                font-size: 34px;
            }
        }

        @media (max-width: 600px) {
            .form-panel {
                padding: 30px 22px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .field.full {
                grid-column: span 1;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <section class="brand-panel">

        <div>
            <div class="logo">
                <div class="logo-icon">✦</div>
                HireNest
            </div>

            <div class="brand-content">
                <h1>Build your team with the right talent.</h1>

                <p>
                    Create your company profile and connect with talented
                    students looking for their next career opportunity.
                </p>

                <div class="features">

                    <div class="feature">
                        <div class="feature-icon">✓</div>
                        Discover qualified candidates
                    </div>

                    <div class="feature">
                        <div class="feature-icon">◆</div>
                        Publish opportunities easily
                    </div>

                    <div class="feature">
                        <div class="feature-icon">↗</div>
                        Manage applications in one place
                    </div>

                </div>
            </div>
        </div>

        <div class="brand-footer">
            © 2026 HireNest · Connecting talent with opportunity
        </div>

    </section>


    <section class="form-panel">

        <div class="form-header">
            <h2>Create company account</h2>
            <p>Set up your organization profile to start hiring.</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>

        <% if (error != null) { %>
            <div class="error">
                <%= error %>
            </div>
        <% } %>

        <form action="company-register" method="post">

            <div class="form-grid">

                <div class="field full">
                    <label>Company Name</label>
                    <input
                        type="text"
                        name="companyName"
                        placeholder="Enter company name"
                        required>
                </div>

                <div class="field">
                    <label>Company Email</label>
                    <input
                        type="email"
                        name="email"
                        placeholder="company@example.com"
                        required>
                </div>

                <div class="field">
                    <label>Phone Number</label>
                    <input
                        type="tel"
                        name="phone"
                        placeholder="+91 XXXXX XXXXX">
                </div>

                <div class="field">
                    <label>Password</label>

                    <div class="password-box">
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create password"
                            required>

                        <button
                            type="button"
                            class="toggle-password"
                            onclick="togglePassword()">
                            ◉
                        </button>
                    </div>
                </div>

                <div class="field">
                    <label>Company Website</label>
                    <input
                        type="url"
                        name="website"
                        placeholder="https://example.com">
                </div>

                <div class="field full">
                    <label>Company Description</label>
                    <textarea
                        name="description"
                        placeholder="Tell candidates about your company..."></textarea>
                </div>

            </div>

            <div class="terms">
                <input type="checkbox" required>

                <span>
                    I agree to the HireNest terms and confirm that the
                    information provided is accurate.
                </span>
            </div>

            <button type="submit" class="register-btn">
                Create Company Account
            </button>

        </form>

        <div class="login-link">
            Already have a company account?
            <a href="company-login.jsp">Sign in</a>
        </div>

    </section>

</div>

<script>
    function togglePassword() {
        const password = document.getElementById("password");

        if (password.type === "password") {
            password.type = "text";
        } else {
            password.type = "password";
        }
    }
</script>

</body>
</html>