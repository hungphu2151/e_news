<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light shadow" style="background-color: aquamarine">
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
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-light my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>