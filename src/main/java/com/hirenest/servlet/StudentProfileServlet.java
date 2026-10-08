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

@WebServlet("/student-profile")
public class StudentProfileServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            Student student =
                    studentDAO.getStudentById(studentId);

            if (student == null) {

                response.sendRedirect(
                        "student-dashboard.jsp?error=Student+profile+not+found"
                );

                return;
            }

            request.setAttribute(
                    "student",
                    student
            );

            request.getRequestDispatcher(
                    "student-profile.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-dashboard.jsp?error=Unable+to+load+profile"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            String fullName =
                    request.getParameter("fullName");

            String email =
                    request.getParameter("email");

            String phone =
                    request.getParameter("phone");

            String course =
                    request.getParameter("course");

            String branch =
                    request.getParameter("branch");

            String cgpaParameter =
                    request.getParameter("cgpa");

            String graduationYearParameter =
                    request.getParameter("graduationYear");

            if (fullName == null ||
                    fullName.trim().isEmpty() ||
                    email == null ||
                    email.trim().isEmpty()) {

                response.sendRedirect(
                        "student-profile?error=Name+and+email+are+required"
                );

                return;
            }

            if (phone == null) {
                phone = "";
            }

            if (course == null) {
                course = "";
            }

            if (branch == null) {
                branch = "";
            }

            double cgpa;

            int graduationYear;

            try {

                cgpa =
                        Double.parseDouble(
                                cgpaParameter
                        );

                graduationYear =
                        Integer.parseInt(
                                graduationYearParameter
                        );

            } catch (Exception e) {

                response.sendRedirect(
                        "student-profile?error=Please+enter+valid+CGPA+and+graduation+year"
                );

                return;
            }

            if (cgpa < 0 || cgpa > 10) {

                response.sendRedirect(
                        "student-profile?error=CGPA+must+be+between+0+and+10"
                );

                return;
            }

            Student existingStudent =
                    studentDAO.getStudentById(studentId);

            if (existingStudent == null) {

                response.sendRedirect(
                        "student-profile?error=Student+profile+not+found"
                );

                return;
            }

            if (!email.equalsIgnoreCase(
                    existingStudent.getEmail())) {

                Student emailStudent =
                        studentDAO.getStudentByLogin(
                                email,
                                existingStudent.getPassword()
                        );

                if (emailStudent != null &&
                        emailStudent.getStudentId()
                                != studentId) {

                    response.sendRedirect(
                            "student-profile?error=Email+is+already+registered"
                    );

                    return;
                }
            }

            Student student =
                    new Student();

            student.setStudentId(studentId);
            student.setFullName(fullName.trim());
            student.setEmail(email.trim());
            student.setPassword(
                    existingStudent.getPassword()
            );
            student.setPhone(phone.trim());
            student.setCourse(course.trim());
            student.setBranch(branch.trim());
            student.setCgpa(cgpa);
            student.setGraduationYear(
                    graduationYear
            );

            boolean updated =
                    studentDAO.updateStudent(
                            student
                    );

            if (updated) {

                session.setAttribute(
                        "student",
                        student
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

                response.sendRedirect(
                        "student-profile?success=Profile+updated+successfully"
                );

            } else {

                response.sendRedirect(
                        "student-profile?error=Unable+to+update+profile"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-profile?error=Something+went+wrong"
            );
        }
    }
}