package com.kainmvc.crud_product.repository;

import com.kainmvc.crud_product.entity.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository{
    private static List<Product> products = new ArrayList<>();

    static{
        products.add(new Product(1,"Logitech",146,"Vĩnh wibu","binhdaden"));
        products.add(new Product(2,"Asus",146,"Vĩnh wibu","binhdaden"));
        products.add(new Product(3,"Apple",146,"Vĩnh wibu","binhdaden"));
        products.add(new Product(4,"Big mouse",146,"Vĩnh wibu","binhdaden"));
        products.add(new Product(5,"Razer",146,"Vĩnh wibu","binhdaden"));
    }

    @Override
    public List<Product> findAll() {
        return products;
    }

    @Override
    public void add(Product product) {
        products.add(product);
    }

    @Override
    public void update(Product product) {
        for (int i = 0; i<products.size();i++){
            if(product.getId()==products.get(i).getId()){
                products.set(i,product);
            }
        }
    }

    @Override
    public void delete(int id) {
        for(int i = 0;i<products.size();i++){
            if(products.get(i).getId()==id){
                products.remove(products.get(i));
            }
        }
    }

    @Override
    public List<Product> findByName(String name) {
        List <Product> listByName = new ArrayList<>();
        for (Product product : products) {
            if (product.getNameProduct().contains(name)) {
                listByName.add(product);
            }
        }
        return listByName;
    }

    @Override
    public Product getProductById(int id) {
        Product product = new Product();
        for (Product value : products) {
            if (value.getId() == id) {
                product = value;
            }
        }
        return product;
    }


}
