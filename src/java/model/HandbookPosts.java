package model;

import java.util.Date;

public class HandbookPosts {

    private int HandbookPostID;
    private String Title;
    private String Content;
    private String Thumbnail;
    private String Status;
    private Date CreatedAt;
    private Date UpdatedAt;

    public HandbookPosts() {
    }

    public HandbookPosts(int HandbookPostID, String Title, String Content, String Thumbnail, String Status, Date CreatedAt, Date UpdatedAt) {
        this.HandbookPostID = HandbookPostID;
        this.Title = Title;
        this.Content = Content;
        this.Thumbnail = Thumbnail;
        this.Status = Status;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }

    public int getHandbookPostID() {
        return HandbookPostID;
    }

    public void setHandbookPostID(int HandbookPostID) {
        this.HandbookPostID = HandbookPostID;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public String getThumbnail() {
        return Thumbnail;
    }

    public void setThumbnail(String Thumbnail) {
        this.Thumbnail = Thumbnail;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Date getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Date CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public Date getUpdatedAt() {
        return UpdatedAt;
    }

    public void setUpdatedAt(Date UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }
}
