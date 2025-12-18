package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.CvSection;

public class CvSectionDAO extends DBContext {

    private CvSection map(ResultSet rs) throws Exception {
        CvSection s = new CvSection();
        s.setSectionId(rs.getInt("SectionID"));
        s.setCvId(rs.getInt("CVID"));
        s.setTitle(rs.getString("Title"));
        s.setContent(rs.getString("Content"));
        s.setSortOrder(rs.getInt("SortOrder"));
        s.setCreatedAt(rs.getTimestamp("CreatedAt"));
        s.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return s;
    }

    // ✅ Lấy sections theo CV + check ownership bằng JOIN CVs
    public List<CvSection> listByCv(int cvId, int jobSeekerId) {
        List<CvSection> list = new ArrayList<>();
        String sql =
        "SELECT s.SectionID, s.CVID, s.Title, s.Content, s.SortOrder, s.CreatedAt, s.UpdatedAt " +
        "FROM CVSections s " +
        "JOIN CVs c ON c.CVID = s.CVID " +
        "WHERE s.CVID=? AND c.JobSeekerID=? " +
        "ORDER BY s.SortOrder ASC, s.SectionID ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Xóa toàn bộ sections của CV (cũng check ownership)
    public void deleteByCv(int cvId, int jobSeekerId) {
        String sql = """
            DELETE s
            FROM CvSections s
            JOIN CVs c ON c.CVID = s.CVID
            WHERE s.CVID = ? AND c.JobSeekerID = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Insert 1 section (không cần JobSeekerID trong CvSections)
    public void insert(int cvId, int jobSeekerId, String title, String content, int sortOrder) {
        // Check ownership trước khi insert
        String check = "SELECT 1 FROM CVs WHERE CVID=? AND JobSeekerID=?";
        String sql = """
            INSERT INTO CvSections(CVID, Title, Content, SortOrder, CreatedAt, UpdatedAt)
            VALUES(?, ?, ?, ?, SYSDATETIME(), SYSDATETIME())
        """;

        try (PreparedStatement psCheck = connection.prepareStatement(check)) {
            psCheck.setInt(1, cvId);
            psCheck.setInt(2, jobSeekerId);
            ResultSet rs = psCheck.executeQuery();
            if (!rs.next()) return; // không phải chủ CV

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, cvId);
                ps.setString(2, title);
                ps.setString(3, content);
                ps.setInt(4, sortOrder);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
