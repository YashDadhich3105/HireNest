package com.hirenest.servlet;

import com.hirenest.dao.ApplicationDAO;
import com.hirenest.dao.NotificationDAO;
import com.hirenest.model.Application;
import com.hirenest.model.Notification;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/company-applications")
public class CompanyApplicationsServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();

    private final NotificationDAO notificationDAO =
            new NotificationDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("companyId") == null) {

            response.sendRedirect("company-login.jsp");
            return;
        }

        try {

            int companyId =
                    (Integer) session.getAttribute("companyId");

            List<Application> applications =
                    applicationDAO.getApplicationsByCompany(
                            companyId
                    );

            request.setAttribute(
                    "applications",
                    applications
            );

            request.getRequestDispatcher(
                    "company-applications.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "company-dashboard.jsp?error=Unable+to+load+applications"
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
                session.getAttribute("companyId") == null) {

            response.sendRedirect("company-login.jsp");
            return;
        }

        try {

            int companyId =
                    (Integer) session.getAttribute("companyId");

            int applicationId =
                    Integer.parseInt(
                            request.getParameter(
                                    "applicationId"
                            )
                    );

            String status =
                    request.getParameter("status");

            if (!"Accepted".equals(status) &&
                    !"Rejected".equals(status)) {

                response.sendRedirect(
                        "company-applications?error=Invalid+status"
                );

                return;
            }

            boolean updated =
                    applicationDAO.updateApplicationStatus(
                            applicationId,
                            companyId,
                            status
                    );

            if (!updated) {

                response.sendRedirect(
                        "company-applications?error=Unable+to+update+application"
                );

                return;
            }

            List<Application> applications =
                    applicationDAO.getApplicationsByCompany(
                            companyId
                    );

            Application selectedApplication = null;

            for (Application application : applications) {

                if (application.getApplicationId()
                        == applicationId) {

                    selectedApplication = application;
                    break;
                }
            }

            if (selectedApplication != null) {

                String studentName =
                        selectedApplication.getStudentName();

                String jobTitle =
                        selectedApplication.getJobTitle();

                String title;

                String message;

                if ("Accepted".equals(status)) {

                    title =
                            "Application Accepted 🎉";

                    message =
                            "Congratulations " +
                            studentName +
                            "! Your application for " +
                            jobTitle +
                            " has been accepted.";

                } else {

                    title =
                            "Application Update";

                    message =
                            "Your application for " +
                            jobTitle +
                            " has been rejected by the company.";
                }

                Notification notification =
                        new Notification(
                                selectedApplication.getStudentId(),
                                title,
                                message,
                                status
                        );

                notificationDAO.createNotification(
                        notification
                );
            }

            response.sendRedirect(
                    "company-applications?success=Application+status+updated"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "company-applications?error=Something+went+wrong"
            );
        }
    }
}