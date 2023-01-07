<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftEditor.jsp"/>
    </jsp:attribute>

  <jsp:body>
    <form action="" method="post" name="frmReason">
      <div class="card">
        <h4 class="card-header">
          Lý do từ chối
        </h4>
        <div class="form-group">
          <input type="text" class="form-control w-25" id="txtID" name="id" value="${article.id_article}" hidden="hidden">
        </div>
        <div class="form-group p-2 bd-highlight" rows="4">
          <label for="txtReason">Lý do từ chối</label>
          <textarea id="txtReason" name="reason" rows="4" class="form-control mb-2" style="max-width: 30rem;"></textarea>
        </div>
        <div class="card-footer">
          <button type="submit" id="save" class="btn btn-primary" formaction="${pageContext.request.contextPath}/Editor/Article/AddReason">
            <i class="fa fa-check" aria-hidden="true"></i>
            Xác nhận
          </button>
        </div>

      </div>
    </form>
  </jsp:body>
</t:main>