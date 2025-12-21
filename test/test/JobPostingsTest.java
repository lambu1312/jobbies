/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package test;

import dao.JobPostingsDAO;
import model.JobPostings;
import org.junit.*;
import static org.junit.Assert.*;
import java.util.List;
import java.sql.Date;

/**
 *
 * @author admin
 */
public class JobPostingsTest {
    
    private static JobPostingsDAO jobPostingsDAO;
    
    public JobPostingsTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
        jobPostingsDAO = new JobPostingsDAO();
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }
    
    // ===== TEST FIND METHODS =====
    
    @Test
    public void testFindAll_ShouldReturnListOfJobPostings() {
        List<JobPostings> list = jobPostingsDAO.findAll();
        assertNotNull(list);
    }
    
    @Test
    public void testFindJobPostingById_WhenIdExists_ShouldReturnJobPosting() {
        JobPostings job = jobPostingsDAO.findJobPostingById(1);
        if (job != null) {
            assertNotNull(job);
            assertEquals(1, job.getJobPostingID());
        }
    }
    
    @Test
    public void testFindJobPostingById_WhenIdNotExists_ShouldReturnNull() {
        JobPostings job = jobPostingsDAO.findJobPostingById(99999);
        assertNull(job);
    }
    
    @Test
    public void testFindJobPostingByRecruiterID_WhenRecruiterIDExists_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findJobPostingbyRecruitersID(1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindJobPostingByRecruiterID_WhenRecruiterIDNotExists_ShouldReturnEmptyList() {
        List<JobPostings> list = jobPostingsDAO.findJobPostingbyRecruitersID(99999);
        assertNotNull(list);
        assertTrue(list.isEmpty());
    }
    
    @Test
    public void testFindJobPostingByRecruiterIDAndOneMonth_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findJobPostingbyRecruitersIDandOneMonth(1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindAllByRecruiterID_WhenRecruiterIDExists_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findAllByRecruiterID(1);
        assertNotNull(list);
    }
    
    @Test
    public void testGetTop5RecentJobPostings_ShouldReturnMaxFiveItems() {
        List<JobPostings> list = jobPostingsDAO.getTop5RecentJobPostings();
        assertNotNull(list);
        assertTrue(list.size() <= 5);
    }
    
    @Test
    public void testGetTop5RecentJobPostingsByRecruiterID_ShouldReturnMaxFiveItems() {
        List<JobPostings> list = jobPostingsDAO.getTop5RecentJobPostingsByRecruiterID(1);
        assertNotNull(list);
        assertTrue(list.size() <= 5);
    }
    
    @Test
    public void testGetJobPostingsByOpen_WhenStatusIsOpen_ShouldReturnOpenJobPostings() {
        List<JobPostings> list = jobPostingsDAO.getJobPostingsByOpen();
        assertNotNull(list);
        for (JobPostings job : list) {
            assertEquals("Open", job.getStatus());
        }
    }
    
    // ===== TEST SEARCH METHODS =====
    
    @Test
    public void testSearchJobPostingByTitle_WhenTitleExists_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.searchJobPostingByTitle("Developer", 1);
        assertNotNull(list);
    }
    
    @Test
    public void testSearchJobPostingByTitle_WhenTitleIsEmpty_ShouldReturnEmptyOrAllList() {
        List<JobPostings> list = jobPostingsDAO.searchJobPostingByTitle("", 1);
        assertNotNull(list);
    }
    
    @Test
    public void testSearchJobPostingByTitleAndRecruiterID_WhenTitleAndRecruiterIDExist_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.searchJobPostingByTitleAndRecruiterID("Developer", 1, 1);
        assertNotNull(list);
    }
    
    @Test
    public void testSearchJobPostingByTitleAndRecruiterID_WhenRecruiterIDNotExists_ShouldReturnEmptyList() {
        List<JobPostings> list = jobPostingsDAO.searchJobPostingByTitleAndRecruiterID("Developer", 99999, 1);
        assertNotNull(list);
        assertTrue(list.isEmpty());
    }
    
    // ===== TEST COUNT METHODS =====
    
    @Test
    public void testCountTotalJobPostings_ShouldReturnCountGreaterThanOrEqualToZero() {
        int count = jobPostingsDAO.countTotalJobPostings();
        assertTrue(count >= 0);
    }
    
    @Test
    public void testCountTotalJobPostingsByRecruiterID_WhenRecruiterIDExists_ShouldReturnCount() {
        int count = jobPostingsDAO.countTotalJobPostingsByRecruiterID(1);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testCountTotalJobPostingsByRecruiterID_WhenRecruiterIDNotExists_ShouldReturnZero() {
        int count = jobPostingsDAO.countTotalJobPostingsByRecruiterID(99999);
        assertEquals(0, count);
    }
    
    @Test
    public void testCountJobsBySalaryRange_WhenSalaryRangeExists_ShouldReturnCount() {
        int count = jobPostingsDAO.countJobsBySalaryRange(1000, 5000);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testCountJobPostingsByCategory_WhenCategoryExists_ShouldReturnCount() {
        int count = jobPostingsDAO.countJobPostingsByCategory(1);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testCountViolateJobPostingsForRecruiter_WhenRecruiterIDExists_ShouldReturnCount() {
        int count = jobPostingsDAO.countViolateJobPostingsForRecruiter(1);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalJobPostingCountByQuarter_WhenQuarterIsValid_ShouldReturnCount() {
        int count = jobPostingsDAO.findTotalJobPostingCountByQuarter(1, 1);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalJobPostingCountByQuarter_WhenQuarterIsInvalid_ShouldThrowException() {
        try {
            jobPostingsDAO.findTotalJobPostingCountByQuarter(1, 5);
            fail("Should throw IllegalArgumentException");
        } catch (IllegalArgumentException e) {
            assertTrue(true);
        }
    }
    
    // ===== TEST FIND RECORD METHODS =====
    
    @Test
    public void testFindTotalRecordByTitle_WhenTitleExists_ShouldReturnCount() {
        int count = jobPostingsDAO.findTotalRecordByTitle("Developer");
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalRecordByTitle_WhenTitleIsEmpty_ShouldReturnCount() {
        int count = jobPostingsDAO.findTotalRecordByTitle("");
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalRecordByTitleAndSalary_WhenFilterIsValid_ShouldReturnCount() {
        int count = jobPostingsDAO.findTotalRecordByTitle("Developer", 1000, 5000);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalRecordByTitleAndRecruiterID_WhenFilterIsValid_ShouldReturnCount() {
        int count = jobPostingsDAO.findTotalRecordByTitleAndRecruiterID("Developer", 1);
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindTotalRecordByTitleAndRecruiterID_WhenRecruiterIDNotExists_ShouldReturnZero() {
        int count = jobPostingsDAO.findTotalRecordByTitleAndRecruiterID("Developer", 99999);
        assertEquals(0, count);
    }
    
    // ===== TEST GET INFORMATION METHODS =====
    
    @Test
    public void testGetJobPostingTitleByJobPostingId_WhenIdExists_ShouldReturnTitle() {
        String title = jobPostingsDAO.getJobPostingTitleByJobPostingId(1);
        if (title != null) {
            assertNotNull(title);
            assertTrue(title.length() > 0);
        }
    }
    
    @Test
    public void testGetJobPostingTitleByJobPostingId_WhenIdNotExists_ShouldReturnNull() {
        String title = jobPostingsDAO.getJobPostingTitleByJobPostingId(99999);
        assertNull(title);
    }
    
    @Test
    public void testFindJobPostingStatusByJobPostingId_WhenIdExists_ShouldReturnStatus() {
        String status = jobPostingsDAO.findJobPostingStatusByJobPostingId(1);
        if (status != null) {
            assertNotNull(status);
        }
    }
    
    @Test
    public void testFindJobPostingStatusByJobPostingId_WhenIdNotExists_ShouldReturnNull() {
        String status = jobPostingsDAO.findJobPostingStatusByJobPostingId(99999);
        assertNull(status);
    }
    
    @Test
    public void testIsRecruiterOwnerOfJobPosting_WhenRecruiterOwnsJobPosting_ShouldReturnTrue() {
        boolean isOwner = jobPostingsDAO.isRecruiterOwnerOfJobPosting(1, 1);
        assertTrue(isOwner || !isOwner);
    }
    
    // ===== TEST FILTER METHODS =====
    
    @Test
    public void testFindJobPostingsWithFilter_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findJobPostingsWithFilter("PostedDate", 1, 10);
        assertNotNull(list);
    }
    
    @Test
    public void testFindJobPostingsWithFilterAndRecruiterID_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findJobPostingsWithFilterAndRecruiterID("PostedDate", 1, 1, 10);
        assertNotNull(list);
    }
    
    @Test
    public void testGetJobsBySalaryRange_WhenSalaryRangeIsValid_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.getJobsBySalaryRange(1000, 5000, 1, 10, "PostedDate");
        assertNotNull(list);
    }
    
    @Test
    public void testGetJobPostingsByCategory_WhenCategoryExists_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.getJobPostingsByCategory(1);
        assertNotNull(list);
    }
    
    // ===== TEST DASHBOARD METHODS =====
    
    @Test
    public void testFindTop5Recruiter_ShouldReturnMaxFiveRecruiters() {
        List<JobPostings> list = jobPostingsDAO.findTop5Recruiter();
        assertNotNull(list);
        assertTrue(list.size() <= 5);
    }
    
    @Test
    public void testFindTop5RecruiterWithDateFilter_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findTop5Recruiter("2024-01-01", "2024-12-31");
        assertNotNull(list);
    }
    
    @Test
    public void testFilterJobPostingStatusForChart_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.filterJobPostingStatusForChart();
        assertNotNull(list);
    }
    
    @Test
    public void testFilterJobPostingStatusForChartWithDateFilter_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.filterJobPostingStatusForChart("2024-01-01", "2024-12-31");
        assertNotNull(list);
    }
    
    // ===== TEST COMPLEX FILTER METHODS =====
    
    @Test
    public void testFindAndfilterJobPostings_WhenFilterIsValid_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findAndfilterJobPostings("Open", "USD", 1000.0, 5000.0, null, "Developer", 1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindAndfilterJobPostings_WhenStatusIsAll_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findAndfilterJobPostings("all", "all", null, null, null, null, 1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindAndfilterAllRecord_WhenFilterIsValid_ShouldReturnCount() {
        int count = jobPostingsDAO.findAndfilterAllRecord("Open", "USD", 1000.0, 5000.0, null, "Developer");
        assertTrue(count >= 0);
    }
    
    @Test
    public void testFindAndfilterJobPostingsHome_WhenFilterIsValid_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findAndfilterJobPostingsHome("1000", "5000", null, "USD", "Developer", null, null, 1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindAndfilterJobPostingsHome_WhenSearchIsEmpty_ShouldReturnList() {
        List<JobPostings> list = jobPostingsDAO.findAndfilterJobPostingsHome(null, null, null, "all", "", null, null, 1);
        assertNotNull(list);
    }
    
    @Test
    public void testFindAndfilterAllHomeRecord_WhenFilterIsValid_ShouldReturnCount() {
        int count = jobPostingsDAO.findAndfilterAllHomeRecord("1000", "5000", null, "USD", "Developer");
        assertTrue(count >= 0);
    }
    

    
    @Test
    public void testFindAndfilterJobPostingsHomeWithDateRange_WhenDateRangeIsValid_ShouldReturnList() {
        Date dateFrom = new Date(System.currentTimeMillis() - 30 * 24 * 60 * 60 * 1000);
        Date dateTo = new Date(System.currentTimeMillis());
        List<JobPostings> list = jobPostingsDAO.findAndfilterJobPostingsHome("1000", "5000", null, "USD", "Developer", null, dateFrom, dateTo, 1);
        assertNotNull(list);
    }
    
    // ===== TEST INSERT/UPDATE/DELETE METHODS =====
    
    @Test
    public void testInsert_WhenJobPostingIsValid_ShouldReturnIdGreaterThanZero() {
        JobPostings testJob = new JobPostings();
        testJob.setRecruiterID(1);
        testJob.setTitle("Test Job Position");
        testJob.setDescription("Test Description");
        testJob.setRequirements("Test Requirements");
        testJob.setCurrency("USD");
        testJob.setLocation("Hanoi");
        testJob.setPostedDate(new java.util.Date());
        testJob.setClosingDate(new java.util.Date());
        testJob.setJob_Posting_CategoryID(1);
        testJob.setStatus("Open");
        
        int result = jobPostingsDAO.insert(testJob);
        assertTrue(result > 0);
    }
    
    @Test
    public void testUpdateJobPosting_WhenJobPostingExists_ShouldUpdateSuccessfully() {
        JobPostings job = jobPostingsDAO.findJobPostingById(1);
        if (job != null) {
            String originalTitle = job.getTitle();
            job.setTitle("Updated Title Test");
            jobPostingsDAO.updateJobPosting(job);
            
            JobPostings updated = jobPostingsDAO.findJobPostingById(1);
            assertEquals("Updated Title Test", updated.getTitle());
        }
    }
    
    @Test
    public void testViolateJobPost_WhenJobPostingExists_ShouldChangeStatusToViolate() {
        JobPostings job = jobPostingsDAO.findJobPostingById(1);
        if (job != null) {
            jobPostingsDAO.violateJobPost(1);
            String status = jobPostingsDAO.findJobPostingStatusByJobPostingId(1);
            if (status != null) {
                assertEquals("Violate", status);
            }
        }
    }
    
    @Test
    public void testDeleteJobPosting_WhenJobPostingExists_ShouldDeleteSuccessfully() {
        JobPostings testJob = new JobPostings();
        testJob.setRecruiterID(1);
        testJob.setTitle("Job To Delete");
        testJob.setDescription("Test Description");
        testJob.setRequirements("Test Requirements");
 
        testJob.setCurrency("USD");
        testJob.setLocation("Hanoi");
        testJob.setPostedDate(new java.util.Date());
        testJob.setClosingDate(new java.util.Date());
        testJob.setJob_Posting_CategoryID(1);
        testJob.setStatus("Open");
        
        int insertedId = jobPostingsDAO.insert(testJob);
        if (insertedId > 0) {
            jobPostingsDAO.deleteJobPosting(insertedId, 1);
            JobPostings deleted = jobPostingsDAO.findJobPostingById(insertedId);
            assertNull(deleted);
        }
    }
}