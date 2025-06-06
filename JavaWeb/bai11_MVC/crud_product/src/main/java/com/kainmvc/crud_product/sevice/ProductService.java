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
    public boolean add(Product product) {
       return iProductRepository.add(product);
    }

    @Override
    public boolean update(Product product) {
       return iProductRepository.update(product);
    }

    @Override
    public boolean delete(int id) {
       return iProductRepository.delete(id);
    }

    @Override
    public List<Product> findByName(String name) {
        return iProductRepository.findByName(name);
    }

    @Override
    public Product getProductById(int id) {
        return iProductRepository.getProductById(id);
    }

    @Override
    public List<Product> findAllWithPagination(int offSet, int pageSize) {
        return iProductRepository.findAllWithPagination(offSet,pageSize);
    }

    @Override
    public int countProduct() {
       return  iProductRepository.countProduct();
    }
}
