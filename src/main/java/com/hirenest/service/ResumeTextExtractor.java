package com.hirenest.service;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

public class ResumeTextExtractor {

    public String extractText(
            String filePath,
            String fileName) throws Exception {

        if (filePath == null ||
                filePath.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Resume file path is empty."
            );
        }

        File file = new File(filePath);

        if (!file.exists() ||
                !file.isFile()) {

            throw new IllegalArgumentException(
                    "Resume file does not exist."
            );
        }

        String lowerFileName =
                fileName == null
                        ? file.getName().toLowerCase()
                        : fileName.toLowerCase();

        if (lowerFileName.endsWith(".pdf")) {

            return extractPdfText(file);

        } else if (lowerFileName.endsWith(".docx")) {

            return extractDocxText(file);

        } else if (lowerFileName.endsWith(".doc")) {

            return extractDocText(file);

        } else {

            throw new IllegalArgumentException(
                    "Unsupported resume format."
            );
        }
    }

    private String extractPdfText(
            File file) throws Exception {

        try (PDDocument document =
                     Loader.loadPDF(file)) {

            PDFTextStripper stripper =
                    new PDFTextStripper();

            return cleanText(
                    stripper.getText(document)
            );
        }
    }

    private String extractDocxText(
            File file) throws Exception {

        try (InputStream inputStream =
                     new FileInputStream(file);
             XWPFDocument document =
                     new XWPFDocument(inputStream);
             XWPFWordExtractor extractor =
                     new XWPFWordExtractor(document)) {

            return cleanText(
                    extractor.getText()
            );
        }
    }

    private String extractDocText(
            File file) throws Exception {

        try (InputStream inputStream =
                     new FileInputStream(file);
             HWPFDocument document =
                     new HWPFDocument(inputStream);
             WordExtractor extractor =
                     new WordExtractor(document)) {

            return cleanText(
                    extractor.getText()
            );
        }
    }

    private String cleanText(
            String text) {

        if (text == null) {
            return "";
        }

        return text
                .replace("\r", " ")
                .replace("\n", " ")
                .replace("\t", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }
}