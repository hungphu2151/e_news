<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="tag" scope="request" type="com.example.e_news.beans.Tag"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>

  <jsp:body>
    <form action="" method="post" id="frmUser">
      <div class="card">
        <h4 class="card-header ">
          Chỉnh sửa nhãn
        </h4>
        <div class="card-body">
          <div class="form-group">
            <label for="txtID">ID</label>
            <input type="text" class="form-control w-25" id="txtID" name="id" value="${tag.id_tag}" readonly>
          </div>
          <div class="form-group">
            <label for="txtname">Tên nhãn</label>
            <input type="text" class="form-control w-25" id="txtname" name="value" value="${tag.value}" autofocus>
          </div>

        </div>
        <div class="card-footer">
          <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Tag/" role="button">
            <i class="fa fa-backward" aria-hidden="true"></i>
            Quay lại
          </a>
          <button type="submit" id="save" class="btn btn-primary" formaction="${pageContext.request.contextPath}/Admin/Tag/UpdateTag">
            <i class="fa fa-check" aria-hidden="true"></i>
            Lưu
          </button>
          <button type="submit" id="delete" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Admin/Tag/DeleteTag">
            <i class="fa fa-times" aria-hidden="true"></i>
            Xóa
          </button>

        </div>
      </div>
    </form>
  </jsp:body>
</t:main>

