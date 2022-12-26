package com.example.e_news.models;

import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class UserModel {

    public static List<User> findByRole(int role) {
        final String query = "select * from users where role = :role";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("role", role)
                    .executeAndFetch(User.class);
        }
    }

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
