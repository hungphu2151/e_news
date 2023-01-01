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
        request.setCharacterEncoding("UTF-8");

        String path = request.getPathInfo();
        switch (path){
            case "/Accept":
                postAccept(request, response);
                break;
            case "/Deny":
                postDeny(request,response);
                break;
            case "/Edit":
                postEdit(request, response);
                break;
            case "/Publish":
                postPublish(request, response);
                break;

            case "/Unapproved":
                postUnapproved(request, response);
                break;
            case "/Upload":
                postUpload(request, response);
                break;
            case "/Writer":
                postWriter(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private void postWriter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String desc = request.getParameter("FullDes");
        System.out.println(desc);
        ServletUtils.forward("/views/vwWriter/Writer.jsp", request, response);
    }

    private void postUpload(HttpServletRequest request, HttpServletResponse response) {
    }

    private void postUnapproved(HttpServletRequest request, HttpServletResponse response) {
    }

    private void postPublish(HttpServletRequest request, HttpServletResponse response) {
    }

    private void postEdit(HttpServletRequest request, HttpServletResponse response) {
    }

    private void postDeny(HttpServletRequest request, HttpServletResponse response) {
    }

    private void postAccept(HttpServletRequest request, HttpServletResponse response) {
    }
}
