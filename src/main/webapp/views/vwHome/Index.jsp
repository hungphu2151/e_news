<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="views" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="dates" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="top10" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="countCmt" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
    <jsp:attribute name="left_home">
        <jsp:include page="../../views/partials/leftHome.jsp"/>
    </jsp:attribute>
    <jsp:body>
        <c:choose>
            <c:when test="${countCmt.size() == 0}">
                <div class="card-body mb-3">
                    <p class="card-text">Không có dữ liệu phù hợp!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="noi_bat">
                            <h5>Nỗi bật</h5>
                        </a>
                    </div>
                    <c:forEach items="${countCmt}" var="count">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                        <img src="${pageContext.request.contextPath}/public/imgs/articles/${count.id_article}/main.jpg" alt="${count.title}" title="${count.title}" class="card-img-top">
                                    </div>
                                    <div class="col-sm-9 mb-2 mt-2">
                                        <div class="card-body">
                                            <h5 class="card-title">${count.title}</h5>
                                            <p class="card-text">${count.sumary}</p>
                                            <div class="d-flex justify-content-end">
                                                    ${count.public_date}
                                            </div>
                                            <div class="d-flex justify-content-end text-danger">
                                                <c:forEach items="${categoriesWithDetails}" var="c">
                                                    <c:if test="${count.category_id==c.id_category}">
                                                        ${c.name}
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex justify-content-md-between">
                                            <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${count.views}</div>
                                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${count.id_article}" role="button">
                                                Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${views.size() == 0}">
                <div class="card-body mb-3">
                    <p class="card-text">Không có dữ liệu phù hợp!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="xem_nhieu">
                            <h5>Xem nhiều</h5>
                        </a>
                    </div>
                    <c:forEach items="${views}" var="v">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                        <img src="${pageContext.request.contextPath}/public/imgs/articles/${v.id_article}/main.jpg" alt="${v.title}" title="${v.title}" class="card-img-top">
                                    </div>
                                    <div class="col-sm-9 mb-2 mt-2">
                                        <div class="card-body">
                                            <h5 class="card-title">${v.title}</h5>
                                            <p class="card-text">${v.sumary}</p>
                                            <div class="d-flex justify-content-end">
                                                    ${v.public_date}
                                            </div>
                                            <div class="d-flex justify-content-end text-danger">
                                                <c:forEach items="${categoriesWithDetails}" var="c">
                                                    <c:if test="${v.category_id==c.id_category}">
                                                        ${c.name}
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex justify-content-md-between">
                                            <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${v.views}</div>
                                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${v.id_article}" role="button">
                                                Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${dates.size() == 0}">
                <div class="card-body mb-3">
                    <p class="card-text">Không có dữ liệu phù hợp!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="moi_nhat">
                            <h5>Mới nhất</h5>
                        </a>
                    </div>
                    <c:forEach items="${dates}" var="d">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                        <img src="${pageContext.request.contextPath}/public/imgs/articles/${d.id_article}/main.jpg" alt="${d.title}" title="${d.title}" class="card-img-top">
                                    </div>
                                    <div class="col-sm-9 mb-2 mt-2">
                                        <div class="card-body">
                                            <h5 class="card-title">${d.title}</h5>
                                            <p class="card-text">${d.sumary}</p>
                                            <div class="d-flex justify-content-end">
                                                    ${d.public_date}
                                            </div>
                                            <div class="d-flex justify-content-end text-danger">
                                                <c:forEach items="${categoriesWithDetails}" var="c">
                                                    <c:if test="${d.category_id==c.id_category}">
                                                        ${c.name}
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex justify-content-md-between">
                                            <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${d.views}</div>
                                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${d.id_article}" role="button">
                                                Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${top10.size() == 0}">
                <div class="card-body mb-3">
                    <p class="card-text">Không có dữ liệu phù hợp!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card mb-3">
                    <a name="top10">
                    </a>
                    <c:forEach items="${top10}" var="t">
                        <div class="card-header">
                            <h5>
                                <c:forEach items="${categoriesWithDetails}" var="c">
                                    <c:if test="${t.category_id==c.id_category}">
                                        ${c.name}
                                    </c:if>
                                </c:forEach>
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                        <img src="${pageContext.request.contextPath}/public/imgs/articles/${t.id_article}/main.jpg" alt="${t.title}" title="${t.title}" class="card-img-top">
                                    </div>
                                    <div class="col-sm-9 mb-2 mt-2">
                                        <div class="card-body">
                                            <h5 class="card-title">${t.title}</h5>
                                            <p class="card-text">${t.sumary}</p>
                                            <div class="d-flex justify-content-end">
                                                    ${t.public_date}
                                            </div>
                                            <div class="d-flex justify-content-end text-danger">
                                                <c:forEach items="${categoriesWithDetails}" var="c">
                                                    <c:if test="${t.category_id==c.id_category}">
                                                        ${c.name}
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex justify-content-md-between">
                                            <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${t.views}</div>
                                            <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${t.id_article}" role="button">
                                                Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </jsp:body>
</t:main>

