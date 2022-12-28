package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/Home/*")
public class HomeServlet extends HttpServlet {
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
                List<Article> listViews = ArticleModel.findByViews();
                request.setAttribute("views",listViews);
                List<Article> listDate = ArticleModel.findByDate();
                request.setAttribute("dates",listDate);
                List<Article> listtop10 = ArticleModel.findByTopCat();
                request.setAttribute("top10", listtop10);
                ServletUtils.forward("/views/vwHome/Index.jsp", request, response);
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
    }
}
