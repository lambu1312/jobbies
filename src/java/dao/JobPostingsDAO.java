package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.JobPostings;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class JobPostingsDAO extends GenericDAO<JobPostings> {

    @Override
    public List<JobPostings> findAll() {
        return queryGenericDAO(JobPostings.class);
    }

    public JobPostings findJobPostingById(int ID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] where JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", ID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    //Tính toán thời gian cách đây 1 tháng so với ngày hiện tại
    public List<JobPostings> findJobPostingbyRecruitersIDandOneMonth(int recruiterID) {
        // Thêm điều kiện tìm kiếm các bài đăng trong 1 tháng
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ? AND PostedDate >= DATEADD(month, -1, GETDATE())";

        // Tạo map chứa các tham số cho câu truy vấn
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);

        // Gọi hàm queryGenericDAO để truy vấn
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public boolean isRecruiterOwnerOfJobPosting(int jobPostingId, int recruiterAccountId) {
        String sql
                = "SELECT 1 "
                + "FROM JobPostings jp "
                + "JOIN Recruiters r ON jp.RecruiterID = r.RecruiterID "
                + "WHERE jp.JobPostingID = ? "
                + "  AND r.AccountID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobPostingId);
            ps.setInt(2, recruiterAccountId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<JobPostings> findJobPostingbyRecruitersID(int recruiterID) {
        String sql = "select * from [dbo].[JobPostings] where RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        ApplicationDAO applicationDao = new ApplicationDAO();
        for (JobPostings jobPostings : list) {
            jobPostings.setApplication(applicationDao.findApplicationByJobPostingID(jobPostings.getJobPostingID()));
        }
        return list;

    }

    public void updateJobPosting(JobPostings t) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [RecruiterID] = ?\n"
                + "      ,[Title] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Requirements] = ?\n"
                + "      ,[MinSalary] = ?\n"
                + "      ,[MaxSalary] = ?\n"
                + "      ,[Currency] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[PostedDate] = ?\n"
                + "      ,[ClosingDate] = ?\n"
                + "      ,[Job_Posting_CategoryID] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", t.getRecruiterID());
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("MinSalary", t.getMinSalary());
        parameterMap.put("MaxSalary", t.getMaxSalary());
        parameterMap.put("Currency", t.getCurrency());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
        parameterMap.put("Job_Posting_CategoryID", t.getJob_Posting_CategoryID());
        parameterMap.put("Status", t.getStatus());
        parameterMap.put("JobPostingID", t.getJobPostingID());
        updateGenericDAO(sql, parameterMap);
    }

    public void deleteJobPosting(String jobPostingEdit) {
        String sql = "DELETE FROM [dbo].[JobPostings]\n"
                + "      WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingEdit);
        deleteGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> getTop5RecentJobPostings() {
        String sql = "SELECT TOP 5 *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY PostedDate DESC";
        parameterMap = new LinkedHashMap<>();
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    @Override
    public int insert(JobPostings t) {
        String sql = "INSERT INTO [dbo].[JobPostings]\n"
                + "           ([RecruiterID]\n"
                + "           ,[Title]\n"
                + "           ,[Description]\n"
                + "           ,[Requirements]\n"
                + "           ,[MinSalary]\n"
                + "           ,[MaxSalary]\n"
                + "           ,[Currency]\n"
                + "           ,[Location]\n"
                + "           ,[PostedDate]\n"
                + "           ,[ClosingDate]\n"
                + "           ,[Job_Posting_CategoryID]\n"
                + "           ,[Status])\n"
                + "     VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", t.getRecruiterID());
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("MinSalary", t.getMinSalary());
        parameterMap.put("MaxSalary", t.getMaxSalary());
        parameterMap.put("Currency", t.getCurrency());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
        parameterMap.put("Job_Posting_CategoryID", t.getJob_Posting_CategoryID());
        parameterMap.put("Status", t.getStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> findAllByRecruiterID(int recruiterID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public void deleteJobPosting(int jobPostingID, int recruiterID) {
        String sql = "DELETE FROM [dbo].[JobPostings]\n"
                + "      WHERE JobPostingID = ? AND RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingID);
        parameterMap.put("RecruiterID", recruiterID);  // Chỉ cho phép xóa nếu recruiterID khớp
        deleteGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> getTop5RecentJobPostingsByRecruiterID(int recruiterID) {
        String sql = "SELECT TOP 5 * FROM [dbo].[JobPostings]\n"
                + "WHERE RecruiterID = ?\n"
                + "ORDER BY PostedDate desc";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    ////
    public List<JobPostings> searchJobPostingByTitleAndRecruiterID(String searchJP, int recruiterID, int page) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND RecruiterID = ? ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        ApplicationDAO applicationDao = new ApplicationDAO();
        for (JobPostings jobPostings : list) {
            jobPostings.setApplication(applicationDao.findApplicationByJobPostingID(jobPostings.getJobPostingID()));
        }
        return list;
    }

    public List<JobPostings> searchJobPostingByTitle(String searchJP, int page) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND Status = ? ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitleAndRecruiterID(String searchQuery, int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitle(String searchQuery) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("Status", "Opened");  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitle(String searchQuery, double minSalary, double maxSalary) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND MinSalary >= ? AND MaxSalary <= ? AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("Status", "Opened");  // Thêm RecruiterID vào truy vấn
        parameterMap.put("MinSalary", minSalary);
        parameterMap.put("MaxSalary", maxSalary);
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findJobPostingsWithFilterAndRecruiterID(String sortField, int recruiterID, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        ApplicationDAO applicationDao = new ApplicationDAO();
        for (JobPostings jobPostings : list) {
            jobPostings.setApplication(applicationDao.findApplicationByJobPostingID(jobPostings.getJobPostingID()));
        }
        return list;
    }

    public List<JobPostings> findJobPostingsWithFilter(String sortField, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        ApplicationDAO applicationDao = new ApplicationDAO();
        for (JobPostings jobPostings : list) {
            jobPostings.setApplication(applicationDao.findApplicationByJobPostingID(jobPostings.getJobPostingID()));
        }
        return list;
    }

    public int countTotalJobPostingsByRecruiterID(int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countJobsBySalaryRange(double minSalary, double maxSalary) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE MinSalary >= ? AND MaxSalary <= ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("MinSalary", minSalary);
        parameterMap.put("MaxSalary", maxSalary);
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countJobPostingsByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = ? and Job_Posting_CategoryID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("Job_Posting_CategoryID", categoryId);

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countTotalJobPostings() {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getJobPostingsByOpen() {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE [Status] = ? order by PostedDate desc";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getJobPostingsByCategory(int categoryId) {
        String sql = "select * from JobPostings where Status = ? and Job_Posting_CategoryID = ? order by PostedDate desc";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("Job_Posting_CategoryID", categoryId);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    // ========== METHODS CHO DASHBOARD WITH DATE FILTER ==========
    /**
     * Lấy top 5 recruiters có nhiều job postings nhất Hỗ trợ filter theo date
     * range
     */
    public List<JobPostings> findTop5Recruiter(String startDate, String endDate) {
        String sql = "SELECT * FROM JobPostings WHERE RecruiterID IN ("
                + "    SELECT TOP 5 RecruiterID FROM JobPostings ";

        // Thêm WHERE clause nếu có date filter
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += "    WHERE PostedDate BETWEEN ? AND ? ";
        }

        sql += "    GROUP BY RecruiterID "
                + "    ORDER BY COUNT(*) DESC"
                + ") ";

        // Thêm WHERE clause cho query chính nếu có date filter
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += "AND PostedDate BETWEEN ? AND ? ";
        }

        sql += "ORDER BY RecruiterID, PostedDate DESC";

        parameterMap = new LinkedHashMap<>();

        // Set parameters nếu có date filter
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            parameterMap.put("StartDate1", startDate);
            parameterMap.put("EndDate1", endDate);
            parameterMap.put("StartDate2", startDate);
            parameterMap.put("EndDate2", endDate);
        }

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    /**
     * Method overload để giữ compatibility với code cũ
     */
    public List<JobPostings> findTop5Recruiter() {
        return findTop5Recruiter(null, null);
    }

    /**
     * Lấy tất cả job postings để đếm theo status Hỗ trợ filter theo date range
     */
    public List<JobPostings> filterJobPostingStatusForChart(String startDate, String endDate) {
        String sql = "SELECT * FROM JobPostings ";

        // Thêm WHERE clause nếu có date filter
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += "WHERE PostedDate BETWEEN ? AND ? ";
        }

        sql += "ORDER BY Status";

        parameterMap = new LinkedHashMap<>();

        // Set parameters nếu có date filter
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            parameterMap.put("StartDate", startDate);
            parameterMap.put("EndDate", endDate);
        }

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    /**
     * Method overload để giữ compatibility với code cũ
     */
    public List<JobPostings> filterJobPostingStatusForChart() {
        return filterJobPostingStatusForChart(null, null);
    }

    // ========== KẾT THÚC METHODS CHO DASHBOARD ==========
    // Tim Job theo khoang luong
    public List<JobPostings> getJobsBySalaryRange(double MinSalary, double MaxSalary, int page, int pageSize, String sortField) {
        String sql = "SELECT * FROM JobPostings WHERE MinSalary >= ? AND MaxSalary <= ? AND Status = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("MinSalary", MinSalary);
        parameterMap.put("MaxSalary", MaxSalary);
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findAndfilterJobPostings(
            String status,
            String currency,
            Double minSalary,
            Double maxSalary,
            String postDate,
            String search,
            int page) {

        String sql = """
        SELECT jb.* FROM JobPostings jb
        JOIN Recruiters re ON jb.RecruiterID = re.RecruiterID
        JOIN Account acc ON re.AccountID = acc.id
        WHERE 1 = 1
    """;

        parameterMap = new LinkedHashMap<>();

        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql += " AND jb.Status = ?";
            parameterMap.put("Status", status);
        }

        if (currency != null && !currency.isEmpty() && !currency.equals("all")) {
            sql += " AND jb.Currency = ?";
            parameterMap.put("Currency", currency);
        }

        if (minSalary != null) {
            sql += " AND jb.MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalary);
        }

        if (maxSalary != null) {
            sql += " AND jb.MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalary);
        }

        if (postDate != null && !postDate.isEmpty()) {
            sql += " AND CAST(jb.PostedDate AS DATE) = CAST(? AS DATE)";
            parameterMap.put("PostedDate", postDate);
        }

        if (search != null && !search.isEmpty()) {
            sql += " AND (acc.firstName + ' ' + acc.lastName LIKE ? OR acc.lastName + ' ' + acc.firstName LIKE ?)";
            parameterMap.put("Search1", "%" + search + "%");
            parameterMap.put("Search2", "%" + search + "%");
        }

        sql += " ORDER BY jb.JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findAndfilterJobPostingsHome(String minSalaryStr, String maxSalaryStr, String filterCategory, String filterCurrency, String search, int page) {
        String sql = "SELECT * FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        // Lọc theo tìm kiếm tiêu đề
        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        // Lọc theo danh mục
        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        // Lọc theo tiền tệ - QUAN TRỌNG ✅
        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        // Lọc theo mức lương
        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        sql += " ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap.put("offset", (page - 1) * 12);
        parameterMap.put("fetch", 12);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public void violateJobPost(int jobPostId) {
        String sql = """
                     UPDATE [dbo].[JobPostings]
                        SET 
                           [Status] = ?
                      WHERE JobPostingID = ?""";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Violate");
        parameterMap.put("JobPostingID", jobPostId);
        updateGenericDAO(sql, parameterMap);
    }

    public int findAndfilterAllRecord(
            String status,
            String currency,
            Double minSalary,
            Double maxSalary,
            String postDate,
            String search) {

        String sql = """
        SELECT COUNT(*) FROM JobPostings jb
        JOIN Recruiters re ON jb.RecruiterID = re.RecruiterID
        JOIN Account acc ON re.AccountID = acc.id
        WHERE 1 = 1
    """;

        parameterMap = new LinkedHashMap<>();

        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql += " AND jb.Status = ?";
            parameterMap.put("Status", status);
        }

        if (currency != null && !currency.isEmpty() && !currency.equals("all")) {
            sql += " AND jb.Currency = ?";
            parameterMap.put("Currency", currency);
        }

        if (minSalary != null) {
            sql += " AND jb.MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalary);
        }

        if (maxSalary != null) {
            sql += " AND jb.MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalary);
        }

        if (postDate != null && !postDate.isEmpty()) {
            sql += " AND CAST(jb.PostedDate AS DATE) = CAST(? AS DATE)";
            parameterMap.put("PostedDate", postDate);
        }

        if (search != null && !search.isEmpty()) {
            sql += " AND (acc.firstName + ' ' + acc.lastName LIKE ? OR acc.lastName + ' ' + acc.firstName LIKE ?)";
            parameterMap.put("Search1", "%" + search + "%");
            parameterMap.put("Search2", "%" + search + "%");
        }

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findAndfilterAllHomeRecord(String minSalaryStr, String maxSalaryStr, String filterCategory, String filterCurrency, String search) {
        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        // Lọc theo tìm kiếm tiêu đề
        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        // Lọc theo danh mục
        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        // Lọc theo tiền tệ - QUAN TRỌNG ✅
        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        // Lọc theo mức lương
        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    ///
    public String getJobPostingTitleByJobPostingId(int jobPostingId) {
        // Câu truy vấn SQL để lấy tiêu đề (Title) của JobPosting theo JobPostingID
        String sql = "SELECT Title FROM JobPostings WHERE JobPostingID = ?";

        // Tạo map chứa các tham số cho câu truy vấn
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingId);

        // Thực hiện truy vấn và lấy kết quả
        List<String> titles = queryGenericDAO1(String.class, sql, parameterMap);

        // Trả về title nếu có kết quả, nếu không trả về null
        return titles.isEmpty() ? null : titles.get(0);
    }

    public String findJobPostingStatusByJobPostingId(int jobPostingId) {
        String sql = "SELECT Status FROM JobPostings WHERE JobPostingID = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingId);

        // Thực hiện truy vấn và lấy danh sách kết quả
        List<String> statusList = queryGenericDAO1(String.class, sql, parameterMap);

        // Trả về phần tử đầu tiên nếu có kết quả, nếu không thì trả về null
        return statusList.isEmpty() ? null : statusList.get(0);
    }

    public int countViolateJobPostingsForRecruiter(int recruiterId) {
        String sql = "SELECT COUNT(*) FROM JobPostings "
                + "WHERE RecruiterID = ? AND Status = 'Violate'";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterId);

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    ///
    public int findTotalJobPostingCountByQuarter(int recruiterID, int quarter) {
        // Xác định khoảng thời gian của quý dựa trên tham số quarter
        int startMonth;
        int endMonth;

        switch (quarter) {
            case 1:
                startMonth = 1;
                endMonth = 3;
                break;
            case 2:
                startMonth = 4;
                endMonth = 6;
                break;
            case 3:
                startMonth = 7;
                endMonth = 9;
                break;
            case 4:
                startMonth = 10;
                endMonth = 12;
                break;
            default:
                throw new IllegalArgumentException("Quý phải nằm trong khoảng từ 1 đến 4.");
        }

        // Tạo câu truy vấn để tính tổng số job posting trong quý cho RecruiterID
        String sql = "SELECT COUNT(JobPostingID) AS TotalJobPostings "
                + "FROM [dbo].[JobPostings] "
                + "WHERE RecruiterID = ? "
                + "AND MONTH(PostedDate) BETWEEN ? AND ?";

        // Tạo map chứa các tham số cho câu truy vấn
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        parameterMap.put("StartMonth", startMonth);
        parameterMap.put("EndMonth", endMonth);

        // Gọi hàm queryGenericDAO để thực hiện truy vấn và trả về kết quả
        List<Integer> result = queryGenericDAO1(Integer.class, sql, parameterMap);

        // Trả về tổng số job postings (nếu không có kết quả thì trả về 0)
        return result.isEmpty() ? 0 : result.get(0);
    }

    public List<JobPostings> findAndfilterJobPostingsHome(
            String minSalaryStr, String maxSalaryStr,
            String filterCategory, String filterCurrency,
            String search,
            Date dateFrom, Date dateTo,
            int page) {

        String sql = "SELECT * FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        // Search title
        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        // Category
        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        // Currency
        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        // Salary
        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        // NEW: Date filter (PostedDate là DATE nên <= ok)
        if (dateFrom != null) {
            sql += " AND PostedDate >= ?";
            parameterMap.put("DateFrom", dateFrom);
        }
        if (dateTo != null) {
            sql += " AND PostedDate <= ?";
            parameterMap.put("DateTo", dateTo);
        }

        sql += " ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap.put("offset", (page - 1) * 12);
        parameterMap.put("fetch", 12);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findAndfilterAllHomeRecord(
            String minSalaryStr, String maxSalaryStr,
            String filterCategory, String filterCurrency,
            String search,
            Date dateFrom, Date dateTo) {

        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        // NEW: Date filter
        if (dateFrom != null) {
            sql += " AND PostedDate >= ?";
            parameterMap.put("DateFrom", dateFrom);
        }
        if (dateTo != null) {
            sql += " AND PostedDate <= ?";
            parameterMap.put("DateTo", dateTo);
        }

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findAndfilterJobPostingsHome(
            String minSalaryStr,
            String maxSalaryStr,
            String filterCategory,
            String filterCurrency,
            String search,
            String filterLocation,
            String dateFrom,
            String dateTo,
            int page
    ) {
        String sql = "SELECT * FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        // Search title
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search.trim() + "%");
        }

        // Category
        if (filterCategory != null && !filterCategory.trim().isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory.trim());
        }

        // Currency
        if (filterCurrency != null && !filterCurrency.trim().isEmpty() && !"all".equalsIgnoreCase(filterCurrency.trim())) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency.trim());
        }

        // Location (TEXT INPUT)
        if (filterLocation != null && !filterLocation.trim().isEmpty()) {
            sql += " AND Location LIKE ?";
            parameterMap.put("Location", "%" + filterLocation.trim() + "%");
        }

        // Date filter (PostedDate)
        boolean hasFrom = dateFrom != null && !dateFrom.trim().isEmpty();
        boolean hasTo = dateTo != null && !dateTo.trim().isEmpty();

        if (hasFrom && hasTo) {
            sql += " AND CAST(PostedDate AS DATE) BETWEEN CAST(? AS DATE) AND CAST(? AS DATE)";
            parameterMap.put("DateFrom", dateFrom.trim());
            parameterMap.put("DateTo", dateTo.trim());
        } else if (hasFrom) {
            sql += " AND CAST(PostedDate AS DATE) >= CAST(? AS DATE)";
            parameterMap.put("DateFrom", dateFrom.trim());
        } else if (hasTo) {
            sql += " AND CAST(PostedDate AS DATE) <= CAST(? AS DATE)";
            parameterMap.put("DateTo", dateTo.trim());
        }

        // Salary filter
        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.trim().isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.trim().isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr.trim());
            parameterMap.put("MaxSalary", maxSalaryStr.trim());
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr.trim());
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr.trim());
        }

        sql += " ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap.put("offset", (page - 1) * 12);
        parameterMap.put("fetch", 12);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findAndfilterAllHomeRecord(
            String minSalaryStr,
            String maxSalaryStr,
            String filterCategory,
            String filterCurrency,
            String search,
            String filterLocation,
            String dateFrom,
            String dateTo
    ) {
        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search.trim() + "%");
        }

        if (filterCategory != null && !filterCategory.trim().isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory.trim());
        }

        if (filterCurrency != null && !filterCurrency.trim().isEmpty() && !"all".equalsIgnoreCase(filterCurrency.trim())) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency.trim());
        }

        if (filterLocation != null && !filterLocation.trim().isEmpty()) {
            sql += " AND Location LIKE ?";
            parameterMap.put("Location", "%" + filterLocation.trim() + "%");
        }

        boolean hasFrom = dateFrom != null && !dateFrom.trim().isEmpty();
        boolean hasTo = dateTo != null && !dateTo.trim().isEmpty();

        if (hasFrom && hasTo) {
            sql += " AND CAST(PostedDate AS DATE) BETWEEN CAST(? AS DATE) AND CAST(? AS DATE)";
            parameterMap.put("DateFrom", dateFrom.trim());
            parameterMap.put("DateTo", dateTo.trim());
        } else if (hasFrom) {
            sql += " AND CAST(PostedDate AS DATE) >= CAST(? AS DATE)";
            parameterMap.put("DateFrom", dateFrom.trim());
        } else if (hasTo) {
            sql += " AND CAST(PostedDate AS DATE) <= CAST(? AS DATE)";
            parameterMap.put("DateTo", dateTo.trim());
        }

        boolean hasMinSalary = minSalaryStr != null && !minSalaryStr.trim().isEmpty();
        boolean hasMaxSalary = maxSalaryStr != null && !maxSalaryStr.trim().isEmpty();

        if (hasMinSalary && hasMaxSalary) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr.trim());
            parameterMap.put("MaxSalary", maxSalaryStr.trim());
        } else if (hasMinSalary) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr.trim());
        } else if (hasMaxSalary) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr.trim());
        }

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findAndfilterJobPostingsHome(
            String minSalaryStr,
            String maxSalaryStr,
            String filterCategory,
            String filterCurrency,
            String search,
            String filterLocation,
            java.sql.Date dateFrom,
            java.sql.Date dateTo,
            int page
    ) {

        String sql = "SELECT * FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        // ===== Search title =====
        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        // ===== Category =====
        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        // ===== Currency =====
        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        // ===== Location (TEXT SEARCH) =====
        if (filterLocation != null && !filterLocation.isEmpty()) {
            sql += " AND Location LIKE ?";
            parameterMap.put("Location", "%" + filterLocation + "%");
        }

        // ===== Salary =====
        boolean hasMin = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMax = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMin && hasMax) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMin) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMax) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        // ===== Date range =====
        if (dateFrom != null && dateTo != null) {
            sql += " AND CAST(PostedDate AS DATE) BETWEEN ? AND ?";
            parameterMap.put("DateFrom", dateFrom);
            parameterMap.put("DateTo", dateTo);
        }

        sql += " ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap.put("offset", (page - 1) * 12);
        parameterMap.put("fetch", 12);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findAndfilterAllHomeRecord(
            String minSalaryStr,
            String maxSalaryStr,
            String filterCategory,
            String filterCurrency,
            String search,
            String filterLocation,
            java.sql.Date dateFrom,
            java.sql.Date dateTo
    ) {

        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = 'Open'";
        parameterMap = new LinkedHashMap<>();

        if (search != null && !search.isEmpty()) {
            sql += " AND Title LIKE ?";
            parameterMap.put("Title", "%" + search + "%");
        }

        if (filterCategory != null && !filterCategory.isEmpty()) {
            sql += " AND Job_Posting_CategoryID = ?";
            parameterMap.put("Job_Posting_CategoryID", filterCategory);
        }

        if (filterCurrency != null && !filterCurrency.isEmpty() && !filterCurrency.equals("all")) {
            sql += " AND Currency = ?";
            parameterMap.put("Currency", filterCurrency);
        }

        if (filterLocation != null && !filterLocation.isEmpty()) {
            sql += " AND Location LIKE ?";
            parameterMap.put("Location", "%" + filterLocation + "%");
        }

        boolean hasMin = minSalaryStr != null && !minSalaryStr.isEmpty();
        boolean hasMax = maxSalaryStr != null && !maxSalaryStr.isEmpty();

        if (hasMin && hasMax) {
            sql += " AND MinSalary >= ? AND MaxSalary <= ?";
            parameterMap.put("MinSalary", minSalaryStr);
            parameterMap.put("MaxSalary", maxSalaryStr);
        } else if (hasMin) {
            sql += " AND MaxSalary >= ?";
            parameterMap.put("MinSalary", minSalaryStr);
        } else if (hasMax) {
            sql += " AND MinSalary <= ?";
            parameterMap.put("MaxSalary", maxSalaryStr);
        }

        if (dateFrom != null && dateTo != null) {
            sql += " AND CAST(PostedDate AS DATE) BETWEEN ? AND ?";
            parameterMap.put("DateFrom", dateFrom);
            parameterMap.put("DateTo", dateTo);
        }

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

}
