/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.FavourJobPosting;

/**
 *
 * @author vanct
 */
public class FavourJobPostingDAO extends GenericDAO<FavourJobPosting> {

    @Override
    public List<FavourJobPosting> findAll() {
        return queryGenericDAO(FavourJobPosting.class);
    }

    @Override
    public int insert(FavourJobPosting t) {
        String sql = "INSERT INTO FavourJobPosting(CandidateID, JobPostingID) VALUES (?, ?)";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", t.getCandidateID());
        parameterMap.put("JobPostingID", t.getJobPostingID());
        
        return insertGenericDAO(sql, parameterMap);
    }
    
    //Danh sach JobPosting ua thich của jobSeeker
    public List<FavourJobPosting> getAllJobPostingsByCandidate(int jobSeekerID) {
        String sql = "SELECT * FROM FavourJobPosting WHERE CandidateID = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", jobSeekerID);
        return queryGenericDAO(FavourJobPosting.class, sql, parameterMap);
    }
    public boolean getJobPostingsByCandidate(int jobSeekerID, int jobPostingID) {
        String sql = "SELECT * FROM FavourJobPosting WHERE CandidateID = ? AND JobPostingID = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", jobSeekerID);
        parameterMap.put("JobPostingID", jobPostingID);
        return !queryGenericDAO(FavourJobPosting.class, sql, parameterMap).isEmpty();
    }
    
    //Xoa JobPosting
    public void deleteJobPosting(int FavourJPID) {
        String sql = "DELETE FROM FavourJobPosting WHERE FavourJPID = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("FavourJPID", FavourJPID);
        deleteGenericDAO(sql, parameterMap);
    }
    
    public int countTotalFavourJPsByJSID(int jobSeekerID) {
        String sql = "SELECT count(*) FROM [dbo].[FavourJobPosting] WHERE CandidateID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", jobSeekerID);
        return findTotalRecordGenericDAO(FavourJobPosting.class, sql, parameterMap);
    }
    
    public List<FavourJobPosting> getAllJobPostingsByCandidate(int id, int page, int pageSize) {
        String sql = "select * from FavourJobPosting where CandidateID = ? ORDER BY FavourJPID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("CandidateID", id);
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(FavourJobPosting.class, sql, parameterMap);
    }
    
    public FavourJobPosting findExistFavourJP(int jobSeekerID, int jobPostingID) {
        String sql = "SELECT * FROM FavourJobPosting WHERE CandidateID = ? AND  JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", jobSeekerID);
        parameterMap.put("JobPostingID", jobPostingID);
        List<FavourJobPosting> list = queryGenericDAO(FavourJobPosting.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
}
