<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="articles" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="cat" scope="request" type="com.example.e_news.beans.Category" />

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
  <jsp:attribute name="js">
    <script>
    </script>
  </jsp:attribute>
  <jsp:body>
      <c:choose>
        <c:when test="${articles.size() == 0}">
          <div class="card-body">
            <p class="card-text">Không có dữ liệu phù hợp!</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="card-header">
              <h5 class="">${cat.name}</h5>
            </div>
            <c:forEach items="${articles}" var="a">
              <div class="card-body">
                <div class="row">
                  <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                    <div class="col-sm-3 mb-2 mt-2 align-self-center">
                      <img src="${pageContext.request.contextPath}/public/imgs/articles/${a.id_article}/main.jpg" alt="${a.title}" title="${a.title}" class="card-img-top">
                    </div>
                    <div class="col-sm-9 mb-2 mt-2">
                      <div class="card-body">
                        <h5 class="card-title">${a.title}</h5>
                        <p class="card-text">${a.sumary}</p>
                        <div class="d-flex justify-content-end">
                            ${a.public_date.dayOfMonth}/${a.public_date.monthValue}/${a.public_date.year}  ${a.public_date.hour}:${a.public_date.minute}:${a.public_date.second}
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
                        <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${a.views}</div>
                        <div class="d-flex flex-row">
                          <div class="d-flex align-items-center text-warning mr-1">
                            <c:if test="${a.premium==1}">
                              Premium
                            </c:if>
                          </div>
                          <a id="btn_detail" class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${a.id_article}" role="button">
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

