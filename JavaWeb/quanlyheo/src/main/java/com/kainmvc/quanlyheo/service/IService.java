package com.kainmvc.quanlyheo.service;

import com.kainmvc.quanlyheo.entity.Pig;

import java.util.List;

public interface IService<T> {
    boolean delete(String id);
    List<T> search(String pigId, int idManu, int status);
    List<T> findAll();
    boolean update(Pig pig);
}
