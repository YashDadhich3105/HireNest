package com.hirenest.dao;

import com.hirenest.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDashboardDAO {

    public int getTotalStudents() {
        return getCount("SELECT COUNT(*) FROM students");
    }

    public int getTotalCompanies() {
        return getCount("SELECT COUNT(*) FROM companies");
    }

    public int getTotalJobs() {
        return getCount("SELECT COUNT(*) FROM jobs");
    }

    public int getTotalApplications() {
        return getCount("SELECT COUNT(*) FROM applications");
    }

    public int getTotalResumes() {
        return getCount("SELECT COUNT(*) FROM resumes");
    }

    public int getTotalNotifications() {
        return getCount("SELECT COUNT(*) FROM notifications");
    }

    public int getAcceptedApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Accepted'"
        );
    }

    public int getRejectedApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Rejected'"
        );
    }

    public int getPendingApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Applied'"
        );
    }

    private int getCount(String sql) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}