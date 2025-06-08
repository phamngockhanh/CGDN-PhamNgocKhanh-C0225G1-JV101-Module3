package com.kainmvc.crud_product.repository;

import com.kainmvc.crud_product.entity.Product;
import com.kainmvc.crud_product.utils.ConnectionDBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository{
    private static final String SELECT_PRODUCT = "select * from computers;";
    private static final String SELECT_PRODUCT_PAGINATION = "SELECT * FROM computers ORDER BY id LIMIT ? OFFSET ?;";
    private static final String ADD_NEW_PRODUCT = "insert into computers(computer_name,release_year,price,quantity,manufacturer,status,id_category) values(?,?,?,?,?,?,?);";
    private static final String DELETE_PRODUCT = "delete from computers where id = ?;";
    private static final String UPDATE_PRODUCT = "update computers set computer_name = ?, release_year=?,price = ?, quantity = ?, manufacturer = ?, status = ?, id_category=? where id = ?;";
    private static final String SELECT_PRODUCT_BY_ID = "select * from computers where id = ?;";
    private static final String COUNT_PRODUCT = "select count(*) from computers;";
    private static final String SEARCH= "SELECT * FROM computers WHERE (computer_name LIKE CONCAT('%', ?, '%') OR ? = '') AND (id_category = ? OR ? = 0) LIMIT ?,?;";
    private static final String COUNT_PRODUCT_WITH_FILTER= "SELECT COUNT(*) FROM computers WHERE (computer_name LIKE CONCAT('%', ?, '%') OR ? = '') AND (id_category = ? OR ? = 0)";
    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT);){
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                int id  = resultSet.getInt("id");
                String computerName  = resultSet.getString("computer_name");
                int releaseYear  = resultSet.getInt("release_year");
                double price  = resultSet.getDouble("price");
                int quantity  = resultSet.getInt("quantity");
                String manufacturer  = resultSet.getString("manufacturer");
                boolean status  = resultSet.getBoolean("status");
                int categoryId  = resultSet.getInt("id_category");
                Product product = new Product(id,computerName,releaseYear,price,quantity,manufacturer,status,categoryId);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }
    public List<Product> findAllWithPagination(int offSet, int pageSize){
        List<Product> products = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_PAGINATION);){
            preparedStatement.setInt(1, pageSize);
            preparedStatement.setInt(2, offSet);
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                int id  = resultSet.getInt("id");
                String computerName  = resultSet.getString("computer_name");
                int releaseYear  = resultSet.getInt("release_year");
                double price  = resultSet.getDouble("price");
                int quantity  = resultSet.getInt("quantity");
                String manufacturer  = resultSet.getString("manufacturer");
                boolean status  = resultSet.getBoolean("status");
                int categoryId  = resultSet.getInt("id_category");
                Product product = new Product(id,computerName,releaseYear,price,quantity,manufacturer,status,categoryId);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }
    @Override
    public boolean add(Product product) {
        try(Connection connection  = ConnectionDBUtil.getConnectDB();
        PreparedStatement preparedStatement = connection.prepareStatement(ADD_NEW_PRODUCT)){
            preparedStatement.setString(1,product.getComputerName());
            preparedStatement.setInt(2,product.getReleaseYear());
            preparedStatement.setDouble(3,product.getPrice());
            preparedStatement.setInt(4,product.getQuantity());
            preparedStatement.setString(5,product.getManufacturer());
            preparedStatement.setBoolean(6,product.isStatus());
            preparedStatement.setInt(7,product.getCategoryId());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            System.out.println("Lỗi thêm dữ liệu");
        }
        return false;
    }

    @Override
    public boolean update(Product product) {
        try(Connection connection = ConnectionDBUtil.getConnectDB();
        PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT)){
            preparedStatement.setString(1,product.getComputerName());
            preparedStatement.setInt(2,product.getReleaseYear());
            preparedStatement.setDouble(3,product.getPrice());
            preparedStatement.setInt(4,product.getQuantity());
            preparedStatement.setString(5,product.getManufacturer());
            preparedStatement.setBoolean(6,product.isStatus());
            preparedStatement.setInt(7,product.getCategoryId());
            preparedStatement.setInt(8,product.getId());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        try(Connection connection = ConnectionDBUtil.getConnectDB();
        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT)){
            preparedStatement.setInt(1,id);
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Product> findByName(String name) {
        return null;
    }

    @Override
    public Product getProductById(int id) {
        Product product = new Product();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)){
            preparedStatement.setInt(1,id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                product.setId(resultSet.getInt("id"));
                product.setComputerName(resultSet.getString("computer_name"));
                product.setReleaseYear(resultSet.getInt("release_year"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setManufacturer(resultSet.getString("manufacturer"));
                product.setStatus(resultSet.getBoolean("status"));
                product.setCategoryId(resultSet.getInt("id_category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    @Override
    public int countProduct()  {
        int totalRecords = 0;
        try(Connection connection= ConnectionDBUtil.getConnectDB();
        PreparedStatement preparedStatement = connection.prepareStatement(COUNT_PRODUCT)){
            ResultSet resultSet = preparedStatement.executeQuery();
                if(resultSet.next()){
                    totalRecords = resultSet.getInt(1);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecords;
    }


    @Override
    public int countProductWithFilter(String computerNameSeach, int idSearch)  {
        int totalRecords = 0;
        try(Connection connection= ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(COUNT_PRODUCT_WITH_FILTER)){
            preparedStatement.setString(1, computerNameSeach);
            preparedStatement.setString(2, computerNameSeach);
            preparedStatement.setInt(3, idSearch);
            preparedStatement.setInt(4, idSearch);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                totalRecords = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecords;
    }
    public List<Product> search(String computerNameSeach, int idSearch,int offset,int pageSize){
        List<Product> products = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SEARCH)){
            preparedStatement.setString(1, computerNameSeach);
            preparedStatement.setString(2, computerNameSeach);
            preparedStatement.setInt(3, idSearch);
            preparedStatement.setInt(4, idSearch);
            preparedStatement.setInt(5, offset);
            preparedStatement.setInt(6, pageSize);
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                int id  = resultSet.getInt("id");
                String computerName  = resultSet.getString("computer_name");
                int releaseYear  = resultSet.getInt("release_year");
                double price  = resultSet.getDouble("price");
                int quantity  = resultSet.getInt("quantity");
                String manufacturer  = resultSet.getString("manufacturer");
                boolean status  = resultSet.getBoolean("status");
                int categoryId  = resultSet.getInt("id_category");
                Product product = new Product(id,computerName,releaseYear,price,quantity,manufacturer,status,categoryId);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }



}
