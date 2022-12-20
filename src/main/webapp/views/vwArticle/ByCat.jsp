<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="articles" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
  <jsp:body>
    <div class="card">
      <h5 class="card-header">Article</h5>
      <c:choose>
        <c:when test="${articles.size() == 0}">
          <div class="card-body">
            <p class="card-text">Không có dữ liệu phù hợp!</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card-body">
            <div class="row">
              <c:forEach items="${articles}" var="a">
                <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                      <img src="${pageContext.request.contextPath}/public/imgs/articles/${a.id_article}/main.jpg" alt="${a.title}" title="${a.title}" class="card-img-top">
                    </div>
                    <div class="col-sm-9 mb-2 mt-2">
                      <div class="card-body">
                        <h5 class="card-title">${a.title}</h5>
                        <p class="card-text">${a.sumary}</p>
                        <div class="d-flex justify-content-end">
                            ${a.public_date}
                        </div>
                        <div class="d-flex justify-content-end text-danger">
                          <c:forEach items="${categoriesWithDetails}" var="c">
                            <c:if test="${a.category_id==c.id_category}">
                              ${c.name}
                            </c:if>
                          </c:forEach>
                        </div>
                      </div>
                      <div class="card-footer d-flex justify-content-md-between">
                        <div mr-3><i class="fa fa-eye" aria-hidden="true"></i>${a.views}</div>
                        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${a.id_article}" role="button">
                          Details
                        </a>
                      </div>
                    </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="card-footer text-muted">
        2 months ago!
      </div>
    </div>
  </jsp:body>
</t:main>

