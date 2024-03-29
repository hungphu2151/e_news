package com.example.e_news.filters;

import com.example.e_news.beans.User;
import com.example.e_news.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "WriterFilter")
public class WriterFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest requestAdmin = (HttpServletRequest) request;
        HttpSession session = requestAdmin.getSession();
        User u = (User)session.getAttribute("authUser");
        if (u.getRole()!=3){
            session.setAttribute("reUrl",((HttpServletRequest) request).getRequestURI());
            ServletUtils.redirect("/Home", (HttpServletRequest) request, (HttpServletResponse) response);
            return;
        }
        chain.doFilter(request, response);
    }
}
