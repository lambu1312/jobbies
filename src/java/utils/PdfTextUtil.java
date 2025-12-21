package utils;

import java.io.File;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class PdfTextUtil {

    public static String extractText(File pdfFile) throws Exception {
        try (PDDocument document = Loader.loadPDF(pdfFile)) {
            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setSortByPosition(true);

            String text = stripper.getText(document);
            if (text == null) return "";
            text = text.trim();

            int maxLen = 25000;
            if (text.length() > maxLen) text = text.substring(0, maxLen);
            return text;
        }
    }
}
