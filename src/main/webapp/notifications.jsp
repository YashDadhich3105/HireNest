<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hirenest.model.Notification" %>

<%
    if (session == null ||
            session.getAttribute("studentId") == null) {

        response.sendRedirect("student-login.jsp");
        return;
    }

    List<Notification> notifications =
            (List<Notification>) request.getAttribute("notifications");

    Integer unreadCountObject =
            (Integer) request.getAttribute("unreadCount");

    int unreadCount =
            unreadCountObject != null
                    ? unreadCountObject
                    : 0;

    if (notifications == null) {
        notifications = new java.util.ArrayList<>();
    }

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Notifications | HireNest</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    min-height: 100vh;
    color: #172033;

    background:
        radial-gradient(
            circle at top left,
            rgba(99,102,241,0.13),
            transparent 32%
        ),
        radial-gradient(
            circle at bottom right,
            rgba(124,58,237,0.10),
            transparent 32%
        ),
        #f8fafc;
}

.navbar {
    height: 74px;

    display: flex;
    align-items: center;
    justify-content: space-between;

    padding: 0 7%;

    background: rgba(255,255,255,0.95);

    backdrop-filter: blur(15px);

    border-bottom:
        1px solid rgba(15,23,42,0.07);

    box-shadow:
        0 5px 25px rgba(15,23,42,0.06);

    position: sticky;
    top: 0;
    z-index: 100;
}

.brand {
    text-decoration: none;

    color: #4f46e5;

    display: flex;
    align-items: center;

    gap: 11px;

    font-size: 24px;
    font-weight: 900;
}

.brand-icon {
    width: 42px;
    height: 42px;

    border-radius: 13px;

    display: flex;
    align-items: center;
    justify-content: center;

    color: white;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    box-shadow:
        0 8px 20px rgba(79,70,229,0.25);
}

.nav-actions {
    display: flex;
    align-items: center;
    gap: 10px;
}

.nav-btn {
    text-decoration: none;

    padding: 10px 16px;

    border-radius: 10px;

    font-size: 13px;
    font-weight: 800;

    transition: 0.25s;
}

.nav-btn.secondary {
    background: #f1f5f9;
    color: #475569;
}

.nav-btn.secondary:hover {
    background: #e2e8f0;
}

.nav-btn.primary {
    color: white;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    box-shadow:
        0 7px 18px rgba(79,70,229,0.20);
}

.nav-btn.primary:hover {
    transform: translateY(-2px);
}

.container {
    max-width: 1050px;

    margin: auto;

    padding: 50px 25px 60px;
}

.header {
    display: flex;

    align-items: flex-end;
    justify-content: space-between;

    gap: 25px;

    margin-bottom: 28px;
}

.header-left {
    display: flex;
    align-items: center;
    gap: 18px;
}

.notification-icon {
    width: 68px;
    height: 68px;

    border-radius: 20px;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 30px;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #f5f3ff
        );

    border:
        1px solid #ddd6fe;

    box-shadow:
        0 10px 25px rgba(79,70,229,0.10);
}

.header h1 {
    font-size: 38px;

    letter-spacing: -1px;

    margin-bottom: 5px;
}

.header h1 span {
    color: #4f46e5;
}

.header p {
    color: #64748b;
    font-size: 14px;
}

.unread-badge {
    display: inline-flex;

    align-items: center;
    justify-content: center;

    min-width: 28px;
    height: 28px;

    padding: 0 9px;

    margin-left: 7px;

    border-radius: 50px;

    color: white;

    background:
        linear-gradient(
            135deg,
            #ef4444,
            #dc2626
        );

    font-size: 12px;
    font-weight: 900;

    box-shadow:
        0 6px 14px rgba(239,68,68,0.22);
}

.header-actions {
    display: flex;
    gap: 9px;
}

.action-btn {
    border: none;

    padding: 10px 15px;

    border-radius: 10px;

    font-family: inherit;

    font-size: 12px;
    font-weight: 800;

    cursor: pointer;

    transition: 0.25s;
}

.mark-all-btn {
    color: #4f46e5;
    background: #eef2ff;
}

.mark-all-btn:hover {
    background: #e0e7ff;
    transform: translateY(-1px);
}

.delete-all-btn {
    color: #dc2626;
    background: #fee2e2;
}

.delete-all-btn:hover {
    background: #fecaca;
    transform: translateY(-1px);
}

.alert {
    margin-bottom: 20px;

    padding: 14px 18px;

    border-radius: 12px;

    background: #fee2e2;

    color: #991b1b;

    border:
        1px solid #fecaca;

    font-size: 13px;
    font-weight: 700;
}

