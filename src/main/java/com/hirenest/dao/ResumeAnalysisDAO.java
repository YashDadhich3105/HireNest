package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.ResumeAnalysis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ResumeAnalysisDAO {

    public boolean saveAnalysis(ResumeAnalysis analysis) {

        String deleteSql =
                "DELETE FROM resume_analysis " +
                "WHERE student_id = ? AND job_id = ?";

        String insertSql =
                "INSERT INTO resume_analysis " +
                "(student_id, job_id, match_percentage, matched_skills, " +
                "missing_skills, recommendations) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement deletePs =
                     con.prepareStatement(deleteSql);
             PreparedStatement insertPs =
                     con.prepareStatement(insertSql)) {

            deletePs.setInt(1, analysis.getStudentId());
            deletePs.setInt(2, analysis.getJobId());
            deletePs.executeUpdate();

            insertPs.setInt(1, analysis.getStudentId());
            insertPs.setInt(2, analysis.getJobId());
            insertPs.setDouble(3, analysis.getMatchPercentage());
            insertPs.setString(4, analysis.getMatchedSkills());
            insertPs.setString(5, analysis.getMissingSkills());
            insertPs.setString(6, analysis.getRecommendations());

            return insertPs.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    public ResumeAnalysis getAnalysis(
            int studentId,
            int jobId) {

        String sql =
                "SELECT analysis_id, student_id, job_id, " +
                "match_percentage, matched_skills, missing_skills, " +
                "recommendations, analyzed_at " +
                "FROM resume_analysis " +
                "WHERE student_id = ? AND job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, jobId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    ResumeAnalysis analysis =
                            new ResumeAnalysis();

                    analysis.setAnalysisId(
                            rs.getInt("analysis_id")
                    );

                    analysis.setStudentId(
                            rs.getInt("student_id")
                    );

                    analysis.setJobId(
                            rs.getInt("job_id")
                    );

                    analysis.setMatchPercentage(
                            rs.getDouble("match_percentage")
                    );

                    analysis.setMatchedSkills(
                            rs.getString("matched_skills")
                    );

                    analysis.setMissingSkills(
                            rs.getString("missing_skills")
                    );

                    analysis.setRecommendations(
                            rs.getString("recommendations")
                    );

                    analysis.setAnalyzedAt(
                            rs.getTimestamp("analyzed_at")
                    );

                    return analysis;
                }

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public List<ResumeAnalysis> getAnalysesByStudent(
            int studentId) {

        List<ResumeAnalysis> analyses =
                new ArrayList<>();

        String sql =
                "SELECT analysis_id, student_id, job_id, " +
                "match_percentage, matched_skills, missing_skills, " +
                "recommendations, analyzed_at " +
                "FROM resume_analysis " +
                "WHERE student_id = ? " +
                "ORDER BY analyzed_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    ResumeAnalysis analysis =
                            new ResumeAnalysis();

                    analysis.setAnalysisId(
                            rs.getInt("analysis_id")
                    );

                    analysis.setStudentId(
                            rs.getInt("student_id")
                    );

                    analysis.setJobId(
                            rs.getInt("job_id")
                    );

                    analysis.setMatchPercentage(
                            rs.getDouble("match_percentage")
                    );

                    analysis.setMatchedSkills(
                            rs.getString("matched_skills")
                    );

                    analysis.setMissingSkills(
                            rs.getString("missing_skills")
                    );

                    analysis.setRecommendations(
                            rs.getString("recommendations")
                    );

                    analysis.setAnalyzedAt(
                            rs.getTimestamp("analyzed_at")
                    );

                    analyses.add(analysis);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return analyses;
    }

    public boolean deleteAnalysis(
            int studentId,
            int jobId) {

        String sql =
                "DELETE FROM resume_analysis " +
                "WHERE student_id = ? AND job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, jobId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }
}