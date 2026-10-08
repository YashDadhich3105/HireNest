package com.hirenest.servlet;

import com.hirenest.dao.StudentDAO;
import com.hirenest.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/student-register")
public class StudentRegisterServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String course = request.getParameter("course");
        String branch = request.getParameter("branch");
        String cgpaValue = request.getParameter("cgpa");
        String graduationYearValue = request.getParameter("graduationYear");

        if (fullName == null || email == null || password == null ||
                phone == null || course == null || branch == null ||
                cgpaValue == null || graduationYearValue == null) {

            response.sendRedirect("student-register.jsp?error=missing");
            return;
        }

        try {

            double cgpa = Double.parseDouble(cgpaValue);
            int graduationYear = Integer.parseInt(graduationYearValue);

            if (studentDAO.emailExists(email)) {
                response.sendRedirect("student-register.jsp?error=email");
                return;
            }

            Student student = new Student(
                    fullName,
                    email,
                    password,
                    phone,
                    course,
                    branch,
                    cgpa,
                    graduationYear
            );

            boolean registered = studentDAO.registerStudent(student);

            if (registered) {
                response.sendRedirect("student-login.jsp?success=registered");
            } else {
                response.sendRedirect("student-register.jsp?error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("student-register.jsp?error=invalid");
        }
    }
}