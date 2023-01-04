package com.example.e_news.filters;


import com.example.e_news.beans.Category;
import com.example.e_news.beans.Tag;
import com.example.e_news.beans.Tags_has_articles;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.TagModel;
import com.example.e_news.models.Tags_has_articleModel;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "LayoutFilter")
public class LayoutFilter implements Filter {
  public void init(FilterConfig config) throws ServletException {
  }

  public void destroy() {
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
    List<Category> listCat = CategoryModel.findAll();
    request.setAttribute("categoriesWithDetails", listCat);

    List<Tag> listTag = TagModel.findAll();
    request.setAttribute("tagWithDetails", listTag);

    List<Tags_has_articles> listTags_has_articles = Tags_has_articleModel.findAll();
    request.setAttribute("tags_has_articles", listTags_has_articles);
    chain.doFilter(request, response);
  }
}
