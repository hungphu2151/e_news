package com.example.e_news.controller;

import com.example.e_news.beans.Article;
import com.example.e_news.beans.Tag;
import com.example.e_news.beans.User;
import com.example.e_news.models.ArticleModel;
import com.example.e_news.models.TagModel;
import com.example.e_news.models.UserModel;
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
                List<Tag> listTag = TagModel.findAll();
                int totalPage = listTag.size()/5;
                if (listTag.size()%5 !=0){
                    totalPage++;
                }
                List<Tag> list;
                int page;
                if(request.getParameter("page") == null || Integer.parseInt(request.getParameter("page"))<1 || Integer.parseInt(request.getParameter("page"))> totalPage){
                    page=1;
                    list = TagModel.pagingTag(1);
                }else {
                    page = Integer.parseInt(request.getParameter("page"));
                    list = TagModel.pagingTag(page);
                }
                request.setAttribute("currentPage",page);
                request.setAttribute("totalPage",totalPage);
                request.setAttribute("tags",list);
                ServletUtils.forward("/views/vwTag/Index.jsp", request, response);
                break;
            case "/AddTag":
                ServletUtils.forward("/views/vwTag/AddTag.jsp", request, response);
                break;

            case "/EditTag":
                int id = Integer.parseInt(request.getParameter("id"));
                Tag t = TagModel.findById(id);
                if(t != null){
                    request.setAttribute("tag",t);
                    ServletUtils.forward("/views/vwTag/EditTag.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Admin/Tag", request, response);
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
            case "/AddTag":
                addTag(request, response);
                break;
            case "/UpdateTag":
                updateTag(request, response);
                break;
            case "/DeleteTag":
                deleteTag(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private static void addTag(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String value = request.getParameter("value");
        Tag t= new Tag(0,value);
        TagModel.add(t);
        ServletUtils.redirect("/Admin/Tag", request, response);
    }

    private static void updateTag(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String value = request.getParameter("value");
        Tag t= new Tag(id,value);
        TagModel.update(t);
        ServletUtils.redirect("/Admin/Tag", request, response);
    }
    private static void deleteTag(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        TagModel.delete(id);
        ServletUtils.redirect("/Admin/Tag", request, response);
    }
}
