package com.kainmvc.quanlyheo.service;

import com.kainmvc.quanlyheo.entity.Pig;

import java.util.List;

public interface IPigService extends IService<Pig>{
    Pig getPigById(String id);
    List<Pig> search2(String pigId, int idManu, int status, int limit);
}
