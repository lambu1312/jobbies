package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.LinkedHashMap;
import java.util.List;

import model.HandbookPosts;

public class HandbookPostsDAO extends GenericDAO<HandbookPosts> {

    @Override
    public List<HandbookPosts> findAll() {
        return queryGenericDAO(HandbookPosts.class);
    }

    public HandbookPosts findById(int id) {
        String sql = "SELECT * FROM [dbo].[HandbookPosts] WHERE HandbookPostID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("HandbookPostID", id);
        List<HandbookPosts> list = queryGenericDAO(HandbookPosts.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public HandbookPosts findPublishedById(int id) {
        String sql = "SELECT * FROM [dbo].[HandbookPosts] WHERE HandbookPostID = ? AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("HandbookPostID", id);
        parameterMap.put("Status", "Published");
        List<HandbookPosts> list = queryGenericDAO(HandbookPosts.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<HandbookPosts> findPublished(String search, int page) {
        if (search == null) {
            search = "";
        }
        String sql = "SELECT * FROM [dbo].[HandbookPosts] WHERE Status = ? AND Title LIKE ? ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Published");
        parameterMap.put("Title", "%" + search + "%");
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(HandbookPosts.class, sql, parameterMap);
    }

    public int countPublished(String search) {
        if (search == null) {
            search = "";
        }
        String sql = "SELECT count(*) FROM [dbo].[HandbookPosts] WHERE Status = ? AND Title LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Published");
        parameterMap.put("Title", "%" + search + "%");
        return findTotalRecordGenericDAO(HandbookPosts.class, sql, parameterMap);
    }

    public List<HandbookPosts> adminList(String search, String status, int page) {
        if (search == null) {
            search = "";
        }
        if (status == null) {
            status = "";
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM [dbo].[HandbookPosts] WHERE 1=1 ");

        parameterMap = new LinkedHashMap<>();

        if (!status.isEmpty()) {
            sql.append(" AND Status = ? ");
            parameterMap.put("Status", status);
        }

        sql.append(" AND Title LIKE ? ");
        parameterMap.put("Title", "%" + search + "%");

        sql.append(" ORDER BY UpdatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);

        return queryGenericDAO(HandbookPosts.class, sql.toString(), parameterMap);
    }

    public int adminCount(String search, String status) {
        if (search == null) {
            search = "";
        }
        if (status == null) {
            status = "";
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT count(*) FROM [dbo].[HandbookPosts] WHERE 1=1 ");

        parameterMap = new LinkedHashMap<>();

        if (!status.isEmpty()) {
            sql.append(" AND Status = ? ");
            parameterMap.put("Status", status);
        }

        sql.append(" AND Title LIKE ? ");
        parameterMap.put("Title", "%" + search + "%");

        return findTotalRecordGenericDAO(HandbookPosts.class, sql.toString(), parameterMap);
    }

    @Override
    public int insert(HandbookPosts t) {
        String sql = "INSERT INTO [dbo].[HandbookPosts] ([Title],[Content],[Thumbnail],[Status],[CreatedAt],[UpdatedAt]) VALUES (?,?,?,?,SYSUTCDATETIME(),SYSUTCDATETIME())";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Content", t.getContent());
        parameterMap.put("Thumbnail", t.getThumbnail());
        parameterMap.put("Status", t.getStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public void update(HandbookPosts t) {
        String sql = "UPDATE [dbo].[HandbookPosts] SET [Title]=?,[Content]=?,[Thumbnail]=?,[Status]=?,[UpdatedAt]=SYSUTCDATETIME() WHERE HandbookPostID=?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Content", t.getContent());
        parameterMap.put("Thumbnail", t.getThumbnail());
        parameterMap.put("Status", t.getStatus());
        parameterMap.put("HandbookPostID", t.getHandbookPostID());
        updateGenericDAO(sql, parameterMap);
    }

    public void delete(int id) {
        String sql = "DELETE FROM [dbo].[HandbookPosts] WHERE HandbookPostID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("HandbookPostID", id);
        deleteGenericDAO(sql, parameterMap);
    }
}
