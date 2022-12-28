package com.example.e_news.models;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class ArticleModel {

    public static List<Article> findAll() {
        String sql = "select * from articles";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql).executeAndFetch(Article.class);
        }
    }

//    public static List<ArticleDTO> findByCatId(int catId) {
//        final String sql = "select * from articles where category_id = :category_id and status=1";
//        List<ArticleDTO> articleList = new ArrayList<>();
//        try (Connection con = DbUtils.getConnection()) {
//            List<Article> list = con.createQuery(sql)
//                    .addParameter("category_id", catId)
//                    .executeAndFetch(Article.class);
//            for (Article item : list) {
//                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
//                String dateFormat = item.getPublic_date().format(dateTimeFormatter);
//                articleList.add(new ArticleDTO(item.getId_article(), item.getCategory_id(), item.getTag_id(), item.getStatus(),
//                        item.getViews(), item.getWriter_id(), item.getTitle(), item.getSumary(), item.getContent(), dateFormat));
//            }
//            return articleList;
//        }
//    }

    public static List<Article> findByCatId(int catId) {
        final String sql = "select * from articles where category_id = :category_id and status=1";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .addParameter("category_id", catId)
                    .executeAndFetch(Article.class);
        }
    }

    public static Article findById(int artID) {
        String sql = "select * from articles where id_article = :id_article";
        try (Connection con = DbUtils.getConnection()) {
            List<Article> list = con.createQuery(sql)
                    .addParameter("id_article", artID)
                    .executeAndFetch(Article.class);

            if (list.size() == 0)
                return null;

            return list.get(0);
        }
    }

    public static List<Article> findByViews() {
        final String sql = "select * from articles order by views desc limit 10";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> findByDate() {
        final String sql = "select * from articles order by public_date desc limit 10";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> findByTopCat() {
        final String sql = "select * from articles\n" +
                "where public_date in (select max(public_date) as public_date\n" +
                "                      from articles\n" +
                "                      group by category_id)";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }

}
