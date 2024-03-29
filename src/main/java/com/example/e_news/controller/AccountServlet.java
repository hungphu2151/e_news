package com.example.e_news.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.example.e_news.beans.User;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "AccountServlet", value = "/Account/*")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        switch (path){
            case "/Register":
                ServletUtils.forward("/views/vwAccount/Register.jsp", request, response);
                break;
            case "/Login":
                HttpSession session = request.getSession();
                if ((boolean) session.getAttribute("auth")) {
                    ServletUtils.redirect("/Home", request, response);
                } else ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
                break;
            case "/ChangePassword":
                ServletUtils.forward("/views/vwAccount/ChangePassword.jsp", request, response);
                break;
            case "/Profile":
                ServletUtils.forward("/views/vwAccount/Profile.jsp", request, response);
                break;
            case "/IsAvailable":
                String username = request.getParameter("user");
                User user = UserModel.findByUsername(0,username);
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
            case "/Register":
                registerUser(request, response);
                break;
            case "/Login":
                login(request,response);
                break;
            case "/Profile":
                updateProfile(request,response);
                break;
            case "/ChangePassword":
                changePassword(request, response);
                break;
            case "/Logout":
                logout(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private static void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String rawpwd = request.getParameter("rawpwd");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String StrDob = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
        LocalDate dob = LocalDate.parse(StrDob, df);
        HttpSession session =request.getSession();
        String captcha =session.getAttribute("dns_security_code").toString();
        String verifyCaptcha = request.getParameter("captcha");

        if(captcha.equals(verifyCaptcha)){
            String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());
            LocalDateTime issue_at = LocalDateTime.now();
            LocalDateTime expriration =LocalDateTime.now().plusDays(7);
            String pen_name = "";
            int role = 4;
            User c = new User(0,role,username, bcryptHashString, name, email, pen_name, dob, issue_at, expriration);
            UserModel.add(c);
            request.setAttribute("success",true);
            ServletUtils.forward("/views/vwAccount/Register.jsp", request, response);
        }else {
            request.setAttribute("error","Mã Captcha không trùng khớp");
            request.setAttribute("username",username);
            request.setAttribute("rawpwd",rawpwd);
            request.setAttribute("name",name);
            request.setAttribute("email",email);
            request.setAttribute("dob",StrDob);
            ServletUtils.forward("/views/vwAccount/Register.jsp", request, response);
        }
    }

    private static void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = UserModel.findByUsername(0,username);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified){
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", user);
                ServletUtils.redirect("/Home", request, response);
            }
            else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMassage", "Invalid Login!");
                ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
            }
        }
        else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMassage", "Invalid Login!");
            ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
        }
    }
    private static void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());
        String url = request.getHeader("referer");
        if (url == null) url = "/Home";
        ServletUtils.redirect(url, request, response);
    }

    private static void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException    {
        String name = request.getParameter("name");
        String pen_name = request.getParameter("pen_name");
        String username = request.getParameter("username");
        String StrDob = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
        LocalDate dob = LocalDate.parse(StrDob, df);
        String email = request.getParameter("email");
        User u = new  User(username, name, email, pen_name, dob);
        UserModel.updateProfile(u);
        User user= UserModel.findByUsername(0,u.getUsername());
        HttpSession session = request.getSession();
        session.setAttribute("authUser", user);
        ServletUtils.redirect("/Account/Profile", request, response);
    }

    private static void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException    {
        String username = request.getParameter("username");
        String rawpwd = request.getParameter("rawpwd");
        String newRawpwd = request.getParameter("newRawpwd");
        User user = UserModel.findByUsername(0,username);
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, newRawpwd.toCharArray());
        BCrypt.Result result = BCrypt.verifyer().verify(rawpwd.toCharArray(), user.getPassword());
        if (result.verified) {
            User u = new  User(username, bcryptHashString);
            UserModel.updatePassword(u);
            request.setAttribute("success",true);
            ServletUtils.redirect("/Account/Profile", request, response);
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMassage", "Mật khẩu không đúng");
            ServletUtils.forward("/views/vwAccount/ChangePassword.jsp", request, response);
        }
    }
}
