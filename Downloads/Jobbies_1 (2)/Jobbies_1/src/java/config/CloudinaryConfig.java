package config;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.util.HashMap;
import java.util.Map;

/**
 * Cloudinary Configuration
 * Manages Cloudinary instance for file upload
 * @author buimi
 */
public class CloudinaryConfig {
    
    // Cloudinary credentials - Replace with your actual credentials
    private static final String CLOUD_NAME = "dofyagmis";
    private static final String API_KEY = "371318323654262";
    private static final String API_SECRET = "1YDYnSqa6mDwdsOhC5Fcvx5Hk3I";
    
    // Singleton instance
    private static Cloudinary cloudinary;
    
    /**
     * Private constructor to prevent instantiation
     */
    private CloudinaryConfig() {
    }
    
    /**
     * Get Cloudinary instance (Singleton pattern)
     * @return Cloudinary instance
     */
    public static Cloudinary getCloudinary() {
        if (cloudinary == null) {
            synchronized (CloudinaryConfig.class) {
                if (cloudinary == null) {
                    Map<String, String> config = new HashMap<>();
                    config.put("cloud_name", CLOUD_NAME);
                    config.put("api_key", API_KEY);
                    config.put("api_secret", API_SECRET);
                    config.put("secure", "true");
                    
                    cloudinary = new Cloudinary(config);
                }
            }
        }
        return cloudinary;
    }
    
    /**
     * Test connection to Cloudinary
     * @return true if connection successful
     */
    public static boolean testConnection() {
        try {
            Cloudinary cloud = getCloudinary();
            // Try to get account details to verify connection
            cloud.api().ping(ObjectUtils.emptyMap());
            return true;
        } catch (Exception e) {
            System.err.println("Cloudinary connection failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Main method to test Cloudinary connection and upload
     */
    public static void main(String[] args) {
        System.out.println("=".repeat(60));
        System.out.println("Testing Cloudinary Configuration & Upload");
        System.out.println("=".repeat(60));
        
        // Test 1: Check configuration
        System.out.println("\n[TEST 1] Configuration Details:");
        System.out.println("Cloud Name: " + CLOUD_NAME);
        System.out.println("API Key: " + API_KEY);
        System.out.println("API Secret: " + API_SECRET.substring(0, 5) + "***" + 
                           API_SECRET.substring(API_SECRET.length() - 3));
        
        // Test 2: Get Cloudinary instance
        System.out.println("\n[TEST 2] Getting Cloudinary Instance...");
        try {
            Cloudinary cloud = getCloudinary();
            if (cloud != null) {
                System.out.println("✓ Cloudinary instance created successfully");
                System.out.println("  Cloud Name: " + cloud.config.cloudName);
                System.out.println("  API Key: " + cloud.config.apiKey);
            } else {
                System.out.println("✗ Failed to create Cloudinary instance");
            }
        } catch (Exception e) {
            System.out.println("✗ Error creating instance: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Test 3: Test connection
        System.out.println("\n[TEST 3] Testing Connection to Cloudinary...");
        try {
            boolean isConnected = testConnection();
            if (isConnected) {
                System.out.println("✓ Connection successful!");
                System.out.println("  Status: CONNECTED");
            } else {
                System.out.println("✗ Connection failed!");
                System.out.println("  Status: DISCONNECTED");
            }
        } catch (Exception e) {
            System.out.println("✗ Connection error: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Test 4: Upload image from local path
        System.out.println("\n[TEST 4] Uploading Image to Cloudinary...");
        
        // Upload single file
        String imagePath = "D:\\anh_test\\anh-dep-tren-bien-test-cloud.jpg";
        
        // Or upload all images in folder (uncomment to use)
        // String imagePath = "D:\\anh_test";
        
        try {
            java.io.File folder = new java.io.File(imagePath);
            
            if (!folder.exists()) {
                System.out.println("✗ Folder not found: " + imagePath);
            } else if (!folder.isDirectory()) {
                // If it's a file, upload directly
                uploadSingleFile(folder);
            } else {
                // If it's a directory, upload all images
                java.io.File[] files = folder.listFiles((dir, name) -> {
                    String lower = name.toLowerCase();
                    return lower.endsWith(".jpg") || lower.endsWith(".jpeg") || 
                           lower.endsWith(".png") || lower.endsWith(".gif") || 
                           lower.endsWith(".webp");
                });
                
                if (files == null || files.length == 0) {
                    System.out.println("✗ No image files found in folder");
                } else {
                    System.out.println("Found " + files.length + " image(s) to upload");
                    System.out.println("-".repeat(60));
                    
                    int successCount = 0;
                    for (java.io.File file : files) {
                        if (uploadSingleFile(file)) {
                            successCount++;
                        }
                    }
                    
                    System.out.println("-".repeat(60));
                    System.out.println("✓ Upload completed: " + successCount + "/" + files.length + " successful");
                }
            }
        } catch (Exception e) {
            System.out.println("✗ Upload error: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("\n" + "=".repeat(60));
        System.out.println("Test Completed!");
        System.out.println("=".repeat(60));
    }
    
    /**
     * Upload a single file to Cloudinary
     * @param file File to upload
     * @return true if successful
     */
    private static boolean uploadSingleFile(java.io.File file) {
        try {
            System.out.println("\nUploading: " + file.getName());
            System.out.println("  Size: " + String.format("%.2f KB", file.length() / 1024.0));
            
            Cloudinary cloud = getCloudinary();
            
            // Upload with folder organization
            Map uploadResult = cloud.uploader().upload(file, 
                ObjectUtils.asMap(
                    "folder", "test-uploads",
                    "resource_type", "auto",
                    "use_filename", true,
                    "unique_filename", true
                )
            );
            
            // Get upload information
            String url = (String) uploadResult.get("secure_url");
            String publicId = (String) uploadResult.get("public_id");
            Integer width = (Integer) uploadResult.get("width");
            Integer height = (Integer) uploadResult.get("height");
            String format = (String) uploadResult.get("format");
            
            System.out.println("  ✓ Upload successful!");
            System.out.println("  Public ID: " + publicId);
            System.out.println("  Format: " + format);
            System.out.println("  Dimensions: " + width + "x" + height);
            System.out.println("  URL: " + url);
            
            return true;
            
        } catch (Exception e) {
            System.out.println("  ✗ Upload failed: " + e.getMessage());
            return false;
        }
    }
}