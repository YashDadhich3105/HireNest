package com.hirenest.servlet;

import com.hirenest.dao.JobDAO;
import com.hirenest.dao.ResumeAnalysisDAO;
import com.hirenest.dao.ResumeDAO;
import com.hirenest.model.Job;
import com.hirenest.model.Resume;
import com.hirenest.model.ResumeAnalysis;
import com.hirenest.service.ResumeAnalyzer;
import com.hirenest.service.ResumeTextExtractor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/analyze-resume")
public class ResumeAnalyzerServlet extends HttpServlet {

    private final ResumeDAO resumeDAO = new ResumeDAO();
    private final ResumeAnalysisDAO analysisDAO =
            new ResumeAnalysisDAO();
    private final ResumeAnalyzer resumeAnalyzer =
            new ResumeAnalyzer();
    private final ResumeTextExtractor textExtractor =
            new ResumeTextExtractor();
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            String jobIdParameter =
                    request.getParameter("jobId");

            if (jobIdParameter == null ||
                    jobIdParameter.trim().isEmpty()) {

                response.sendRedirect(
                        "jobs.jsp?error=Invalid+job"
                );
                return;
            }

            int jobId =
                    Integer.parseInt(jobIdParameter);

            Resume resume =
                    resumeDAO.getResume(studentId);

            if (resume == null) {

                response.sendRedirect(
                        "jobs.jsp?error=Please+upload+your+resume+first"
                );
                return;
            }

            Job job =
                    jobDAO.getJobById(jobId);

            if (job == null) {

                response.sendRedirect(
                        "jobs.jsp?error=Job+not+found"
                );
                return;
            }

            String requiredSkills =
                    job.getSkillsRequired();

            if (requiredSkills == null ||
                    requiredSkills.trim().isEmpty()) {

                response.sendRedirect(
                        "jobs.jsp?error=This+job+does+not+have+required+skills+defined"
                );
                return;
            }

            String absoluteResumePath =
                    getServletContext().getRealPath(
                            "/" + resume.getFilePath()
                    );

            if (absoluteResumePath == null ||
                    absoluteResumePath.trim().isEmpty()) {

                response.sendRedirect(
                        "jobs.jsp?error=Unable+to+locate+your+resume"
                );
                return;
            }

            String resumeText =
                    textExtractor.extractText(
                            absoluteResumePath,
                            resume.getFileName()
                    );

            if (resumeText == null ||
                    resumeText.trim().isEmpty()) {

                response.sendRedirect(
                        "jobs.jsp?error=Unable+to+extract+text+from+your+resume"
                );
                return;
            }

            ResumeAnalysis analysis =
                    resumeAnalyzer.analyze(
                            studentId,
                            jobId,
                            resumeText,
                            requiredSkills
                    );

            boolean saved =
                    analysisDAO.saveAnalysis(
                            analysis
                    );

            if (!saved) {

                response.sendRedirect(
                        "jobs.jsp?error=Unable+to+save+resume+analysis"
                );
                return;
            }

            request.setAttribute(
                    "analysis",
                    analysis
            );

            request.setAttribute(
                    "job",
                    job
            );

            request.setAttribute(
                    "resume",
                    resume
            );

            request.getRequestDispatcher(
                    "resume-analysis.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "jobs.jsp?error=Invalid+job+ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "jobs.jsp?error=Resume+analysis+failed"
            );
        }
    }
}