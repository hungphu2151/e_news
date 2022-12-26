package com.example.e_news.models;

import com.example.e_news.beans.Article;
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
    final String query = "select * from categories where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
              .addParameter("CatID", id)
              .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
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
}