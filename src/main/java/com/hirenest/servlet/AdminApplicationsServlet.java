package com.hirenest.servlet;

import com.hirenest.dao.AdminApplicationDAO;
import com.hirenest.model.Application;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-applications")
public class AdminApplicationsServlet extends HttpServlet {

    private final AdminApplicationDAO applicationDAO =
            new AdminApplicationDAO();

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

        List<Application> applications;

        if (keyword != null &&
                !keyword.trim().isEmpty()) {

            applications =
                    applicationDAO.searchApplications(
                            keyword.trim());

        } else {

            applications =
                    applicationDAO.getAllApplications();
        }

        int totalApplications =
                applicationDAO.getTotalApplications();

        int acceptedApplications =
                applicationDAO.getAcceptedApplications();

        int rejectedApplications =
                applicationDAO.getRejectedApplications();

        int pendingApplications =
                applicationDAO.getPendingApplications();

        int totalStudents =
                applicationDAO.getTotalStudents();

        int totalCompanies =
                applicationDAO.getTotalCompanies();

        int totalJobs =
                applicationDAO.getTotalJobs();

        double placementRate = 0;

        if (totalApplications > 0) {

            placementRate =
                    (acceptedApplications * 100.0)
                            / totalApplications;
        }

        request.setAttribute(
                "applications",
                applications);

        request.setAttribute(
                "search",
                keyword == null ? "" : keyword);

        request.setAttribute(
                "totalApplications",
                totalApplications);

        request.setAttribute(
                "acceptedApplications",
                acceptedApplications);

        request.setAttribute(
                "rejectedApplications",
                rejectedApplications);

        request.setAttribute(
                "pendingApplications",
                pendingApplications);

        request.setAttribute(
                "totalStudents",
                totalStudents);

        request.setAttribute(
                "totalCompanies",
                totalCompanies);

        request.setAttribute(
                "totalJobs",
                totalJobs);

        request.setAttribute(
                "placementRate",
                placementRate);

        request.getRequestDispatcher(
                "admin-applications.jsp")
                .forward(
                        request,
                        response);
    }

    private boolean isAdmin(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null &&
                session.getAttribute("adminId") != null;
    }
}