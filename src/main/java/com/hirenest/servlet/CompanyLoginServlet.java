package com.hirenest.servlet;

import com.hirenest.dao.CompanyDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/company-login")
public class CompanyLoginServlet extends HttpServlet {

    private final CompanyDAO companyDAO = new CompanyDAO();

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
                    "company-login.jsp?error=Please+enter+your+email+address"
            );

            return;
        }

        if (password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    "company-login.jsp?error=Please+enter+your+password"
            );

            return;
        }

        email = email.trim();

        if (!EMAIL_PATTERN.matcher(email).matches()) {

            response.sendRedirect(
                    "company-login.jsp?error=Please+enter+a+valid+email+address"
            );

            return;
        }

        if (email.length() > 100) {

            response.sendRedirect(
                    "company-login.jsp?error=Email+address+is+too+long"
            );

            return;
        }

        if (password.length() > 100) {

            response.sendRedirect(
                    "company-login.jsp?error=Password+is+too+long"
            );

            return;
        }

        int companyId =
                companyDAO.loginCompany(
                        email,
                        password
                );

        if (companyId != -1) {

            HttpSession oldSession =
                    request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session =
                    request.getSession(true);

            session.setAttribute(
                    "company",
                    companyId
            );

            session.setAttribute(
                    "companyId",
                    companyId
            );

            session.setAttribute(
                    "companyEmail",
                    email
            );

            response.sendRedirect(
                    "company-dashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    "company-login.jsp?error=Invalid+email+or+password"
            );
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                "company-login.jsp"
        );
    }
}