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
                String username =request.getParameter("username");
                User u = UserModel.findByUsername(username);
                if(u != null){
                    request.setAttribute("user",u);
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
//        switch (path){
//            case "/AddUser":
//                addUser(request, response);
//                break;
//            case "/UpdateUser":
//                updateUser(request, response);
//                break;
//            case "/DeleteUser":
//                deleteUser(request, response);
//                break;
//            default:
//                ServletUtils.forward("/views/404.jsp", request, response);
//                break;
//        }
    }
//    private static void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String name = request.getParameter("name");
//        String pen_name = request.getParameter("pen_name");
//        String username = request.getParameter("username");
//        String rawpassword = request.getParameter("rawpassword");
//        String bcrypHashString = BCrypt.withDefaults().hashToString(12,rawpassword.toCharArray());
//        String email = request.getParameter("email");
//        int role = Integer.parseInt(request.getParameter("role"));
//        String StrDob = request.getParameter("dob");
//        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
//        LocalDate dob = LocalDate.parse(StrDob, df);
//        LocalDateTime issue_at= LocalDateTime.now();
//        User u = new User(0,role,1,username,bcrypHashString,name,email,pen_name,dob,issue_at);
//        UserModel.add(u);
//        ServletUtils.redirect("/Admin/User", request, response);
//    }
//
//    private static void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        String name = request.getParameter("name");
//        String pen_name = request.getParameter("pen_name");
//        String username = request.getParameter("username");
//        String rawpassword = request.getParameter("rawpassword");
//        String bcrypHashString = BCrypt.withDefaults().hashToString(12,rawpassword.toCharArray());
//        String email = request.getParameter("email");
//        int role = Integer.parseInt(request.getParameter("role"));
//        String StrDob = request.getParameter("dob");
//        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
//        LocalDate dob = LocalDate.parse(StrDob, df);
//        LocalDateTime issue_at= LocalDateTime.parse(request.getParameter("issue_at"));
//        System.out.println(issue_at);
//        User u = new User(id,role,1,username,bcrypHashString,name,email,pen_name,dob,issue_at);
//        UserModel.update(u);
//        ServletUtils.redirect("/Admin/User", request, response);
//    }
//
//    private static void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username =request.getParameter("username");
//        UserModel.delete(username);
//        ServletUtils.redirect("/Admin/User", request, response);
//    }
}
