package com.example.e_news.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.example.e_news.beans.User;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AdminUsersServlet", value = "/Admin/User/*")
public class AdminUsersServlet extends HttpServlet {
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
                List<User> listUser = UserModel.findAll();
                int totalPage = listUser.size()/5;
                if (listUser.size()%5 !=0){
                    totalPage++;
                }
                List<User> list;
                int page;
                if(request.getParameter("page") == null || Integer.parseInt(request.getParameter("page"))<1 || Integer.parseInt(request.getParameter("page"))> totalPage){
                    page=1;
                     list = UserModel.pagingUser(1);
                }else {
                    page = Integer.parseInt(request.getParameter("page"));
                    list = UserModel.pagingUser(page);
                }
                request.setAttribute("currentPage",page);
                request.setAttribute("totalPage",totalPage);
                request.setAttribute("users",list);
                LocalDateTime now = LocalDateTime.now();
                request.setAttribute("now",now);
                ServletUtils.forward("/views/vwUser/Index.jsp", request, response);
                break;

            case "/AddUser":
                ServletUtils.forward("/views/vwUser/AddUser.jsp", request, response);
                break;
            case "/EditUser":
                String username =request.getParameter("username");
                User u = UserModel.findByUsername(0,username);
                if(u != null){
                    request.setAttribute("user",u);
                    ServletUtils.forward("/views/vwUser/EditUser.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Admin/User", request, response);
                }
                break;
            case "/IsAvailable":
                String userName = request.getParameter("user");
                int id = Integer.parseInt(request.getParameter("id"));
                User user = UserModel.findByUsername(id,userName);
                boolean isAvailable = (user==null);
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(isAvailable);
                out.flush();
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
            case "/AddUser":
                addUser(request, response);
                break;
            case "/UpdateUser":
                updateUser(request, response);
                break;
            case "/ExtendUser":
                updateExUser(request, response);
                break;
            case "/DeleteUser":
                deleteUser(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private static void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pen_name = request.getParameter("pen_name");
        String username = request.getParameter("username");
        String rawpassword = request.getParameter("rawpassword");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12,rawpassword.toCharArray());
        String email = request.getParameter("email");
        int role = Integer.parseInt(request.getParameter("role"));
        String StrDob = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
        LocalDate dob = LocalDate.parse(StrDob, df);
        LocalDateTime issue_at= LocalDateTime.now();
        LocalDateTime expriration = issue_at.plusDays(7);
        User u = new User(0,role,username, bcryptHashString, name, email, pen_name, dob, issue_at, expriration);
        UserModel.add(u);
        ServletUtils.redirect("/Admin/User", request, response);
    }

    private static void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String pen_name = request.getParameter("pen_name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        int role = Integer.parseInt(request.getParameter("role"));
        String StrDob = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
        LocalDate dob = LocalDate.parse(StrDob, df);
        LocalDateTime issue_at= LocalDateTime.parse(request.getParameter("issue_at"));
        LocalDateTime expriration = LocalDateTime.parse(request.getParameter("expriration"));
        String rawpassword = request.getParameter("rawpassword");
        User u = UserModel.findByUsername(0,username);
        String bcryptHashString;
        if(rawpassword.equals(u.getPassword())){
            bcryptHashString = rawpassword;
        }
        else {
            bcryptHashString = BCrypt.withDefaults().hashToString(12,rawpassword.toCharArray());
        }
        User user = new User(id,role,username, bcryptHashString, name, email, pen_name, dob, issue_at, expriration);
        UserModel.update(user);
        ServletUtils.redirect("/Admin/User", request, response);
    }

    private static void updateExUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        LocalDateTime expriration = LocalDateTime.parse(request.getParameter("expriration"));
        if(expriration.isBefore(LocalDateTime.now())){
            expriration =LocalDateTime.now().plusDays(7);
        }else {
            expriration = expriration.plusDays(7);
        }
        UserModel.updateEx(id, expriration);
        ServletUtils.redirect("/Admin/User", request, response);
    }

    private static void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username =request.getParameter("username");
        UserModel.delete(username);
        ServletUtils.redirect("/Admin/User", request, response);
    }
}
