<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div class="card">
  <h4 class="card-header">
    Editor
  </h4>
  <div class="list-group ">
    <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Editor/Article">
      Quản lí bài viết
    </a>
    <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Editor/Article/AcceptedArticle">
      Quản lí bài viết đã được duyệt
    </a>
    <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/Editor/Article/RefusedArticle">
      Quản lí bài viết bị từ chối
    </a>
  </div>
</div>



