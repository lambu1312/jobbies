/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Thanh nam
 */
import java.sql.*;
import java.util.*;
import model.JobType;

public class JobTypeDAO extends DBContext {

    public List<JobType> getAllJobTypes() {
        List<JobType> list = new ArrayList<>();
        String sql = "SELECT JobTypeID, JobTypeName FROM JobType";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new JobType(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

