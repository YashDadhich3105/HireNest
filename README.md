# 🪹 HireNest - Student Placement & Recruitment Management System

[![Java](https://img.shields.io/badge/Java-22-orange.svg?style=flat&logo=openjdk)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue.svg?style=flat&logo=jakartaee)](https://jakarta.ee/)
[![Servlet](https://img.shields.io/badge/Jakarta%20Servlet-6.0-green.svg)](https://jakarta.ee/specifications/servlet/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-blue.svg?style=flat&logo=mysql)](https://www.mysql.com/)
[![Maven](https://img.shields.io/badge/Maven-3.8%2B-red.svg?style=flat&logo=apachemaven)](https://maven.apache.org/)
[![Apache PDFBox](https://img.shields.io/badge/Apache%20PDFBox-3.0.6-yellow.svg)](https://pdfbox.apache.org/)

---

## 📌 Academic Project Details

* **Course Name:** Advance Java Lab — Project Based Learning (PBL)
* **Project Title:** HireNest — Smart Campus Placement & Recruitment Management System
* **Domain:** Enterprise Java Web Application (MVC Architecture)

---

## 👥 Project Team Members

| S.No. | Student Name | Roll Number / Student ID | Branch |
| :---: | :--- | :---: | :---: |
| 1 | **Palak Agarwal** | `24EARIT038` | Information Technology |
| 2 | **Nidhi Sharma** | `24EARIT035` | Information Technology |
| 3 | **Riyanshi Kumawat** | `24EARIT047` | Information Technology |
| 4 | **Yash Dadhich** | `24EARIT062` | Information Technology |
| 5 | **Yash Verma** | `24EARIT063` | Information Technology |

---

## 📋 Table of Contents

- [About The Project](#-about-the-project)
- [Key Features](#-key-features)
  - [1. Student Portal](#1-student-portal)
  - [2. Company / Recruiter Portal](#2-company--recruiter-portal)
  - [3. Admin Control Panel](#3-admin-control-panel)
  - [4. Smart Resume Analyzer & Matcher](#4-smart-resume-analyzer--skill-matcher)
- [System Architecture](#-system-architecture)
- [Technology Stack](#-technology-stack)
- [Database Schema](#-database-schema)
- [Project Directory Structure](#-project-directory-structure)
- [Servlet Endpoint Mappings](#-servlet-endpoint-mappings)
- [Prerequisites & Installation](#-prerequisites--installation)
- [How to Run the Application](#-how-to-run-the-application)
- [Future Enhancements](#-future-enhancements)
- [Academic Declaration](#-academic-declaration)

---

## 🚀 About The Project

**HireNest** is a modern, enterprise-grade **Student Placement & Recruitment Management System** designed to streamline and automate campus placement drives in educational institutions. 

It connects **Students**, **Recruiters/Companies**, and **Placement Officers (Admin)** under a unified platform. HireNest addresses the challenges of manual resume handling, tracking applications, matching candidate skillsets, and broadcasting recruitment notifications.

Built using **Jakarta Servlets**, **JSP (JavaServer Pages)**, **JDBC**, and **MySQL**, HireNest also integrates document processing engines (**Apache PDFBox** & **Apache POI**) to parse student resumes (`.pdf`, `.docx`, `.doc`) and calculate skill compatibility match scores against job postings.

---

## ✨ Key Features

### 1. 🎓 Student Portal
* **Account Registration & Authentication:** Secure sign-up and login with session management.
* **Profile Management:** Maintain academic records (CGPA, Course, Branch, Graduation Year, Contact info).
* **Resume Upload & Automated Parsing:** Upload resumes in PDF or Word format; extracted text is parsed automatically.
* **Job Exploration & Application:** Browse available campus job listings with filters and one-click application submission.
* **Application Status Tracking:** Monitor status of submitted job applications (Pending, Shortlisted, Rejected, Accepted).
* **In-App Notifications:** Real-time alert feed for application updates and placement drive announcements.

### 2. 🏢 Company / Recruiter Portal
* **Company Registration & Authentication:** Verified access for corporate recruiters.
* **Job Posting & Management:** Create detailed job vacancies with title, salary package, location, required skills, eligibility criteria, and deadline.
* **Applicant Tracking System (ATS):** Review list of applicants for posted jobs, access candidate details, and download uploaded resumes.
* **Status Decision Pipeline:** Shortlist, accept, or reject candidate applications with automatic notification triggering.

### 3. ⚙️ Admin Control Panel
* **Institutional Dashboard:** Comprehensive view of metrics (Total Registered Students, Active Companies, Open Job Listings, Total Applications).
* **Student Directory Management:** View, update, or remove student profiles.
* **Company Verification:** Monitor and manage onboarded company profiles.
* **Placement Oversight:** Monitor job listings and application status trends across departments.

### 4. 🤖 Smart Resume Analyzer & Skill Matcher
* **Document Parsing Engine:** Extracts plain text from `.pdf` files using **Apache PDFBox** and `.doc`/`.docx` files using **Apache POI**.
* **Skill Tokenization & Normalization:** Extracts core technical skills (Java, SQL, Spring, Python, React, Data Science, etc.) using normalized keyword extraction algorithms.
* **Match Percentage Score:** Dynamically compares candidate resume text with job requirements to display an exact compatibility percentage score.
* **Skill Gap & Recommendation Engine:** Highlights matched skills, missing required skills, and offers actionable suggestions to help students bridge skill gaps.

---

## 🏗️ System Architecture

HireNest is engineered using the industry-standard **Model-View-Controller (MVC)** architectural pattern combined with the **Data Access Object (DAO)** pattern for clean separation of concerns:

```
                  ┌──────────────────────────────────────────┐
                  │               Client Browser             │
                  └────────────────────┬─────────────────────┘
                                       │ HTTP Request / Response
                                       ▼
                  ┌──────────────────────────────────────────┐
                  │          Jakarta Servlet Container       │
                  │              (Apache Tomcat)             │
                  └──────┬────────────────────────────▲──────┘
                         │                            │
             Controller  │ Servlets                   │ JSP Pages (View)
                         ▼                            │
                  ┌─────────────────────────────┐     │
                  │    com.hirenest.servlet     ├─────┘
                  └──────────────┬──────────────┘
                                 │
                     Services    │ Text Extraction & Skill Matcher
                                 ▼
                  ┌─────────────────────────────┐
                  │    com.hirenest.service     │
                  │ (PDFBox / Apache POI Engine)│
                  └──────────────┬──────────────┘
                                 │
                     DAO Layer   │ Prepared Statements / Data Mapping
                                 ▼
                  ┌─────────────────────────────┐
                  │      com.hirenest.dao       │
                  └──────────────┬──────────────┘
                                 │ JDBC
                                 ▼
                  ┌─────────────────────────────┐
                  │     MySQL Database Engine   │
                  │        (hirenest_db)        │
                  └─────────────────────────────┘
```

* **Model (`com.hirenest.model`):** Encapsulates core domain entities (`Student`, `Job`, `Application`, `Resume`, `ResumeAnalysis`, `Notification`, `Admin`).
* **View (`src/main/webapp/*.jsp`):** Renders dynamic HTML views using standard JavaServer Pages (JSP) taglibs and clean UI CSS styles.
* **Controller (`com.hirenest.servlet`):** Handles HTTP GET/POST requests, routes business logic, manages sessions (`HttpSession`), and forwards responses.
* **Data Access Object (`com.hirenest.dao`):** Handles parameterized SQL queries, CRUD operations, connection cleanup, and database transactions via JDBC.

---

## 🛠️ Technology Stack

| Layer | Technology / Library | Version / Details |
| :--- | :--- | :--- |
| **Language** | Java Development Kit (JDK) | Java 22 |
| **Server Engine** | Jakarta Servlet API | `6.0.0` (Tomcat 10.1+) |
| **Server-Side UI** | Jakarta Servlet JSP API | `3.1.1` |
| **Database** | MySQL Server | 8.0+ |
| **Database Connector** | MySQL Connector/J | `9.5.0` |
| **Document Processing** | Apache PDFBox | `3.0.6` (PDF Parsing) |
| **Office Suite Processing**| Apache POI / POI-OOXML | `5.4.1` (DOC / DOCX Parsing) |
| **Build Management** | Apache Maven | Packaging: `war` |
| **Testing** | JUnit | `3.8.1` |
| **Frontend Styling** | HTML5, CSS3, JavaScript | Custom Responsive UI |

---

## 🗄️ Database Schema

The database `hirenest_db` comprises relational tables linked with Foreign Key constraints:

```sql
CREATE DATABASE IF NOT EXISTS hirenest_db;
USE hirenest_db;

-- 1. Students Table
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    course VARCHAR(50),
    branch VARCHAR(50),
    cgpa DOUBLE,
    graduation_year INT
);

-- 2. Companies Table
CREATE TABLE IF NOT EXISTS companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(100),
    industry VARCHAR(100),
    website VARCHAR(150)
);

-- 3. Jobs Table
CREATE TABLE IF NOT EXISTS jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    job_description TEXT,
    location VARCHAR(100),
    salary VARCHAR(50),
    skills_required TEXT,
    eligibility_criteria TEXT,
    application_deadline DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

-- 4. Applications Table
CREATE TABLE IF NOT EXISTS applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    student_id INT NOT NULL,
    application_status VARCHAR(50) DEFAULT 'Pending',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- 5. Resumes Table
CREATE TABLE IF NOT EXISTS resumes (
    resume_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- 6. Resume Analysis Table
CREATE TABLE IF NOT EXISTS resume_analysis (
    analysis_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    job_id INT NOT NULL,
    match_percentage DOUBLE NOT NULL,
    matched_skills TEXT,
    missing_skills TEXT,
    recommendations TEXT,
    analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE
);

-- 7. Notifications Table
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    notification_type VARCHAR(50),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- 8. Admins Table
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);
```

---

## 📂 Project Directory Structure

```
HireNest/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── hirenest/
        │           ├── dao/
        │           │   ├── AdminApplicationDAO.java
        │           │   ├── AdminCompanyDAO.java
        │           │   ├── AdminDAO.java
        │           │   ├── AdminDashboardDAO.java
        │           │   ├── AdminJobDAO.java
        │           │   ├── AdminStudentDAO.java
        │           │   ├── ApplicationDAO.java
        │           │   ├── CompanyDAO.java
        │           │   ├── JobDAO.java
        │           │   ├── NotificationDAO.java
        │           │   ├── ResumeAnalysisDAO.java
        │           │   ├── ResumeDAO.java
        │           │   └── StudentDAO.java
        │           ├── db/
        │           │   ├── DBConnection.java
        │           │   └── DBTest.java
        │           ├── model/
        │           │   ├── Admin.java
        │           │   ├── Application.java
        │           │   ├── Job.java
        │           │   ├── Notification.java
        │           │   ├── Resume.java
        │           │   ├── ResumeAnalysis.java
        │           │   └── Student.java
        │           ├── service/
        │           │   ├── ResumeAnalyzer.java
        │           │   └── ResumeTextExtractor.java
        │           └── servlet/
        │               ├── AdminApplicationsServlet.java
        │               ├── AdminCompaniesServlet.java
        │               ├── AdminDashboardServlet.java
        │               ├── AdminJobsServlet.java
        │               ├── AdminLoginServlet.java
        │               ├── AdminLogoutServlet.java
        │               ├── AdminStudentsServlet.java
        │               ├── ApplyJobServlet.java
        │               ├── CompanyApplicationsServlet.java
        │               ├── CompanyJobsServlet.java
        │               ├── CompanyLoginServlet.java
        │               ├── CompanyLogoutServlet.java
        │               ├── CompanyRegisterServlet.java
        │               ├── DatabaseTestServlet.java
        │               ├── HomeServlet.java
        │               ├── NotificationServlet.java
        │               ├── PostJobServlet.java
        │               ├── ResumeAnalyzerServlet.java
        │               ├── ResumeUploadServlet.java
        │               ├── StudentApplicationsServlet.java
        │               ├── StudentJobsServlet.java
        │               ├── StudentLoginServlet.java
        │               ├── StudentLogoutServlet.java
        │               ├── StudentProfileServlet.java
        │               └── StudentRegisterServlet.java
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            ├── admin-applications.jsp
            ├── admin-companies.jsp
            ├── admin-dashboard.jsp
            ├── admin-jobs.jsp
            ├── admin-login.jsp
            ├── admin-students.jsp
            ├── company-applications.jsp
            ├── company-dashboard.jsp
            ├── company-jobs.jsp
            ├── company-login.jsp
            ├── company-post-job.jsp
            ├── company-register.jsp
            ├── index.jsp
            ├── jobs.jsp
            ├── notifications.jsp
            ├── resume-analysis.jsp
            ├── student-application.jsp
            ├── student-applications.jsp
            ├── student-dashboard.jsp
            ├── student-jobs.jsp
            ├── student-login.jsp
            ├── student-profile.jsp
            └── student-register.jsp
```

---

## 🔗 Servlet Endpoint Mappings

| Servlet Class | Endpoint Route | Role / Purpose |
| :--- | :--- | :--- |
| `HomeServlet` | `/home` | Root landing page controller |
| `StudentLoginServlet` | `/student/login` | Student authentication & session creation |
| `StudentRegisterServlet` | `/student/register` | Student account registration |
| `StudentProfileServlet` | `/student/profile` | View and edit academic profile |
| `StudentJobsServlet` | `/student/jobs` | Browse active placement opportunities |
| `ApplyJobServlet` | `/student/apply` | Submit application for a job |
| `StudentApplicationsServlet` | `/student/applications` | Track application status history |
| `ResumeUploadServlet` | `/student/resume-upload` | Upload resume file (`.pdf`/`.docx`) |
| `ResumeAnalyzerServlet` | `/student/resume-analyzer` | Run ATS skill-match analysis algorithm |
| `NotificationServlet` | `/student/notifications` | View system alerts & application status updates |
| `CompanyLoginServlet` | `/company/login` | Recruiter authentication |
| `CompanyRegisterServlet` | `/company/register` | Recruiter account onboarding |
| `PostJobServlet` | `/company/post-job` | Publish new job opening |
| `CompanyJobsServlet` | `/company/jobs` | Manage recruiter job listings |
| `CompanyApplicationsServlet` | `/company/applications` | Review applicants & change decision status |
| `AdminLoginServlet` | `/admin/login` | Placement Officer login |
| `AdminDashboardServlet` | `/admin/dashboard` | Placement statistics & analytics overview |
| `AdminStudentsServlet` | `/admin/students` | Placement office student management |
| `AdminCompaniesServlet` | `/admin/companies` | Company approval & verification portal |
| `AdminJobsServlet` | `/admin/jobs` | System-wide job listings manager |
| `AdminApplicationsServlet` | `/admin/applications` | Global application audit log |

---

## ⚡ Prerequisites & Installation

Before building and deploying **HireNest**, ensure your system meets the following software requirements:

1. **Java Development Kit (JDK 22 or 17+)**
   * Check version: `java -version`
2. **Apache Maven (3.8+)**
   * Check version: `mvn -version`
3. **MySQL Database Server (8.0+)**
   * Running on `localhost:3306`
4. **Apache Tomcat Application Server (10.1+)**
   * Tomcat 10+ is required for `jakarta.servlet.*` support.

---

## 🏃 How to Run the Application

### Step 1: Clone the Repository
```bash
git clone https://github.com/YashDadhich3105/HireNest.git
cd HireNest
```

### Step 2: Configure MySQL Database Connection
1. Open MySQL Command Line Client or MySQL Workbench.
2. Execute the table creation script listed in the [Database Schema](#-database-schema) section to create the database `hirenest_db` and required tables.
3. Update database credentials in [`DBConnection.java`](file:///c:/Users/kusha/OneDrive/Desktop/HireNest/HireNest/src/main/java/com/hirenest/db/DBConnection.java):
```java
private static final String URL = "jdbc:mysql://localhost:3306/hirenest_db";
private static final String USER = "your_mysql_username"; // e.g. root
private static final String PASSWORD = "your_mysql_password";
```

### Step 3: Build the Web Application
Compile the source code and generate the `.war` package using Apache Maven:
```bash
mvn clean package
```
*The output artifact `HireNest.war` will be generated inside the `target/` directory.*

### Step 4: Deploy on Apache Tomcat
1. Copy `target/HireNest.war` to your Tomcat installation's `webapps/` directory.
2. Start Apache Tomcat:
   * **Windows:** `bin\startup.bat`
   * **Linux/macOS:** `bin/startup.sh`
3. Access HireNest in your web browser:
   ```
   http://localhost:8080/HireNest/
   ```

---

## 🔮 Future Enhancements

* 🤖 **AI-powered Resume Scoring:** Integration with LLMs/NLP APIs for automated resume feedback and interview questions generation.
* 📧 **Email Notification Service:** JavaMail API integration for automatic confirmation emails.
* 📊 **Analytics Dashboard:** Graphical placement statistics charts for TPO officers using Chart.js.
* 💬 **Interview Scheduling Portal:** Built-in slot booking system for campus interviews.

---

## 📜 Academic Declaration

This project entitled **"HireNest - Student Placement & Recruitment Management System"** is submitted towards the partial fulfillment of the requirements for the **Advance Java Lab - Project Based Learning (PBL)** course.

* **Department:** Department of Information Technology  
* **Academic Year:** 2026-2027  
* **Developed By:** Palak Agarwal, Nidhi Sharma, Riyanshi Kumawat, Yash Dadhich, Yash Verma

---

<p center="true">
  <b>Developed with ❤️ for Advance Java Lab - PBL Project</b>
</p>
