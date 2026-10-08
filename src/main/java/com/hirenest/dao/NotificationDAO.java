package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public List<Notification> getNotificationsByStudent(int studentId) {

        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_id, student_id, title, message, " +
                "notification_type, is_read, created_at " +
                "FROM notifications " +
                "WHERE student_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Notification notification = new Notification();

                    notification.setNotificationId(
                            rs.getInt("notification_id"));

                    notification.setStudentId(
                            rs.getInt("student_id"));

                    notification.setTitle(
                            rs.getString("title"));

                    notification.setMessage(
                            rs.getString("message"));

                    notification.setNotificationType(
                            rs.getString("notification_type"));

                    notification.setRead(
                            rs.getBoolean("is_read"));

                    notification.setCreatedAt(
                            rs.getTimestamp("created_at"));

                    notifications.add(notification);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return notifications;
    }

    public List<Notification> getNotificationsByStudentId(int studentId) {
        return getNotificationsByStudent(studentId);
    }

    public int getUnreadCount(int studentId) {

        String sql = "SELECT COUNT(*) FROM notifications " +
                "WHERE student_id = ? AND is_read = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean markAsRead(int notificationId, int studentId) {

        String sql = "UPDATE notifications " +
                "SET is_read = 1 " +
                "WHERE notification_id = ? AND student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, notificationId);
            ps.setInt(2, studentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markAllAsRead(int studentId) {

        String sql = "UPDATE notifications " +
                "SET is_read = 1 " +
                "WHERE student_id = ? AND is_read = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createNotification(Notification notification) {

        String sql = "INSERT INTO notifications " +
                "(student_id, title, message, notification_type) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, notification.getStudentId());
            ps.setString(2, notification.getTitle());
            ps.setString(3, notification.getMessage());
            ps.setString(4, notification.getNotificationType());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createNotification(
            int studentId,
            String title,
            String message,
            String notificationType) {

        Notification notification =
                new Notification(
                        studentId,
                        title,
                        message,
                        notificationType);

        return createNotification(notification);
    }

    public boolean deleteNotification(
            int notificationId,
            int studentId) {

        String sql = "DELETE FROM notifications " +
                "WHERE notification_id = ? AND student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, notificationId);
            ps.setInt(2, studentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAllNotifications(int studentId) {

        String sql = "DELETE FROM notifications WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}