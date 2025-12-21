package utils;

import com.google.gson.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import model.CvExtract;

public class GeminiCvApi {

    private static final String API_KEY = "AIzaSyAPSi0NWA4XXNOrk6J0KUdpyEsoPJFRquI";

    // fallback list: thử lần lượt
    private static final String[] MODELS = {
        "gemini-2.5-flash",
        "gemini-2.0-flash-001",
        "gemini-2.0-flash"
    };

    // retry khi 503/429
    private static final int MAX_RETRY = 3;

    public static CvExtract checkAndExtract(String input) throws Exception {
        CvExtract ex = new CvExtract();

        if (API_KEY == null || API_KEY.isBlank()) {
            ex.setCv(false);
            ex.setMessage("Missing GEMINI_API_KEY env. Please set it before running.");
            return ex;
        }

        String prompt = buildPrompt(input);

        Exception last = null;

        // thử các model lần lượt
        for (String model : MODELS) {

            // retry theo model (backoff)
            for (int attempt = 1; attempt <= MAX_RETRY; attempt++) {
                try {
                    return callGemini(model, prompt);
                } catch (Exception e) {
                    last = e;

                    String msg = e.getMessage() == null ? "" : e.getMessage();
                    boolean retryable
                            = msg.contains("503") || msg.toLowerCase().contains("overloaded")
                            || msg.toLowerCase().contains("unavailable") || msg.contains("429");

                    if (!retryable) {
                        throw e;
                    }

                    // backoff: 300ms, 900ms, 1800ms...
                    try {
                        Thread.sleep(300L * attempt * attempt);
                    } catch (InterruptedException ignored) {
                    }
                }
            }
        }

        // nếu tới đây là fail hết
        throw last != null ? last : new RuntimeException("Gemini call failed");
    }

    private static CvExtract callGemini(String modelName, String prompt) throws Exception {
        String endpoint = "https://generativelanguage.googleapis.com/v1beta/models/"
                + modelName + ":generateContent?key=" + API_KEY;

        HttpURLConnection conn = (HttpURLConnection) new URL(endpoint).openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(30000);
        conn.setDoOutput(true);

        JsonObject req = new JsonObject();

        JsonArray contents = new JsonArray();
        JsonObject content = new JsonObject();
        JsonArray parts = new JsonArray();
        JsonObject part = new JsonObject();
        part.addProperty("text", prompt);
        parts.add(part);
        content.add("parts", parts);
        contents.add(content);
        req.add("contents", contents);

        JsonObject generationConfig = new JsonObject();
        generationConfig.addProperty("temperature", 0.0);
        generationConfig.addProperty("responseMimeType", "application/json");
        req.add("generationConfig", generationConfig);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(req.toString().getBytes(StandardCharsets.UTF_8));
        }

        int code = conn.getResponseCode();
        String resp = readAll(code >= 400 ? conn.getErrorStream() : conn.getInputStream());

        if (code >= 400) {
            // ném exception để retry/fallback
            throw new RuntimeException("AI API error (" + code + "): " + resp);
        }

        return parseGeminiResponse(resp);
    }

    private static String buildPrompt(String input) {
        int maxLen = 14000;
        if (input == null) {
            input = "";
        }
        if (input.length() > maxLen) {
            input = input.substring(0, maxLen);
        }

        return ""
                + "You are a CV/Resume information extractor.\n"
                + "Return STRICT JSON ONLY. No markdown. No extra text.\n"
                + "DO NOT GUESS. If not explicitly present, return empty string.\n"
                + "\n"
                + "Schema:\n"
                + "{\n"
                + "  \"is_cv\": boolean,\n"
                + "  \"confidence\": number,\n"
                + "  \"message\": string,\n"
                + "  \"full_name\": string,\n"
                + "  \"email\": string,\n"
                + "  \"phone\": string,\n"
                + "  \"dob\": string,\n"
                + "  \"job_title\": string,\n"
                + "  \"address\": string\n"
                + "}\n"
                + "\n"
                + "Rules:\n"
                + "- If input is NOT a CV: is_cv=false and explain in message.\n"
                + "- email must contain '@' and domain; else \"\".\n"
                + "- phone must have >=9 digits (ignore spaces/dots/dashes); else \"\".\n"
                + "- full_name: person name near the top; avoid company names.\n"
                + "- dob: only if clearly birth date; prefer yyyy-MM-dd.\n"
                + "\n"
                + "INPUT:\n"
                + input;
    }

    private static CvExtract parseGeminiResponse(String json) {
        CvExtract ex = new CvExtract();
        try {
            JsonObject root = new JsonParser().parse(json).getAsJsonObject();

            JsonArray candidates = root.getAsJsonArray("candidates");
            if (candidates == null || candidates.size() == 0) {
                ex.setCv(false);
                ex.setMessage("AI response missing candidates.");
                return ex;
            }

            JsonObject c0 = candidates.get(0).getAsJsonObject();
            JsonObject content = c0.getAsJsonObject("content");
            if (content == null) {
                ex.setCv(false);
                ex.setMessage("AI response missing content.");
                return ex;
            }

            JsonArray parts = content.getAsJsonArray("parts");
            if (parts == null || parts.size() == 0) {
                ex.setCv(false);
                ex.setMessage("AI response missing parts.");
                return ex;
            }

            String aiText = parts.get(0).getAsJsonObject().get("text").getAsString();
            aiText = aiText.replace("```json", "").replace("```", "").trim();
            aiText = cleanupToJson(aiText);

            JsonObject data = new JsonParser().parse(aiText).getAsJsonObject();

            ex.setCv(getBool(data, "is_cv"));
            ex.setConfidence(getDouble(data, "confidence"));
            ex.setMessage(getStr(data, "message"));

            if (!ex.isCv()) {
                return ex;
            }

            ex.setFullName(getStr(data, "full_name"));
            ex.setEmail(getStr(data, "email"));
            ex.setPhone(getStr(data, "phone"));
            ex.setDob(getStr(data, "dob"));
            ex.setJobTitle(getStr(data, "job_title"));
            ex.setAddress(getStr(data, "address"));

            return ex;
        } catch (Exception e) {
            ex.setCv(false);
            ex.setMessage("AI parse failed: " + e.getMessage());
            return ex;
        }
    }

    private static String cleanupToJson(String s) {
        if (s == null) {
            return "{}";
        }
        s = s.trim();
        int a = s.indexOf('{');
        int b = s.lastIndexOf('}');
        if (a >= 0 && b > a) {
            return s.substring(a, b + 1);
        }
        return s;
    }

    private static String readAll(InputStream is) throws Exception {
        if (is == null) {
            return "";
        }
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            return sb.toString();
        }
    }

    private static String getStr(JsonObject o, String k) {
        return o.has(k) && !o.get(k).isJsonNull() ? o.get(k).getAsString() : "";
    }

    private static boolean getBool(JsonObject o, String k) {
        return o.has(k) && !o.get(k).isJsonNull() && o.get(k).getAsBoolean();
    }

    private static double getDouble(JsonObject o, String k) {
        try {
            return o.has(k) && !o.get(k).isJsonNull() ? o.get(k).getAsDouble() : 0.0;
        } catch (Exception e) {
            return 0.0;
        }
    }
}
