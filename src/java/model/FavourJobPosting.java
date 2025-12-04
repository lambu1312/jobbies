/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author vanct
 */
public class FavourJobPosting {
    private int FavourJPID;
    private int CandidateID;
    private int JobPostingID;

    public FavourJobPosting() {
    }

    public FavourJobPosting(int FavourJPID, int CandidateID, int JobPostingID) {
        this.FavourJPID = FavourJPID;
        this.CandidateID = CandidateID;
        this.JobPostingID = JobPostingID;
    }

    public int getFavourJPID() {
        return FavourJPID;
    }

    public void setFavourJPID(int FavourJPID) {
        this.FavourJPID = FavourJPID;
    }

    public int getCandidateID() {
        return CandidateID;
    }

    public void setCandidateID(int CandidateID) {
        this.CandidateID = CandidateID;
    }

    public int getJobPostingID() {
        return JobPostingID;
    }

    public void setJobPostingID(int JobPostingID) {
        this.JobPostingID = JobPostingID;
    }
    
    
}
