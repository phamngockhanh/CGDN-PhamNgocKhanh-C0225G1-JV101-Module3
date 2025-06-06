package com.kainmvc.crud_product.repository;

import com.kainmvc.crud_product.entity.Category;

import java.util.List;

public interface ICategoryRepository {
    List<Category> findAll();
}
