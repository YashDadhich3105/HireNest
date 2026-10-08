package com.hirenest.dao;

import com.hirenest.db.DBConnection;
import com.hirenest.model.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    public Admin getAdminByLogin(String email, String password) {

        String sql =
                "SELECT admin_id, full_name, email, password " +
                "FROM admins " +
                "WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Admin admin = new Admin();

                    admin.setAdminId(
                            rs.getInt("admin_id"));

                    admin.setFullName(
                            rs.getString("full_name"));

                    admin.setEmail(
                            rs.getString("email"));

                    admin.setPassword(
                            rs.getString("password"));

                    return admin;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}