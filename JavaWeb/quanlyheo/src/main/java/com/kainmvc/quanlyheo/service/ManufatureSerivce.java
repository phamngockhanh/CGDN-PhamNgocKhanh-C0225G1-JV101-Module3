package com.kainmvc.quanlyheo.service;

import com.kainmvc.quanlyheo.entity.Manufacture;
import com.kainmvc.quanlyheo.entity.Pig;
import com.kainmvc.quanlyheo.repository.IManufactureRepo;
import com.kainmvc.quanlyheo.repository.ManufactureRepo;

import java.util.List;

public class ManufatureSerivce implements IManufactureService{
    private static IManufactureRepo manufactureRepo = new ManufactureRepo();
    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<Manufacture> search(String pigId, int idManu, int status) {
        return List.of();
    }

    @Override
    public List<Manufacture> findAll() {
        return manufactureRepo.findAll();
    }

    @Override
    public boolean update(Pig pig) {
        return false;
    }
}
