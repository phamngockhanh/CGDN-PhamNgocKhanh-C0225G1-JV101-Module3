package com.kainmvc.quanlyheo.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/quan_ly_heo";
    private static final String USER = "root";
    private static final String PASS = "codegym";

    public static Connection getConnectDB(){
        Connection connection = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection= DriverManager.getConnection(URL,USER,PASS);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

}
