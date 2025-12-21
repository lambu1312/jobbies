package controller.recruiter;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "GeminiAISuggestion", urlPatterns = {"/GeminiAISuggestion"})
public class GeminiAISuggestion extends HttpServlet {

    // Working API key (tested with curl)
    private static final String GEMINI_API_KEY = "AIzaSyAPSi0NWA4XXNOrk6J0KUdpyEsoPJFRquI";

    // Use v1beta API (confirmed working with curl test)
    private static final String[] AVAILABLE_MODELS = {
        "gemini-2.5-flash", // Fastest, tested working
        "gemini-2.5-pro", // Most capable
        "gemini-2.0-flash-001", // Stable version
        "gemini-2.0-flash" // General version
    };
    private static String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + GEMINI_API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Đọc jobTitle từ request
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            Gson gson = new Gson();
            JsonObject requestData = gson.fromJson(sb.toString(), JsonObject.class);
            String jobTitle = requestData.get("jobTitle").getAsString();

            System.out.println("Received job title: " + jobTitle);

            if (jobTitle == null || jobTitle.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "Job title is required");
                response.getWriter().write(gson.toJson(errorResponse));
                return;
            }

            // Detect language (Vietnamese or English)
            boolean isVietnamese = containsVietnamese(jobTitle);
            String language = isVietnamese ? "Vietnamese" : "English";

            System.out.println("Detected language: " + language);
