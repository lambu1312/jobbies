package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CV;

public class CvDAO extends DBContext {

    // =========================
    // Mapper
    // =========================
    private CV map(ResultSet rs) throws Exception {
        CV c = new CV();
        c.setCvId(rs.getInt("CVID"));
        c.setJobSeekerId(rs.getInt("JobSeekerID"));
        c.setTitle(rs.getString("Title"));
        c.setTemplateCode(rs.getString("TemplateCode"));
        c.setIsDefault(rs.getBoolean("IsDefault"));
        c.setSummary(rs.getString("Summary"));
        c.setSkills(rs.getString("Skills"));
        c.setLinks(rs.getString("Links"));
        c.setFilePath(rs.getString("FilePath"));
        c.setUploadDate(rs.getTimestamp("UploadDate"));
        c.setLastUpdated(rs.getTimestamp("LastUpdated"));
        return c;
    }

    // =========================
    // NEW (CV Builder)
    // =========================

    public List<CV> listByJobSeeker(int jobSeekerId) {
        List<CV> list = new ArrayList<>();
        String sql = "SELECT * FROM CVs WHERE JobSeekerID=? ORDER BY IsDefault DESC, LastUpdated DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public CV getById(int cvId, int jobSeekerId) {
        String sql = "SELECT * FROM CVs WHERE CVID=? AND JobSeekerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Insert CV builder (Title/Template/Summary/Skills/Links)
    public int insert(CV cv) {
        String sql = """
            INSERT INTO CVs(JobSeekerID, Title, TemplateCode, IsDefault, Summary, Skills, Links, FilePath, UploadDate, LastUpdated)
            VALUES(?, ?, ?, ?, ?, ?, ?, NULL, GETDATE(), GETDATE())
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, cv.getJobSeekerId());
            ps.setString(2, cv.getTitle());
            ps.setString(3, cv.getTemplateCode());
            ps.setBoolean(4, cv.isIsDefault());
            ps.setString(5, cv.getSummary());
            ps.setString(6, cv.getSkills());
            ps.setString(7, cv.getLinks());

            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
return -1;
    }

    public void update(CV cv) {
        String sql = """
            UPDATE CVs
            SET Title=?, TemplateCode=?, Summary=?, Skills=?, Links=?, LastUpdated=GETDATE()
            WHERE CVID=? AND JobSeekerID=?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cv.getTitle());
            ps.setString(2, cv.getTemplateCode());
            ps.setString(3, cv.getSummary());
            ps.setString(4, cv.getSkills());
            ps.setString(5, cv.getLinks());
            ps.setInt(6, cv.getCvId());
            ps.setInt(7, cv.getJobSeekerId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFilePath(int cvId, int jobSeekerId, String path) {
        String sql = "UPDATE CVs SET FilePath=?, UploadDate=GETDATE(), LastUpdated=GETDATE() WHERE CVID=? AND JobSeekerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, path);
            ps.setInt(2, cvId);
            ps.setInt(3, jobSeekerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDefault(int jobSeekerId, int cvId) {
        try {
            connection.setAutoCommit(false);

            try (PreparedStatement ps1 = connection.prepareStatement(
                    "UPDATE CVs SET IsDefault=0 WHERE JobSeekerID=?")) {
                ps1.setInt(1, jobSeekerId);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = connection.prepareStatement(
                    "UPDATE CVs SET IsDefault=1 WHERE CVID=? AND JobSeekerID=?")) {
                ps2.setInt(1, cvId);
                ps2.setInt(2, jobSeekerId);
                ps2.executeUpdate();
            }

            connection.commit();
        } catch (Exception e) {
            try { connection.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
        } finally {
            try { connection.setAutoCommit(true); } catch (Exception ignored) {}
        }
    }

    // =========================
    // OLD (Upload CV file-style)
    // =========================

    /**
     * Insert CV theo kiểu cũ (chỉ lưu FilePath + UploadDate).
     * Dùng khi bạn upload file CV (pdf/doc) lên server.
     */
    public int insertFileCV(CV t) {
        String sql = "INSERT INTO CVs (JobSeekerID, FilePath, UploadDate, LastUpdated) VALUES (?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, t.getJobSeekerId());
            ps.setString(2, t.getFilePath());
            ps.setTimestamp(3, t.getUploadDate() != null ? t.getUploadDate() : new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
if (keys.next()) return keys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * FIX BUG: tìm CV theo JobSeekerID (bản cũ bạn ghi nhầm CVID)
     */
    public CV findCVbyJobSeekerID(int jobSeekerID) {
        String sql = "SELECT TOP 1 * FROM CVs WHERE JobSeekerID=? ORDER BY IsDefault DESC, LastUpdated DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public CV findCVbyCVID(int CVID) {
        String sql = "SELECT * FROM CVs WHERE CVID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, CVID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update theo JobSeekerID kiểu cũ (thường dùng cho upload file)
     */
    public void updateCVByJobSeeker(CV cv) {
        String sql = """
            UPDATE CVs
            SET FilePath=?, UploadDate=?, LastUpdated=?
            WHERE JobSeekerID=?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cv.getFilePath());
            ps.setTimestamp(2, cv.getUploadDate());
            ps.setTimestamp(3, cv.getLastUpdated() != null ? cv.getLastUpdated() : new Timestamp(System.currentTimeMillis()));
            ps.setInt(4, cv.getJobSeekerId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<CV> findAll() {
        List<CV> list = new ArrayList<>();
        String sql = "SELECT * FROM CVs";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}