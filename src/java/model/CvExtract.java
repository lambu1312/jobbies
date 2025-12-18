package model;

public class CvExtract {
    private boolean isCv;
    private double confidence;
    private String message;

    private String fullName;
    private String email;
    private String phone;
    private String dob;
    private String jobTitle;
    private String address;

    public boolean isCv() { return isCv; }
    public void setCv(boolean cv) { isCv = cv; }

    public double getConfidence() { return confidence; }
    public void setConfidence(double confidence) { this.confidence = confidence; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
