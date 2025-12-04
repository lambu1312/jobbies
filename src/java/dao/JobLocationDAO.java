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
import model.JobLocation;

public class JobLocationDAO extends DBContext {

    public List<JobLocation> getAllLocations() {
        List<JobLocation> list = new ArrayList<>();
        String sql = "SELECT LocationID, LocationName FROM JobLocation";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new JobLocation(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

