<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:useBean id="categories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="tags" scope="request" type="java.util.List<com.example.e_news.beans.Tag>"/>
<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"></jsp:useBean>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftWriter.jsp"/>
    </jsp:attribute>

    <jsp:attribute name="css">
        <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="js">
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/vi.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src='https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js'></script>
        <script>
            $('#frmAddArticle').on('submit', function (e){
                e.preventDefault();
                const title = $('#txtTitle').val();
                const summary = $('#txtSummary').val();
                const content = $('#txtContent').val();
                const tagID = $('#txtTagID').val();
                if(title.length===0 || summary.length===0 || content.length===0 || tagID.length===0){
                    alert('Vui lòng nhập đầy đủ!!!');
                    return;
                }
                $('#frmAddArticle').off('submit').submit();
            });
            tinymce.init({
                selector: '#txtContent',
                height: 450,
                plugins:    'lists paste image link autolink table',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrought | numlist bullíst | alignleft aligncenter alignright | forecolor backcolor | table link image'
                ],
                entity_encoding: "raw"
            });
            $("#fuMain").fileinput({
                theme:"fa",
                language:"vi",
                dropZoneEnabled:false,
                allowFileExtensions:['jpg','png','gif']
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" enctype="multipart/form-data" id="frmAddArticle">
            <div class="card">
                <h4 class="card-header">
                    Đăng bài viết
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtID">ID phóng viên</label>
                        <input type="text" class="form-control" id="txtID" name="id" value="${authUser.id}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="txtTitle">Title</label>
                        <input type="text" class="form-control" id="txtTitle" name="title">
                    </div>
                    <div class="form-group">
                        <label for="txtSummary">Summary</label>
                        <input type="text" class="form-control" id="txtSummary" name="summary">
                    </div>
                    <div class="form-group">
                        <label for="txtContent">Content</label>
                        <textarea id="txtContent" name="content"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="file" id="fuMain" name="fuMain">
                    </div>
                    <div class="form-group mb-3">
                        <label for="inputGroupSelect">Thuộc chuyên mục</label>
                        <select class="form-control w-25" id="inputGroupSelect" name="category_id">
                            <c:forEach items="${categories}" var="c">
                                <c:if test="${c.parent_id!=0}">
                                    <option value="${c.id_category}">${c.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        Nhãn:  &nbsp;
                        <c:forEach items="${tags}" var="t">
                            <input type="checkbox" id="txtTagID" name="tag_id" value="${t.id_tag}">  ${t.value} &nbsp; &nbsp;&nbsp;
                        </c:forEach>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary" >
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Đăng bài viết
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>


