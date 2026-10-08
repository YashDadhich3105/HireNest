package com.hirenest.servlet;

import com.hirenest.dao.AdminStudentDAO;
import com.hirenest.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-students")
public class AdminStudentsServlet extends HttpServlet {

    private final AdminStudentDAO studentDAO =
            new AdminStudentDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String keyword =
                request.getParameter("search");

        List<Student> students;

        if (keyword != null &&
                !keyword.trim().isEmpty()) {

            students =
                    studentDAO.searchStudents(
                            keyword.trim());

        } else {

            students =
                    studentDAO.getAllStudents();
        }

        request.setAttribute(
                "students",
                students);

        request.setAttribute(
                "search",
                keyword == null ? "" : keyword);

        request.getRequestDispatcher(
                "admin-students.jsp")
                .forward(
                        request,
                        response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String action =
                request.getParameter("action");

        if ("delete".equals(action)) {

            try {

                int studentId =
                        Integer.parseInt(
                                request.getParameter(
                                        "studentId"));

                studentDAO.deleteStudent(studentId);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin-students");
    }

    private boolean isAdmin(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null &&
                session.getAttribute("adminId") != null;
    }
}
