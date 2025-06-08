package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Product;

import java.util.List;
import java.util.Map;

public interface IProductService {
    List<Product> findAll();
    Map<String, String> add(Product product);
    boolean update(Product product);
    boolean delete(int id);
    List<Product> findByName(String name);
    Product getProductById(int id);
    List<Product> findAllWithPagination(int offSet, int pageSize);
    int countProduct();
    List<Product> search(String productName, int id,int offSet, int pageSize);
    int countProductWithFilter(String computerNameSeach, int idSearch);
}
