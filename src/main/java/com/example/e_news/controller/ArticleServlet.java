package com.example.e_news.controller;

import com.example.e_news.beans.*;
import com.example.e_news.models.*;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import static com.example.e_news.models.ArticleModel.updateView;

@WebServlet(name = "ArticleServlet", value = "/Article/*")
public class  ArticleServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
    String path = request.getPathInfo();
    switch (path) {

      case "/ByCat":
        int catId = Integer.parseInt(request.getParameter("id"));
        List<Article> list = ArticleModel.findByCatId(catId);
        Category cat = CategoryModel.findByIdforArt(catId);
        List<Tag> list_tag = TagModel.findAll();
        List<Tags_has_articles> list_tags_has_articles = Tags_has_articleModel.findAll();
        request.setAttribute("cat", cat);
        request.setAttribute("articles", list);
        request.setAttribute("list_tag", list_tag);
        request.setAttribute("list_tags_has_articles", list_tags_has_articles);
        ServletUtils.forward("/views/vwArticle/ByCat.jsp", request, response);
        break;

      case "/ByTag":
        int tagId = Integer.parseInt(request.getParameter("id"));
        List<Article> listbytag = ArticleModel.findByTagId(tagId);
        Tag tag = TagModel.findById(tagId);
        List<Tag> list_tag1 = TagModel.findAll();
        List<Tags_has_articles> list_tags_has_articles1 = Tags_has_articleModel.findAll();
        request.setAttribute("list_tag", list_tag1);
        request.setAttribute("list_tags_has_articles", list_tags_has_articles1);
        request.setAttribute("tag", tag);
        request.setAttribute("articles", listbytag);
        ServletUtils.forward("/views/vwArticle/ByTag.jsp", request, response);
        break;

      case "/Detail":
        HttpSession session = request.getSession();
        boolean auth = (boolean) session.getAttribute("auth");
        int artID = Integer.parseInt(request.getParameter("id"));
        Article art = ArticleModel.findById(artID);
        List<Cmt> cmt = CmtModel.findByArtId(artID);
        List<User> users = UserModel.findAll();
        List<Article> listSameCat = ArticleModel.findSameCat(artID);
        List<Tag> listTagbyArt = TagModel.findByArtId(artID);
        List<Tag> list_tag2 = TagModel.findAll();
        List<Tags_has_articles> list_tags_has_articles2 = Tags_has_articleModel.findAll();
        int count_view = art.getViews();
        if (art == null)
          ServletUtils.redirect("/Home", request, response);
        else {
          request.setAttribute("cmts", cmt);
          request.setAttribute("article", art);
          request.setAttribute("user", users);
          request.setAttribute("sameCat", listSameCat);
          request.setAttribute("tagbyArt", listTagbyArt);
          request.setAttribute("list_tag", list_tag2);
          request.setAttribute("list_tags_has_articles", list_tags_has_articles2);
          if ( art.getPremium()==1 && auth==false ){
            ServletUtils.forward("/views/vwArticle/erro.jsp", request, response);
            return;
          }
          count_view=count_view+1;
          updateView(artID, count_view);
          ServletUtils.forward("/views/vwArticle/Detail.jsp", request, response);
        }
        break;

      case "/Search":
        String  search = request.getParameter("txtResult");
        System.out.println(search);
        List<Article> search_result = ArticleModel.findSearch(search);
        if (search_result==null)
          ServletUtils.forward("/views/404.jsp", request, response);
        else {
          request.setAttribute("results",search_result);
          ServletUtils.forward("/views/vwSearch/Search.jsp", request, response);
        }
        break;

      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
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
    HttpSession session = request.getSession();
    User u = (User) session.getAttribute("authUser");
    boolean auth = (boolean) session.getAttribute("auth");
    if (auth == false) {
      ServletUtils.redirect("/Account/Login",request , response);
      return;
    }
    else {
      int article_id = Integer.parseInt(request.getParameter("id"));
      int user_id = u.getId();
      String comment = request.getParameter("Cmt");
      LocalDateTime date = LocalDateTime.now();
      Cmt c = new Cmt(0, article_id, user_id, comment, date);
      CmtModel.add(c);
      String url = request.getHeader("referer");
      if (url == null) url = "/Home";
      ServletUtils.redirect(url, request, response);
    }
  }
}


