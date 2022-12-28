package com.example.e_news.models;

import com.example.e_news.beans.Category;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class CategoryModel {
  public static List<Category> findAll() {
    final String query = "select * from categories";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(Category.class);
    }
  }
  public static Category findByIdforArt(int catId) {
    final String query = "select * from categories where id_category = :id_category";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
              .addParameter("id_category", catId)
              .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }

  public static Category findById(int id) {
    final String query = "select * from categories where id_category = :id_category";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
              .addParameter("id_category", id)
              .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }

  public static Category findMainCategoryById(int id) {
    final String query = "select * from categories where id_category = :id_category  and parent_id=0";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
              .addParameter("id_category", id)
              .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }
  public static Category findSubCategoryById(int id) {
    final String query = "select * from categories where id_category = :id_category  and parent_id!=0";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
              .addParameter("id_category", id)
              .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }
  public static List<Category> findMainCategory() {
    final String query = "select * from categories where parent_id=0";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(Category.class);
    }
  }

  public static void add(Category c){
    String insertSql = "INSERT INTO categories ( name, parent_id,editor_id) VALUES (:name, :parent_id,:editor_id)";
    try (Connection con = DbUtils.getConnection()){
      con.createQuery(insertSql)
              .addParameter("name", c.getName())
              .addParameter("parent_id",c.getParent_id())
              .addParameter("editor_id",c.getEditor_id())
              .executeUpdate();
    }
  }

  public static void update(Category c){
    String insertSql = "UPDATE categories SET name = :name, parent_id = :parent_id, editor_id = :editor_id WHERE id_category = :id_category";
    try (Connection con = DbUtils.getConnection()){
      con.createQuery(insertSql)
              .addParameter("id_category", c.getId_category())
              .addParameter("name", c.getName())
              .addParameter("parent_id",c.getParent_id())
              .addParameter("editor_id",c.getEditor_id())
              .executeUpdate();
    }
  }

  public static void delete (int id, int parent_id){
    if(parent_id == 0){
      String insertSql = "delete from categories WHERE parent_id = :id_category";
      try (Connection con = DbUtils.getConnection()){
        con.createQuery(insertSql)
                .addParameter("id_category", id)
                .executeUpdate();
      }
    }
    String insertSql = "delete from categories WHERE id_category = :id_category";
    try (Connection con = DbUtils.getConnection()){
      con.createQuery(insertSql)
              .addParameter("id_category", id)
              .executeUpdate();
    }
  }
}