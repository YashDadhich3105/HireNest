package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ApplicationDAO {

    public boolean applyForJob(int studentId, int jobId) {

        String checkSql =
                "SELECT application_id FROM applications " +
                "WHERE student_id = ? AND job_id = ?";

        String insertSql =
                "INSERT INTO applications " +
                "(job_id, student_id, application_status) " +
                "VALUES (?, ?, 'Applied')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setInt(1, studentId);
            checkPs.setInt(2, jobId);

            try (ResultSet rs = checkPs.executeQuery()) {

                if (rs.next()) {
                    return false;
                }
            }

            try (PreparedStatement insertPs =
                         con.prepareStatement(insertSql)) {

                insertPs.setInt(1, jobId);
                insertPs.setInt(2, studentId);

                return insertPs.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Set<Integer> getAppliedJobIds(int studentId) {

        Set<Integer> appliedJobIds = new HashSet<>();

        String sql =
                "SELECT job_id FROM applications " +
                "WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    appliedJobIds.add(rs.getInt("job_id"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appliedJobIds;
    }

    public List<Application> getApplicationsByStudent(int studentId) {

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
                "c.company_name " +
                "FROM applications a " +
                "JOIN jobs j ON a.job_id = j.job_id " +
                "JOIN companies c ON j.company_id = c.company_id " +
                "WHERE a.student_id = ? " +
                "ORDER BY a.applied_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

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

    public List<Application> getApplicationsByCompany(int companyId) {

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
                "WHERE j.company_id = ? " +
                "ORDER BY a.applied_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);

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

    public boolean updateApplicationStatus(
            int applicationId,
            int companyId,
            String status) {

        String sql =
                "UPDATE applications a " +
                "JOIN jobs j ON a.job_id = j.job_id " +
                "SET a.application_status = ? " +
                "WHERE a.application_id = ? " +
                "AND j.company_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, applicationId);
            ps.setInt(3, companyId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}