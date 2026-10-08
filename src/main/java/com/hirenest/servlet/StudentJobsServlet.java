package com.hirenest.servlet;

import com.hirenest.dao.ApplicationDAO;
import com.hirenest.dao.JobDAO;
import com.hirenest.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/student-jobs")
public class StudentJobsServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            List<Job> jobs = jobDAO.getAllJobs();

            Set<Integer> appliedJobIds =
                    applicationDAO.getAppliedJobIds(studentId);

            request.setAttribute("jobs", jobs);
            request.setAttribute("appliedJobIds", appliedJobIds);

            request.getRequestDispatcher("jobs.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-dashboard.jsp?error=Unable+to+load+jobs"
            );
        }
    }
}