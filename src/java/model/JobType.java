/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.logging.Logger;

/**
 *
 * @author Thanh nam
 */
public class JobType {
    private int JobTypeID;
    private String JobTypeName;

    public JobType() {
    }

    public JobType(int JobTypeID, String JobTypeName) {
        this.JobTypeID = JobTypeID;
        this.JobTypeName = JobTypeName;
    }

    public int getJobTypeID() {
        return JobTypeID;
    }

    public void setJobTypeID(int JobTypeID) {
        this.JobTypeID = JobTypeID;
    }

    public String getJobTypeName() {
        return JobTypeName;
    }

    public void setJobTypeName(String JobTypeName) {
        this.JobTypeName = JobTypeName;
    }
    
   
}
