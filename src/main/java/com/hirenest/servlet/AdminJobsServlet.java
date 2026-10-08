package com.hirenest.servlet;

import com.hirenest.dao.AdminJobDAO;
import com.hirenest.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-jobs")
public class AdminJobsServlet extends HttpServlet {

    private final AdminJobDAO jobDAO =
            new AdminJobDAO();

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

        List<Job> jobs;

        if (keyword != null &&
                !keyword.trim().isEmpty()) {

            jobs =
                    jobDAO.searchJobs(
                            keyword.trim());

        } else {

            jobs =
                    jobDAO.getAllJobs();
        }

        request.setAttribute(
                "jobs",
                jobs);

        request.setAttribute(
                "search",
                keyword == null ? "" : keyword);

        request.getRequestDispatcher(
                "admin-jobs.jsp")
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

                int jobId =
                        Integer.parseInt(
                                request.getParameter(
                                        "jobId"));

                jobDAO.deleteJob(jobId);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin-jobs");
    }

    private boolean isAdmin(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null &&
                session.getAttribute("adminId") != null;
    }
}