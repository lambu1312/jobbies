/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author vanct
 */
public class Applications {

    private int ApplicationID;
    private int JobPostingID;
    private int CandidateID;
    private int CVID;
    private int Status;
    private Date AppliedDate;
    private transient Candidates jobCandidate;

    public Applications() {
    }

    public Applications(int ApplicationID, int JobPostingID, int CandidateID, int CVID, int Status, Date AppliedDate) {
        this.ApplicationID = ApplicationID;
        this.JobPostingID = JobPostingID;
        this.CandidateID = CandidateID;
        this.CVID = CVID;
        this.Status = Status;
        this.AppliedDate = AppliedDate;
    }

    public int getApplicationID() {
        return ApplicationID;
    }

    public void setApplicationID(int ApplicationID) {
        this.ApplicationID = ApplicationID;
    }

    public int getJobPostingID() {
        return JobPostingID;
    }

    public void setJobPostingID(int JobPostingID) {
        this.JobPostingID = JobPostingID;
    }

    public int getCandidateID() {
        return CandidateID;
    }

    public void setCandidateID(int CandidateID) {
        this.CandidateID = CandidateID;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public Date getAppliedDate() {
        return AppliedDate;
    }

    public void setAppliedDate(Date AppliedDate) {
        this.AppliedDate = AppliedDate;
    }

    public Candidates getCandidate() {
        return jobCandidate;
    }

    public void setCandidate(Candidates jobCandidate) {
        this.jobCandidate = jobCandidate;
    }
    

}
