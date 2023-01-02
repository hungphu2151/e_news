package com.example.e_news.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.example.e_news.beans.Article;
import com.example.e_news.beans.User;
import com.example.e_news.models.ArticleModel;
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

@WebServlet(name = "AdminUserServlet", value = "/Admin/Article/*")
public class AdminArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        if(path==null || path.equals("/")){
            path="/Index";
        }
        switch (path){
            case "/Index":
                List<Article> listArticle = ArticleModel.findAll();
                request.setAttribute("articles",listArticle);
                int roleWriter = 3;
                List<User> listWriter = UserModel.findByRole(roleWriter);
                request.setAttribute("writers",listWriter);
                ServletUtils.forward("/views/vwArticle/Index.jsp", request, response);
                break;

            case "/AddArticle":
                ServletUtils.forward("/views/vwArticle/AddArticle.jsp", request, response);
                break;
            case "/EditArticle":
                int id =Integer.parseInt(request.getParameter("id"));
                Article a = ArticleModel.findById(id);
                if(a != null){
                    request.setAttribute("article",a);
                    ServletUtils.forward("/views/vwArticle/EditArticle.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Admin/Article", request, response);
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
            case "/UpdateStatus":
                updateStatus(request, response);
                break;
            case "/UpdatePremium":
                updatePremium(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private static void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id =Integer.parseInt(request.getParameter("id"));
        ArticleModel.updateStatus(id,1);
        ServletUtils.redirect("/Admin/Article", request, response);
    }

    private static void updatePremium(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id =Integer.parseInt(request.getParameter("id"));
        int premium=Integer.parseInt(request.getParameter("premium"));
        if(premium ==1){
            premium =0;
        }else {
            premium=1;
        }
        ArticleModel.updatePremium(id,premium);
        Article a = ArticleModel.findById(id);
        request.setAttribute("article",a);
        String url = "/Admin/Article/EditArticle?id=" + id;
        ServletUtils.redirect(url, request, response);
    }
}
