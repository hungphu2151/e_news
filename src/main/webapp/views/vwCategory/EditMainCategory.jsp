<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:useBean id="category" scope="request" type="com.example.e_news.beans.Category"/>
<jsp:useBean id="editors" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>
  <jsp:body>
    <form action="" method="post">
      <div class="card">
        <h4 class="card-header ">
          Chỉnh sửa danh mục chính
        </h4>
        <div class="card-body">
          <div class="form-group">
            <label for="txtID">ID</label>
            <input type="text" class="form-control w-25" id="txtID" name="id_category" value="${category.id_category}" readonly>
          </div>
          <div class="form-group">
            <label for="textCatName">Tên danh mục</label>
            <input type="text" class="form-control w-25" id="textCatName" name="name" autofocus value="${category.name}">
          </div>
          <div class="form-group mb-3">
            <label for="inputGroupSelect">Tên biên tập viên</label>
            <select class="form-control w-25" id="inputGroupSelect" name="id_editor" >
              <c:forEach items="${editors}" var="c">
                <c:choose>
                  <c:when test="${c.id == category.editor_id}">
                    <option value="${c.id}" selected>${c.name}</option>
                  </c:when>
                  <c:otherwise>
                    <option value="${c.id}">${c.name}</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
          </div>
        </div>
        <div class="card-footer">
          <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/" role="button">
            <i class="fa fa-backward" aria-hidden="true"></i>
            Quay lại
          </a>
          <button type="submit" class="btn btn-primary" formaction="${pageContext.request.contextPath}/Admin/Category/UpdateMainCategory">
            <i class="fa fa-check" aria-hidden="true"></i>
            Lưu
          </button>
          <button type="submit" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Admin/Category/Delete">
            <i class="fa fa-check" aria-hidden="true"></i>
            Xóa
          </button>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>
