package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MiscServlet", value = "/Misc/*")
public class MiscServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path){
            case "/Writer":
                ServletUtils.forward("/views/vwWriter/Writer.jsp", request, response);
                break;

            case "/Upload":
                ServletUtils.forward("/views/vwWriter/Upload.jsp", request, response);
                break;

            case "/Publish":
                List<Article> Da_xuat_ban = ArticleModel.find_da_xuat_ban();
                request.setAttribute("da_xuat_ban", Da_xuat_ban);
                ServletUtils.forward("/views/vwWriter/Publish.jsp", request, response);
                break;

            case "/Accept":
                List<Article> Da_duoc_duyet = ArticleModel.find_da_duoc_duyet();
                request.setAttribute("da_duoc_duyet", Da_duoc_duyet);
                ServletUtils.forward("/views/vwWriter/Accept.jsp", request, response);
                break;

            case "/Deny":
                List<Article> Bi_tu_choi = ArticleModel.find_bi_tu_choi();
                request.setAttribute("bi_tu_choi", Bi_tu_choi);
                ServletUtils.forward("/views/vwWriter/Deny.jsp", request, response);
                break;

            case "/Unapproved":
                List<Article> Chua_duoc_duyet = ArticleModel.find_chua_duoc_duyet();
                request.setAttribute("chua_duoc_duyet", Chua_duoc_duyet);
                ServletUtils.forward("/views/vwWriter/Unapproved.jsp", request, response);
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
            case "/AddMainCategory":
//                addMainCategory(request, response);
                break;
            case "/AddSubCategory":
//                addSubCategory(request,response);
                break;
            case "/UpdateMainCategory":
//                updateMainCategory(request, response);
                break;
            case "/UpdateSubCategory":
//                updateSubCategory(request, response);
                break;

            case "/Delete":
//                deleteMainCategory(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
}
