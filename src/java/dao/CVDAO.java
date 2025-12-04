/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.CV;

/**
 *
 * @author vanct
 */
public class CVDAO extends GenericDAO<CV> {

    @Override
    public List<CV> findAll() {
        return queryGenericDAO(CV.class);
    }

    //Nhap CV
    @Override
    public int insert(CV t) {
        String sql = "insert into CVs (CandidateID, FilePath, UploadDate) values (?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", t.getCandidateID());
        parameterMap.put("FilePath", t.getFilePath());
        parameterMap.put("UploadDate", t.getUploadDate());
        
        return insertGenericDAO(sql, parameterMap);
    }
    
    //Tim CV cho Job Seeker
    public CV findCVbyCandidateID(int CandidateID) {
        String sql = "select * from CVs where CVID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CandidateID", CandidateID);
        List<CV> list = queryGenericDAO(CV.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
        
    }
    
    public CV findCVbyCVID(int CVID) {
        String sql = "select * from CVs where CVID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("CVID", CVID);
        List<CV> list = queryGenericDAO(CV.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
        
    }
    
    public void updateCV(CV cv) {
        String sql = "update [CVs] set [FilePath] = ?"
                + ", [UploadDate] = ?"
                + ", [LastUpdated] = ? "
                + "WHERE [CandidateID] = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("FilePath", cv.getFilePath());
        parameterMap.put("UploadDate", cv.getUploadDate());
        parameterMap.put("LastUpdated", cv.getLastUpdated());
        parameterMap.put("CandidateID", cv.getCandidateID());
        
        updateGenericDAO(sql, parameterMap);
    }
    
    

}
