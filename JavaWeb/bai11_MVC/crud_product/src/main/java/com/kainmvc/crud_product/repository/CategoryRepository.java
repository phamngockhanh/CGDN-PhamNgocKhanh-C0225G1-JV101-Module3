package com.kainmvc.crud_product.repository;

import com.kainmvc.crud_product.entity.Category;
import com.kainmvc.crud_product.utils.ConnectionDBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepository implements ICategoryRepository {
    public static final String SELECT_ALL ="select * from categories;";
    @Override
    public List<Category> findAll() {
        List<Category> categoryList = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL)){
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                int id = resultSet.getInt("id");
                String categoryName = resultSet.getString("category_name");
                Category category = new Category(id,categoryName);
                categoryList.add(category);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categoryList;
    }
}
