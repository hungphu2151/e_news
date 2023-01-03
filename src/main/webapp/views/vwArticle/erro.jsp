<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article" />
<jsp:useBean id="cmts" scope="request" type="java.util.List<com.example.e_news.beans.Cmt>" />
<jsp:useBean id="user" scope="request" type="java.util.List<com.example.e_news.beans.User>" />
<jsp:useBean id="sameCat" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
  <jsp:body>
    <div class="card mb-3">
      <h4 class="card-header">
          ${article.title}
      </h4>
      <div class="card-body">
        <h2>Đăng nhập để xem bài viết</h2>
      </div>
    </div>
    <div>
      <c:choose>
        <c:when test="${sameCat.size() == 0}">
          <div class="card-body">
            <p class="card-text">Không có dữ liệu phù hợp!</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="card-header">
              <h5 class="">
                Cùng chuyên mục
              </h5>
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
                        <div class="d-flex align-items-center"><i class="fa fa-eye" aria-hidden="true"></i>${s.views}</div>
                        <div class="d-flex flex-row">
                          <div class="d-flex align-items-center text-warning mr-1">
                            <c:if test="${s.premium==1}">
                              Premium
                            </c:if>
                          </div>
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
        </c:otherwise>
      </c:choose>
    </div>
  </jsp:body>
</t:main>