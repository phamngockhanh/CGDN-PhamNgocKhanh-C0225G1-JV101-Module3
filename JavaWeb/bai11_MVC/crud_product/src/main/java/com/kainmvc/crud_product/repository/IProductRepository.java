package com.kainmvc.crud_product.repository;

import com.kainmvc.crud_product.entity.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();
    List<Product> findAllWithPagination(int offSet, int pageSize);
    boolean add(Product product);
    boolean update(Product product);
    boolean delete(int id);
    List<Product> findByName(String name);
    Product getProductById(int id);
    int countProduct();
    List<Product> search(String productName, int id, int offSet, int pageSize);
    int countProductWithFilter(String computerNameSeach, int idSearch);
}