.notification-list {
    display: flex;
    flex-direction: column;
    gap: 13px;
}

.notification-card {
    position: relative;

    display: flex;

    align-items: flex-start;

    gap: 16px;

    padding: 21px;

    background: white;

    border:
        1px solid rgba(15,23,42,0.07);

    border-radius: 19px;

    box-shadow:
        0 9px 28px rgba(15,23,42,0.055);

    transition:
        transform 0.25s,
        box-shadow 0.25s,
        border-color 0.25s;
}

.notification-card:hover {
    transform: translateY(-3px);

    box-shadow:
        0 16px 35px rgba(15,23,42,0.09);
}

.notification-card.unread {
    border-left:
        4px solid #4f46e5;

    background:
        linear-gradient(
            90deg,
            #fafaff,
            #ffffff
        );
}

.notification-card.read {
    opacity: 0.78;
}

.type-icon {
    flex-shrink: 0;

    width: 50px;
    height: 50px;

    border-radius: 15px;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 22px;

    background: #f1f5f9;
}

.type-icon.accepted {
    background: #dcfce7;
}

.type-icon.rejected {
    background: #fee2e2;
}

.type-icon.resume {
    background: #fef3c7;
}

.type-icon.job {
    background: #dbeafe;
}

.type-icon.general {
    background: #ede9fe;
}

.notification-content {
    flex: 1;

    min-width: 0;
}

.notification-title-row {
    display: flex;

    align-items: center;

    gap: 9px;

    margin-bottom: 6px;
}

.notification-title {
    color: #172033;

    font-size: 15px;
    font-weight: 900;
}

.new-label {
    padding: 4px 8px;

    border-radius: 50px;

    color: #4f46e5;

    background: #eef2ff;

    font-size: 9px;
    font-weight: 900;

    letter-spacing: 0.4px;
}

.notification-message {
    color: #64748b;

    font-size: 13px;

    line-height: 1.65;

    margin-bottom: 9px;
}

.notification-meta {
    color: #94a3b8;

    font-size: 11px;

    font-weight: 700;
}

.notification-actions {
    display: flex;

    align-items: center;

    gap: 7px;
}

.small-btn {
    border: none;

    width: 35px;
    height: 35px;

    border-radius: 9px;

    display: flex;
    align-items: center;
    justify-content: center;

    cursor: pointer;

    font-size: 15px;

    transition: 0.2s;
}

.read-btn {
    color: #4f46e5;
    background: #eef2ff;
}

.read-btn:hover {
    background: #e0e7ff;
}

.remove-btn {
    color: #dc2626;
    background: #fee2e2;
}

.remove-btn:hover {
    background: #fecaca;
}

.empty-state {
    padding: 75px 25px;

    text-align: center;

    background: white;

    border:
        1px solid rgba(15,23,42,0.07);

    border-radius: 25px;

    box-shadow:
        0 15px 40px rgba(15,23,42,0.06);
}

.empty-icon {
    width: 82px;
    height: 82px;

    margin: 0 auto 18px;

    border-radius: 25px;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 38px;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #f5f3ff
        );
}

.empty-state h2 {
    font-size: 22px;

    margin-bottom: 8px;
}

.empty-state p {
    color: #64748b;

    font-size: 13px;

    max-width: 420px;

    margin: auto;

    line-height: 1.6;
}

.footer {
    text-align: center;

    padding: 25px;

    color: #94a3b8;

    font-size: 12px;
}

@media (max-width: 700px) {

    .navbar {
        padding: 0 20px;
    }

    .nav-btn.secondary {
        display: none;
    }

    .container {
        padding: 35px 15px;
    }

    .header {
        align-items: flex-start;
        flex-direction: column;
    }

    .header h1 {
        font-size: 32px;
    }

    .header-actions {
        width: 100%;
    }

    .action-btn {
        flex: 1;
    }

    .notification-card {
        padding: 17px;
    }

    .type-icon {
        width: 44px;
        height: 44px;
        font-size: 19px;
    }

    .notification-title-row {
        flex-wrap: wrap;
    }

    .notification-actions {
        flex-direction: column;
    }
}

</style>

</head>

<body>

<nav class="navbar">

    <a href="student-dashboard.jsp"
       class="brand">

        <div class="brand-icon">
            H
        </div>

        HireNest

    </a>

    <div class="nav-actions">

        <a href="jobs.jsp"
           class="nav-btn secondary">
            Browse Jobs
        </a>

        <a href="student-dashboard.jsp"
           class="nav-btn primary">
            Dashboard
        </a>

    </div>

