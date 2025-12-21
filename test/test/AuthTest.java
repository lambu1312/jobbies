/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package test;

import dao.AccountDAO;
import model.Account;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author admin
 */
public class AuthTest {

    private static AccountDAO accountDAO;

    public AuthTest() {
    }

    @BeforeClass
    public static void setUpClass() {
        accountDAO = new AccountDAO();
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

    @Test
    public void testFindUserByUsername_WhenUsernameIsBlank_ShouldReturnNull() {

        Account testAccount = new Account();
        testAccount.setUsername("");

        Account account = accountDAO.findUserByUsername(testAccount);

        assertNull(account);
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenUsernameAndPasswordIsTrue_ShouldReturnTrueAccount() {
        Account testAccount = new Account();
        testAccount.setUsername("buiminhtuan");
        testAccount.setPassword("123456@Bcdej");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNotNull(resultAccount);
        assertEquals(testAccount.getUsername(), resultAccount.getUsername());
        assertEquals(testAccount.getPassword(), resultAccount.getPassword());
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenUsernameIsWrong_ShouldReturnNull() {
        Account testAccount = new Account();
        testAccount.setUsername("buiminhtuan12345");
        testAccount.setPassword("123456@Bcdej");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNull(resultAccount);
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenAccountNotExists_ShouldReturnNull() {
        Account testAccount = new Account();
        testAccount.setUsername("NotExistUsername");
        testAccount.setPassword("123456@Bcdej");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNull(resultAccount);
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenPasswordIsWrong_ShouldReturnNull() {
        Account testAccount = new Account();
        testAccount.setUsername("buiminhtuan");
        testAccount.setPassword("sai_mat_khau_123");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNull(resultAccount);
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenPasswordIsEmpty_ShouldReturnNull() {
        Account testAccount = new Account();
        testAccount.setUsername("buiminhtuan"); // username tồn tại
        testAccount.setPassword("");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNull(resultAccount);
    }

    @Test
    public void testFindUserByUsernameAndPassword_WhenUsernameAndPasswordAreEmpty_ShouldReturnNull() {
        Account testAccount = new Account();
        testAccount.setUsername("");
        testAccount.setPassword("");

        Account resultAccount = accountDAO.findUserByUsernameAndPassword(testAccount);

        assertNull(resultAccount);
    }
}
