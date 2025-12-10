package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Interview;

public class InterviewDAO extends DBContext {
    
    // Create new interview
    public boolean createInterview(Interview interview) {
        String sql = "INSERT INTO [Interviews] ([ApplicationID], [InterviewDate], [InterviewTime], " +
                     "[Location], [InterviewType], [MeetingLink], [Notes], [Status]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, interview.getApplicationID());
            ps.setTimestamp(2, interview.getInterviewDate());
            ps.setString(3, interview.getInterviewTime());
            ps.setString(4, interview.getLocation());
            ps.setString(5, interview.getInterviewType());
            ps.setString(6, interview.getMeetingLink());
            ps.setString(7, interview.getNotes());
            ps.setString(8, interview.getStatus() != null ? interview.getStatus() : "Scheduled");
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating interview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get interview by ID
    public Interview getInterviewById(int interviewId) {
        String sql = "SELECT * FROM [Interviews] WHERE [InterviewID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return extractInterviewFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting interview by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Get interview by application ID
    public Interview getInterviewByApplicationId(int applicationId) {
        String sql = "SELECT * FROM [Interviews] WHERE [ApplicationID] = ? ORDER BY [CreatedAt] DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return extractInterviewFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting interview by application ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all interviews for a job posting
    public List<Interview> getInterviewsByJobPostingId(int jobPostingId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT i.* FROM [Interviews] i " +
                     "INNER JOIN [Applications] a ON i.[ApplicationID] = a.[ApplicationID] " +
                     "WHERE a.[JobPostingID] = ? ORDER BY i.[InterviewDate] DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobPostingId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                interviews.add(extractInterviewFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting interviews by job posting ID: " + e.getMessage());
            e.printStackTrace();
        }
        return interviews;
    }
    
    // Update interview
    public boolean updateInterview(Interview interview) {
        String sql = "UPDATE [Interviews] SET [InterviewDate] = ?, [InterviewTime] = ?, " +
                     "[Location] = ?, [InterviewType] = ?, [MeetingLink] = ?, " +
                     "[Notes] = ?, [Status] = ?, [UpdatedAt] = GETDATE() " +
                     "WHERE [InterviewID] = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, interview.getInterviewDate());
            ps.setString(2, interview.getInterviewTime());
            ps.setString(3, interview.getLocation());
            ps.setString(4, interview.getInterviewType());
            ps.setString(5, interview.getMeetingLink());
            ps.setString(6, interview.getNotes());
            ps.setString(7, interview.getStatus());
            ps.setInt(8, interview.getInterviewID());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating interview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Update interview status
    public boolean updateInterviewStatus(int interviewId, String status) {
        String sql = "UPDATE [Interviews] SET [Status] = ?, [UpdatedAt] = GETDATE() WHERE [InterviewID] = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, interviewId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating interview status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete interview
    public boolean deleteInterview(int interviewId) {
        String sql = "DELETE FROM [Interviews] WHERE [InterviewID] = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting interview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to extract Interview object from ResultSet
    private Interview extractInterviewFromResultSet(ResultSet rs) throws SQLException {
        Interview interview = new Interview();
        interview.setInterviewID(rs.getInt("InterviewID"));
        interview.setApplicationID(rs.getInt("ApplicationID"));
        interview.setInterviewDate(rs.getTimestamp("InterviewDate"));
        interview.setInterviewTime(rs.getString("InterviewTime"));
        interview.setLocation(rs.getString("Location"));
        interview.setInterviewType(rs.getString("InterviewType"));
        interview.setMeetingLink(rs.getString("MeetingLink"));
        interview.setNotes(rs.getString("Notes"));
        interview.setStatus(rs.getString("Status"));
        interview.setCreatedAt(rs.getTimestamp("CreatedAt"));
        interview.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return interview;
    }
    
    // Check if interview exists for application
    public boolean hasInterview(int applicationId) {
        String sql = "SELECT COUNT(*) FROM [Interviews] WHERE [ApplicationID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking interview existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Check for conflicting interview times for recruiter (within 1 hour buffer)
    public boolean hasConflictingInterview(int recruiterId, Date interviewDate, String interviewTime, Integer excludeInterviewId) {
        String sql = "SELECT i.InterviewTime, i.InterviewID FROM [Interviews] i " +
                     "INNER JOIN [Applications] a ON i.ApplicationID = a.ApplicationID " +
                     "INNER JOIN [JobPostings] jp ON a.JobPostingID = jp.JobPostingID " +
                     "WHERE jp.RecruiterID = ? " +
                     "AND CAST(i.InterviewDate AS DATE) = CAST(? AS DATE) " +
                     "AND i.Status NOT IN ('Cancelled', 'Completed')";
        
        if (excludeInterviewId != null) {
            sql += " AND i.InterviewID != ?";
        }
        
        System.out.println("DEBUG - Checking conflicts for recruiterId=" + recruiterId + 
                          ", date=" + interviewDate + ", time=" + interviewTime + 
                          ", excludeId=" + excludeInterviewId);
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setDate(2, new java.sql.Date(interviewDate.getTime()));
            
            if (excludeInterviewId != null) {
                ps.setInt(3, excludeInterviewId);
            }
            
            ResultSet rs = ps.executeQuery();
            
            // Parse the new interview time (format: HH:mm)
            String[] newTimeParts = interviewTime.split(":");
            int newHour = Integer.parseInt(newTimeParts[0]);
            int newMinute = Integer.parseInt(newTimeParts[1]);
            int newTimeInMinutes = newHour * 60 + newMinute;
            
            System.out.println("DEBUG - New time in minutes: " + newTimeInMinutes);
            
            while (rs.next()) {
                String existingTime = rs.getString("InterviewTime");
                int existingInterviewId = rs.getInt("InterviewID");
                
                System.out.println("DEBUG - Found existing interview ID=" + existingInterviewId + 
                                  ", time=" + existingTime);
                
                String[] existingTimeParts = existingTime.split(":");
                int existingHour = Integer.parseInt(existingTimeParts[0]);
                int existingMinute = Integer.parseInt(existingTimeParts[1]);
                int existingTimeInMinutes = existingHour * 60 + existingMinute;
                
                // Check if within 1 hour (60 minutes) buffer
                int timeDifference = Math.abs(newTimeInMinutes - existingTimeInMinutes);
                
                System.out.println("DEBUG - Time difference: " + timeDifference + " minutes");
                
                if (timeDifference < 60) {
                    System.out.println("DEBUG - CONFLICT DETECTED!");
                    return true; // Conflict found
                }
            }
            
            System.out.println("DEBUG - No conflicts found");
        } catch (SQLException e) {
            System.err.println("Error checking conflicting interview: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error parsing time: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}

