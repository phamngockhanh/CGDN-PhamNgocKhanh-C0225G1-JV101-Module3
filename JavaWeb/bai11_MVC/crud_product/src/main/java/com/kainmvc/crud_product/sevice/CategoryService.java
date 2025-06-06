package com.kainmvc.crud_product.sevice;


import com.kainmvc.crud_product.entity.Category;
import com.kainmvc.crud_product.repository.CategoryRepository;
import com.kainmvc.crud_product.repository.ICategoryRepository;

import java.util.List;

public class CategoryService implements ICategoryService{
    private static ICategoryRepository iCategoryRepository = new CategoryRepository() ;
    @Override
    public List<Category> findAll() {
        return iCategoryRepository.findAll();
    }
}
