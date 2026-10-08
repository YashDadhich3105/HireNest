package com.hirenest.servlet;

import com.hirenest.dao.NotificationDAO;
import com.hirenest.model.Notification;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

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
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            List<Notification> notifications =
                    notificationDAO.getNotificationsByStudent(
                            studentId
                    );

            int unreadCount =
                    notificationDAO.getUnreadCount(
                            studentId
                    );

            request.setAttribute(
                    "notifications",
                    notifications
            );

            request.setAttribute(
                    "unreadCount",
                    unreadCount
            );

            request.getRequestDispatcher(
                    "notifications.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-dashboard.jsp?error=Unable+to+load+notifications"
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

            String action =
                    request.getParameter("action");

            if ("markRead".equals(action)) {

                String notificationIdParameter =
                        request.getParameter("notificationId");

                if (notificationIdParameter != null) {

                    int notificationId =
                            Integer.parseInt(
                                    notificationIdParameter
                            );

                    notificationDAO.markAsRead(
                            notificationId,
                            studentId
                    );
                }

                response.sendRedirect(
                        "notifications"
                );

                return;
            }

            if ("markAllRead".equals(action)) {

                notificationDAO.markAllAsRead(
                        studentId
                );

                response.sendRedirect(
                        "notifications"
                );

                return;
            }

            if ("delete".equals(action)) {

                String notificationIdParameter =
                        request.getParameter("notificationId");

                if (notificationIdParameter != null) {

                    int notificationId =
                            Integer.parseInt(
                                    notificationIdParameter
                            );

                    notificationDAO.deleteNotification(
                            notificationId,
                            studentId
                    );
                }

                response.sendRedirect(
                        "notifications"
                );

                return;
            }

            if ("deleteAll".equals(action)) {

                notificationDAO.deleteAllNotifications(
                        studentId
                );

                response.sendRedirect(
                        "notifications"
                );

                return;
            }

            response.sendRedirect(
                    "notifications"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "notifications?error=Something+went+wrong"
            );
        }
    }
}