// Tạo prompt cho Gemini AI
            String prompt = createPrompt(jobTitle, language);

            System.out.println("Generated prompt: " + prompt);

            // Gọi Gemini API với retry mechanism
            System.out.println("=== Calling Gemini AI (Required) ===");
            JsonObject aiResponse = callGeminiAPIWithRetry(prompt, jobTitle, 3); // Retry 3 lần

            if (aiResponse != null && aiResponse.has("description") && aiResponse.has("requirements")) {
                System.out.println("✓ AI Response received successfully");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(gson.toJson(aiResponse));
            } else {
                System.err.println("✗ Failed to get AI response after retries");
                response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "AI service is currently unavailable. Please try again later.");
                errorResponse.addProperty("retryable", true);
                response.getWriter().write(gson.toJson(errorResponse));
            }

        } catch (Exception e) {
            System.err.println("Exception in doPost: " + e.getMessage());
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "System error occurred. Please try again.");
            errorResponse.addProperty("retryable", true);
            response.getWriter().write(new Gson().toJson(errorResponse));
        }
    }

    private JsonObject callGeminiAPIWithRetry(String prompt, String jobTitle, int maxRetries) {
        JsonObject response = null;

        // Try different models if one fails (using v1beta API)
        for (String model : AVAILABLE_MODELS) {
            GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent?key=" + GEMINI_API_KEY;
            System.out.println("Trying model: " + model);

            response = callGeminiAPI(prompt, jobTitle);

            if (response != null && response.has("description") && response.has("requirements")) {
                System.out.println("✓ Success with model: " + model);
                return response;
            }

            System.out.println("✗ Failed with model: " + model + ", trying next...");

            // Wait 2 seconds before trying next model
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        System.err.println("All models failed");
        return null;
    }

    private boolean containsVietnamese(String text) {
        // Check for Vietnamese characters
        return text.matches(".*[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ].*");
    }

    private String createPrompt(String jobTitle, String language) {
        if (language.equals("Vietnamese")) {
            return "Bạn là chuyên gia tuyển dụng chuyên nghiệp. Hãy tạo nội dung tuyển dụng CỤ THỂ cho vị trí: '" + jobTitle + "'\n\n"
                    + "Yêu cầu:\n"
                    + "1. Phân tích kỹ tên vị trí '" + jobTitle + "' để hiểu đúng công việc thực tế\n"
                    + "2. Tạo mô tả công việc CHI TIẾT gồm:\n"
                    + "   - Tổng quan về vị trí và vai trò trong công ty\n"
                    + "   - Liệt kê 5-8 TRÁCH NHIỆM CỤ THỂ mà người làm '" + jobTitle + "' phải thực hiện hàng ngày\n"
                    + "   - Mô tả môi trường làm việc và công nghệ/công cụ sẽ sử dụng\n"
                    + "3. Liệt kê yêu cầu tuyển dụng CỤ THỂ:\n"
                    + "   - Trình độ học vấn phù hợp với '" + jobTitle + "'\n"
                    + "   - Số năm kinh nghiệm cần thiết\n"
                    + "   - 5-8 KỸ NĂNG CHUYÊN MÔN cụ thể cho '" + jobTitle + "' (ngôn ngữ lập trình, công cụ, framework...)\n"
                    + "   - Kỹ năng mềm cần có\n\n"
                    + "QUAN TRỌNG:\n"
                    + "- KHÔNG dùng cụm từ chung chung như 'this position', 'các nhiệm vụ', 'công cụ liên quan'\n"
                    + "- PHẢI nêu TÊN CỤ THỂ: tên công nghệ, tên công cụ, tên kỹ năng cho vị trí '" + jobTitle + "'\n"
                    + "- Ví dụ: Nếu là 'Lập trình viên Java' thì phải có: Spring Boot, Hibernate, MySQL, Maven...\n"
                    + "- Ví dụ: Nếu là 'Marketing Manager' thì phải có: Google Ads, Facebook Ads, SEO, Google Analytics...\n"
                    + "- Viết HOÀN TOÀN bằng tiếng Việt\n"
                    + "- Sử dụng HTML: <p>, <strong>, <ul>, <li>\n\n"
                    + "Trả về ĐÚNG format JSON này (không có markdown):\n"
                    + "{\n"
                    + "  \"description\": \"<p><strong>Tổng quan:</strong></p><p>...</p><p><strong>Trách nhiệm:</strong></p><ul><li>...</li></ul>\",\n"
                    + "  \"requirements\": \"<p><strong>Yêu cầu:</strong></p><ul><li>...</li></ul>\"\n"
                    + "}";
        } else {
            return "You are a professional recruitment expert. Create SPECIFIC job posting content for: '" + jobTitle + "'\n\n"
                    + "Requirements:\n"
                    + "1. Analyze the job title '" + jobTitle + "' to understand the actual work\n"
                    + "2. Create DETAILED job description with:\n"
                    + "   - Overview of the position and role in company\n"
                    + "   - List 5-8 SPECIFIC RESPONSIBILITIES that a '" + jobTitle + "' performs daily\n"
                    + "   - Describe work environment and technologies/tools to be used\n"
                    + "3. List SPECIFIC requirements:\n"
                    + "   - Education level appropriate for '" + jobTitle + "'\n"
                    + "   - Years of experience needed\n"
                    + "   - 5-8 SPECIFIC TECHNICAL SKILLS for '" + jobTitle + "' (programming languages, tools, frameworks...)\n"
                    + "   - Soft skills needed\n\n"
                    + "CRITICAL:\n"
                    + "- DO NOT use generic phrases like 'this position', 'related tasks', 'relevant tools'\n"
                    + "- MUST name SPECIFIC: technology names, tool names, skill names for '" + jobTitle + "'\n"
                    + "- Example: If 'Java Developer' then include: Spring Boot, Hibernate, MySQL, Maven, Git...\n"
                    + "- Example: If 'Marketing Manager' then include: Google Ads, Facebook Ads, SEO, Google Analytics...\n"
                    + "- Write ENTIRELY in English\n"
                    + "- Use HTML: <p>, <strong>, <ul>, <li>\n\n"
                    + "Return this EXACT JSON format (no markdown):\n"
                    + "{\n"
                    + "  \"description\": \"<p><strong>Overview:</strong></p><p>...</p><p><strong>Responsibilities:</strong></p><ul><li>...</li></ul>\",\n"
                    + "  \"requirements\": \"<p><strong>Requirements:</strong></p><ul><li>...</li></ul>\"\n"
                    + "}";
        }
    }

    private JsonObject callGeminiAPI(String prompt, String jobTitle) {
        try {
            System.out.println("========================================");
            System.out.println("Calling Gemini API...");
            System.out.println("API URL: " + GEMINI_API_URL);
            System.out.println("========================================");

            URL url = new URL(GEMINI_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);
            conn.setConnectTimeout(30000); // 30 seconds timeout for Vietnamese
            conn.setReadTimeout(30000);

            // Tạo request body theo format của Gemini API
            JsonObject requestBody = new JsonObject();
            JsonArray contents = new JsonArray();
            JsonObject content = new JsonObject();
            JsonArray parts = new JsonArray();
            JsonObject part = new JsonObject();
            part.addProperty("text", prompt);
            parts.add(part);
            content.add("parts", parts);
            contents.add(content);
            requestBody.add("contents", contents);
            System.out.println("Request body: " + requestBody.toString());

            // Gửi request
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Đọc response
            int responseCode = conn.getResponseCode();
            System.out.println("========================================");
            System.out.println("Response Code: " + responseCode);
            System.out.println("Response Message: " + conn.getResponseMessage());
            System.out.println("========================================");

            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    StringBuilder responseStr = new StringBuilder();
                    String responseLine;
                    while ((responseLine = br.readLine()) != null) {
                        responseStr.append(responseLine.trim());
                    }

                    System.out.println("Gemini response: " + responseStr.toString());

                    // Parse response từ Gemini
                    Gson gson = new Gson();
                    JsonObject geminiResponse = gson.fromJson(responseStr.toString(), JsonObject.class);

                    // Extract text từ response
                    String generatedText = extractTextFromGeminiResponse(geminiResponse);

                    if (generatedText != null && !generatedText.isEmpty()) {
                        System.out.println("Generated text: " + generatedText);
                        // Parse JSON từ generated text
                        return parseAIGeneratedText(generatedText);
                    }
                }
            } else {
                // Read error stream
                System.err.println("========================================");
                System.err.println("API ERROR - Response Code: " + responseCode);
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
                    StringBuilder errorStr = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        errorStr.append(line);
                    }
                    System.err.println("Error Response Body: " + errorStr.toString());
                }
                System.err.println("========================================");
            }

        } catch (Exception e) {
            System.err.println("Exception in callGeminiAPI: " + e.getMessage());
            e.printStackTrace();
        }

        return null; // Return null to let caller handle default response with proper language
    }

    private String extractTextFromGeminiResponse(JsonObject response) {
        try {
            JsonArray candidates = response.getAsJsonArray("candidates");
            if (candidates != null && candidates.size() > 0) {
                JsonObject candidate = candidates.get(0).getAsJsonObject();
                JsonObject content = candidate.getAsJsonObject("content");
                JsonArray parts = content.getAsJsonArray("parts");
                if (parts != null && parts.size() > 0) {
                    JsonObject part = parts.get(0).getAsJsonObject();
                    return part.get("text").getAsString();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private JsonObject parseAIGeneratedText(String text) {
        try {
            // Remove markdown code blocks if present
            text = text.trim();
            if (text.startsWith("```json")) {
                text = text.substring(7);
            }
            if (text.startsWith("```")) {
                text = text.substring(3);
            }
            if (text.endsWith("```")) {
                text = text.substring(0, text.length() - 3);
            }
            text = text.trim();

            // Find JSON in text response
            int jsonStart = text.indexOf("{");
            int jsonEnd = text.lastIndexOf("}");

            if (jsonStart != -1 && jsonEnd != -1) {
                String jsonStr = text.substring(jsonStart, jsonEnd + 1);
                Gson gson = new Gson();
                JsonObject result = gson.fromJson(jsonStr, JsonObject.class);

                // Validate result has required fields
                if (result.has("description") && result.has("requirements")) {
                    return result;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
