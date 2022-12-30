package com.example.e_news.models;

import com.example.e_news.beans.Category;
import com.example.e_news.beans.DateTime;
import com.example.e_news.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.List;

public class DatetimeModel {
  public static DateTime datetime() {
    LocalDateTime now = LocalDateTime.now();
    return new DateTime(now);
  }
}