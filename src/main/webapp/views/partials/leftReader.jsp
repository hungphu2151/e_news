<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<div class="card">
    <h4 class="card-header">
        Danh mục
    </h4>
    <div class="list-group list-group-flush">
    <c:forEach items="${categoriesWithDetails}" var="c">
        <c:if test="${c.parent_id == '0'}">
            <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    ${c.name}
            </button>
<%--            <div class="dropdown-menu">--%>
            <c:forEach items="${categoriesWithDetails}" var="child">
                <c:if test="${child.parent_id == c.id_category}">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/Article/ByCat?id=${child.id_category}">
                            ${child.name}
                    </a>
                </c:if>
            </c:forEach>
<%--            </div>--%>
        </c:if>
    </c:forEach>
    </div>
</div>

