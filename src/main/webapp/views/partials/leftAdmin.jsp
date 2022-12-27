<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div class="card">
    <h4 class="card-header">
        Admin
    </h4>
    <div class="list-group ">
        <a class="list-group-item list-group-item-action"  href="${pageContext.request.contextPath}/Admin/Category">
            Quản lí danh mục
        </a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Admin/Tag">
            Quản lí nhãn
        </a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Admin/Article">
            Quản lí bài viết
        </a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Admin/User" >
            Quản lí người dùng
        </a>
    </div>
</div>



