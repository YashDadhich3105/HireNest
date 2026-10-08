package com.hirenest.dao;

import com.hirenest.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminCompanyDAO {

    public List<Object[]> getAllCompanies() {

        List<Object[]> companies = new ArrayList<>();

        String sql =
                "SELECT company_id, company_name, email, phone, " +
                "website, description, created_at " +
                "FROM companies " +
                "ORDER BY company_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Object[] company = new Object[7];

                company[0] = rs.getInt("company_id");
                company[1] = rs.getString("company_name");
                company[2] = rs.getString("email");
                company[3] = rs.getString("phone");
                company[4] = rs.getString("website");
                company[5] = rs.getString("description");
                company[6] = rs.getTimestamp("created_at");

                companies.add(company);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return companies;
    }

    public List<Object[]> searchCompanies(String keyword) {

        List<Object[]> companies = new ArrayList<>();

        String sql =
                "SELECT company_id, company_name, email, phone, " +
                "website, description, created_at " +
                "FROM companies " +
                "WHERE company_name LIKE ? " +
                "OR email LIKE ? " +
                "OR phone LIKE ? " +
                "ORDER BY company_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Object[] company = new Object[7];

                    company[0] = rs.getInt("company_id");
                    company[1] = rs.getString("company_name");
                    company[2] = rs.getString("email");
                    company[3] = rs.getString("phone");
                    company[4] = rs.getString("website");
                    company[5] = rs.getString("description");
                    company[6] = rs.getTimestamp("created_at");

                    companies.add(company);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return companies;
    }

    public boolean deleteCompany(int companyId) {

        String sql =
                "DELETE FROM companies WHERE company_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}