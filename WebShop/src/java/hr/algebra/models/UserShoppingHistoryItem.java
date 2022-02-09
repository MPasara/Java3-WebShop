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
public class UserShoppingHistoryItem {
    
    private int billId;
    private LocalDateTime dateOdPurchase;
    private String paymentMethod;
    private double total;
    private int appUserId;
    private int itemId;

    public UserShoppingHistoryItem(int billId, LocalDateTime dateOdPurchase, String paymentMethod, double total, int appUserId, int itemId) {
        this.billId = billId;
        this.dateOdPurchase = dateOdPurchase;
        this.paymentMethod = paymentMethod;
        this.total = total;
        this.appUserId = appUserId;
        this.itemId = itemId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public LocalDateTime getDateOdPurchase() {
        return dateOdPurchase;
    }

    public void setDateOdPurchase(LocalDateTime dateOdPurchase) {
        this.dateOdPurchase = dateOdPurchase;
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

    public int getAppUserId() {
        return appUserId;
    }

    public void setAppUserId(int appUserId) {
        this.appUserId = appUserId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    @Override
    public String toString() {
        return "UserShoppingHistory{" + "billId=" + billId + 
                ", dateOdPurchase=" + dateOdPurchase + ", paymentMethod=" + 
                paymentMethod + ", total=" + total + ", appUserId=" + 
                appUserId + ", itemId=" + itemId + '}';
    }
    
    
}
