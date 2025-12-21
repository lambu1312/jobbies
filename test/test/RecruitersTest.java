package test;

import dao.RecruitersDAO;
import model.Recruiters;
import org.junit.*;
import static org.junit.Assert.*;

public class RecruitersTest {

    private static RecruitersDAO recruitersDAO;

    public RecruitersTest() {
    }

    @BeforeClass
    public static void setUpClass() {
        recruitersDAO = new RecruitersDAO();
    }

    @AfterClass
    public static void tearDownClass() {
        recruitersDAO = null;
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    // ---------- TEST FIND BY ID ----------1
    @Test
    public void testFindById_WhenIdNotExists_ShouldThrowException() {
        try {
            Recruiters result = recruitersDAO.findById("99999");
            fail("Should throw IndexOutOfBoundsException for non-existent id");
        } catch (IndexOutOfBoundsException e) {
            assertTrue("Exception thrown as expected", true);
        }
    }

    // ---------- TEST FIND BY ACCOUNT ID ----------2, 3
    @Test
    public void testFindRecruitersbyAccountID_WhenAccountIDExists_ShouldReturnRecruiter() {
        Recruiters result = recruitersDAO.findRecruitersbyAccountID("2");
        assertNotNull("Should find recruiter with AccountID 2", result);
        assertEquals("RecruiterID should be 1", 1, result.getRecruiterID());
        assertEquals("AccountID should be 2", 2, result.getAccountID());
    }

    @Test
    public void testFindRecruitersbyAccountID_WhenAccountIDNotExists_ShouldReturnNull() {
        Recruiters result = recruitersDAO.findRecruitersbyAccountID("99999");
        assertNull("Should return null for non-existent AccountID", result);
    }

    // ---------- TEST LIST BY RECRUITER ID ----------4 , 5
    @Test
    public void testListRecruiterByRecruiterID_WhenIdExists_ShouldReturnList() {
        java.util.List<Recruiters> result = recruitersDAO.listRecruiterByRecruiterID(1);
        assertNotNull("List should not be null", result);
        assertFalse("List should not be empty for existing id", result.isEmpty());
        assertEquals("Should have at least 1 recruiter", 1, result.size());
        assertEquals("First recruiter ID should be 1", 1, result.get(0).getRecruiterID());
    }

    @Test
    public void testListRecruiterByRecruiterID_WhenIdNotExists_ShouldReturnEmptyList() {
        java.util.List<Recruiters> result = recruitersDAO.listRecruiterByRecruiterID(99999);
        assertNotNull("List should not be null", result);
        assertTrue("List should be empty for non-existent id", result.isEmpty());
    }

    // ---------- TEST LIST BY ACCOUNT ID ----------6, 7
    @Test
    public void testListRecruiterByAccountID_WhenAccountIDExists_ShouldReturnList() {
        java.util.List<Recruiters> result = recruitersDAO.listRecruiterByAccountID(2);
        assertNotNull("List should not be null", result);
        assertFalse("List should not be empty for existing AccountID", result.isEmpty());
    }

    @Test
    public void testListRecruiterByAccountID_WhenAccountIDNotExists_ShouldReturnEmptyList() {
        java.util.List<Recruiters> result = recruitersDAO.listRecruiterByAccountID(99999);
        assertNotNull("List should not be null", result);
        assertTrue("List should be empty for non-existent AccountID", result.isEmpty());
    }

}
