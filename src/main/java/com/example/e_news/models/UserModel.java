package com.example.e_news.models;

import com.example.e_news.beans.User;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
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
        String insertSql = "UPDATE users SET  username = :username, password = :password, name = :name, expriration = :expriration, issue_at =:issue_at, role = :role, pen_name = :pen_name, email = :email  , dob = :dob WHERE id = :id \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id",c.getId())
                    .addParameter("username", c.getUsername())
                    .addParameter("password", c.getPassword())
                    .addParameter("name", c.getName())
                    .addParameter("email", c.getEmail())
                    .addParameter("dob", c.getDob())
                    .addParameter("issue_at",c.getIssue_at())
                    .addParameter("role", c.getRole())
                    .addParameter("pen_name", c.getPen_name())
                    .addParameter("expriration", c.getExpriration())
                    .executeUpdate();
        }
    }
    public static void updateEx (int id , LocalDateTime expriration){
        String insertSql = "UPDATE users SET expriration =:expriration WHERE id = :id \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id",id)
                    .addParameter("expriration",expriration)
                    .executeUpdate();
        }
    }
    public static void updateProfile(User c){
        String insertSql = "UPDATE users SET username= :username, name = :name,  email = :email, pen_name = :pen_name, dob = :dob WHERE username = :username\n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("username", c.getUsername())
                    .addParameter("name", c.getName())
                    .addParameter("pen_name", c.getPen_name())
                    .addParameter("email", c.getEmail())
                    .addParameter("dob", c.getDob())
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
    public static User findByUsername(int id,String username){
        final String query = "select * from users where username = :username and id !=:id";
        try (Connection con = DbUtils.getConnection()) {
            List<User> list = con.createQuery(query)
                    .addParameter("username",username)
                    .addParameter("id",id)
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
