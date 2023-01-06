<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="tags" scope="request" type="java.util.List<com.example.e_news.beans.Tag>"/>


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
        <div class="card">
        <h4 class="card-header d-flex justify-content-between">
            Danh sách nhãn
            <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Tag/AddTag" role="button">
                <i class="fa fa-plus" aria-hidden="true"></i>
                Thêm nhãn
            </a>
        </h4>
        <c:choose>
            <c:when test="${tags.size() == 0}">
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
                            <th>Tên</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${tags}" var="t">
                            <tr>
                                <td>${t.id_tag}</td>
                                <td>${t.value}</td>
                                <td class="text-right">
                                    <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/Tag/EditTag?id=${t.id_tag}" role="button">
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
        <ul class="pagination justify-content-center mt-4">
            <li class="page-item ${currentPage==1? "disabled":''}">
                <a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=${currentPage-1}">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>

            <c:choose>
                <c:when test="${totalPage>5}">
                    <li class="page-item ${currentPage==1 ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=1">1</a></li>

                    <c:if test="${currentPage>3}">
                        <li class="page-item"><a class="page-link">...</a></li>
                    </c:if>

                    <c:forEach begin="${currentPage==1? 2:currentPage-2}" end="${currentPage+2}" var="u">
                        <c:if test="${u>1 && u <totalPage}">
                            <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=${u}">${u}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${currentPage<totalPage-2}">
                        <li class="page-item"><a class="page-link">...</a></li>
                    </c:if>

                    <li class="page-item ${currentPage==totalPage ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=${totalPage}">${totalPage}</a></li>

                </c:when>
                <c:otherwise>
                    <c:forEach begin="1" end="${totalPage}" var="u">
                        <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=${u}">${u}</a></li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <li class="page-item ${currentPage==totalPage? "disabled":''}">
                <a class="page-link" href="${pageContext.request.contextPath}/Admin/Tag?page=${currentPage+1}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
        </div>

    </jsp:body>
</t:main>
