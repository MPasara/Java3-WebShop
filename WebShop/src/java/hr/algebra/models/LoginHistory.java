/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.models;

import java.time.LocalDateTime;

/**
 *
 * @author Mladen
 */
public class LoginHistory {

    private int id;
    private int userId;
    private LocalDateTime loginTime;
    private String userAddress; //IP Address

    public LoginHistory() {
    }
    
    
    public LoginHistory(int id, int userId, LocalDateTime loginTime, String userAddress) {
        this.id = id;
        this.userId = userId;
        this.loginTime = loginTime;
        this.userAddress = userAddress;
    }

    public LoginHistory(int userId, LocalDateTime loginTime, String userAddress) {
        this.userId = userId;
        this.loginTime = loginTime;
        this.userAddress = userAddress;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser() {
        return userId;
    }

    public void setUser(int user) {
        this.userId = user;
    }

    public LocalDateTime getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(LocalDateTime loginTime) {
        this.loginTime = loginTime;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    @Override
    public String toString() {
        return "user id:"+userId+" time:"+loginTime+" IP: "+userAddress;
    }
    
}
