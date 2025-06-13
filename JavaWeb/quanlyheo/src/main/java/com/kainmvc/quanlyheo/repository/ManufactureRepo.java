package com.kainmvc.quanlyheo.repository;

import com.kainmvc.quanlyheo.entity.Manufacture;
import com.kainmvc.quanlyheo.entity.Pig;
import com.kainmvc.quanlyheo.utils.ConnectionDBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManufactureRepo implements IManufactureRepo{
    private static String SELECT_ALL="select * from manufactures";
    @Override
    public List<Manufacture> findAll() {
        List<Manufacture> manufactures = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL)){

            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                int id  = resultSet.getInt("id");
                String name  = resultSet.getString("name");
                Manufacture manufacturer = new Manufacture(id,name);
                manufactures.add(manufacturer);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return manufactures;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<Manufacture> search(String pigId, int idManu,int status) {
        return List.of();
    }

    @Override
    public boolean update(Pig pig) {
        return false;
    }
}
