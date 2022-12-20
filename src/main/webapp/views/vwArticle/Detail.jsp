<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article" />
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
  <jsp:body>
    <div class="card mb-3">
      <h4 class="card-header">
          ${article.title}
      </h4>
      <div class="card-body">
        <img src="${pageContext.request.contextPath}/public/imgs/articles/${article.id_article}/main.jpg" alt="${article.title}" title="${article.title}">
        <p class="card-text mt-3">${article.content}</p>
        <div class="d-flex justify-content-end">
            ${article.public_date}
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
      <div class="card col-sm-8">
        <from>
          <div class="form-group" rows="4">
            <label for="txtCmt">A hãy bình luận của bạn</label>
            <textarea id="txtCmt" name="username" cols="30" rows="4" class="form-control"></textarea>
          </div>
          <button type="submit" class="btn btn-info mb-2">
            Đăng bình luận
          </button>
        </from>
      </div>
    <div class="card col-sm-8 mt-3">
      <h5>Bình luận</h5>
    </div>


  </jsp:body>
</t:main>