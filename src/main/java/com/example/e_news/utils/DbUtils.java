package com.example.e_news.utils;

import org.sql2o.Connection;
import org.sql2o.Sql2o;

public class DbUtils {
    static Sql2o sql2o = new Sql2o("jdbc:mysql://localhost:3306/enews", "root", "");

    public static Connection getConnection(){
        return sql2o.open();
    }
}
