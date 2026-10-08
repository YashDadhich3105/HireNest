package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Resume;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ResumeDAO {

    public boolean saveResume(Resume resume) {

        String deleteSql =
                "DELETE FROM resumes WHERE student_id = ?";

        String insertSql =
                "INSERT INTO resumes " +
                "(student_id, file_name, file_path) " +
                "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement deletePs =
                     con.prepareStatement(deleteSql);
             PreparedStatement insertPs =
                     con.prepareStatement(insertSql)) {

            deletePs.setInt(1, resume.getStudentId());
            deletePs.executeUpdate();

            insertPs.setInt(1, resume.getStudentId());
            insertPs.setString(2, resume.getFileName());
            insertPs.setString(3, resume.getFilePath());

            return insertPs.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    public boolean hasResume(int studentId) {

        String sql =
                "SELECT resume_id FROM resumes WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    public Resume getResume(int studentId) {

        String sql =
                "SELECT resume_id, student_id, file_name, " +
                "file_path, uploaded_at " +
                "FROM resumes WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Resume resume = new Resume();

                    resume.setResumeId(
                            rs.getInt("resume_id")
                    );

                    resume.setStudentId(
                            rs.getInt("student_id")
                    );

                    resume.setFileName(
                            rs.getString("file_name")
                    );

                    resume.setFilePath(
                            rs.getString("file_path")
                    );

                    resume.setUploadedAt(
                            rs.getTimestamp("uploaded_at")
                    );

                    return resume;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public boolean deleteResume(int studentId) {

        String sql =
                "DELETE FROM resumes WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }
}