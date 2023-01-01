package com.example.e_news.controller;


import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.models.CategoryModel;
import com.example.e_news.models.UserModel;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;




@WebServlet(name = "AdminCategoryServlet", value = "/Admin/Category/*")
public class AdminCategoryServlet extends HttpServlet {
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
                List<User> listE = UserModel.findByRole(2);
                request.setAttribute("editors",listE);
                List<Category> list = CategoryModel.findAll();
                request.setAttribute("categories",list);
                ServletUtils.forward("/views/vwCategory/Index.jsp", request, response);
                break;

            case "/AddMainCategory":
                int roleEditor = 2;
                List<User> listEditor = UserModel.findByRole(roleEditor);
                request.setAttribute("editors",listEditor);
                ServletUtils.forward("/views/vwCategory/AddMainCategory.jsp", request, response);
                break;

            case "/AddSubCategory":
                List<Category> listMainCategory = CategoryModel.findMainCategory();
                request.setAttribute("mainCategories",listMainCategory);
                ServletUtils.forward("/views/vwCategory/AddSubCategory.jsp", request, response);
                break;

            case "/EditMainCategory":
                int id =0;
                try{
                    id = Integer.parseInt(request.getParameter("id"));
                }catch (NumberFormatException e){

                }
                int roleEditor1 = 2;
                List<User> listEditor1 = UserModel.findByRole(roleEditor1);
                request.setAttribute("editors",listEditor1);

                Category c = CategoryModel.findMainCategoryById(id);
                if(c != null){
                    request.setAttribute("category",c);
                    ServletUtils.forward("/views/vwCategory/EditMainCategory.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Admin/Category", request, response);
                }
                break;
            case "/EditSubCategory":
                int idSubCat =0;
                try{
                    idSubCat = Integer.parseInt(request.getParameter("id"));
                }catch (NumberFormatException e){

                }
                List<Category> listCategory = CategoryModel.findMainCategory();
                request.setAttribute("mainCategories",listCategory);

                Category sc = CategoryModel.findSubCategoryById(idSubCat);
                if(sc != null){
                    request.setAttribute("category",sc);
                    ServletUtils.forward("/views/vwCategory/EditSubCategory.jsp", request, response);
                }else {
                    ServletUtils.redirect("/Admin/Category", request, response);
                }
                break;
            case "/IsAvailable":
                String name = request.getParameter("name");
                Category category;
                if(request.getParameter("id") != null){
                    int id_category= Integer.parseInt(request.getParameter("id"));
                     category = CategoryModel.findByName(id_category,name);
                }else {
                     category = CategoryModel.findByName(0,name);
                }
                boolean isAvailable = (category==null);
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
            case "/AddMainCategory":
                addMainCategory(request, response);
                break;
            case "/AddSubCategory":
                addSubCategory(request,response);
                break;
            case "/UpdateMainCategory":
                updateMainCategory(request, response);
                break;
            case "/UpdateSubCategory":
                updateSubCategory(request, response);
                break;

            case "/Delete":
                deleteMainCategory(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private static void addMainCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id"));
        Category c = new Category(name,0,id);
        CategoryModel.add(c);
        ServletUtils.redirect("/Admin/Category", request, response);
    }

    private static void addSubCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id"));
        Category c = new Category(name,id,0);
        CategoryModel.add(c);
        ServletUtils.redirect("/Admin/Category", request, response);
    }

    private static void updateMainCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id_category"));
        int idEditor = Integer.parseInt(request.getParameter("id_editor"));
        Category c = new Category(id,0,idEditor,name);
        CategoryModel.update(c);
        ServletUtils.redirect("/Admin/Category", request, response);
    }

    private static void updateSubCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id_category"));
        int idMainCat = Integer.parseInt(request.getParameter("id_parent"));
        Category c = new Category(id,idMainCat,0,name);
        CategoryModel.update(c);
        ServletUtils.redirect("/Admin/Category", request, response);
    }

    private static void deleteMainCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id_category"));
        System.out.println(id);
        CategoryModel.delete(id,0);
        ServletUtils.redirect("/Admin/Category", request, response);
    }
}

