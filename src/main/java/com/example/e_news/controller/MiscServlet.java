package com.example.e_news.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.example.e_news.beans.Article;
import com.example.e_news.beans.Category;
import com.example.e_news.beans.Tag;
import com.example.e_news.beans.User;
import com.example.e_news.models.*;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "MiscServlet", value = "/Misc/*")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 50 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
public class MiscServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("authUser");
        List<Category> categoryList = CategoryModel.findAll();
        List<Tag> listTag = TagModel.findAll();
        switch (path){
            case "/Writer":
                request.setAttribute("categories",categoryList);
                request.setAttribute("tags",listTag);
                ServletUtils.forward("/views/vwWriter/Writer.jsp", request, response);
                break;


            case "/Publish":
                List<Article> Da_xuat_ban = ArticleModel.find_da_xuat_ban(u.getId());
                request.setAttribute("da_xuat_ban", Da_xuat_ban);
                ServletUtils.forward("/views/vwWriter/Publish.jsp", request, response);
                break;

            case "/Accept":
                List<Article> Da_duoc_duyet = ArticleModel.find_da_duoc_duyet(u.getId());
                request.setAttribute("da_duoc_duyet", Da_duoc_duyet);
                ServletUtils.forward("/views/vwWriter/Accept.jsp", request, response);
                break;

            case "/Deny":
                List<Article> Bi_tu_choi = ArticleModel.find_bi_tu_choi(u.getId());
                request.setAttribute("bi_tu_choi", Bi_tu_choi);
                ServletUtils.forward("/views/vwWriter/Deny.jsp", request, response);
                break;

            case "/Unapproved":
                List<Article> Chua_duoc_duyet = ArticleModel.find_chua_duoc_duyet(u.getId());
                request.setAttribute("chua_duoc_duyet", Chua_duoc_duyet);
                ServletUtils.forward("/views/vwWriter/Unapproved.jsp", request, response);
                break;
            case "/Detail":
                int id =Integer.parseInt(request.getParameter("id"));
                Article a = ArticleModel.findById(id);
                if(a != null){
                    Category c= CategoryModel.findById(a.getCategory_id());
                    List<Tag> listTagbyArt = TagModel.findByArtId(id);
                    request.setAttribute("tagbyArt", listTagbyArt);
                    request.setAttribute("article",a);
                    request.setAttribute("category",c);
                    ServletUtils.forward("/views/vwWriter/Detail.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Misc/Writer", request, response);
                }
                break;

            case "/Upload":
                int id_article =Integer.parseInt(request.getParameter("id"));
                Article v = ArticleModel.findById(id_article);
                if(v!=null && (v.getStatus()==3 || v.getStatus()==4) && v.getWriter_id()==u.getId()) {
                    request.setAttribute("article", v);
                    request.setAttribute("categories",categoryList);
                    request.setAttribute("tags",listTag);
                    ServletUtils.forward("/views/vwWriter/Upload.jsp", request, response);
                } else {
                    ServletUtils.redirect("/Misc/Publish", request, response);
                }
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

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        int category_id = Integer.parseInt(request.getParameter("category_id"));
        String [] tag_id =request.getParameterValues("tag_id");
        Article a = new Article(0,0,category_id,3,0,id,title,summary,content,null,null);
        ArticleModel.add(a);
        Article article= ArticleModel.LatestArticleID();
        for (Part part :request.getParts()){
            if(part.getName().equals("fuMain")){
                String targetDir= this.getServletContext().getRealPath("public/imgs/articles/"+article.getId_article());
                File dir= new File(targetDir);
                if(!dir.exists()){
                    dir.mkdir();
                }
                String destination = targetDir+"/main.jpg" ;
                part.write(destination);
            }
        }
        for(String item: tag_id){
            Tags_has_articleModel.addTags_Articles(Integer.parseInt(item),article.getId_article());
        }
        List<Category> listCategory = CategoryModel.findAll();
        request.setAttribute("categories",listCategory);
        List<Tag> listTag = TagModel.findAll();
        request.setAttribute("tags",listTag);
        ServletUtils.forward("/views/vwWriter/Writer.jsp", request, response);
    }

    private void postUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_writer = Integer.parseInt(request.getParameter("id_writer"));
        int id_article = Integer.parseInt(request.getParameter("id_article"));
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        int category_id = Integer.parseInt(request.getParameter("category_id"));
        String [] tag_id =request.getParameterValues("tag_id");
        Article a = new Article(id_article,0,category_id,3,0,id_writer,title,summary,content,null,null);
        ArticleModel.update(a);
        for (Part part :request.getParts()){
            if(part.getName().equals("fuMain")){
                String targetDir= this.getServletContext().getRealPath("public/imgs/articles/"+id_article);
                File dir= new File(targetDir);
                if(!dir.exists()){
                    dir.mkdir();
                }
                String destination = targetDir+"/main.jpg" ;
                part.write(destination);
            }
        }
        Tags_has_articleModel.deleteTagByIDArticle(id_article);
        for(String item: tag_id){
            Tags_has_articleModel.addTags_Articles(Integer.parseInt(item),id_article);
        }
        ServletUtils.redirect("/Misc/Unapproved", request, response);
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

    private static void addWriter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
//        int role = Integer.parseInt(request.getParameter("role"));
//        String StrDob = request.getParameter("dob");
//        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
//        LocalDate dob = LocalDate.parse(StrDob, df);
//        LocalDateTime issue_at= LocalDateTime.now();
//        LocalDateTime expriration = issue_at.plusDays(7);
//        Article a = new Article(0,category ,3,1,4,title,summary,content,null,0);
//        int id_article, int category_id, int status, int views, int writer_id, String title, String sumary, String content, LocalDateTime public_date, int premium
//        ArticleModel.add(a);
//        ServletUtils.redirect("/Admin/User", request, response);
    }
}
