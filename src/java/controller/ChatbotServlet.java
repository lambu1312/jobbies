package controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import GeminiChatService.ChatbotService;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {

    private String apiKey;
    private ChatbotService chatbotService;
private static final String GEMINI_API_URL =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent";


    @Override
    public void init() throws ServletException {
        try {
            Properties props = new Properties();
            InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
            if (input == null) {
                throw new ServletException("Cannot find config.properties");
            }
            props.load(input);
            apiKey = props.getProperty("gemini.api.key");
            input.close();
            
            if (apiKey == null || apiKey.isEmpty()) {
                throw new ServletException("API key not found");
            }
            
               this.chatbotService = new ChatbotService();
        } catch (IOException e) {
            throw new ServletException("Cannot load config", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        String userMessage = request.getParameter("message");
        PrintWriter out = response.getWriter();
        
        try {
            if (userMessage == null || userMessage.trim().isEmpty()) {
                throw new Exception("Tin nhắn không được để trống");
            }
            
            String botReply = callGeminiAPI(userMessage.trim());
            
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("reply", botReply);
            jsonResponse.put("status", "success");
            
            out.print(jsonResponse.toString());
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            String errorMsg = e.getMessage();
            if (errorMsg == null || errorMsg.isEmpty()) {
                errorMsg = "Xin lỗi, đã có lỗi xảy ra.";
            }
            
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("error", errorMsg);
            errorResponse.put("status", "error");
            
            out.print(errorResponse.toString());
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
    
    private String callGeminiAPI(String message) throws Exception {
        String dbContext = chatbotService.getContextForQuestion(message);
        
        String context = "Bạn là trợ lý AI của Jobbies - nền tảng tìm việc làm.\n" +
                       "Quy tắc:\n" +
                       "1. Trả lời NGẮN GỌN (2-3 câu tối đa)\n" +
                       "2. Không hỏi lại, chỉ trả lời trực tiếp\n" +
                       "3. Thân thiện, bằng tiếng Việt\n" +
                       "4. Nếu cần info thêm, gợi ý trong câu trả lời chứ không hỏi\n\n" +
                        "Thông tin từ database:\n" + dbContext + "\n\n" +
                       "Câu hỏi: " + message;
        
        // Tạo request body
        JSONObject requestBody = new JSONObject();
        JSONArray contents = new JSONArray();
        JSONObject content = new JSONObject();
        JSONArray parts = new JSONArray();
        JSONObject part = new JSONObject();
        
        part.put("text", context);
        parts.put(part);
        content.put("parts", parts);
        contents.put(content);
        requestBody.put("contents", contents);
        
        // Add generation config
        JSONObject genCfg = new JSONObject();
        genCfg.put("temperature", 0.5);
        genCfg.put("maxOutputTokens", 500);
        requestBody.put("generationConfig", genCfg);
        
        // Gọi API
        URL url = new URL(GEMINI_API_URL + "?key=" + apiKey);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);
        
        // Gửi request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes("utf-8");
            os.write(input, 0, input.length);
        }
        
        // Đọc response
        int responseCode = conn.getResponseCode();
        BufferedReader in;
        
        if (responseCode == HttpURLConnection.HTTP_OK) {
            in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
        } else {
            in = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
        }
        
        StringBuilder responseStr = new StringBuilder();
        String line;
        while ((line = in.readLine()) != null) {
            responseStr.append(line);
        }
        in.close();
        
        if (responseCode != HttpURLConnection.HTTP_OK) {
            System.err.println("API Error Response: " + responseStr.toString());
            throw new Exception("API Error: " + responseCode + " - " + responseStr.toString());
        }
        
        // Parse response
        try {
            JSONObject responseJson = new JSONObject(responseStr.toString());
            
            if (responseJson.has("candidates") && responseJson.getJSONArray("candidates").length() > 0) {
                JSONObject candidate = responseJson.getJSONArray("candidates").getJSONObject(0);
                String reply = "";
                
                if (candidate.has("content")) {
                    JSONObject contentObj = candidate.getJSONObject("content");
                    if (contentObj.has("parts") && contentObj.getJSONArray("parts").length() > 0) {
                        reply = contentObj.getJSONArray("parts").getJSONObject(0).getString("text");
                    }
                }
                
                if (reply.isEmpty()) {
                    throw new Exception("Không tìm thấy text trong response");
                }
                
                // Clean up reply: remove ** and format as list
                reply = reply.replace("\r\n", "\n").trim();
                // Remove ** markers
                reply = reply.replaceAll("\\*\\*(.*?)\\*\\*", "$1");
                // Convert "- " to "\n• " for better formatting
                reply = reply.replaceAll("(?m)^-\\s+", "\n• ");
                reply = reply.replaceAll("(?m)^\\*\\s+", "\n• ");
                // Clean up leading newline
                reply = reply.replaceAll("^\\n", "");
                
                return reply;
            } else if (responseJson.has("error")) {
                throw new Exception("API Error: " + responseJson.getJSONObject("error").getString("message"));
            } else {
                throw new Exception("Unexpected API response format");
            }
        } catch (Exception e) {
            System.err.println("Parse Error: " + e.getMessage());
            System.err.println("Response: " + responseStr.toString());
            throw e;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        if ("test".equals(action)) {
            JSONObject testResult = new JSONObject();
            testResult.put("message", "Chatbot API is running");
            testResult.put("apiKeyConfigured", apiKey != null && !apiKey.isEmpty());
            testResult.put("apiKeyLength", apiKey != null ? apiKey.length() : 0);
            out.print(testResult.toString());
        } else {
            JSONObject info = new JSONObject();
            info.put("message", "Chatbot API is running");
            info.put("method", "Use POST to send messages");
            out.print(info.toString());
        }
        out.flush();
    }

    @Override
    public String getServletInfo() {
        return "Jobbies Chatbot Servlet";
    }
}