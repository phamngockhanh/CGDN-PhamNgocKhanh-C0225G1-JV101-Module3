package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();
    boolean add(Product product);
    boolean update(Product product);
    boolean delete(int id);
    List<Product> findByName(String name);
    Product getProductById(int id);
    List<Product> findAllWithPagination(int offSet, int pageSize);
    int countProduct();
}
