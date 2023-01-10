<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="article" scope="request" type="com.example.e_news.beans.Article"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftEditor.jsp"/>
    </jsp:attribute>

  <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>
  <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>

          $('#txtPublicDate').datetimepicker({
            format:'d/m/Y H:00:00',
            mask: true,
          });

        </script>
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
              <div class="d-flex justify-content-end">
                Ngày xuất bản:&nbsp; <b><i>${article.public_date.dayOfMonth}/${article.public_date.monthValue}/${article.public_date.year} ${article.public_date.hour}:${article.public_date.minute}:${article.public_date.second}</i></b>
              </div>

            </c:when>
            <c:when test="${article.status == 3}">
              <div class="d-flex justify-content-end" style="color: sandybrown">
                Chưa được duyệt
              </div>
              <div class="form-group">
                <label for="txtPublicDate">Ngày xuất bản</label>
                <input type="text" class="form-control" id="txtPublicDate" name="public_date">
              </div>
            </c:when>
            <c:otherwise >
              <div class="d-flex justify-content-end" style="color: red">
                Bị từ chối
              </div>
              <h4>
                Lý do bị từ chối
              </h4>
              <textarea readonly>${article.reason}</textarea>


            </c:otherwise>
          </c:choose>

<%--          <div class="form-group">--%>
<%--            <label for="txtPublicDate">Ngày xuất bản</label>--%>
<%--            <input type="text" class="form-control" id="txtPublicDate" name="public_date">--%>
<%--          </div>--%>

          <div class="form-group">
            <input type="text" class="form-control w-25" id="txtID" name="id" value="${article.id_article}" hidden="hidden">
          </div>
        </div>
        <div class="card-footer">
          <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Editor/Article/" role="button">
            <i class="fa fa-backward" aria-hidden="true"></i>
            Quay lại
          </a>
          <c:if test="${article.status == 3}">
            <button type="submit" id="save" class="btn btn-primary" formaction="${pageContext.request.contextPath}/Editor/Article/AcceptArticle">
              <i class="fa fa-check" aria-hidden="true"></i>
              Duyệt
            </button>
            <button type="submit" id="save" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Editor/Article/RefuseArticle">
              <i class="fa fa-remove" aria-hidden="true"></i>
              Từ chối
            </button>
          </c:if>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>

