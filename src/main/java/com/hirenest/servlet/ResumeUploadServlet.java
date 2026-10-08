package com.hirenest.servlet;

import com.hirenest.dao.ResumeDAO;
import com.hirenest.model.Resume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/upload-resume")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class ResumeUploadServlet extends HttpServlet {

    private final ResumeDAO resumeDAO = new ResumeDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("student-login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute("studentId");

            Part filePart =
                    request.getPart("resume");

            if (filePart == null ||
                    filePart.getSize() == 0) {

                response.sendRedirect(
                        "student-dashboard.jsp?resumeError=Please+select+a+resume"
                );
                return;
            }

            String originalFileName =
                    Paths.get(
                            filePart.getSubmittedFileName()
                    ).getFileName().toString();

            String lowerFileName =
                    originalFileName.toLowerCase();

            boolean validExtension =
                    lowerFileName.endsWith(".pdf") ||
                    lowerFileName.endsWith(".doc") ||
                    lowerFileName.endsWith(".docx");

            if (!validExtension) {

                response.sendRedirect(
                        "student-dashboard.jsp?resumeError=Only+PDF%2C+DOC+and+DOCX+files+are+allowed"
                );
                return;
            }

            String extension = "";

            int dotIndex =
                    originalFileName.lastIndexOf(".");

            if (dotIndex >= 0) {
                extension =
                        originalFileName.substring(dotIndex);
            }

            String safeFileName =
                    "student_" +
                    studentId +
                    "_resume" +
                    extension;

            String uploadDirectory =
                    getServletContext().getRealPath(
                            "/uploads/resumes"
                    );

            File directory =
                    new File(uploadDirectory);

            if (!directory.exists()) {
                directory.mkdirs();
            }

            File resumeFile =
                    new File(
                            directory,
                            safeFileName
                    );

            filePart.write(
                    resumeFile.getAbsolutePath()
            );

            String filePath =
                    "uploads/resumes/" +
                    safeFileName;

            Resume resume =
                    new Resume(
                            studentId,
                            originalFileName,
                            filePath
                    );

            boolean saved =
                    resumeDAO.saveResume(resume);

            if (saved) {

                response.sendRedirect(
                        "student-dashboard.jsp?resumeSuccess=Resume+uploaded+successfully"
                );

            } else {

                if (resumeFile.exists()) {
                    resumeFile.delete();
                }

                response.sendRedirect(
                        "student-dashboard.jsp?resumeError=Unable+to+save+resume"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "student-dashboard.jsp?resumeError=Something+went+wrong+while+uploading+resume"
            );
        }
    }
}