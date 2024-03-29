<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article" />
<jsp:useBean id="cmts" scope="request" type="java.util.List<com.example.e_news.beans.Cmt>" />
<jsp:useBean id="user" scope="request" type="java.util.List<com.example.e_news.beans.User>" />
<jsp:useBean id="sameCat" scope="request" type="java.util.List<com.example.e_news.beans.Article>" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="tagbyArt" scope="request" type="java.util.List<com.example.e_news.beans.Tag>"/>
<jsp:useBean id="list_tag" scope="request" type="java.util.List<com.example.e_news.beans.Tag>" />
<jsp:useBean id="list_tags_has_articles" scope="request" type="java.util.List<com.example.e_news.beans.Tags_has_articles>" />

<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
  <jsp:body>
    <div>
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
          <div class="d-flex justify-content-end">
            <c:forEach items="${tagbyArt}" var="t">
              <a href="${pageContext.request.contextPath}/Article/ByTag?id=${t.id_tag}">
                <div>#${t.value}</div>
              </a>
            </c:forEach>
          </div>
        </div>
      </div>
      <div class="card mb-3" style="width: 50%">
        <div class="card-header">
          Bình luận
        </div>
        <div class="card-body">
          <c:choose>
            <c:when test="${cmts.size()==0}">
              <div class="d-flex flex-column bd-highlight mb-3 ml-3">
                <div class="p-2 bd-highlight">Chưa có bình luận!</div>
              </div>
            </c:when>
            <c:otherwise>
              <c:forEach items="${cmts}" var="c">
                <div class="d-flex flex-column bd-highlight mb-3 ml-3">
                  <div class="p-2 bd-highlight mr-5">
                    <c:forEach items="${user}" var="u">
                      <c:if test="${c.user_id==u.id}">
                        ${u.name}
                      </c:if>
                    </c:forEach>
                  </div>
                  <div class="p-2 bd-highlight">
                    <div class="card border-info mb-3" style="max-width: 30rem;">
                      <div class="card-body text-info">${c.comment}</div>
                      <div class="card-footer d-flex justify-content-end">
                          ${c.date.dayOfMonth}/${c.date.monthValue}/${c.date.year}  ${c.date.hour}:${c.date.minute}:${c.date.second}
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          <div class="d-flex flex-column bd-highlight ml-3">
            <form method="post" action="${pageContext.request.contextPath}/Article/Detail?id=${article.id_article}">
              <div class="form-group p-2 bd-highlight" rows="4">
                <label for="txtCmt">Hãy bình luận của bạn</label>
                <textarea id="txtCmt" name="Cmt" rows="4" class="form-control mb-2" style="max-width: 30rem;"></textarea>
                <button type="submit" class="btn btn-info">
                  Đăng bình luận
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <c:choose>
        <c:when test="${sameCat.size() == 0}">
          <div class="card-body">
            <p class="card-text">Không có dữ liệu phù hợp!</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="card-header">
              <h5 class="">Cùng chuyên mục</h5>
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
                            ${a.public_date.dayOfMonth}/${s.public_date.monthValue}/${s.public_date.year}  ${s.public_date.hour}:${s.public_date.minute}:${s.public_date.second}
                        </div>
                        <div class="d-flex justify-content-end text-danger">
                          <c:forEach items="${categoriesWithDetails}" var="c">
                            <c:if test="${s.category_id==c.id_category}">
                              <a href="${pageContext.request.contextPath}/Article/ByCat?id=${s.category_id}">
                                  ${c.name}
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="d-flex justify-content-end">
                          <c:forEach items="${list_tags_has_articles}" var="t_h_a">
                            <c:if test="${s.id_article==t_h_a.article_id}">
                              <c:forEach items="${list_tag}" var="t">
                                <c:if test="${t_h_a.tag_id==t.id_tag}">
                                  <a href="${pageContext.request.contextPath}/Article/ByTag?id=${t.id_tag}">
                                    <div>#${t.value}</div>
                                  </a>
                                </c:if>
                              </c:forEach>
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
                          <a id="txtDetail" class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Article/Detail?id=${s.id_article}" role="button">
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
    </div>
  </jsp:body>
</t:main>