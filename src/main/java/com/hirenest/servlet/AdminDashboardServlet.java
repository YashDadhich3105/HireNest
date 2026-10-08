package com.hirenest.servlet;

import com.hirenest.dao.AdminDashboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminDashboardDAO dashboardDAO =
            new AdminDashboardDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("adminId") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        request.setAttribute(
                "totalStudents",
                dashboardDAO.getTotalStudents()
        );

        request.setAttribute(
                "totalCompanies",
                dashboardDAO.getTotalCompanies()
        );

        request.setAttribute(
                "totalJobs",
                dashboardDAO.getTotalJobs()
        );

        request.setAttribute(
                "totalApplications",
                dashboardDAO.getTotalApplications()
        );

        request.setAttribute(
                "totalResumes",
                dashboardDAO.getTotalResumes()
        );

        request.setAttribute(
                "totalNotifications",
                dashboardDAO.getTotalNotifications()
        );

        request.setAttribute(
                "acceptedApplications",
                dashboardDAO.getAcceptedApplications()
        );

        request.setAttribute(
                "rejectedApplications",
                dashboardDAO.getRejectedApplications()
        );

        request.setAttribute(
                "pendingApplications",
                dashboardDAO.getPendingApplications()
        );

        request.getRequestDispatcher(
                "admin-dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}