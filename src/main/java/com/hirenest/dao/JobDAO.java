package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Job;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public boolean addJob(Job job) {

        String sql =
                "INSERT INTO jobs " +
                "(company_id, job_title, job_description, location, salary, " +
                "skills_required, eligibility_criteria, application_deadline) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, job.getCompanyId());
            ps.setString(2, job.getJobTitle());
            ps.setString(3, job.getJobDescription());
            ps.setString(4, job.getLocation());
            ps.setString(5, job.getSalary());
            ps.setString(6, job.getSkillsRequired());
            ps.setString(7, job.getEligibilityCriteria());

            if (job.getApplicationDeadline() != null) {
                ps.setDate(
                        8,
                        job.getApplicationDeadline()
                );
            } else {
                ps.setDate(8, null);
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    public boolean createJob(Job job) {
        return addJob(job);
    }

    public List<Job> getJobsByCompany(int companyId) {

        List<Job> jobs = new ArrayList<>();

        String sql =
                "SELECT * FROM jobs " +
                "WHERE company_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    jobs.add(mapJob(rs));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return jobs;
    }

    public List<Job> getAllJobs() {

        List<Job> jobs = new ArrayList<>();

        String sql =
                "SELECT * FROM jobs " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                jobs.add(mapJob(rs));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return jobs;
    }

    public Job getJobById(int jobId) {

        String sql =
                "SELECT * FROM jobs " +
                "WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jobId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return mapJob(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    private Job mapJob(ResultSet rs) throws Exception {

        Job job = new Job();

        job.setJobId(
                rs.getInt("job_id")
        );

        job.setCompanyId(
                rs.getInt("company_id")
        );

        job.setJobTitle(
                rs.getString("job_title")
        );

        job.setJobDescription(
                rs.getString("job_description")
        );

        job.setLocation(
                rs.getString("location")
        );

        job.setSalary(
                rs.getString("salary")
        );

        job.setSkillsRequired(
                rs.getString("skills_required")
        );

        job.setEligibilityCriteria(
                rs.getString("eligibility_criteria")
        );

        job.setApplicationDeadline(
                rs.getDate("application_deadline")
        );

        job.setCreatedAt(
                rs.getTimestamp("created_at")
        );

        return job;
    }
}