<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article" />
<jsp:useBean id="cmts" scope="request" type="java.util.List<com.example.e_news.beans.Cmt>" />
<jsp:useBean id="user" scope="request" type="java.util.List<com.example.e_news.beans.User>" />
<jsp:useBean id="sameCat" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftWriter.jsp"/>
  </jsp:attribute>
    <jsp:body>
        <div class="card mb-3">
            <h4 class="card-header">
                    ${article.title}
            </h4>
            <div class="card-body">
                <img src="${pageContext.request.contextPath}/public/imgs/articles/${article.id_article}/main.jpg" alt="${article.title}" title="${article.title}">
                <p class="card-text mt-3">${article.content}</p>
                <div class="d-flex justify-content-end">
                        ${article.public_date.dayOfMonth}/${article.public_date.monthValue}/${article.public_date.year}  ${article.public_date.hour}:${article.public_date.minute}:${article.public_date.second}
                </div>
                <div class="d-flex justify-content-end">
                    <c:forEach items="${categoriesWithDetails}" var="c">
                        <c:if test="${article.category_id==c.id_category}">
                            <a href="${pageContext.request.contextPath}/Article/ByCat?id=${article.category_id}">
                                    ${c.name}
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>

                        <c:forEach items="${sameCat}" var="s">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                        <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                            <img src="${pageContext.request.contextPath}/public/imgs/articles/${s.id_article}/main.jpg" alt="${s.title}" title="${s.title}" class="card-img-top">
                                        </div>
                                        <div class="col-sm-9 mb-2 mt-2">
                                            <div class="card-body">
                                                <h5 class="card-title">${s.title}</h5>
                                                <p class="card-text">${s.sumary}</p>
                                                <div class="d-flex justify-content-end">
                                                        ${s.public_date.dayOfMonth}/${s.public_date.monthValue}/${s.public_date.year}  ${s.public_date.hour}:${s.public_date.minute}:${s.public_date.second}
                                                </div>
                                                <div class="d-flex justify-content-end text-danger">
                                                    <c:forEach items="${categoriesWithDetails}" var="c">
                                                        <c:if test="${s.category_id==c.id_category}">
                                                            ${c.name}
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="card-footer d-flex justify-content-md-between">
                                                <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${s.views}</div>
                                                <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${s.id_article}" role="button">
                                                    Details
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
        </div>
    </jsp:body>
</t:main>