</nav>

<main class="container">

    <section class="header">

        <div class="header-left">

            <div class="notification-icon">
                🔔
            </div>

            <div>

                <h1>
                    My <span>Notifications</span>

                    <% if (unreadCount > 0) { %>

                        <span class="unread-badge">
                            <%= unreadCount %>
                        </span>

                    <% } %>

                </h1>

                <p>
                    Stay updated with your HireNest career activity.
                </p>

            </div>

        </div>

        <% if (!notifications.isEmpty()) { %>

            <div class="header-actions">

                <% if (unreadCount > 0) { %>

                    <form
                        action="notifications"
                        method="post">

                        <input
                            type="hidden"
                            name="action"
                            value="markAllRead">

                        <button
                            type="submit"
                            class="action-btn mark-all-btn">

                            ✓ Mark All Read

                        </button>

                    </form>

                <% } %>

                <form
                    action="notifications"
                    method="post"
                    onsubmit="return confirm('Delete all notifications?');">

                    <input
                        type="hidden"
                        name="action"
                        value="deleteAll">

                    <button
                        type="submit"
                        class="action-btn delete-all-btn">

                        Clear All

                    </button>

                </form>

            </div>

        <% } %>

    </section>

    <% if (error != null) { %>

        <div class="alert">
            <%= error %>
        </div>

    <% } %>

    <% if (notifications.isEmpty()) { %>

        <section class="empty-state">

            <div class="empty-icon">
                🔔
            </div>

            <h2>
                You're all caught up
            </h2>

            <p>
                You don't have any notifications yet.
                Application updates, job alerts and other
                important HireNest activity will appear here.
            </p>

        </section>

    <% } else { %>

        <section class="notification-list">

            <% for (Notification notification : notifications) {

                String type =
                        notification.getNotificationType();

                if (type == null) {
                    type = "General";
                }

                String icon = "🔔";
                String iconClass = "general";

                if ("Accepted".equalsIgnoreCase(type)) {
                    icon = "✓";
                    iconClass = "accepted";
                } else if ("Rejected".equalsIgnoreCase(type)) {
                    icon = "✕";
                    iconClass = "rejected";
                } else if ("Resume".equalsIgnoreCase(type)) {
                    icon = "📄";
                    iconClass = "resume";
                } else if ("Job".equalsIgnoreCase(type)) {
                    icon = "💼";
                    iconClass = "job";
                }

            %>

                <article
                    class="notification-card
                    <%= notification.isRead()
                            ? "read"
                            : "unread" %>">

                    <div class="type-icon <%= iconClass %>">
                        <%= icon %>
                    </div>

                    <div class="notification-content">

                        <div class="notification-title-row">

                            <div class="notification-title">
                                <%= notification.getTitle() %>
                            </div>

                            <% if (!notification.isRead()) { %>

                                <span class="new-label">
                                    NEW
                                </span>

                            <% } %>

                        </div>

                        <div class="notification-message">
                            <%= notification.getMessage() %>
                        </div>

                        <div class="notification-meta">

                            <%= notification.getNotificationType() %>

                            &nbsp;•&nbsp;

                            <%= notification.getCreatedAt() %>

                        </div>

                    </div>

                    <div class="notification-actions">

                        <% if (!notification.isRead()) { %>

                            <form
                                action="notifications"
                                method="post">

                                <input
                                    type="hidden"
                                    name="action"
                                    value="markRead">

                                <input
                                    type="hidden"
                                    name="notificationId"
                                    value="<%= notification.getNotificationId() %>">

                                <button
                                    type="submit"
                                    class="small-btn read-btn"
                                    title="Mark as read">

                                    ✓

                                </button>

                            </form>

                        <% } %>

                        <form
                            action="notifications"
                            method="post"
                            onsubmit="return confirm('Delete this notification?');">

                            <input
                                type="hidden"
                                name="action"
                                value="delete">

                            <input
                                type="hidden"
                                name="notificationId"
                                value="<%= notification.getNotificationId() %>">

                            <button
                                type="submit"
                                class="small-btn remove-btn"
                                title="Delete notification">

                                ×

                            </button>

                        </form>

                    </div>

                </article>

            <% } %>

        </section>

    <% } %>

</main>

<footer class="footer">

    HireNest &copy; 2026
    &nbsp;•&nbsp;
    Smart Career &amp; Placement Platform

</footer>

</body>

</html>