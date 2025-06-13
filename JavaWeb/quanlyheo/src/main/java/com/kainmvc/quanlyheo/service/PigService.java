package com.kainmvc.quanlyheo.service;

import com.kainmvc.quanlyheo.entity.Pig;
import com.kainmvc.quanlyheo.repository.IPigRepo;
import com.kainmvc.quanlyheo.repository.PigRepo;

import java.util.List;

public class PigService implements IPigService{

    private static IPigRepo iPigRepo = new PigRepo();

    @Override
    public boolean delete(String id) {
        return iPigRepo.delete(id);
    }

    @Override
    public List<Pig> search(String pigId, int idManu, int status) {
        return iPigRepo.search(pigId, idManu,status);
    }

    @Override
    public List<Pig> findAll() {
        return iPigRepo.findAll();
    }

    @Override
    public boolean update(Pig pig) {
        return iPigRepo.update(pig);
    }

    @Override
    public Pig getPigById(String id) {
        return iPigRepo.getPigById(id);
    }

    @Override
    public List<Pig> search2(String pigId, int idManu, int status, int limit) {
        return iPigRepo.search2(pigId,idManu,status,limit);
    }
}
