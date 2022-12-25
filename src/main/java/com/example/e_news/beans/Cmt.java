package com.example.e_news.beans;

import java.time.LocalDateTime;

public class Cmt {
    int id_comment, article_id, user_id;
    String comment;
    LocalDateTime date;

    public Cmt(int id_comment, int article_id, int user_id, String comment, LocalDateTime date) {
        this.id_comment = id_comment;
        this.article_id = article_id;
        this.user_id = user_id;
        this.comment = comment;
        this.date = date;
    }

    public Cmt() {
    }

    public int getId_comment() {
        return id_comment;
    }

    public int getArticle_id() {
        return article_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public String getComment() {
        return comment;
    }

    public LocalDateTime getDate() {
        return date;
    }
}
