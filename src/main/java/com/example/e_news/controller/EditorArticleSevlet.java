package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "EditorArticleSevlet", value = "/Editor/Article/*")
public class EditorArticleSevlet extends HttpServlet {
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
                List<Category> listCategory = CategoryModel.findAll();
                request.setAttribute("categories",listCategory);
                ServletUtils.forward("/views/vwEditor/Index.jsp", request, response);
                break;
            case "/AcceptedArticle":
                listArticle = ArticleModel.findAll();
                request.setAttribute("articles",listArticle);
                roleWriter = 3;
                listWriter = UserModel.findByRole(roleWriter);
                request.setAttribute("writers",listWriter);
                listCategory = CategoryModel.findAll();
                request.setAttribute("categories",listCategory);
                ServletUtils.forward("/views/vwEditor/AcceptedArticle.jsp", request, response);
                break;
            case "/RefusedArticle":
                listArticle = ArticleModel.findAll();
                request.setAttribute("articles",listArticle);
                roleWriter = 3;
                listWriter = UserModel.findByRole(roleWriter);
                request.setAttribute("writers",listWriter);
                listCategory = CategoryModel.findAll();
                request.setAttribute("categories",listCategory);
                ServletUtils.forward("/views/vwEditor/RefusedArticle.jsp", request, response);
                break;
            case "/Edit":
                int id =Integer.parseInt(request.getParameter("id"));
                Article a = ArticleModel.findById(id);
                if(a != null){
                    request.setAttribute("article",a);
                    ServletUtils.forward("/views/vwEditor/Edit.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Editor/Article", request, response);
                }
                break;
            case "/Reason":
                id = Integer.parseInt(request.getParameter("id"));
                a = ArticleModel.findById(id);
                if(a != null){
                    request.setAttribute("article",a);
                    ServletUtils.forward("/views/vwEditor/Reason.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Editor/Article", request, response);
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
            case "/AcceptArticle":
                acceptArticle(request, response);
                break;
            case "/RefuseArticle":
                refuseArticle(request, response);
                break;
            case "/AddReason":
                addReason(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private static void acceptArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id =Integer.parseInt(request.getParameter("id"));
        ArticleModel.updateStatus(id,2,null);
        ServletUtils.redirect("/Editor/Article", request, response);
    }

    private static void refuseArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id =Integer.parseInt(request.getParameter("id"));
        ArticleModel.updateStatus(id,4,null);
        ServletUtils.redirect("/Editor/Article/Reason?id="+id, request, response);
    }

    private static void addReason(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String reason = request.getParameter("reason");
        ArticleModel.updateReason(id,reason);
        ServletUtils.redirect("/Editor/Article", request, response);
    }
}
