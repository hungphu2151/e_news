package com.example.e_news.beans;

import java.time.LocalDateTime;

public class Article {
  private int id_article, category_id, status, views, writer_id, premium;
  private String title, sumary, content, reason;
  private LocalDateTime public_date;

  public Article(int id_article, int premium, int category_id, int status, int views, int writer_id,
                 String title, String sumary, String content, LocalDateTime public_date, String reason) {
    this.id_article = id_article;
    this.premium = premium;
    this.category_id = category_id;
    this.status = status;
    this.views = views;
    this.writer_id = writer_id;
    this.title = title;
    this.sumary = sumary;
    this.content = content;
    this.public_date = public_date;
    this.reason = reason;
  }

  public Article() {
  }

  public int getId_article() {
    return id_article;
  }

  public int getCategory_id() {
    return category_id;
  }

  public int getStatus() {
    return status;
  }

  public int getViews() {
    return views;
  }

  public int getWriter_id() {
    return writer_id;
  }

  public String getTitle() {
    return title;
  }

  public String getSumary() {
    return sumary;
  }

  public String getContent() {
    return content;
  }

  public LocalDateTime getPublic_date() {
    return public_date;
  }

  public String getReason() { return reason; }

  public int getPremium() { return premium; }
}
