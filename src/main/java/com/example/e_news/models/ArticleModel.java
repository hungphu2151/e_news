package com.example.e_news.models;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
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

    public static List<Article> findByCatId(int catId) {
        final String sql = "select * from articles where category_id = :category_id and status=1 order by premium desc ";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .addParameter("category_id", catId)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> findByTagId(int tagId) {
        final String sql = "select id_article, premium, title, public_date, category_id, sumary, content, status, views, writer_id from articles, tags_has_articles\n" +
                "where tags_has_articles.tag_id = :tag_id and articles.id_article=tags_has_articles.article_id and status=1 order by premium desc";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .addParameter("tag_id", tagId)
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

    public static List<Article> findBycountCmt() {
        final String sql = "select id_article, premium, title, public_date, category_id, sumary, content, status, views, writer_id\n" +
                "from comments, articles\n" +
                "where comments.article_id = articles.id_article\n" +
                "group by article_id\n" +
                "order by count(article_id)\n" +
                "desc\n" +
                "limit 10";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> findSameCat(int catId) {
        final String sql = "SELECT * FROM articles\n" +
                "where category_id=4 and id_article!=:id_article\n" +
                "ORDER BY RAND()\n" +
                "LIMIT 5";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .addParameter("id_article", catId)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> findSearch(String search) {
        final String sql = "SELECT *\n" +
                "FROM articles\n" +
                "WHERE\n" +
                "    MATCH(title, sumary, content)\n" +
                "          AGAINST('search');";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }
    public static Article LatestArticleID(){
        final String query = "Select id_article from articles  where id_article >= ALL (Select id_article from articles)";
        try (Connection con = DbUtils.getConnection()) {
            List<Article> list = con.createQuery(query)
                    .executeAndFetch(Article.class);
            if (list.size()==0){
                return null;
            }
            return list.get(0);
        }
    }

    public static void add(Article a){
        String insertSql = "INSERT INTO articles (id_article, title, public_date, category_id, sumary, content, status, views, writer_id, premium, reason)" +
                "VALUES (:id_article,:title,:public_date,:category_id,:sumary,:content,:status,:views,:writer_id,:premium,:reason)\n";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("id_article", a.getId_article())
                    .addParameter("title", a.getTitle())
                    .addParameter("public_date", a.getPublic_date())
                    .addParameter("category_id", a.getCategory_id())
                    .addParameter("sumary", a.getSumary())
                    .addParameter("content", a.getContent())
                    .addParameter("status", a.getStatus())
                    .addParameter("views", a.getViews())
                    .addParameter("writer_id", a.getWriter_id())
                    .addParameter("premium", a.getPremium())
                    .addParameter("reason", a.getReason())
                    .executeUpdate();
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

    public static void updateStatus (int id_article, int status){
        String insertSql = "UPDATE articles SET status =:status WHERE id_article = :id_article \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id_article",id_article)
                    .addParameter("status",status)
                    .executeUpdate();
        }
    }
    public static void updatePremium (int id_article, int premium){
        String insertSql = "UPDATE articles SET premium =:premium WHERE id_article = :id_article \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id_article",id_article)
                    .addParameter("premium",premium)
                    .executeUpdate();
        }
    }
    public static void updateView (int id_article, int views){
        String insertSql = "UPDATE articles SET views =:views WHERE id_article = :id_article \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id_article",id_article)
                    .addParameter("views",views)
                    .executeUpdate();
        }
    }
    public static void updateReason (int id_article, String reason){
        String insertSql = "UPDATE articles SET reason =:reason WHERE id_article = :id_article \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id_article",id_article)
                    .addParameter("reason",reason)
                    .executeUpdate();
        }
    }
    public static void delete (int id){
        String insertSql = "DELETE FROM articles WHERE id_article = :id_article \n";
        try (Connection con = DbUtils.getConnection()){
            con.createQuery(insertSql)
                    .addParameter("id_article", id)
                    .executeUpdate();
        }
    }


    public static List<Article> find_da_duoc_duyet() {
        final String sql = "select *\n" +
                "from articles\n" +
                "where status = 2";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }

    public static List<Article> find_da_xuat_ban() {
        final String sql = "select *\n" +
                "from articles\n" +
                "where status = 1";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }
    public static List<Article> find_bi_tu_choi() {
        final String sql = "select *\n" +
                "from articles\n" +
                "where status = 4";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }
    public static List<Article> find_chua_duoc_duyet() {
        final String sql = "select *\n" +
                "from articles\n" +
                "where status = 3";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(sql)
                    .executeAndFetch(Article.class);
        }
    }
}
