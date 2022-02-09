/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.models;

/**
 *
 * @author Mladen
 */
public class User {
    
    private int id;
    private String Username;
    private String Password;
    private String Address;
    private boolean isAdmin;

    public User(int id, String Username, String Password, String Address, boolean isAdmin) {
        this.id = id;
        this.Username = Username;
        this.Password = Password;
        this.Address = Address;
        this.isAdmin = isAdmin;
    }

    public User(String Username, String Password, String Address, boolean isAdmin) {
        this.Username = Username;
        this.Password = Password;
        this.Address = Address;
        this.isAdmin = isAdmin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
    
    @Override
    public String toString() {
        return Username;
    }
    
}
