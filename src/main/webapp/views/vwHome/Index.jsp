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
        <div class="card mb-3">
            <div class="card-header">
                    <h5>Xem nhiều</h5>
            </div>
            <div class="card-body d-flex justify-content-center">
                <div style="width: 50%">
                    <div id="carouselExampleCaptions1" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                            <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="${pageContext.request.contextPath}/public/imgs/articles/1/main.jpg" class="d-block w-100" alt="..." >
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>First slide label</h5>
                                    <p>Some representative placeholder content for the first slide.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/public/imgs/articles/2/main.jpg" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Second slide label</h5>
                                    <p>Some representative placeholder content for the second slide.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/public/imgs/articles/3/main.jpg" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Third slide label</h5>
                                    <p>Some representative placeholder content for the third slide.</p>
                                </div>
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <c:choose>
            <c:when test="${countCmt.size() == 0}">
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="noi_bat">
                            <h5>Nỗi bật</h5>
                        </a>
                    </div>
                    <div class="card-body">
                    </div>
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
                                                    ${count.public_date.dayOfMonth}/${count.public_date.monthValue}/${count.public_date.year}  ${count.public_date.hour}:${count.public_date.minute}:${count.public_date.second}
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
                                            <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${count.views}</div>
                                            <div class="d-flex flex-row">
                                                <div class="d-flex align-items-center text-warning mr-1">
                                                    <c:if test="${a.premium==1}">
                                                        Premium
                                                    </c:if>
                                                </div>
                                                <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${count.id_article}" role="button">
                                                    Details
                                                </a>
                                            </div>
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
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="xem_nhieu">
                            <h5>Xem nhiều</h5>
                        </a>
                    </div>
                    <div class="card-body">
                    </div>
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
                                                    ${v.public_date.dayOfMonth}/${v.public_date.monthValue}/${v.public_date.year}  ${v.public_date.hour}:${v.public_date.minute}:${v.public_date.second}
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
                                            <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${v.views}</div>
                                            <div class="d-flex flex-row">
                                                <div class="d-flex align-items-center text-warning mr-1">
                                                    <c:if test="${v.premium==1}">
                                                        Premium
                                                    </c:if>
                                                </div>
                                                <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${v.id_article}" role="button">
                                                    Details
                                                </a>
                                            </div>
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
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="moi_nhat">
                            <h5>Mới nhất</h5>
                        </a>
                    </div>
                    <div class="card-body">
                    </div>
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
                                                    ${d.public_date.dayOfMonth}/${d.public_date.monthValue}/${d.public_date.year}  ${d.public_date.hour}:${d.public_date.minute}:${d.public_date.second}
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
                                            <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${d.views}</div>
                                            <div class="d-flex flex-row">
                                                <div class="d-flex align-items-center text-warning mr-1">
                                                    <c:if test="${d.premium==1}">
                                                        Premium
                                                    </c:if>
                                                </div>
                                                <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${d.id_article}" role="button">
                                                    Details
                                                </a>
                                            </div>
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
                <div class="card mb-3">
                    <div class="card-header">
                        <a name="top10">
                        </a>
                    </div>
                    <div class="card-body">
                    </div>
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
                                                    ${t.public_date.dayOfMonth}/${t.public_date.monthValue}/${t.public_date.year}  ${t.public_date.hour}:${t.public_date.minute}:${t.public_date.second}
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
                                            <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${t.views}</div>
                                            <div class="d-flex flex-row">
                                                <div class="d-flex align-items-center text-warning mr-1">
                                                    <c:if test="${t.premium==1}">
                                                        Premium
                                                    </c:if>
                                                </div>
                                                <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${t.id_article}" role="button">
                                                    Details
                                                </a>
                                            </div>
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

