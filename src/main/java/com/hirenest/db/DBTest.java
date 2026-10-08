package com.hirenest.db;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try (Connection con = DBConnection.getConnection()) {

            if (con != null && !con.isClosed()) {
                System.out.println("=================================");
                System.out.println("HIRENEST DATABASE CONNECTION OK");
                System.out.println("Database: hirenest_db");
                System.out.println("MySQL connection successful!");
                System.out.println("=================================");
            }

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
    }
}