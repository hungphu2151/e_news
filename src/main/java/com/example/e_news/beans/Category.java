package com.example.e_news.beans;

public class Category {
  private int id_category, parent_id, editor_id;
  private String name;

  public Category(int id_category, int parent_id, int editor_id, String name) {
    this.id_category = id_category;
    this.parent_id = parent_id;
    this.editor_id = editor_id;
    this.name = name;
  }

  public Category(String name, int parent_id) {
    this.parent_id = 0;
    this.editor_id = parent_id;
    this.name = name;
  }

  public Category() {
  }

  public int getId_category() {
    return id_category;
  }

  public int getParent_id() {
    return parent_id;
  }

  public int getEditor_id() {
    return editor_id;
  }

  public String getName() {
    return name;
  }
}
