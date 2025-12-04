package dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Scanner;
import model.Candidates;

/**
 * DAO for Candidates
 */
public class CandidateDAO extends GenericDAO<Candidates> {

    @Override
    public List<Candidates> findAll() {
        return queryGenericDAO(Candidates.class);
    }

    // Insert a new Job Seeker
    @Override
    public int insert(Candidates t) {
        String sql = "INSERT INTO [dbo].[Candidates] ([AccountID]) VALUES (?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", t.getAccountID());
        return insertGenericDAO(sql, parameterMap);
    }

    // Find Candidate by AccountID
    public Candidates findCandidateIDByAccountID(String accountID) {
        String sql = "SELECT * FROM [dbo].[Candidates] WHERE AccountID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", accountID);

        List<Candidates> list = queryGenericDAO(Candidates.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);  // Return first result if found, else null
    }
    
    public Candidates findCandidateIDByCandidateID(String CandidateID) {
        String sql = "SELECT * FROM [dbo].[Candidates] WHERE CandidateID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", CandidateID);

        List<Candidates> list = queryGenericDAO(Candidates.class, sql, parameterMap);
        AccountDAO accountDao = new AccountDAO();
        if(!list.isEmpty()) {
            list.get(0).setAccount(accountDao.findUserById(list.get(0).getAccountID()));
        }
        return list.isEmpty() ? null : list.get(0);  
    }

    public static void main(String[] args) {
        // Test findCandidateByAccountID method
        CandidateDAO dao = new CandidateDAO();
        Scanner sc = new Scanner(System.in);
        String accountIDStr = sc.nextLine();
        Candidates jobSeeker = dao.findCandidateIDByAccountID(accountIDStr);
        if (jobSeeker != null) {
            System.out.println("Job Seeker ID: " + jobSeeker.getCandidateID());
        } else {
            System.out.println("No Job Seeker found with AccountID" + accountIDStr);
        }
    }
}
