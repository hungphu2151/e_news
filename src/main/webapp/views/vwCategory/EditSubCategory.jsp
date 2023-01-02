<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:useBean id="category" scope="request" type="com.example.e_news.beans.Category"/>
<jsp:useBean id="mainCategories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>
  <jsp:attribute name="js">
        <script>
          $("#delete").click(function () {
            console.log("delete");
            if(confirm("Bạn có chắc chắn?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
            {
              $("#frmCategory").attr("action", "${pageContext.request.contextPath}/Admin/Category/Delete");
            }else{
              return false;
            }

          });

          $("#save").click(function (e) {
            e.preventDefault();
            console.log("save");
            const id = $('#txtID').val();
            const name = $('#textCatName').val();
            if(name.length === 0){
              alert('Vui lòng nhập đầy đủ!!!');
            }else {
              $.getJSON('${pageContext.request.contextPath}/Admin/Category/IsAvailable?id='+ id + '&name='+name, function (data){
                if(data === true){
                  $('#frmCategory').submit();
                }else {
                  alert('Chuyên mục đã tồn tại');
                }
              });
            }
            $("#frmCategory").attr("action", "${pageContext.request.contextPath}/Admin/Category/UpdateSubCategory");
          });

        </script>
    </jsp:attribute>
  <jsp:body>
    <form action="" method="post" id="frmCategory">
      <div class="card">
        <h4 class="card-header ">
          Chỉnh sửa chuyên mục phụ
        </h4>
        <div class="card-body">
          <div class="form-group">
            <label for="txtID">ID</label>
            <input type="text" class="form-control w-25" id="txtID" name="id_category" value="${category.id_category}" readonly>
          </div>
          <div class="form-group">
            <label for="textCatName">Tên chuyên mục</label>
            <input type="text" class="form-control w-25" id="textCatName" name="name" autofocus value="${category.name}">
          </div>
          <div class="form-group mb-3">
            <label for="inputGroupSelect">Thuộc chuyên mục chính</label>
            <select class="form-control w-25" id="inputGroupSelect" name="id_parent" >
              <c:forEach items="${mainCategories}" var="c">
                <c:choose>
                  <c:when test="${c.id_category == category.parent_id}">
                    <option value="${c.id_category}" selected>${c.name}</option>
                  </c:when>
                  <c:otherwise>
                    <option value="${c.id_category}">${c.name}</option>
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
          <button type="submit" class="btn btn-primary" id="save" formaction="${pageContext.request.contextPath}/Admin/Category/UpdateSubCategory">
            <i class="fa fa-check" aria-hidden="true"></i>
            Lưu
          </button>
          <button type="submit" class="btn btn-danger" id="delete" formaction="${pageContext.request.contextPath}/Admin/Category/Delete">
            <i class="fa fa-times" aria-hidden="true"></i>
            Xóa
          </button>
        </div>
      </div>
    </form>
  </jsp:body>
</t:main>
