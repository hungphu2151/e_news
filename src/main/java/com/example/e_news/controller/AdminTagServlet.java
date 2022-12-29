package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Tag;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.TagModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminTagServlet", value = "/Admin/Tag/*")
public class AdminTagServlet extends HttpServlet {
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
                List<Tag> list = TagModel.findAll();
                request.setAttribute("tags",list);
                ServletUtils.forward("/views/vwTag/Index.jsp", request, response);
                break;
            case "/AddTag":
                List<Article> listArticle = ArticleModel.findAll();
                request.setAttribute("articles",listArticle);
                ServletUtils.forward("/views/vwTag/AddTag.jsp", request, response);
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
