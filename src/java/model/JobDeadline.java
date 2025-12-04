/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Thanh nam
 */
public class JobDeadline {
    private int deadlineID;
    private String deadlineName;

    public JobDeadline() {}

    public JobDeadline(int deadlineID, String deadlineName) {
        this.deadlineID = deadlineID;
        this.deadlineName = deadlineName;
    }

    public int getDeadlineID() {
        return deadlineID;
    }

    public void setDeadlineID(int deadlineID) {
        this.deadlineID = deadlineID;
    }

    public String getDeadlineName() {
        return deadlineName;
    }

    public void setDeadlineName(String deadlineName) {
        this.deadlineName = deadlineName;
    }
}

