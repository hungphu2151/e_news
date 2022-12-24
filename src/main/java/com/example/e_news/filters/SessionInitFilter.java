package com.example.e_news.filters;


import com.example.e_news.beans.Category;
import com.example.e_news.beans.User;
import com.example.e_news.models.CategoryModel;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "SessionInitFilter", value = "/*")
public class SessionInitFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session =  request.getSession();
        if (session.getAttribute("auth")==null)
        {
            session.setAttribute("auth", false);
            session.setAttribute("authUser", new User());
        }
        chain.doFilter(req, res);
    }
}
