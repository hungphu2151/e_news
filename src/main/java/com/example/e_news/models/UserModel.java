package com.example.e_news.models;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;
public class UserModel {

    public static List<User> findAll() {
        final String query = "select * from users";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
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

    public static void update(User c){
        String insertSql = "UPDATE users SET  username = :username, password = :password, name = :name, issue_at = :issueAt, expriration = :expriration, role = :role, pen_name = :penName, email = :email, dob = :dob WHERE id = :id \n";
        try (Connection con = DbUtils.getConnection()){
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

    public static void delete (String username){
        String insertSql = "delete from users WHERE username = :username";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("username", username)
                    .executeUpdate();
        }
    }
    public static User findByUsername(String username){
        final String query = "select * from users where username = :username";
        try (Connection con = DbUtils.getConnection()) {
            List<User> list = con.createQuery(query)
                    .addParameter("username",username)
                    .executeAndFetch(User.class);
            if (list.size()==0){
                return null;
            }
            return list.get(0);
        }
    }
    public static List<User> findByRole(int role) {
        final String query = "select * from users WHERE role = :role ";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("role",role)
                    .executeAndFetch(User.class);
        }
    }
}
