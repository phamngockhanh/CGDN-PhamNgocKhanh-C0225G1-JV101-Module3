package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Product;
import com.kainmvc.crud_product.repository.IProductRepository;
import com.kainmvc.crud_product.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService{
    private static IProductRepository iProductRepository = new ProductRepository();
    @Override
    public List<Product> findAll() {
        return iProductRepository.findAll();
    }

    @Override
    public void add(Product product) {
        iProductRepository.add(product);
    }

    @Override
    public void update(Product product) {
        iProductRepository.update(product);
    }

    @Override
    public void delete(int id) {
        iProductRepository.delete(id);
    }

    @Override
    public List<Product> findByName(String name) {
        return iProductRepository.findByName(name);
    }

    @Override
    public Product getProductById(int id) {
        return iProductRepository.getProductById(id);
    }
}
