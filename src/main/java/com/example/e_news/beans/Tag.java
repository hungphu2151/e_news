package com.example.e_news.beans;

public class Tag {
  private int id_tag, article_id;
  private String value;

  public Tag(int id_tag, int article_id, String value) {
    this.id_tag = id_tag;
    this.value = value;
    this.article_id = article_id;
  }

  public Tag() {
  }

  public int getId_tag() {
    return id_tag;
  }
  public int getArticle_id() {
    return article_id;
  }
  public String getValue() {
    return value;
  }

}
