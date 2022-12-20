package com.example.e_news.models;

import com.example.e_news.beans.User;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

public class UserModel {

    public static void add(User c){
        String insertSql = "INSERT INTO users (username, password, name, email, dob, role, pen_name, issue_at, expriration) VALUES (:username,:password,:name,:email,:dob,:role,:pen_name,:issue_at,:expriration)\n";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("username", c.getUsername())
                    .addParameter("password", c.getPassword())
                    .addParameter("name", c.getName())
                    .addParameter("email", c.getEmail())
                    .addParameter("dob", c.getDob())
                    .addParameter("role", c.getRole())
                    .addParameter("pen_name", c.getPen_name())
                    .addParameter("issue_at", c.getIssue_at())
                    .addParameter("expriration", c.getExpriration())
                    .executeUpdate();
        }
    }

}
