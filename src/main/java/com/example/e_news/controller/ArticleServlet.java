package com.example.e_news.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.Cmt;
import com.example.e_news.beans.User;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.CmtModel;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    String path = request.getPathInfo();
    switch (path){
      case "/Detail":
        postCmt(request, response);
        break;
      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  private static void postCmt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String rawpwd = request.getParameter("rawpwd");
    String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String StrDob = request.getParameter("dob");
    DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
    LocalDate dob = LocalDate.parse(StrDob, df);
    LocalDateTime issue_at = LocalDateTime.now();
    int expriration = 0;
    int role = 4;
    String pen_name = "";
    User c = new User(0,role,expriration,username, bcryptHashString, name, email, pen_name, dob, issue_at);
    UserModel.add(c);
    ServletUtils.forward("/views/vwAccount/Register.jsp", request, response);
  }
}


