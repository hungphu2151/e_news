package com.example.e_news.beans;

public class Tag {
  private int tag_id;
  private String value;

  public Tag(int tag_id, String value) {
    this.tag_id = tag_id;
    this.value = value;
  }

  public Tag() {
  }

  public int getId_tag() {
    return tag_id;
  }
  public String getValue() {
    return value;
  }

}
