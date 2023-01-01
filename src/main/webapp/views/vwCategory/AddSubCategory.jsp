<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:useBean id="mainCategories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            $('#frmCategory').on('submit', function (e){
                e.preventDefault();
                const name = $('#textCatName').val();
                if(name.length===0){
                    alert('Vui lòng nhập đầy đủ!!!');
                    return;
                }
                else {
                    $.getJSON('${pageContext.request.contextPath}/Admin/Category/IsAvailable?name='+ name,function (data){
                        if (data === true){
                            $('#frmCategory').off('submit').submit();
                        }
                        else {
                            alert('Chuyên mục đã tồn tại');
                        }
                    });
                }
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" id="frmCategory">
            <div class="card">
                <h4 class="card-header ">
                    Thêm chuyên mục phụ
                </h4>
                <div class="card-body">
                        <div class="form-group">
                            <label for="textCatName">Tên chuyên mục</label>
                            <input type="text" class="form-control w-25" id="textCatName" name="name" autofocus>
                        </div>
                        <div class="form-group mb-3">
                            <label for="inputGroupSelect">Thuộc chuyên mục chính</label>
                            <select class="form-control w-25" id="inputGroupSelect" name="id" >
                                <c:forEach items="${mainCategories}" var="c">
                                    <option value="${c.id_category}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                </div>
                <div class="card-footer">
                    <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/" role="button">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary" >
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Thêm
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>



