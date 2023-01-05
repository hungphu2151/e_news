<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="tagWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Tag>"/>

<div>
    <form class="form-inline" action="">
        <input id="txtSearch" name="txtResult" class="form-control" type="search" placeholder="Search" aria-label="Search" style="width: 100%">
        <button class="btn btn-light " type="submit">Search</button>
    </form>
</div>
<div class="card mt-3">
    <h4 class="card-header">
        Danh mục
    </h4>
    <div class="card">
        <c:forEach items="${categoriesWithDetails}" var="c">
            <c:if test="${c.parent_id == '0'}">
                <div class="btn-group mb-1">
                    <button type="button" class="btn btn-info dropdown-toggle d-flex justify-content-between align-items-center" data-toggle="dropdown" data-display="static" aria-expanded="false">
                            ${c.name}
                    </button>
                    <div class="dropdown-menu dropdown-menu-lg-right">
                        <c:forEach items="${categoriesWithDetails}" var="child">
                            <c:if test="${c.id_category == child.parent_id}">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/Article/ByCat?id=${child.id_category}">
                                        ${child.name}
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<div class="btn-group mt-3" style="width: 100%;">
    <button type="button" class="btn btn-success dropdown-toggle d-flex justify-content-between align-items-center" data-toggle="dropdown" data-display="static" aria-expanded="false" >
        Nhãn
    </button>
    <div class="dropdown-menu dropdown-menu-lg-right">
        <c:forEach items="${tagWithDetails}" var="t">
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Article/ByTag?id=${t.id_tag}">
                    ${t.value}
            </a>
        </c:forEach>
    </div>
</div>
