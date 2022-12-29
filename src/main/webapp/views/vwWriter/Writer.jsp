<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%--<jsp:useBean id="editors" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>--%>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
  </jsp:attribute>
    <jsp:attribute name="js">
        <script src='https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js'></script>
        <script>
            tinymce.init({
                selector: '#txtArticle',
                plugins: 'link',
                toolbar: 'link'
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post">
            <div class="card">
                <h4 class="card-header ">
                    WYSIWYG HTML Writer
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtArticle">Title</label>
                        <textarea id="txtArticle">Hello, World!</textarea>
                    </div>
                    <div class="form-group">
                        <label for="txtArticle">Summary</label>
                    </div>
                    <div class="form-group">
                        <label for="txtArticle">Content</label>
                    </div>
                    <div class="form-group">
                        <label for="txtArticle">Categories</label>
                    </div>
                    <div class="form-group">
                        <label for="txtArticle">Label</label>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary" >
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Thêm
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>


