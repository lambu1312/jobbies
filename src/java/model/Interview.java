package model;

import java.sql.Timestamp;

public class Interview {
    private int interviewID;
    private int applicationID;
    private Timestamp interviewDate;
    private String interviewTime;
    private String location;
    private String interviewType; // Onsite, Online, Phone
    private String meetingLink;
    private String notes;
    private String status; // Scheduled, Rescheduled, Completed, Cancelled
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Transient field to hold application details
    private transient Applications application;

    // Constructors
    public Interview() {
    }

    public Interview(int interviewID, int applicationID, Timestamp interviewDate, String interviewTime, 
                     String location, String interviewType, String meetingLink, String notes, 
                     String status, Timestamp createdAt, Timestamp updatedAt) {
        this.interviewID = interviewID;
        this.applicationID = applicationID;
        this.interviewDate = interviewDate;
        this.interviewTime = interviewTime;
        this.location = location;
        this.interviewType = interviewType;
        this.meetingLink = meetingLink;
        this.notes = notes;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getInterviewID() {
        return interviewID;
    }

    public void setInterviewID(int interviewID) {
        this.interviewID = interviewID;
    }

    public int getApplicationID() {
        return applicationID;
    }

    public void setApplicationID(int applicationID) {
        this.applicationID = applicationID;
    }

    public Timestamp getInterviewDate() {
        return interviewDate;
    }

    public void setInterviewDate(Timestamp interviewDate) {
        this.interviewDate = interviewDate;
    }

    public String getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(String interviewTime) {
        this.interviewTime = interviewTime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getInterviewType() {
        return interviewType;
    }

    public void setInterviewType(String interviewType) {
        this.interviewType = interviewType;
    }

    public String getMeetingLink() {
        return meetingLink;
    }

    public void setMeetingLink(String meetingLink) {
        this.meetingLink = meetingLink;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Applications getApplication() {
        return application;
    }

    public void setApplication(Applications application) {
        this.application = application;
    }
}
