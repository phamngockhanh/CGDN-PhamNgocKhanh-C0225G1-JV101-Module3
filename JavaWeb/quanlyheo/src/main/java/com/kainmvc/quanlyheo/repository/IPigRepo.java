package com.kainmvc.quanlyheo.repository;

import com.kainmvc.quanlyheo.entity.Pig;

import java.util.List;

public interface IPigRepo extends IRepo<Pig>{
    Pig getPigById(String id);
    List<Pig> search2(String pigId, int idManu, int status, int limit);
}
