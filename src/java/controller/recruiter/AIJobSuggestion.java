package controller.recruiter;

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
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "AIJobSuggestion", urlPatterns = {"/aiJobSuggestion"})
public class AIJobSuggestion extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyBZLH4zERWyF611YWxeZ1aROy1VMvzYJ_0";
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=" + GEMINI_API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");

        try {
            // Đọc dữ liệu từ request
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            // Kiểm tra dữ liệu đầu vào
            if (sb.length() == 0) {
                sendError(response, "Vui lòng nhập tiêu đề công việc", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            JSONObject requestData = new JSONObject(sb.toString());
            String jobTitle = requestData.optString("jobTitle", "").trim();

            if (jobTitle.isEmpty()) {
                sendError(response, "Vui lòng nhập tiêu đề công việc", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // Tạo prompt cho AI
            String prompt = "Bạn là một chuyên gia tuyển dụng. Hãy tạo thông tin chi tiết cho vị trí: " + jobTitle + "\n\n" +
                    "Yêu cầu:\n" +
                    "1. Mô tả công việc (description): Khoảng 100-150 từ, mô tả chi tiết về công việc, trách nhiệm chính.\n" +
                    "2. Yêu cầu công việc (requirements): Khoảng 5-7 yêu cầu chính, mỗi yêu cầu ngắn gọn, rõ ràng.\n\n" +
                    "Định dạng trả lời theo JSON chính xác như sau (không thêm bất kỳ ký tự thừa nào):\n" +
                    "{\"description\":\"[Mô tả công việc]\",\"requirements\":\"[Yêu cầu công việc]\"}";

            // Gọi API Gemini
            String geminiResponse = callGeminiAPI(prompt);

            // Trả về kết quả
            response.getWriter().write(geminiResponse);

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Lỗi: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String callGeminiAPI(String prompt) throws Exception {
        // Tạo request body
        JSONObject requestBody = new JSONObject();
        JSONObject content = new JSONObject();
        JSONArray parts = new JSONArray();
        parts.put(new JSONObject().put("text", prompt));
        content.put("parts", parts);
        requestBody.put("contents", new JSONArray().put(content));

        // Cấu hình request
        URL url = new URL(GEMINI_API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        // Gửi request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        // Đọc response
        int responseCode = conn.getResponseCode();
        StringBuilder responseBuilder = new StringBuilder();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(
                        responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(),
                        StandardCharsets.UTF_8))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                responseBuilder.append(responseLine.trim());
            }
        }

        if (responseCode != 200) {
            throw new Exception("Lỗi khi gọi API Gemini: " + responseBuilder.toString());
        }

        // Xử lý kết quả từ Gemini
        JSONObject jsonResponse = new JSONObject(responseBuilder.toString());
        JSONArray candidates = jsonResponse.getJSONArray("candidates");
        if (candidates.length() == 0) {
            throw new Exception("Không nhận được phản hồi từ AI");
        }

        String textResponse = candidates.getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts")
                .getJSONObject(0)
                .getString("text");

        // Làm sạch kết quả
        textResponse = textResponse.replace("```json", "").replace("```", "").trim();
        return textResponse;
    }

    private void sendError(HttpServletResponse response, String message, int status) throws IOException {
        response.setStatus(status);
        response.getWriter().write("{\"error\":\"" + message + "\"}");
    }
}