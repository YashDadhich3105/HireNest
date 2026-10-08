package com.hirenest.servlet;

import com.hirenest.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/company-register")
public class CompanyRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String companyName = request.getParameter("companyName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String website = request.getParameter("website");
        String description = request.getParameter("description");

        companyName = companyName == null ? "" : companyName.trim();
        email = email == null ? "" : email.trim();
        password = password == null ? "" : password;
        phone = phone == null ? "" : phone.trim();
        website = website == null ? "" : website.trim();
        description = description == null ? "" : description.trim();

        if (companyName.isEmpty()
                || email.isEmpty()
                || password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Company name, email and password are required."
            );

            request.getRequestDispatcher(
                    "company-register.jsp"
            ).forward(request, response);

            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

            request.setAttribute(
                    "error",
                    "Please enter a valid email address."
            );

            request.getRequestDispatcher(
                    "company-register.jsp"
            ).forward(request, response);

            return;
        }

        if (password.length() < 6) {

            request.setAttribute(
                    "error",
                    "Password must contain at least 6 characters."
            );

            request.getRequestDispatcher(
                    "company-register.jsp"
            ).forward(request, response);

            return;
        }

        String sql =
                "INSERT INTO companies " +
                "(company_name, email, password, phone, website, description) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, companyName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, website);
            ps.setString(6, description);

            int result = ps.executeUpdate();

            if (result > 0) {

                response.sendRedirect(
                        "company-login.jsp?registered=true"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Company registration failed."
                );

                request.getRequestDispatcher(
                        "company-register.jsp"
                ).forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Registration failed. This email may already be registered."
            );

            request.getRequestDispatcher(
                    "company-register.jsp"
            ).forward(request, response);
        }
    }
}