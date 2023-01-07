<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="articles" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftEditor.jsp"/>
    </jsp:attribute>
  <jsp:body>
    <div class="card">
    <h4 class="card-header d-flex justify-content-between">
      Danh sách bài báo chưa được duyệt
    </h4>
    <c:choose>
      <c:when test="${articles.size() == 0}">
        <div class="card-body">
          <p class="card-text">Không có dữ liệu...</p>
        </div>
      </c:when>
      <c:otherwise>
        <tr class="card-body">
          <table class="table table-hover">
            <thead>
            <tr>
              <th>STT</th>
              <th>Tiêu đề</th>
              <th>Tóm tắt</th>
              <th>Trạng thái</th>
              <th>Người viết</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${articles}" var="a">
              <c:choose>
                <c:when test="${a.status==4}">
                  <tr>
                    <td>${a.id_article}</td>
                    <td>${a.title}</td>
                    <td>${a.sumary}</td>
                    <td>${a.status == 4 ? "Bị từ chối" : "Bị từ chối"}</td>
                    <c:forEach items="${writers}" var="w">
                      <c:if test="${w.id == a.writer_id}">
                        <td>${w.pen_name}</td>
                      </c:if>
                    </c:forEach>
                  </tr>
                </c:when>
              </c:choose>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
    </div>

  </jsp:body>
</t:main>
