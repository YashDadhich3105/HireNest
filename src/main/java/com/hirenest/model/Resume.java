package com.hirenest.model;

import java.sql.Timestamp;

public class Resume {

    private int resumeId;
    private int studentId;
    private String fileName;
    private String filePath;
    private Timestamp uploadedAt;

    public Resume() {
    }

    public Resume(int studentId, String fileName, String filePath) {
        this.studentId = studentId;
        this.fileName = fileName;
        this.filePath = filePath;
    }

    public int getResumeId() {
        return resumeId;
    }

    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Timestamp getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
}