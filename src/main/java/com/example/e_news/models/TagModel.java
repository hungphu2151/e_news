package com.example.e_news.models;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.Tag;
import com.example.e_news.beans.User;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class TagModel {

    public static List<Tag> findAll() {
        final String query = "select * from tags";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Tag.class);
        }
    }
    public static Tag findById(int id) {
        final String query = "SELECT * FROM tags WHERE tag_id = :tag_id \n";
        try (Connection con = DbUtils.getConnection()) {
            List<Tag> list = con.createQuery(query)
                    .addParameter("tag_id", id)
                    .executeAndFetch(Tag.class);

            if (list.size() == 0) {
                return null;
            }

            return list.get(0);
        }
    }
    public static List<Tag> findByArtId(int ArtId) {
        final String sql = "select tags.tag_id, value\n" +
                "from tags_has_articles, tags, articles\n" +
                "where articles.id_article=:id_article and tags_has_articles.article_id=articles.id_article and tags_has_articles.tag_id=tags.tag_id";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .addParameter("id_article", ArtId)
                    .executeAndFetch(Tag.class);
        }
    }

    public static List<Tag> pagingTag(int page){
        final String query = "Select *\n" +
                "from tags\n" +
                "ORDER BY tag_id\n" +
                "LIMIT 5 OFFSET :index ";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("index",(page-1)*5)
                    .executeAndFetch(Tag.class);
        }
    }
    public static void add(Tag t){
        String insertSql = "INSERT INTO tags (tag_id, value) VALUES (:tag_id,:value)\n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("tag_id", t.getId_tag())
                    .addParameter("value",t.getValue())
                    .executeUpdate();
        }
    }
    public static void update(Tag t){
        String insertSql = "UPDATE tags SET  value = :value WHERE tag_id = :tag_id \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("tag_id", t.getId_tag())
                    .addParameter("value",t.getValue())
                    .executeUpdate();
        }
    }

    public static void delete (int id){
        String insertSql = "DELETE FROM tags WHERE tag_id = :tag_id \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("tag_id", id)
                    .executeUpdate();
        }
    }

}
