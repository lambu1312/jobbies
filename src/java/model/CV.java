
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class CV {
    private int cvId;
    private int jobSeekerId;

    private String title;
    private String templateCode;
    private boolean isDefault;

    private String summary;
    private String skills;
    private String links;

    private String filePath;
    private Timestamp uploadDate;
    private Timestamp lastUpdated;

    // getters/setters
    public int getCvId() { return cvId; }
    public void setCvId(int cvId) { this.cvId = cvId; }

    public int getJobSeekerId() { return jobSeekerId; }
    public void setJobSeekerId(int jobSeekerId) { this.jobSeekerId = jobSeekerId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getTemplateCode() { return templateCode; }
    public void setTemplateCode(String templateCode) { this.templateCode = templateCode; }

    public boolean isIsDefault() { return isDefault; }
    public void setIsDefault(boolean isDefault) { this.isDefault = isDefault; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getLinks() { return links; }
    public void setLinks(String links) { this.links = links; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public Timestamp getUploadDate() { return uploadDate; }
    public void setUploadDate(Timestamp uploadDate) { this.uploadDate = uploadDate; }

    public Timestamp getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(Timestamp lastUpdated) { this.lastUpdated = lastUpdated; }
}
