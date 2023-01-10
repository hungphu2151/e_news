<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article"/>
<jsp:useBean id="category" scope="request" type="com.example.e_news.beans.Category"/>
<jsp:useBean id="tagbyArt" scope="request" type="java.util.List<com.example.e_news.beans.Tag>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftWriter.jsp"/>
    </jsp:attribute>

  <jsp:body>
    <form action="" method="post" id="frmUser">
      <div class="card">
        <h4 class="card-header d-flex justify-content-between">
            ${article.title}
        </h4>

        <div class="card-body">
          <p class="card-text mt-3"><i>${article.sumary}</i></p>
          <div class="mt-4 text-center">
            <img src="${pageContext.request.contextPath}/public/imgs/articles/${article.id_article}/main.jpg" alt="${article.title}" title="${article.title}" style="width: 80%">
          </div>
          <p class="card-text mt-4">${article.content}</p>
          <div class="d-flex justify-content-end">
            Thuộc chuyên mục:&nbsp; <b> <i>${category.name}</i></b>
          </div>

          <div class="d-flex justify-content-end align-items-center">
            <i class="fa fa-tags" aria-hidden="true" style="transform: rotate(90deg);margin-right: 5px"></i>
            <c:forEach items="${tagbyArt}" var="t">
              <div style="padding: 3px; background: #ff9800; border-radius: 5px; margin-right: 5px">
                <div style="border: 1px solid white; border-radius: 5px;font-size: 14px;font-weight: 600"># ${t.value}</div>
              </div>
            </c:forEach>
          </div>

          <c:if test="${article.public_date!=null}">
            <div class="d-flex justify-content-end">
              Ngày xuất bản:&nbsp; <b><i>${article.public_date.dayOfMonth}/${article.public_date.monthValue}/${article.public_date.year} ${article.public_date.hour}:${article.public_date.minute}:${article.public_date.second}</i></b></div>
          </c:if>

          <c:choose>
            <c:when test="${article.status == 1 }">
              <div class="d-flex justify-content-end" style="color: #28a745">
                Đã xuất bản
              </div>
            </c:when>
            <c:when test="${article.status == 2 }">
              <div class="d-flex justify-content-end" style="color: blue">
                Đã được duyệt và chưa xuất bản
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

        </div>
        <div class="card-footer">
          <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Misc/Publish" role="button">
            <i class="fa fa-backward" aria-hidden="true"></i>
            Quay lại
          </a>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>

