package com.example.e_news.beans;

public class Tags_has_articles {
  private int tag_id, article_id;

  public Tags_has_articles(int tag_id, int article_id) {
    this.tag_id = tag_id;
    this.article_id = article_id;
  }

  public Tags_has_articles() {
  }

  public int getTag_id() {
    return tag_id;
  }

  public int getArticle_id() {
    return article_id;
  }
}
