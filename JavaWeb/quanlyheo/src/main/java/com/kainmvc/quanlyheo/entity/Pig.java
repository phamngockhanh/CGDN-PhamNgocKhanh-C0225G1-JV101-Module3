package com.kainmvc.quanlyheo.entity;

public class Pig {
    private String id;
    private String timeIn;
    private String timeOut;
    private double weightIn;
    private double weightOut;
    private int manufactureId;
    private boolean status;

    public Pig() {
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Pig(String id, String timeIn, String timeOut, double weightIn, double weightOut, int manufactureId, boolean status) {
        this.id = id;
        this.timeIn = timeIn;
        this.timeOut = timeOut;
        this.weightIn = weightIn;
        this.weightOut = weightOut;
        this.manufactureId = manufactureId;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTimeIn() {
        return timeIn;
    }

    public void setTimeIn(String timeIn) {
        this.timeIn = timeIn;
    }

    public String getTimeOut() {
        return timeOut;
    }

    public void setTimeOut(String timeOut) {
        this.timeOut = timeOut;
    }

    public double getWeightIn() {
        return weightIn;
    }

    public void setWeightIn(double weightIn) {
        this.weightIn = weightIn;
    }

    public double getWeightOut() {
        return weightOut;
    }

    public void setWeightOut(double weightOut) {
        this.weightOut = weightOut;
    }

    public int getManufactureId() {
        return manufactureId;
    }

    public void setManufactureId(int manufactureId) {
        this.manufactureId = manufactureId;
    }
}
