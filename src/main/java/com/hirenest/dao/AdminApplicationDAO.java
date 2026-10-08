package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminApplicationDAO {

    public List<Application> getAllApplications() {

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.application_id, " +
                "a.job_id, " +
                "a.student_id, " +
                "a.application_status, " +
                "a.applied_at, " +
                "j.job_title, " +
                "j.location, " +
                "j.salary, " +
                "c.company_name, " +
                "s.full_name, " +
                "s.email, " +
                "s.phone, " +
                "s.course, " +
                "s.branch, " +
                "s.cgpa, " +
                "s.graduation_year " +
                "FROM applications a " +
                "JOIN jobs j ON a.job_id = j.job_id " +
                "JOIN companies c ON j.company_id = c.company_id " +
                "JOIN students s ON a.student_id = s.student_id " +
                "ORDER BY a.applied_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Application application = new Application();

                application.setApplicationId(
                        rs.getInt("application_id"));

                application.setJobId(
                        rs.getInt("job_id"));

                application.setStudentId(
                        rs.getInt("student_id"));

                application.setJobTitle(
                        rs.getString("job_title"));

                application.setCompanyName(
                        rs.getString("company_name"));

                application.setLocation(
                        rs.getString("location"));

                application.setSalary(
                        rs.getString("salary"));

                application.setStudentName(
                        rs.getString("full_name"));

                application.setStudentEmail(
                        rs.getString("email"));

                application.setStudentPhone(
                        rs.getString("phone"));

                application.setStudentCourse(
                        rs.getString("course"));

                application.setStudentBranch(
                        rs.getString("branch"));

                application.setStudentCgpa(
                        rs.getDouble("cgpa"));

                application.setStudentGraduationYear(
                        rs.getInt("graduation_year"));

                application.setApplicationStatus(
                        rs.getString("application_status"));

                application.setAppliedAt(
                        rs.getTimestamp("applied_at"));

                applications.add(application);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    public List<Application> searchApplications(String keyword) {

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.application_id, " +
                "a.job_id, " +
                "a.student_id, " +
                "a.application_status, " +
                "a.applied_at, " +
                "j.job_title, " +
                "j.location, " +
                "j.salary, " +
                "c.company_name, " +
                "s.full_name, " +
                "s.email, " +
                "s.phone, " +
                "s.course, " +
                "s.branch, " +
                "s.cgpa, " +
                "s.graduation_year " +
                "FROM applications a " +
                "JOIN jobs j ON a.job_id = j.job_id " +
                "JOIN companies c ON j.company_id = c.company_id " +
                "JOIN students s ON a.student_id = s.student_id " +
                "WHERE s.full_name LIKE ? " +
                "OR s.email LIKE ? " +
                "OR j.job_title LIKE ? " +
                "OR c.company_name LIKE ? " +
                "OR a.application_status LIKE ? " +
                "ORDER BY a.applied_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);
            ps.setString(5, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Application application = new Application();

                    application.setApplicationId(
                            rs.getInt("application_id"));

                    application.setJobId(
                            rs.getInt("job_id"));

                    application.setStudentId(
                            rs.getInt("student_id"));

                    application.setJobTitle(
                            rs.getString("job_title"));

                    application.setCompanyName(
                            rs.getString("company_name"));

                    application.setLocation(
                            rs.getString("location"));

                    application.setSalary(
                            rs.getString("salary"));

                    application.setStudentName(
                            rs.getString("full_name"));

                    application.setStudentEmail(
                            rs.getString("email"));

                    application.setStudentPhone(
                            rs.getString("phone"));

                    application.setStudentCourse(
                            rs.getString("course"));

                    application.setStudentBranch(
                            rs.getString("branch"));

                    application.setStudentCgpa(
                            rs.getDouble("cgpa"));

                    application.setStudentGraduationYear(
                            rs.getInt("graduation_year"));

                    application.setApplicationStatus(
                            rs.getString("application_status"));

                    application.setAppliedAt(
                            rs.getTimestamp("applied_at"));

                    applications.add(application);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    public int getTotalApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications");
    }

    public int getAcceptedApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Accepted'");
    }

    public int getRejectedApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Rejected'");
    }

    public int getPendingApplications() {
        return getCount(
                "SELECT COUNT(*) FROM applications " +
                "WHERE application_status = 'Applied'");
    }

    public int getTotalStudents() {
        return getCount(
                "SELECT COUNT(*) FROM students");
    }

    public int getTotalCompanies() {
        return getCount(
                "SELECT COUNT(*) FROM companies");
    }

    public int getTotalJobs() {
        return getCount(
                "SELECT COUNT(*) FROM jobs");
    }

    private int getCount(String sql) {

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
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