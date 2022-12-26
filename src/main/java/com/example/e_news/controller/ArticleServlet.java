package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.Cmt;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.CmtModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ArticleServlet", value = "/Article/*")
public class ArticleServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();
    switch (path) {
      case "/ByCat":
        int catId = Integer.parseInt(request.getParameter("id"));
        List<Article> list = ArticleModel.findByCatId(catId);
        Category cat = CategoryModel.findByIdforArt(catId);
        request.setAttribute("cat", cat);
        request.setAttribute("articles", list);
        ServletUtils.forward("/views/vwArticle/ByCat.jsp", request, response);
        break;

      case "/Detail":
        int artID = Integer.parseInt(request.getParameter("id"));
        Article art = ArticleModel.findById(artID);
        List<Cmt> cmt = CmtModel.findByArtId(artID);
        if (art == null)
          ServletUtils.redirect("/Home", request, response);
        else {
          request.setAttribute("cmts", cmt);
          request.setAttribute("article", art);
          ServletUtils.forward("/views/vwArticle/Detail.jsp", request, response);
        }
        break;

      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  }
}
