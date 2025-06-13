package com.kainmvc.quanlyheo.repository;

import com.kainmvc.quanlyheo.entity.Pig;
import com.kainmvc.quanlyheo.utils.ConnectionDBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PigRepo implements IPigRepo{
    private static String SELECT_ALL_PIG_NO_FILTER = "SELECT * FROM pigs";
    private static String DELETE = "DELETE FROM pigs where pig_id = ?";
    private static String UPDATE_PIG = "update pigs set time_in = ?, time_out = ?, weight_in =?, weitht_out =?, manufacture = ?,status = ? where pig_id =? ;";
    private static String GET_PIG_BY_ID = "select * from pigs where pig_id = ?";
    private static String SEARCH = "SELECT * FROM pigs WHERE (pig_id LIKE CONCAT('%', ?, '%') OR ? = '') AND (manufacture = ? OR ? = 0) AND (status = ?  OR ? = -1) ";

    @Override
    public List<Pig> findAll() {
        List<Pig> pigs = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PIG_NO_FILTER)){

            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                String id  = resultSet.getString("pig_id");
                String timeIn  = resultSet.getString("time_in");
                String timeOut  = resultSet.getString("time_out");
                double weightIn  = resultSet.getDouble("weight_in");
                double weithtOut  = resultSet.getInt("weitht_out");
                int manufacturer  = resultSet.getInt("manufacture");
                boolean status  = resultSet.getBoolean("status");
                Pig pig = new Pig(id,timeIn,timeOut,weightIn,weithtOut,manufacturer,status);
                pigs.add(pig);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pigs;
    }

    @Override
    public boolean delete(String id) {
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE)){
            preparedStatement.setString(1,id);
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }


    public List<Pig> search(String pigId, int idManu, int statusPig){
        List<Pig> pigs = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(SEARCH)){
            preparedStatement.setString(1, pigId);
            preparedStatement.setString(2, pigId);
            preparedStatement.setInt(3, idManu);
            preparedStatement.setInt(4, idManu);
            preparedStatement.setInt(5, statusPig);
            preparedStatement.setInt(6, statusPig);
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                String id  = resultSet.getString("pig_id");
                String timeIn  = resultSet.getString("time_in");
                String timeOut  = resultSet.getString("time_out");
                double weightIn  = resultSet.getDouble("weight_in");
                double weithtOut  = resultSet.getInt("weitht_out");
                int manufacturer  = resultSet.getInt("manufacture");
                boolean status  = resultSet.getBoolean("status");
                Pig pig = new Pig(id,timeIn,timeOut,weightIn,weithtOut,manufacturer,status);
                pigs.add(pig);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pigs;
    }

    @Override
    public boolean update(Pig pig) {
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PIG)){
            preparedStatement.setString(1,pig.getTimeIn());
            preparedStatement.setString(2,pig.getTimeOut());
            preparedStatement.setDouble(3, pig.getWeightIn());
            preparedStatement.setDouble(4,pig.getWeightOut());
            preparedStatement.setInt(5,pig.getManufactureId());
            preparedStatement.setBoolean(6,pig.isStatus());
            preparedStatement.setString(7,pig.getId());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Pig getPigById(String id) {
        Pig pig = new Pig();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(GET_PIG_BY_ID)){
            preparedStatement.setString(1,id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                pig.setId(resultSet.getString("pig_id"));
                pig.setTimeIn(resultSet.getString("time_in"));
                pig.setTimeOut(resultSet.getString("time_out"));
                pig.setWeightIn(resultSet.getDouble("weight_in"));
                pig.setWeightOut(resultSet.getDouble("weitht_out"));
                pig.setManufactureId(resultSet.getInt("manufacture"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pig;
    }

    @Override
    public List<Pig> search2(String pigId, int idManu, int statusPig, int limit) {
        String search2 = "SELECT * FROM pigs WHERE (pig_id LIKE CONCAT('%', ?, '%') OR ? = '') AND (manufacture = ? OR ? = 0) AND (status = ?  OR ? = -1) ";
        if(limit > 0){
            search2 += " limit ?;";
        }
        List<Pig> pigs = new ArrayList<>();
        try(Connection connection = ConnectionDBUtil.getConnectDB();
            PreparedStatement preparedStatement = connection.prepareStatement(search2)){
            preparedStatement.setString(1, pigId);
            preparedStatement.setString(2, pigId);
            preparedStatement.setInt(3, idManu);
            preparedStatement.setInt(4, idManu);
            preparedStatement.setInt(5, statusPig);
            preparedStatement.setInt(6, statusPig);
            if (limit > 0){
                preparedStatement.setInt(7, limit);
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                String id  = resultSet.getString("pig_id");
                String timeIn  = resultSet.getString("time_in");
                String timeOut  = resultSet.getString("time_out");
                double weightIn  = resultSet.getDouble("weight_in");
                double weithtOut  = resultSet.getInt("weitht_out");
                int manufacturer  = resultSet.getInt("manufacture");
                boolean status  = resultSet.getBoolean("status");
                Pig pig = new Pig(id,timeIn,timeOut,weightIn,weithtOut,manufacturer,status);
                pigs.add(pig);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return pigs;
    }
}
