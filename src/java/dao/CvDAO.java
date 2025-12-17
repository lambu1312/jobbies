package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import model.CV;

public class CvDAO extends GenericDAO<CV> {

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

        c.setUploadDate(rs.getTimestamp("UploadDate"));     // Timestamp ⟶ Date (OK)
        c.setLastUpdated(rs.getTimestamp("LastUpdated"));   // Timestamp ⟶ Date (OK)

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
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    // =========================
    // LIST + SEARCH + SORT + PAGING
    // =========================
    public List<CV> list(int jobSeekerId, String q, String sort, String dir, int offset, int size) throws SQLException {
        String orderCol;
        if ("title".equalsIgnoreCase(sort)) orderCol = "Title";
        else if ("updated".equalsIgnoreCase(sort)) orderCol = "LastUpdated";
        else orderCol = "CVID";

        String orderDir = "desc".equalsIgnoreCase(dir) ? "DESC" : "ASC";

        String sql =
            "SELECT CVID, JobSeekerID, FilePath, UploadDate, LastUpdated, Title, TemplateCode, IsDefault, Summary, Skills, Links " +
            "FROM CVs " +
            "WHERE JobSeekerID=? " +
            (q != null && !q.isBlank()
                ? "AND (Title LIKE ? OR Summary LIKE ? OR Skills LIKE ? OR Links LIKE ?) "
                : "") +
            "ORDER BY IsDefault DESC, " + orderCol + " " + orderDir + " " +
            "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int i = 1;
            ps.setInt(i++, jobSeekerId);
            if (q != null && !q.isBlank()) {
                String like = "%" + q.trim() + "%";
                ps.setString(i++, like);
                ps.setString(i++, like);
                ps.setString(i++, like);
                ps.setString(i++, like);
            }
            ps.setInt(i++, offset);
            ps.setInt(i++, size);

            ResultSet rs = ps.executeQuery();
            List<CV> list = new ArrayList<>();
            while (rs.next()) {
                CV cv = new CV();
                cv.setCvId(rs.getInt("CVID"));
                cv.setJobSeekerId(rs.getInt("JobSeekerID"));
                cv.setFilePath(rs.getString("FilePath"));
                cv.setUploadDate(rs.getTimestamp("UploadDate"));
                cv.setLastUpdated(rs.getTimestamp("LastUpdated"));
                cv.setTitle(rs.getString("Title"));
                cv.setTemplateCode(rs.getString("TemplateCode"));
                cv.setIsDefault(rs.getBoolean("IsDefault"));
                cv.setSummary(rs.getString("Summary"));
                cv.setSkills(rs.getString("Skills"));
                cv.setLinks(rs.getString("Links"));
                list.add(cv);
            }
            return list;
        }
    }
    public CV getById(int cvId, int jobSeekerId) {
        String sql = "SELECT * FROM CVs WHERE CVID=? AND JobSeekerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
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
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    
    public int count(int jobSeekerId, String q) throws SQLException {
        String sql =
            "SELECT COUNT(*) FROM CVs WHERE JobSeekerID=? " +
            (q != null && !q.isBlank()
                ? "AND (Title LIKE ? OR Summary LIKE ? OR Skills LIKE ? OR Links LIKE ?) "
                : "");

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int i = 1;
            ps.setInt(i++, jobSeekerId);
            if (q != null && !q.isBlank()) {
                String like = "%" + q.trim() + "%";
                ps.setString(i++, like);
                ps.setString(i++, like);
                ps.setString(i++, like);
                ps.setString(i++, like);
            }
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        }
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
        String sql = """
        UPDATE CVs
        SET FilePath=?, UploadDate=?, LastUpdated=?
        WHERE CVID=? AND JobSeekerID=?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, path);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setInt(4, cvId);
            ps.setInt(5, jobSeekerId);

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
            try {
                connection.rollback();
            } catch (Exception ignored) {
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (Exception ignored) {
            }
        }
    }

    // =========================
    // OLD (Upload CV file-style)
    // =========================
    /**
     * Insert CV theo kiểu cũ (chỉ lưu FilePath + UploadDate). Dùng khi bạn
     * upload file CV (pdf/doc) lên server.
     */
    public int insertFileCV(CV cv) {
        String sql = """
        INSERT INTO CVs(JobSeekerID, FilePath, UploadDate, LastUpdated)
        VALUES (?, ?, ?, ?)
    """;
        try (PreparedStatement ps
                = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, cv.getJobSeekerId());
            ps.setString(2, cv.getFilePath());

            ps.setTimestamp(3,
                    cv.getUploadDate() != null
                    ? new Timestamp(cv.getUploadDate().getTime())
                    : new Timestamp(System.currentTimeMillis())
            );

            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
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
                if (rs.next()) {
                    return map(rs);
                }
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
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update theo JobSeekerID kiểu cũ (thường dùng cho upload file)
     */
//    public void update(CV cv) {
//        String sql = """
//        UPDATE CVs
//        SET Title=?, TemplateCode=?, Summary=?, Skills=?, Links=?, LastUpdated=?
//        WHERE CVID=? AND JobSeekerID=?
//    """;
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ps.setString(1, cv.getTitle());
//            ps.setString(2, cv.getTemplateCode());
//            ps.setString(3, cv.getSummary());
//            ps.setString(4, cv.getSkills());
//            ps.setString(5, cv.getLinks());
//
//            ps.setTimestamp(6,
//                    cv.getLastUpdated() != null
//                    ? new Timestamp(cv.getLastUpdated().getTime())
//                    : new Timestamp(System.currentTimeMillis())
//            );
//
//            ps.setInt(7, cv.getCvId());
//            ps.setInt(8, cv.getJobSeekerId());
//
//            ps.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    @Override
    public List<CV> findAll() {
        return queryGenericDAO(CV.class);
    }
//nhap cv
    public int Insert(CV t) {
        String sql = "insert into CVs (JobSeekerID, FilePath, UploadDate) values (?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", t.getJobSeekerId());
        parameterMap.put("FilePath", t.getFilePath());
        parameterMap.put("UploadDate", t.getUploadDate());
        
        return insertGenericDAO(sql, parameterMap);
    }
    
    
    // =========================
    // DELETE + DEFAULT
    // =========================
    public void delete(int cvid, int jobSeekerId) throws SQLException {
        String sql = "DELETE FROM CVs WHERE CVID=? AND JobSeekerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvid);
            ps.setInt(2, jobSeekerId);
            ps.executeUpdate();
        }
    }
    
    public void updateUploadedFile(int cvid, int jobSeekerId, String title, String filePath) throws SQLException {
        String sql =
            "UPDATE CVs SET Title=?, FilePath=?, LastUpdated=SYSDATETIME() " +
            "WHERE CVID=? AND JobSeekerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, filePath);
            ps.setInt(3, cvid);
            ps.setInt(4, jobSeekerId);
            ps.executeUpdate();
        }
    }
    
    // =========================
    // UPLOADED PDF
    // =========================

    /**
     * Insert CV dạng upload PDF
     * - TemplateCode NOT NULL => set mặc định TEMPLATE_1 (hoặc TEMPLATE_2 tùy bạn)
     * - FilePath: có thể NULL lúc đầu rồi update sau khi lưu file
     */
    public int insertUploaded(int jobSeekerId, String title, String filePath) throws SQLException {
        String sql =
            "INSERT INTO CVs(JobSeekerID, Title, FilePath, TemplateCode, IsDefault, Summary, Skills, Links, UploadDate, LastUpdated) " +
            "VALUES(?, ?, ?, 'TEMPLATE_1', 0, NULL, NULL, NULL, SYSDATETIME(), SYSDATETIME())";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, jobSeekerId);
            ps.setString(2, title);
            ps.setString(3, filePath); // có thể NULL
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            return rs.getInt(1);
        }
    }

    
}
