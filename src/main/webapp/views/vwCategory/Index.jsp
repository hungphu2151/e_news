<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:useBean id="categories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<jsp:useBean id="editors" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            $(document).ready(function () {
                const loc = window.location.href;
                $("div a").each(function() {
                    if (loc.indexOf($(this).attr("href")) != -1) {
                        $(this).addClass("list-group-item-primary");
                    }
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div>
            <div class="card">
                <h4 class="card-header d-flex justify-content-between">
                    Danh sách chuyên mục chính
                    <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/AddMainCategory" role="button">
                        <i class="fa fa-plus" aria-hidden="true"></i>
                        Thêm chuyên mục chính
                    </a>
                </h4>
                <c:choose>
                <c:when test="${categories.size() == 0}">
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
                            <th>Tên chuyên mục</th>
                            <th>Biên tập viên phụ trách</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categories}" var="c">
                            <c:if test="${c.parent_id == '0'}">
                                <tr>
                                    <th>${c.id_category}</th>
                                    <th>${c.name}</th>
                                    <c:forEach items="${editors}" var="u">
                                        <c:if test="${u.id==c.editor_id}">
                                            <th>${u.name}</th>
                                        </c:if>
                                        <c:if test="${u.id!=c.editor_id}">
                                            <th></th>
                                        </c:if>
                                    </c:forEach>
                                    <th class="text-right">
                                        <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/Category/EditMainCategory?id=${c.id_category}" role="button">
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
            </div>
            </c:otherwise>
            </c:choose>
        </div>
        <div class="card mt-4">
        <h4 class="card-header d-flex justify-content-between">
            Danh sách chuyên mục phụ
            <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/AddSubCategory" role="button">
                <i class="fa fa-plus" aria-hidden="true"></i>
                Thêm chuyên mục phụ
            </a>
        </h4>
        <c:choose>
            <c:when test="${categories.size() == 0}">
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
                            <th>Tên chuyên mục</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categories}" var="c">
                            <c:if test="${c.parent_id == '0'}">
                                <tr>
                                    <th>${c.id_category}</th>
                                    <th>${c.name}</th>
                                    <th class="text-right">
                                    </th>
                                </tr>

                                <c:forEach items="${categories}" var="child">
                                    <c:if test="${child.parent_id == c.id_category}">
                                        <tr>
                                            <td>${child.id_category}</td>
                                            <td>${child.name}</td>
                                            <td class="text-right">
                                                <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/Category/EditSubCategory?id=${child.id_category}" role="button">
                                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
        </div>
        </div>

    </jsp:body>
</t:main>
