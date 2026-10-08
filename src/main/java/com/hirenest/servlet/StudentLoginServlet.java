package com.hirenest.servlet;

import com.hirenest.dao.StudentDAO;
import com.hirenest.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            );

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()) {

            response.sendRedirect(
                    "student-login.jsp?error=Please+enter+your+email+address"
            );

            return;
        }

        if (password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    "student-login.jsp?error=Please+enter+your+password"
            );

            return;
        }

        email = email.trim();

        if (!EMAIL_PATTERN.matcher(email).matches()) {

            response.sendRedirect(
                    "student-login.jsp?error=Please+enter+a+valid+email+address"
            );

            return;
        }

        if (email.length() > 100) {

            response.sendRedirect(
                    "student-login.jsp?error=Email+address+is+too+long"
            );

            return;
        }

        if (password.length() > 100) {

            response.sendRedirect(
                    "student-login.jsp?error=Password+is+too+long"
            );

            return;
        }

        Student student =
                studentDAO.getStudentByLogin(
                        email,
                        password
                );

        if (student != null) {

            HttpSession oldSession =
                    request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session =
                    request.getSession(true);

            session.setAttribute(
                    "student",
                    true
            );

            session.setAttribute(
                    "studentId",
                    student.getStudentId()
            );

            session.setAttribute(
                    "studentName",
                    student.getFullName()
            );

            session.setAttribute(
                    "studentEmail",
                    student.getEmail()
            );

            session.setAttribute(
                    "studentPhone",
                    student.getPhone()
            );

            session.setAttribute(
                    "studentCourse",
                    student.getCourse()
            );

            session.setAttribute(
                    "studentBranch",
                    student.getBranch()
            );

            session.setAttribute(
                    "studentCgpa",
                    student.getCgpa()
            );

            session.setAttribute(
                    "studentGraduationYear",
                    student.getGraduationYear()
            );

            response.sendRedirect(
                    "student-dashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    "student-login.jsp?error=Invalid+email+or+password"
            );
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                "student-login.jsp"
        );
    }
}