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

}