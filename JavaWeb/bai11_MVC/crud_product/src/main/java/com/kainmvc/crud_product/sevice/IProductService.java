package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();
    void add(Product product);
    void update(Product product);
    void delete(int id);
    List<Product> findByName(String name);
    Product getProductById(int id);
}
