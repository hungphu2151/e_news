package com.example.e_news.models;

import com.example.e_news.beans.Cmt;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class CmtModel {

  public static List<Cmt> findByArtId(int artId) {
    final String sql = "select * from comments where article_id = :article_id";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(sql)
              .addParameter("article_id", artId)
              .executeAndFetch(Cmt.class);
    }
  }

    public static void add(Cmt c) {
      String insertSql = "INSERT INTO comments (article_id, user_id, comment, date) VALUES (:article_id,:user_id,:comment,:date)\n";
      try (Connection con = DbUtils.getConnection()) {
        con.createQuery(insertSql)
                .addParameter("article_id", c.getArticle_id())
                .addParameter("user_id", c.getUser_id())
                .addParameter("comment", c.getComment())
                .addParameter("date", c.getDate())
                .executeUpdate();
      }
    }
}