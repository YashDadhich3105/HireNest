<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Student" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<Student> students =
            (List<Student>) request.getAttribute("students");

    String search =
            (String) request.getAttribute("search");

    if (students == null) {
        students = new java.util.ArrayList<>();
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

    <title>Manage Students | HireNest</title>

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
            height: 72px;
            background: #101828;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 35px;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
        }

        .brand span {
            color: #64d8ff;
        }

        .nav-links {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #dce3ef;
            padding: 9px 14px;
            border-radius: 8px;
            font-size: 14px;
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
            margin-bottom: 6px;
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
            font-size: 13px;
            text-transform: uppercase;
        }

        td {
            padding: 17px;
            border-top: 1px solid #edf0f4;
            font-size: 14px;
        }

        .student-name {
            font-weight: 700;
        }

        .muted {
            color: #718096;
        }

        .badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #eef5ff;
            color: #3157a6;
            font-size: 12px;
            font-weight: 700;
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
            padding: 60px;
            text-align: center;
            color: #718096;
        }

        @media(max-width: 800px) {

            .navbar {
                padding: 0 18px;
            }

            .nav-links a:not(:first-child) {
                display: none;
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

        <a href="admin-companies">
            Companies
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

            <h1>Manage Students</h1>

            <p>
                View, search and manage registered students.
            </p>

        </div>

        <form
                action="admin-students"
                method="get"
                class="search">

            <input
                    type="text"
                    name="search"
                    value="<%= search %>"
                    placeholder="Search students..."
            >

            <button type="submit">
                Search
            </button>

        </form>

    </div>

    <div class="table-wrapper">

        <% if (students.isEmpty()) { %>

            <div class="empty">
                No students found.
            </div>

        <% } else { %>

        <table>

            <thead>

            <tr>
                <th>ID</th>
                <th>Student</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Course</th>
                <th>Branch</th>
                <th>CGPA</th>
                <th>Graduation</th>
                <th>Action</th>
            </tr>

            </thead>

            <tbody>

            <% for (Student student : students) { %>

            <tr>

                <td>
                    #<%= student.getStudentId() %>
                </td>

                <td class="student-name">
                    <%= student.getFullName() %>
                </td>

                <td>
                    <%= student.getEmail() %>
                </td>

                <td class="muted">
                    <%= student.getPhone() %>
                </td>

                <td>
                    <%= student.getCourse() %>
                </td>

                <td>
                    <span class="badge">
                        <%= student.getBranch() %>
                    </span>
                </td>

                <td>
                    <%= student.getCgpa() %>
                </td>

                <td>
                    <%= student.getGraduationYear() %>
                </td>

                <td>

                    <form
                            action="admin-students"
                            method="post"
                            onsubmit="return confirm('Delete this student? This may also affect related records.');">

                        <input
                                type="hidden"
                                name="action"
                                value="delete">

                        <input
                                type="hidden"
                                name="studentId"
                                value="<%= student.getStudentId() %>">

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