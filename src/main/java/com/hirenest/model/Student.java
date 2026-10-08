package com.hirenest.model;

public class Student {

    private int studentId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String course;
    private String branch;
    private double cgpa;
    private int graduationYear;

    public Student() {
    }

    public Student(String fullName, String email, String password,
                   String phone, String course, String branch,
                   double cgpa, int graduationYear) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.course = course;
        this.branch = branch;
        this.cgpa = cgpa;
        this.graduationYear = graduationYear;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    public int getGraduationYear() {
        return graduationYear;
    }

    public void setGraduationYear(int graduationYear) {
        this.graduationYear = graduationYear;
    }
}