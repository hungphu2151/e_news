<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftEditor.jsp"/>
    </jsp:attribute>

  <jsp:body>
    <form action="" method="post" id="frmUser">
      <div class="card">
        <h4 class="card-header ">
          Chỉnh sửa bài viết
        </h4>
        <div class="card-body">
          <h4 class="card-header">
              ${article.title}
          </h4>
          <img src="${pageContext.request.contextPath}/public/imgs/articles/${article.id_article}/main.jpg" alt="${article.title}" title="${article.title}">
          <p class="card-text mt-3">${article.content}</p>
          <div class="d-flex justify-content-end">
              ${article.public_date}
          </div>
          <c:choose>
            <c:when test="${article.status == 1 }">
              <div class="d-flex justify-content-end" style="color: #28a745">
                Đã được duyệt
              </div>
            </c:when>
            <c:when test="${article.status == 2 }">
              <div class="d-flex justify-content-end" style="color: blue">
                Đã được duyệt
              </div>
            </c:when>
            <c:when test="${article.status == 3}">
              <div class="d-flex justify-content-end" style="color: sandybrown">
                Chưa được duyệt
              </div>
            </c:when>
            <c:otherwise >
              <div class="d-flex justify-content-end" style="color: red">
                Bị từ chối
              </div>
            </c:otherwise>
          </c:choose>

          <div class="form-group">
            <input type="text" class="form-control w-25" id="txtID" name="id" value="${article.id_article}" hidden="hidden">
          </div>
        </div>
        <div class="card-footer">
          <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Editor/Article/" role="button">
            <i class="fa fa-backward" aria-hidden="true"></i>
            Quay lại
          </a>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>

