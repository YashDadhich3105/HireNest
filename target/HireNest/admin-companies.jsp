<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<Object[]> companies =
            (List<Object[]>) request.getAttribute("companies");

    String search =
            (String) request.getAttribute("search");

    if (companies == null) {
        companies = new java.util.ArrayList<>();
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

    <title>Manage Companies | HireNest</title>

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
            min-height: 72px;
            background: #101828;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 35px;
            gap: 20px;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
            white-space: nowrap;
        }

        .brand span {
            color: #64d8ff;
        }

        .nav-links {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .nav-links a {
            text-decoration: none;
            color: #dce3ef;
            padding: 9px 13px;
            border-radius: 8px;
            font-size: 13px;
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
            margin-bottom: 7px;
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
            font-size: 14px;
        }

        .search input:focus {
            border-color: #64d8ff;
            box-shadow: 0 0 0 3px rgba(100,216,255,0.1);
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

        .search button:hover {
            background: #263449;
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
            min-width: 1100px;
        }

        th {
            text-align: left;
            padding: 17px;
            background: #f8fafc;
            color: #596579;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        td {
            padding: 17px;
            border-top: 1px solid #edf0f4;
            font-size: 14px;
            vertical-align: top;
        }

        tr:hover td {
            background: #fbfcfe;
        }

        .company-id {
            color: #718096;
            font-weight: 700;
        }

        .company-name {
            font-weight: 700;
            font-size: 15px;
        }

        .email {
            color: #3157a6;
        }

        .muted {
            color: #718096;
        }

        .website {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .website:hover {
            text-decoration: underline;
        }

        .description {
            max-width: 280px;
            line-height: 1.5;
            color: #64748b;
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
            padding: 70px 30px;
            text-align: center;
            color: #718096;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .count {
            margin-bottom: 15px;
            color: #64748b;
            font-size: 14px;
        }

        @media(max-width: 900px) {

            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .nav-links {
                justify-content: flex-start;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .search {
                width: 100%;
            }

            .search input {
                width: 100%;
            }

        }

        @media(max-width: 600px) {

            .container {
                padding: 25px 15px;
            }

            .header h1 {
                font-size: 27px;
            }

            .search {
                flex-direction: column;
            }

            .search button {
                width: 100%;
            }

        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="brand">
        Hire<span>Nest</span> Admin
    </div>

    <div class="nav-links">

        <a href="admin-dashboard">
            Dashboard
        </a>

        <a href="admin-students">
            Students
        </a>

        <a href="admin-jobs">
            Jobs
        </a>

        <a href="admin-applications">
            Applications
        </a>

        <a href="admin-logout">
            Logout
        </a>

    </div>

</nav>

<main class="container">

    <div class="header">

        <div>

            <h1>Manage Companies</h1>

            <p>
                View, search and manage registered companies.
            </p>

        </div>

        <form
                action="admin-companies"
                method="get"
                class="search">

            <input
                    type="text"
                    name="search"
                    value="<%= search %>"
                    placeholder="Search company, email or phone"
            >

            <button type="submit">
                Search
            </button>

        </form>

    </div>

    <div class="count">
        <%= companies.size() %> company record(s) found
    </div>

    <div class="table-wrapper">

        <% if (companies.isEmpty()) { %>

            <div class="empty">

                <div class="empty-icon">
                    🏢
                </div>

                <h3>
                    No companies found
                </h3>

                <p>
                    Try another search term.
                </p>

            </div>

        <% } else { %>

        <table>

            <thead>

            <tr>

                <th>ID</th>

                <th>Company</th>

                <th>Email</th>

                <th>Phone</th>

                <th>Website</th>

                <th>Description</th>

                <th>Action</th>

            </tr>

            </thead>

            <tbody>

            <% for (Object[] company : companies) { %>

            <tr>

                <td class="company-id">
                    #<%= company[0] %>
                </td>

                <td>

                    <div class="company-name">
                        <%= company[1] == null
                                ? "N/A"
                                : company[1] %>
                    </div>

                </td>

                <td class="email">

                    <%= company[2] == null
                            ? "N/A"
                            : company[2] %>

                </td>

                <td class="muted">

                    <%= company[3] == null
                            ? "N/A"
                            : company[3] %>

                </td>

                <td>

                    <%
                        String website =
                                company[4] == null
                                        ? ""
                                        : company[4].toString();
                    %>

                    <% if (!website.trim().isEmpty()) { %>

                        <a
                                class="website"
                                href="<%= website %>"
                                target="_blank">

                            Visit Website

                        </a>

                    <% } else { %>

                        <span class="muted">
                            Not provided
                        </span>

                    <% } %>

                </td>

                <td>

                    <div class="description">

                        <%= company[5] == null
                                ? "No description"
                                : company[5] %>

                    </div>

                </td>

                <td>

                    <form
                            action="admin-companies"
                            method="post"
                            onsubmit="return confirm('Delete this company? Related jobs may prevent deletion if database constraints exist.');">

                        <input
                                type="hidden"
                                name="action"
                                value="delete">

                        <input
                                type="hidden"
                                name="companyId"
                                value="<%= company[0] %>">

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