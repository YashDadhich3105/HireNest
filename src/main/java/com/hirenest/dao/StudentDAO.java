package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentDAO {

    public boolean registerStudent(Student student) {

        String sql = "INSERT INTO students " +
                "(full_name, email, password, phone, course, branch, cgpa, graduation_year) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());
            ps.setString(4, student.getPhone());
            ps.setString(5, student.getCourse());
            ps.setString(6, student.getBranch());
            ps.setDouble(7, student.getCgpa());
            ps.setInt(8, student.getGraduationYear());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExists(String email) {

        String sql = "SELECT student_id FROM students WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Student getStudentByLogin(String email, String password) {

        String sql = "SELECT student_id, full_name, email, password, phone, " +
                "course, branch, cgpa, graduation_year " +
                "FROM students WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Student student = new Student();

                    student.setStudentId(rs.getInt("student_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setPassword(rs.getString("password"));
                    student.setPhone(rs.getString("phone"));
                    student.setCourse(rs.getString("course"));
                    student.setBranch(rs.getString("branch"));
                    student.setCgpa(rs.getDouble("cgpa"));
                    student.setGraduationYear(rs.getInt("graduation_year"));

                    return student;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Student getStudentById(int studentId) {

        String sql = "SELECT student_id, full_name, email, password, phone, " +
                "course, branch, cgpa, graduation_year " +
                "FROM students WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Student student = new Student();

                    student.setStudentId(rs.getInt("student_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setPassword(rs.getString("password"));
                    student.setPhone(rs.getString("phone"));
                    student.setCourse(rs.getString("course"));
                    student.setBranch(rs.getString("branch"));
                    student.setCgpa(rs.getDouble("cgpa"));
                    student.setGraduationYear(rs.getInt("graduation_year"));

                    return student;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateStudent(Student student) {

        String sql = "UPDATE students SET " +
                "full_name = ?, " +
                "email = ?, " +
                "phone = ?, " +
                "course = ?, " +
                "branch = ?, " +
                "cgpa = ?, " +
                "graduation_year = ? " +
                "WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPhone());
            ps.setString(4, student.getCourse());
            ps.setString(5, student.getBranch());
            ps.setDouble(6, student.getCgpa());
            ps.setInt(7, student.getGraduationYear());
            ps.setInt(8, student.getStudentId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}