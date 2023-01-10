<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="articles" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>
<jsp:useBean id="writers" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>
<jsp:useBean id="categories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftEditor.jsp"/>
    </jsp:attribute>
  <jsp:body>
    <div class="card">
    <h4 class="card-header d-flex justify-content-between">
      Danh sách bài báo
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
              <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
              <c:forEach items="${articles}" var="a">
                <c:forEach items="${categories}" var="c">
                    <c:if test="${a.category_id == c.id_category}">
                      <c:forEach items="${categories}" var="c1">
                        <c:if test="${c1.id_category == c.parent_id}">
                          <c:if test="${c1.editor_id == authUser.id}">
                            <tr>
                              <td>${a.id_article}</td>
                              <td>${a.title}</td>
                              <td>${a.sumary}</td>
                              <td>${a.status == 1 ? "Đã được duyệt" :a.status ==2 ? "Đã được duyệt" : a.status == 3? "Chưa được duyệt": "Bị từ chối" }</td>
                              <td class="text-right">
                                <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Editor/Article/Edit?id=${a.id_article}" role="button">
                                  <c:choose>
                                    <c:when test="${a.status == 3}">
                                      <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </c:when>
                                    <c:otherwise>
                                      <i class="fa fa-eye" aria-hidden="true"></i>
                                    </c:otherwise>
                                  </c:choose>
                                </a>
                              </td>
                            </tr>
                          </c:if>
                        </c:if>
                      </c:forEach>
                  </c:if>
                </c:forEach>
            </c:forEach>
            </tbody>
          </table>
        </tr>
      </c:otherwise>
    </c:choose>
    </div>

  </jsp:body>
</t:main>
