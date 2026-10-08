package com.hirenest.servlet;

import com.hirenest.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/db-test")
public class DatabaseTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        try (Connection con = DBConnection.getConnection()) {

            if (con != null && !con.isClosed()) {

                out.println("""
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>HireNest Database Test</title>
                        <style>
                            * {
                                box-sizing: border-box;
                                margin: 0;
                                padding: 0;
                            }

                            body {
                                min-height: 100vh;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-family: Arial, sans-serif;
                                background: linear-gradient(135deg, #0f172a, #1e293b, #0f766e);
                                color: white;
                            }

                            .card {
                                width: 520px;
                                padding: 45px;
                                border-radius: 24px;
                                text-align: center;
                                background: rgba(255, 255, 255, 0.10);
                                border: 1px solid rgba(255, 255, 255, 0.18);
                                box-shadow: 0 25px 70px rgba(0, 0, 0, 0.35);
                                backdrop-filter: blur(18px);
                            }

                            .icon {
                                width: 80px;
                                height: 80px;
                                margin: 0 auto 22px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                border-radius: 50%;
                                font-size: 38px;
                                background: rgba(34, 197, 94, 0.18);
                                border: 1px solid rgba(34, 197, 94, 0.35);
                            }

                            h1 {
                                margin-bottom: 12px;
                                font-size: 30px;
                            }

                            .success {
                                color: #86efac;
                                font-size: 20px;
                                font-weight: bold;
                                margin-bottom: 28px;
                            }

                            .info {
                                padding: 18px;
                                border-radius: 15px;
                                background: rgba(0, 0, 0, 0.18);
                                text-align: left;
                                line-height: 2;
                            }

                            .label {
                                color: #94a3b8;
                            }

                            .value {
                                color: #f8fafc;
                                font-weight: bold;
                            }

                            .footer {
                                margin-top: 25px;
                                color: #94a3b8;
                                font-size: 13px;
                            }
                        </style>
                    </head>
                    <body>
                        <div class="card">
                            <div class="icon">✓</div>

                            <h1>HireNest Database</h1>

                            <div class="success">
                                Database Connected Successfully
                            </div>

                            <div class="info">
                                <div>
                                    <span class="label">Database:</span>
                                    <span class="value"> hirenest_db</span>
                                </div>

                                <div>
                                    <span class="label">Server:</span>
                                    <span class="value"> localhost:3306</span>
                                </div>

                                <div>
                                    <span class="label">Status:</span>
                                    <span class="value"> Connected</span>
                                </div>
                            </div>

                            <div class="footer">
                                HireNest • Student Placement & Recruitment Platform
                            </div>
                        </div>
                    </body>
                    </html>
                    """);

            } else {

                out.println("""
                    <html>
                    <body>
                        <h1>Database Connection Failed</h1>
                    </body>
                    </html>
                    """);
            }

        } catch (Exception e) {

            out.println("""
                <!DOCTYPE html>
                <html>
                <head>
                    <title>HireNest Database Error</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background: #0f172a;
                            color: white;
                            padding: 50px;
                        }

                        .error {
                            max-width: 800px;
                            margin: auto;
                            padding: 30px;
                            border-radius: 20px;
                            background: #1e293b;
                            border: 1px solid #ef4444;
                        }

                        h1 {
                            color: #f87171;
                        }

                        pre {
                            margin-top: 20px;
                            padding: 20px;
                            border-radius: 12px;
                            background: #020617;
                            color: #fca5a5;
                            white-space: pre-wrap;
                        }
                    </style>
                </head>
                <body>
                    <div class="error">
                        <h1>Database Connection Failed</h1>
                        <pre>
                """ + e.getMessage() + """
                        </pre>
                    </div>
                </body>
                </html>
                """);
        }
    }
}