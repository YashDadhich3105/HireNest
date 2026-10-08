<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object company = session.getAttribute("company");

    if (company == null) {
        response.sendRedirect("company-login.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Post a Job | HireNest</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #6c63ff;
            --primary-dark: #5148e5;
            --dark: #101322;
            --text: #202336;
            --muted: #73788c;
            --border: #e4e6ef;
            --surface: #ffffff;
            --background: #f5f6fb;
            --danger: #d9304f;
        }

        body {
            min-height: 100vh;
            font-family: "Inter", sans-serif;
            color: var(--text);
            background:
                radial-gradient(circle at 10% 10%, rgba(108, 99, 255, 0.12), transparent 28%),
                radial-gradient(circle at 90% 20%, rgba(42, 185, 255, 0.10), transparent 28%),
                var(--background);
        }

        .navbar {
            height: 76px;
            background: rgba(255, 255, 255, 0.86);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid rgba(228, 230, 239, 0.8);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
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
            width: 42px;
            height: 42px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 800;
            background: linear-gradient(135deg, #6c63ff, #8d7dff);
            box-shadow: 0 8px 22px rgba(108, 99, 255, 0.28);
        }

        .brand-name {
            font-family: "Space Grotesk", sans-serif;
            font-size: 22px;
            font-weight: 700;
        }

        .brand-name span {
            color: var(--primary);
        }

        .back-link {
            text-decoration: none;
            color: #555b70;
            font-weight: 600;
            font-size: 14px;
            padding: 10px 16px;
            border-radius: 10px;
            transition: 0.25s ease;
        }

        .back-link:hover {
            color: var(--primary);
            background: #f0efff;
        }

        .page {
            width: min(1100px, 92%);
            margin: 55px auto 80px;
        }

        .hero {
            margin-bottom: 30px;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
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

        .hero h1 {
            font-family: "Space Grotesk", sans-serif;
            font-size: clamp(32px, 5vw, 50px);
            line-height: 1.08;
            color: var(--dark);
            margin-bottom: 12px;
        }

        .hero p {
            max-width: 680px;
            color: var(--muted);
            line-height: 1.7;
            font-size: 15px;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.94);
            border: 1px solid rgba(228, 230, 239, 0.9);
            border-radius: 25px;
            padding: 34px;
            box-shadow: 0 24px 70px rgba(25, 29, 55, 0.09);
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 25px;
        }

        .section-number {
            width: 36px;
            height: 36px;
            border-radius: 11px;
            background: #eeedff;
            color: var(--primary);
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 800;
        }

        .section-title h2 {
            font-family: "Space Grotesk", sans-serif;
            font-size: 20px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px;
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
            font-size: 13px;
            font-weight: 700;
            color: #35394c;
        }

        .required {
            color: var(--danger);
        }

        input,
        textarea,
        select {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 13px;
            padding: 14px 15px;
            font-family: inherit;
            font-size: 14px;
            color: var(--text);
            background: #fbfbfd;
            outline: none;
            transition: 0.25s ease;
        }

        input:hover,
        textarea:hover,
        select:hover {
            border-color: #c9c7f5;
        }

        input:focus,
        textarea:focus,
        select:focus {
            background: white;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.10);
        }

        textarea {
            min-height: 125px;
            resize: vertical;
        }

        .hint {
            color: #9398a9;
            font-size: 11px;
        }

        .error-box {
            margin-bottom: 25px;
            padding: 14px 17px;
            border-radius: 13px;
            background: #fff0f3;
            border: 1px solid #ffc8d3;
            color: var(--danger);
            font-size: 14px;
            font-weight: 600;
        }

        .divider {
            height: 1px;
            background: #ececf2;
            margin: 35px 0;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            border: none;
            text-decoration: none;
            cursor: pointer;
            border-radius: 13px;
            padding: 14px 23px;
            font-family: inherit;
            font-weight: 700;
            font-size: 14px;
            transition: 0.25s ease;
        }

        .btn-cancel {
            color: #555b70;
            background: #f0f1f6;
        }

        .btn-cancel:hover {
            background: #e5e6ed;
        }

        .btn-submit {
            color: white;
            background: linear-gradient(135deg, var(--primary), #887cff);
            box-shadow: 0 10px 25px rgba(108, 99, 255, 0.25);
            min-width: 150px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(108, 99, 255, 0.32);
        }

        .footer-note {
            text-align: center;
            color: #969aaa;
            font-size: 12px;
            margin-top: 25px;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 5%;
            }

            .back-link {
                padding: 8px;
            }

            .page {
                width: 94%;
                margin-top: 35px;
            }

            .form-card {
                padding: 23px 18px;
                border-radius: 20px;
            }

            .grid {
                grid-template-columns: 1fr;
            }

            .field.full {
                grid-column: auto;
            }

            .actions {
                flex-direction: column-reverse;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }

    </style>
</head>

<body>

<nav class="navbar">

    <a href="company-dashboard.jsp" class="brand">
        <div class="brand-icon">H</div>
        <div class="brand-name">Hire<span>Nest</span></div>
    </a>

    <a href="company-dashboard.jsp" class="back-link">
        ← Back to Dashboard
    </a>

</nav>

<main class="page">

    <section class="hero">

        <div class="eyebrow">
            ✦ Company Hiring
        </div>

        <h1>Post your next opportunity.</h1>

        <p>
            Create a detailed job listing and connect your company
            with talented candidates searching for their next career opportunity.
        </p>

    </section>

    <section class="form-card">

        <% if (error != null) { %>

            <div class="error-box">
                <%= error %>
            </div>

        <% } %>

        <form action="post-job" method="post">

            <input type="hidden"
                   name="companyId"
                   value="<%= session.getAttribute("companyId") != null
                           ? session.getAttribute("companyId")
                           : "" %>">

            <div class="section-title">
                <div class="section-number">01</div>
                <h2>Job Information</h2>
            </div>

            <div class="grid">

                <div class="field full">
                    <label for="jobTitle">
                        Job Title <span class="required">*</span>
                    </label>

                    <input
                        type="text"
                        id="jobTitle"
                        name="jobTitle"
                        placeholder="e.g. Java Full Stack Developer"
                        required>
                </div>

                <div class="field">
                    <label for="location">Location</label>

                    <input
                        type="text"
                        id="location"
                        name="location"
                        placeholder="e.g. Jaipur / Remote">
                </div>

                <div class="field">
                    <label for="salary">Salary</label>

                    <input
                        type="text"
                        id="salary"
                        name="salary"
                        placeholder="e.g. ₹5 - ₹8 LPA">
                </div>

                <div class="field full">
                    <label for="jobDescription">
                        Job Description
                    </label>

                    <textarea
                        id="jobDescription"
                        name="jobDescription"
                        placeholder="Describe the role, responsibilities and what the candidate will work on..."></textarea>
                </div>

            </div>

            <div class="divider"></div>

            <div class="section-title">
                <div class="section-number">02</div>
                <h2>Candidate Requirements</h2>
            </div>

            <div class="grid">

                <div class="field full">
                    <label for="skillsRequired">
                        Required Skills
                    </label>

                    <input
                        type="text"
                        id="skillsRequired"
                        name="skillsRequired"
                        placeholder="e.g. Java, Spring Boot, MySQL, REST API, Git">

                    <span class="hint">
                        Separate multiple skills using commas.
                    </span>
                </div>

                <div class="field full">
                    <label for="eligibilityCriteria">
                        Eligibility Criteria
                    </label>

                    <textarea
                        id="eligibilityCriteria"
                        name="eligibilityCriteria"
                        placeholder="e.g. B.Tech / BCA / MCA, minimum 60% CGPA, 0-2 years experience..."></textarea>
                </div>

                <div class="field">
                    <label for="applicationDeadline">
                        Application Deadline
                    </label>

                    <input
                        type="date"
                        id="applicationDeadline"
                        name="applicationDeadline">
                </div>

            </div>

            <div class="actions">

                <a href="company-dashboard.jsp"
                   class="btn btn-cancel">
                    Cancel
                </a>

                <button type="submit"
                        class="btn btn-submit">
                    Publish Job →
                </button>

            </div>

        </form>

        <div class="footer-note">
            Your job listing will be visible to eligible candidates on HireNest.
        </div>

    </section>

</main>

</body>
</html>