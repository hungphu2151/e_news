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
}
