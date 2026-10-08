package com.hirenest.servlet;

import com.hirenest.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/company-jobs")
public class CompanyJobsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("companyId") == null) {
            response.sendRedirect("company-login.jsp");
            return;
        }

        int companyId = (Integer) session.getAttribute("companyId");

        String sql =
                "SELECT job_id, job_title, job_description, location, salary, " +
                "skills_required, eligibility_criteria, application_deadline, created_at " +
                "FROM jobs WHERE company_id = ? ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);

            ResultSet rs = ps.executeQuery();

            request.setAttribute("jobs", rs);
            request.getRequestDispatcher("company-jobs.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "company-dashboard.jsp?error=Unable+to+load+jobs"
            );
        }
    }
}