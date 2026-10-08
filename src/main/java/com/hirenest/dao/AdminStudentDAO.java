package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminStudentDAO {

    public List<Student> getAllStudents() {

        List<Student> students = new ArrayList<>();

        String sql =
                "SELECT student_id, full_name, email, phone, " +
                "course, branch, cgpa, graduation_year " +
                "FROM students ORDER BY student_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setCourse(rs.getString("course"));
                student.setBranch(rs.getString("branch"));
                student.setCgpa(rs.getDouble("cgpa"));
                student.setGraduationYear(
                        rs.getInt("graduation_year"));

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    public List<Student> searchStudents(String keyword) {

        List<Student> students = new ArrayList<>();

        String sql =
                "SELECT student_id, full_name, email, phone, " +
                "course, branch, cgpa, graduation_year " +
                "FROM students " +
                "WHERE full_name LIKE ? " +
                "OR email LIKE ? " +
                "OR course LIKE ? " +
                "OR branch LIKE ? " +
                "ORDER BY student_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Student student = new Student();

                    student.setStudentId(
                            rs.getInt("student_id"));

                    student.setFullName(
                            rs.getString("full_name"));

                    student.setEmail(
                            rs.getString("email"));

                    student.setPhone(
                            rs.getString("phone"));

                    student.setCourse(
                            rs.getString("course"));

                    student.setBranch(
                            rs.getString("branch"));

                    student.setCgpa(
                            rs.getDouble("cgpa"));

                    student.setGraduationYear(
                            rs.getInt("graduation_year"));

                    students.add(student);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    public boolean deleteStudent(int studentId) {

        String sql =
                "DELETE FROM students WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}