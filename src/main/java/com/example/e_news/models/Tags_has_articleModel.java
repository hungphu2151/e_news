package com.example.e_news.models;

import com.example.e_news.beans.Tags_has_articles;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class Tags_has_articleModel {

    public static List<Tags_has_articles> findAll() {
        final String query = "select * from tags_has_articles";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Tags_has_articles.class);
        }
    }
    public static void addTags_Articles(int tag_id,int article_id){
        String insertSql = "INSERT INTO tags_has_articles (tag_id, article_id) VALUES (:tag_id,:article_id)\n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("tag_id",tag_id)
                    .addParameter("article_id",article_id)
                    .executeUpdate();
        }
    }
    public static void deleteTagByIDArticle(int article_id) {
        String insertSql = "delete from tags_has_articles WHERE article_id = :article_id";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("article_id", article_id)
                    .executeUpdate();
        }
    }
}
