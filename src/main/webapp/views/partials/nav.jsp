<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"></jsp:useBean>

<nav class="navbar navbar-expand-lg navbar-light shadow sticky-top" style="background-color: aquamarine">
  <a class="navbar-brand" href="">
    <i class="fa fa-newspaper-o" aria-hidden="true"></i>
  </a>
  <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarSupportedContent">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/Home/Index">Trang chủ <span class="sr-only">(current)</span></a>
      </li>
    </ul>
    <span style="color: red; font-size:25px; font-weight: bold">E_NEWS</span>
    <ul class="navbar-nav">
      <c:choose>
        <c:when test="${auth}">
          <form id="formLogout" method="post" action="${pageContext.request.contextPath}/Account/Logout"></form>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Hi <b>${authUser.name}!</b>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">
                <i class="fa fa-user" aria-hidden="true"></i>
                Hồ sơ
              </a>
              <c:if test="${authUser.role==1}">
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/Category">
                  <i class="fa fa-dashboard" aria-hidden="true"></i>
                  Dashboard
                </a>
              </c:if>
              <c:if test="${authUser.role==2}">
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/Editor/Article">
                  <i class="fa fa-edit" aria-hidden="true"></i>
                  Duyệt bài viết
                </a>
              </c:if>
              <c:if test="${authUser.role==3}">
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/Misc/Writer">
                  <i class="fa fa-newspaper-o" aria-hidden="true"></i>
                  Đăng bài viết
                </a>
              </c:if>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="javascript: $('#formLogout').submit()">
                <i class="fa fa-sign-out" aria-hidden="true"></i>
                Thoát
              </a>
            </div>
          </li>
        </c:when>
        <c:otherwise>
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/Account/Register">Đăng ký</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/Account/Login">Đăng nhập</a>
          </li>
        </c:otherwise>
      </c:choose>

    </ul>
  </div>
</nav>