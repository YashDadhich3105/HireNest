package com.hirenest.servlet;

import com.hirenest.dao.AdminCompanyDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-companies")
public class AdminCompaniesServlet extends HttpServlet {

    private final AdminCompanyDAO companyDAO =
            new AdminCompanyDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String keyword =
                request.getParameter("search");

        List<Object[]> companies;

        if (keyword != null &&
                !keyword.trim().isEmpty()) {

            companies =
                    companyDAO.searchCompanies(
                            keyword.trim());

        } else {

            companies =
                    companyDAO.getAllCompanies();
        }

        request.setAttribute(
                "companies",
                companies);

        request.setAttribute(
                "search",
                keyword == null ? "" : keyword);

        request.getRequestDispatcher(
                "admin-companies.jsp")
                .forward(
                        request,
                        response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String action =
                request.getParameter("action");

        if ("delete".equals(action)) {

            try {

                int companyId =
                        Integer.parseInt(
                                request.getParameter(
                                        "companyId"));

                companyDAO.deleteCompany(companyId);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin-companies");
    }

    private boolean isAdmin(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null &&
                session.getAttribute("adminId") != null;
    }
}