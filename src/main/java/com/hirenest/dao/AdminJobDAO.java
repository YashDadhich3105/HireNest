package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Job;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminJobDAO {

    public List<Job> getAllJobs() {

        List<Job> jobs = new ArrayList<>();

        String sql =
                "SELECT j.job_id, j.company_id, " +
                "j.job_title, j.job_description, j.location, " +
                "j.salary, j.skills_required, " +
                "j.eligibility_criteria, " +
                "j.application_deadline, " +
                "c.company_name " +
                "FROM jobs j " +
                "JOIN companies c " +
                "ON j.company_id = c.company_id " +
                "ORDER BY j.job_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Job job = new Job();

                job.setJobId(
                        rs.getInt("job_id"));

                job.setCompanyId(
                        rs.getInt("company_id"));

                job.setJobTitle(
                        rs.getString("job_title"));

                job.setJobDescription(
                        rs.getString("job_description"));

                job.setLocation(
                        rs.getString("location"));

                job.setSalary(
                        rs.getString("salary"));

                job.setSkillsRequired(
                        rs.getString("skills_required"));

                job.setEligibilityCriteria(
                        rs.getString("eligibility_criteria"));

                job.setApplicationDeadline(
                        rs.getDate("application_deadline"));

                job.setCompanyName(
                        rs.getString("company_name"));

                jobs.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }

    public List<Job> searchJobs(String keyword) {

        List<Job> jobs = new ArrayList<>();

        String sql =
                "SELECT j.job_id, j.company_id, " +
                "j.job_title, j.job_description, j.location, " +
                "j.salary, j.skills_required, " +
                "j.eligibility_criteria, " +
                "j.application_deadline, " +
                "c.company_name " +
                "FROM jobs j " +
                "JOIN companies c " +
                "ON j.company_id = c.company_id " +
                "WHERE j.job_title LIKE ? " +
                "OR j.location LIKE ? " +
                "OR c.company_name LIKE ? " +
                "OR j.skills_required LIKE ? " +
                "ORDER BY j.job_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Job job = new Job();

                    job.setJobId(
                            rs.getInt("job_id"));

                    job.setCompanyId(
                            rs.getInt("company_id"));

                    job.setJobTitle(
                            rs.getString("job_title"));

                    job.setJobDescription(
                            rs.getString("job_description"));

                    job.setLocation(
                            rs.getString("location"));

                    job.setSalary(
                            rs.getString("salary"));

                    job.setSkillsRequired(
                            rs.getString("skills_required"));

                    job.setEligibilityCriteria(
                            rs.getString("eligibility_criteria"));

                    job.setApplicationDeadline(
                            rs.getDate("application_deadline"));

                    job.setCompanyName(
                            rs.getString("company_name"));

                    jobs.add(job);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }

    public boolean deleteJob(int jobId) {

        String sql =
                "DELETE FROM jobs WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jobId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}