package com.hirenest.service;

import com.hirenest.model.ResumeAnalysis;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

public class ResumeAnalyzer {

    private static final List<String> COMMON_SKILLS =
            Arrays.asList(
                    "java",
                    "python",
                    "c",
                    "c++",
                    "c#",
                    "javascript",
                    "typescript",
                    "html",
                    "css",
                    "sql",
                    "mysql",
                    "postgresql",
                    "mongodb",
                    "oracle",
                    "spring",
                    "spring boot",
                    "hibernate",
                    "servlet",
                    "jsp",
                    "jdbc",
                    "react",
                    "react.js",
                    "angular",
                    "node.js",
                    "express",
                    "php",
                    "laravel",
                    "django",
                    "flask",
                    "machine learning",
                    "deep learning",
                    "artificial intelligence",
                    "data science",
                    "pandas",
                    "numpy",
                    "matplotlib",
                    "tensorflow",
                    "pytorch",
                    "git",
                    "github",
                    "docker",
                    "aws",
                    "azure",
                    "rest api",
                    "rest",
                    "api",
                    "json",
                    "xml",
                    "maven",
                    "tomcat",
                    "linux"
            );

    public ResumeAnalysis analyze(
            int studentId,
            int jobId,
            String resumeText,
            String requiredSkills) {

        ResumeAnalysis analysis =
                new ResumeAnalysis();

        analysis.setStudentId(studentId);
        analysis.setJobId(jobId);

        if (resumeText == null) {
            resumeText = "";
        }

        if (requiredSkills == null) {
            requiredSkills = "";
        }

        String normalizedResume =
                normalize(resumeText);

        List<String> requiredSkillList =
                extractRequiredSkills(requiredSkills);

        Set<String> matchedSkills =
                new LinkedHashSet<>();

        Set<String> missingSkills =
                new LinkedHashSet<>();

        for (String skill : requiredSkillList) {

            String normalizedSkill =
                    normalize(skill);

            if (normalizedSkill.isEmpty()) {
                continue;
            }

            if (containsSkill(
                    normalizedResume,
                    normalizedSkill)) {

                matchedSkills.add(skill);

            } else {

                missingSkills.add(skill);
            }
        }

        double matchPercentage = 0.0;

        if (!requiredSkillList.isEmpty()) {

            matchPercentage =
                    ((double) matchedSkills.size()
                            / requiredSkillList.size()) * 100.0;
        }

        matchPercentage =
                Math.round(matchPercentage * 100.0) / 100.0;

        analysis.setMatchPercentage(matchPercentage);

        analysis.setMatchedSkills(
                joinSkills(matchedSkills)
        );

        analysis.setMissingSkills(
                joinSkills(missingSkills)
        );

        analysis.setRecommendations(
                generateRecommendations(missingSkills)
        );

        return analysis;
    }

    private List<String> extractRequiredSkills(
            String requiredSkills) {

        Set<String> skills =
                new LinkedHashSet<>();

        String[] parts =
                requiredSkills.split("[,;|\\n]+");

        for (String part : parts) {

            String skill =
                    part.trim();

            if (!skill.isEmpty()) {

                skills.add(skill);
            }
        }

        if (skills.size() == 1) {

            String singleValue =
                    skills.iterator().next();

            String normalized =
                    normalize(singleValue);

            List<String> detected =
                    new ArrayList<>();

            for (String commonSkill :
                    COMMON_SKILLS) {

                if (containsSkill(
                        normalized,
                        normalize(commonSkill))) {

                    detected.add(commonSkill);
                }
            }

            if (!detected.isEmpty()) {

                skills.clear();
                skills.addAll(detected);
            }
        }

        return new ArrayList<>(skills);
    }

    private boolean containsSkill(
            String resumeText,
            String skill) {

        if (resumeText.isEmpty() ||
                skill.isEmpty()) {

            return false;
        }

        String searchableText =
                " " + resumeText + " ";

        String searchableSkill =
                " " + skill + " ";

        return searchableText.contains(
                searchableSkill
        );
    }

    private String generateRecommendations(
            Set<String> missingSkills) {

        if (missingSkills.isEmpty()) {

            return "Excellent match. Your resume contains all the required skills for this job.";
        }

        StringBuilder recommendations =
                new StringBuilder();

        recommendations.append(
                "Consider learning or improving: "
        );

        int count = 0;

        for (String skill :
                missingSkills) {

            if (count > 0) {
                recommendations.append(", ");
            }

            recommendations.append(skill);

            count++;

            if (count >= 5) {
                break;
            }
        }

        recommendations.append(".");

        return recommendations.toString();
    }

    private String joinSkills(
            Set<String> skills) {

        if (skills.isEmpty()) {
            return "None";
        }

        return String.join(", ", skills);
    }

    private String normalize(
            String text) {

        return text
                .toLowerCase(Locale.ROOT)
                .replaceAll("[^a-z0-9+#.\\s]", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }
}