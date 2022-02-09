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
public class Bill {
    
    private int id;
    private int userId;
    private LocalDateTime dateOfPurchase;
    private String paymentMethod;
    private double total;

    public Bill() {
    }

    public Bill(int id, int userId, LocalDateTime dateOfPurchase, String paymentMethod, double total) {
        this.id = id;
        this.userId = userId;
        this.dateOfPurchase = dateOfPurchase;
        this.paymentMethod = paymentMethod;
        this.total = total;
    }

    public Bill(int userId, LocalDateTime dateOfPurchase, String paymentMethod, double total) {
        this.userId = userId;
        this.dateOfPurchase = dateOfPurchase;
        this.paymentMethod = paymentMethod;
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getDateOfPurchase() {
        return dateOfPurchase;
    }

    public void setDateOfPurchase(LocalDateTime dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    
    @Override
    public String toString() {
        return "Bill{" + "id=" + id + ", user=" + userId + ", dateOfPurchase=" + dateOfPurchase + ", paymentMethod=" + paymentMethod + ", total="+total+'}';
    }
    
}
