package com.kainmvc.quanlyheo.repository;

import com.kainmvc.quanlyheo.entity.Pig;

import java.util.List;

public interface IRepo<T> {
    List<T> findAll();
    boolean delete(String id);
    List<T> search(String pigId, int idManu,int status);
    boolean update(Pig pig);
}
