package com.kainmvc.crud_product.entity;

public class Product {
    private int id;
    private String computerName;
    private int releaseYear;
    private double price;
    private int quantity;
    private String manufacturer;
    private boolean status;
    private int categoryId ;

    public Product() {
    }

    public Product(int id, String computerName, int releaseYear, double price, int quantity, String manufacturer, boolean status, int categoryId) {
        this.id = id;
        this.computerName = computerName;
        this.releaseYear = releaseYear;
        this.price = price;
        this.quantity = quantity;
        this.manufacturer = manufacturer;
        this.status = status;
        this.categoryId = categoryId;
    }

    public Product( String computerName, int releaseYear, double price, int quantity, String manufacturer, boolean status, int categoryId) {
        this.computerName = computerName;
        this.releaseYear = releaseYear;
        this.price = price;
        this.quantity = quantity;
        this.manufacturer = manufacturer;
        this.status = status;
        this.categoryId = categoryId;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComputerName() {
        return computerName;
    }

    public void setComputerName(String computerName) {
        this.computerName = computerName;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}
