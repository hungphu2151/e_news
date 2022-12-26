<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:useBean id="categories" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
    </jsp:attribute>
    <jsp:body>
        <div>
            <div class="card">
                <h4 class="card-header d-flex justify-content-between">
                    Danh mục chính
                    <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/AddMainCategory" role="button">
                        <i class="fa fa-plus" aria-hidden="true"></i>
                        Thêm danh mục chính
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
                            <th>Tên danh mục</th>
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
            Danh mục phụ
            <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/AddSubCategory" role="button">
                <i class="fa fa-plus" aria-hidden="true"></i>
                Thêm danh mục phụ
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
                            <th>Danh mục</th>
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
