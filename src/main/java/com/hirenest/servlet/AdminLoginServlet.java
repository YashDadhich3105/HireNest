package com.hirenest.servlet;

import com.hirenest.dao.AdminDAO;
import com.hirenest.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            );

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-login.jsp?error=Please+enter+your+email+address"
            );

            return;
        }

        if (password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-login.jsp?error=Please+enter+your+password"
            );

            return;
        }

        email = email.trim();

        if (!EMAIL_PATTERN.matcher(email).matches()) {

            response.sendRedirect(
                    "admin-login.jsp?error=Please+enter+a+valid+email+address"
            );

            return;
        }

        if (email.length() > 100) {

            response.sendRedirect(
                    "admin-login.jsp?error=Email+address+is+too+long"
            );

            return;
        }

        if (password.length() > 100) {

            response.sendRedirect(
                    "admin-login.jsp?error=Password+is+too+long"
            );

            return;
        }

        Admin admin =
                adminDAO.getAdminByLogin(
                        email,
                        password
                );

        if (admin != null) {

            HttpSession oldSession =
                    request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session =
                    request.getSession(true);

            session.setAttribute(
                    "adminId",
                    admin.getAdminId()
            );

            session.setAttribute(
                    "adminName",
                    admin.getFullName()
            );

            session.setAttribute(
                    "adminEmail",
                    admin.getEmail()
            );

            response.sendRedirect(
                    "admin-dashboard"
            );

        } else {

            response.sendRedirect(
                    "admin-login.jsp?error=Invalid+admin+credentials"
            );
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                "admin-login.jsp"
        );
    }
}