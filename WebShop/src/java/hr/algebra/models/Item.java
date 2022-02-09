/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.models;

import java.util.Arrays;
import java.util.Objects;

/**
 *
 * @author Mladen
 */
public class Item {

    private int id;
    private String itemName;
    private String itemDescription;
    private double price;
    private int availableAmount;
    private byte[] itemImage;
    private int categoryId;

    public Item(int id, String itemName, String itemDescription, double price, int availableAmount, byte[] itemImage, int categoryId) {
        this.id = id;
        this.itemName = itemName;
        this.itemDescription = itemDescription;
        this.price = price;
        this.availableAmount = availableAmount;
        this.itemImage = itemImage;
        this.categoryId = categoryId;
    }

    public Item() {
    }

    public Item(String itemName, String itemDescription, double price, int availableAmount, byte[] itemImage, int categoryId) {
        this.itemName = itemName;
        this.itemDescription = itemDescription;
        this.price = price;
        this.availableAmount = availableAmount;
        this.itemImage = itemImage;
        this.categoryId = categoryId;
    }

    public int getId() {
        return id;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemDescription() {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAvailableAmount() {
        return availableAmount;
    }

    public void setAvailableAmount(int availableAmount) {
        this.availableAmount = availableAmount;
    }

    public byte[] getItemImage() {
        return itemImage;
    }

    public void setItemImage(byte[] itemImage) {
        this.itemImage = itemImage;
    }

    public int getCategory() {
        return categoryId;
    }

    public void setCategory(int categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return id + itemName;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + this.id;
        hash = 97 * hash + Objects.hashCode(this.itemName);
        hash = 97 * hash + Objects.hashCode(this.itemDescription);
        hash = 97 * hash + (int) (Double.doubleToLongBits(this.price) ^ (Double.doubleToLongBits(this.price) >>> 32));
        hash = 97 * hash + this.availableAmount;
        hash = 97 * hash + Arrays.hashCode(this.itemImage);
        hash = 97 * hash + this.categoryId;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Item other = (Item) obj;
        if (this.id != other.id) {
            return false;
        }
        if (Double.doubleToLongBits(this.price) != Double.doubleToLongBits(other.price)) {
            return false;
        }
        if (this.availableAmount != other.availableAmount) {
            return false;
        }
        if (this.categoryId != other.categoryId) {
            return false;
        }
        if (!Objects.equals(this.itemName, other.itemName)) {
            return false;
        }
        if (!Objects.equals(this.itemDescription, other.itemDescription)) {
            return false;
        }
        if (!Arrays.equals(this.itemImage, other.itemImage)) {
            return false;
        }
        return true;
    }

}
