package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Category;

import java.util.List;

public interface ICategoryService {
    List<Category> findAll();

}
