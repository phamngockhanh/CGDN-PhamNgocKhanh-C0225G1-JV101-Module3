package com.kainmvc.crud_product.sevice;

import com.kainmvc.crud_product.entity.Product;
import com.kainmvc.crud_product.repository.IProductRepository;
import com.kainmvc.crud_product.repository.ProductRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductService implements IProductService{
    private static IProductRepository iProductRepository = new ProductRepository();
    @Override
    public List<Product> findAll() {
        return iProductRepository.findAll();
    }

    @Override
    public Map<String, String> add(Product product) {
        Map<String,String> error = new HashMap<>();
        if(!product.getComputerName().matches("^[A-Z][a-zA-Z0-9\\s]{1,49}$")){
            error.put("computerName","Vui lòng nhập đúng định dạng. VD: May tinh 1");
        }
        if(!product.getManufacturer().matches("^[A-Z][a-zA-Z0-9\\s]{1,49}$")){
            error.put("manufacturer","Vui lòng nhập đúng định dạng. VD: Jage Hugeman");
        }
        if(product.getPrice()<=0){
            error.put("price","Giá phải lớn hơn 0");
        }
        if(product.getQuantity()<0){
            error.put("quantity","Số lượng phải lớn hơn hoặc bằng 0");
        }
        if(product.getReleaseYear()<1900||product.getReleaseYear()>2025){
            error.put("year","Năm sản xuất phải nằm trong khoảng từ 1900 đến 2025");
        }
        if(product.getCategoryId()==0){
            error.put("categoryId","Vui lòng chọn loại hàng");
        }

        if(error.isEmpty()){
            iProductRepository.add(product);
        }
       return error;
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

    @Override
    public List<Product> search(String productName, int id,int offSet, int pageSize) {
        return iProductRepository.search( productName, id,offSet,pageSize);
    }

    @Override
    public int countProductWithFilter(String computerNameSeach, int idSearch) {
        return iProductRepository.countProductWithFilter(computerNameSeach,idSearch);
    }
}
