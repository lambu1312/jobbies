/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author vanct
 */
public class Candidates {
    private int CandidateID;
    private int AccountID;
    private Account account;

    public Candidates() {
    }

    public Candidates(int CandidateID, int AccountID, Account account) {
        this.CandidateID = CandidateID;
        this.AccountID = AccountID;
        this.account = account;
    }


    public int getCandidateID() {
        return CandidateID;
    }

    public void setCandidateID(int CandidateID) {
        this.CandidateID = CandidateID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
}
