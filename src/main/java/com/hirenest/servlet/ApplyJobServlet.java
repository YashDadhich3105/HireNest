package com.hirenest.servlet;

import com.hirenest.dao.ApplicationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/apply-job")
public class ApplyJobServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("student-login.jsp");
            return;
        }

        String jobIdParameter = request.getParameter("jobId");

        if (jobIdParameter == null || jobIdParameter.trim().isEmpty()) {
            response.sendRedirect("student-jobs");
            return;
        }

        try {

            int jobId = Integer.parseInt(jobIdParameter);

            int studentId = (Integer) session.getAttribute("studentId");

            boolean success =
                    applicationDAO.applyForJob(jobId, studentId);

            if (success) {

                response.sendRedirect(
                        "student-jobs?success=applied"
                );

            } else {

                response.sendRedirect(
                        "student-jobs?error=already-applied"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "student-jobs?error=invalid-job"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-jobs?error=server-error"
            );
        }
    }
}