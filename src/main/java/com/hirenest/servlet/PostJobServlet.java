package com.hirenest.servlet;

import com.hirenest.dao.JobDAO;
import com.hirenest.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/post-job")
public class PostJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("company") == null) {
            response.sendRedirect("company-login.jsp");
            return;
        }

        try {

            int companyId = (Integer) session.getAttribute("company");

            String jobTitle = request.getParameter("jobTitle");
            String jobDescription = request.getParameter("jobDescription");
            String location = request.getParameter("location");
            String salary = request.getParameter("salary");
            String skillsRequired = request.getParameter("skillsRequired");
            String eligibilityCriteria = request.getParameter("eligibilityCriteria");
            String deadlineString = request.getParameter("applicationDeadline");

            Date applicationDeadline = null;

            if (deadlineString != null && !deadlineString.trim().isEmpty()) {
                applicationDeadline = Date.valueOf(deadlineString);
            }

            if (jobTitle == null || jobTitle.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Job title is required."
                );

                request.getRequestDispatcher(
                        "company-post-job.jsp"
                ).forward(request, response);

                return;
            }

            Job job = new Job(
                    companyId,
                    jobTitle.trim(),
                    jobDescription,
                    location,
                    salary,
                    skillsRequired,
                    eligibilityCriteria,
                    applicationDeadline
            );

            boolean success = jobDAO.addJob(job);

            if (success) {

                response.sendRedirect(
                        "company-jobs.jsp?success=Job posted successfully"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to post the job. Please try again."
                );

                request.getRequestDispatcher(
                        "company-post-job.jsp"
                ).forward(request, response);
            }

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "error",
                    "Please enter a valid application deadline."
            );

            request.getRequestDispatcher(
                    "company-post-job.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Something went wrong while posting the job."
            );

            request.getRequestDispatcher(
                    "company-post-job.jsp"
            ).forward(request, response);
        }
    }
}