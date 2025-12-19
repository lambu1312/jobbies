package utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import config.CloudinaryConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Map;
import java.util.UUID;

/**
 * Cloudinary Upload Utility Simple utility to upload images and return URL for
 * database storage
 *
 * @author buimi
 */
public class CloudinaryUploadUtil {

    private static final Cloudinary cloudinary = CloudinaryConfig.getCloudinary();

    /**
     * Upload image from servlet Part and return URL for database Usage: String
     * imageUrl =
     * CloudinaryUploadUtil.uploadImage(request.getPart("businessLicense"),
     * "business-licenses");
     *
     * @param part Image file from form upload
     * @param folderName Folder name in Cloudinary (e.g., "business-licenses",
     * "avatars", "job-images")
     * @return Cloudinary URL to save in database, or null if upload failed
     */
    public static String uploadImage(Part part, String folderName) {
        if (part == null || part.getSubmittedFileName() == null
                || part.getSubmittedFileName().trim().isEmpty()) {
            return null;
        }

        File tempFile = null;
        try {
            // Convert Part to File
            tempFile = convertPartToFile(part);

            // Upload to Cloudinary
            Map uploadResult = cloudinary.uploader().upload(tempFile,
                    ObjectUtils.asMap(
                            "folder", folderName,
                            "resource_type", "auto",
                            "use_filename", true,
                            "unique_filename", true
                    )
            );

            // Return secure URL for database
            return (String) uploadResult.get("secure_url");

        } catch (Exception e) {
            System.err.println("Cloudinary upload failed: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            // Clean up temp file
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }

    /**
     * Upload image from File object and return URL for database Usage: String
     * imageUrl = CloudinaryUploadUtil.uploadImage(new
     * File("path/to/image.jpg"), "products");
     *
     * @param file Image file
     * @param folderName Folder name in Cloudinary
     * @return Cloudinary URL to save in database, or null if upload failed
     */
    public static String uploadImage(File file, String folderName) {
        if (file == null || !file.exists() || !file.isFile()) {
            return null;
        }

        try {
            Map uploadResult = cloudinary.uploader().upload(file,
                    ObjectUtils.asMap(
                            "folder", folderName,
                            "resource_type", "auto",
                            "use_filename", true,
                            "unique_filename", true
                    )
            );

            return (String) uploadResult.get("secure_url");

        } catch (Exception e) {
            System.err.println("Cloudinary upload failed: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Upload image with custom public ID and return URL Useful when you want to
     * control the image name
     *
     * @param part Image file from form upload
     * @param folderName Folder name in Cloudinary
     * @param publicId Custom public ID (without extension)
     * @return Cloudinary URL to save in database, or null if upload failed
     */
    public static String uploadImageWithPublicId(Part part, String folderName, String publicId) {
        if (part == null || part.getSubmittedFileName() == null
                || part.getSubmittedFileName().trim().isEmpty()) {
            return null;
        }

        File tempFile = null;
        try {
            tempFile = convertPartToFile(part);

            Map uploadResult = cloudinary.uploader().upload(tempFile,
                    ObjectUtils.asMap(
                            "folder", folderName,
                            "public_id", publicId,
                            "resource_type", "auto",
                            "overwrite", true
                    )
            );

            return (String) uploadResult.get("secure_url");

        } catch (Exception e) {
            System.err.println("Cloudinary upload failed: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }

    /**
     * Delete image from Cloudinary by URL Extract public ID from URL and delete
     *
     * @param cloudinaryUrl Full Cloudinary URL
     * @return true if deleted successfully
     */
    public static boolean deleteImage(String cloudinaryUrl) {
        if (cloudinaryUrl == null || cloudinaryUrl.isEmpty()
                || !cloudinaryUrl.contains("cloudinary.com")) {
            return false;
        }

        try {
            String publicId = extractPublicId(cloudinaryUrl);
            if (publicId == null) {
                return false;
            }

            Map result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
            return "ok".equals(result.get("result"));

        } catch (Exception e) {
            System.err.println("Cloudinary delete failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Extract public ID from Cloudinary URL Example:
     * https://res.cloudinary.com/demo/image/upload/v1234/folder/image.jpg
     * Returns: folder/image
     *
     * @param cloudinaryUrl Full Cloudinary URL
     * @return Public ID
     */
    private static String extractPublicId(String cloudinaryUrl) {
        try {
            String[] parts = cloudinaryUrl.split("/upload/");
            if (parts.length > 1) {
                String pathPart = parts[1];
                // Remove version number (v1234567890)
                pathPart = pathPart.replaceFirst("v\\d+/", "");
                // Remove file extension
                int dotIndex = pathPart.lastIndexOf('.');
                if (dotIndex > 0) {
                    pathPart = pathPart.substring(0, dotIndex);
                }
                return pathPart;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Convert Part to temporary File
     *
     * @param part File part from servlet
     * @return Temporary file
     * @throws Exception if conversion fails
     */
    private static File convertPartToFile(Part part) throws Exception {
        // Generate unique filename
        String originalFilename = part.getSubmittedFileName();
        String extension = "";
        int dotIndex = originalFilename.lastIndexOf(".");
        if (dotIndex > 0) {
            extension = originalFilename.substring(dotIndex);
        }

        String tempFilename = UUID.randomUUID().toString() + extension;

        // Create temp file
        File tempFile = File.createTempFile(tempFilename, null);

        // Write part to temp file
        try (InputStream input = part.getInputStream(); FileOutputStream output = new FileOutputStream(tempFile)) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }

        return tempFile;
    }

    /**
     * Get optimized/transformed image URL Useful for displaying thumbnails or
     * resized images
     *
     * @param originalUrl Original Cloudinary URL
     * @param width Desired width
     * @param height Desired height
     * @return Transformed URL
     */
    public static String getOptimizedImageUrl(String originalUrl, int width, int height) {
        if (originalUrl == null || !originalUrl.contains("cloudinary.com")) {
            return originalUrl;
        }

        String transformation = String.format("w_%d,h_%d,c_fill,q_auto,f_auto", width, height);
        return originalUrl.replace("/upload/", "/upload/" + transformation + "/");
    }

    /**
     * Test method to verify upload functionality
     */
    public static void main(String[] args) {
        System.out.println("Testing CloudinaryUploadUtil...\n");

        // Test upload from File
        File testFile = new File("D:\\anh_test\\anh-dep-tren-bien-test-cloud.jpg");

        if (testFile.exists()) {
            System.out.println("Uploading test image...");
            String url = uploadImage(testFile, "test-uploads");

            if (url != null) {
                System.out.println("✓ Upload successful!");
                System.out.println("URL: " + url);
                System.out.println("\nThis URL can be saved directly to database.");

                // Test optimized URL
                String optimizedUrl = getOptimizedImageUrl(url, 300, 200);
                System.out.println("\nOptimized URL (300x200): " + optimizedUrl);
            } else {
                System.out.println("✗ Upload failed!");
            }
        } else {
            System.out.println("✗ Test file not found!");
        }
    }
}
