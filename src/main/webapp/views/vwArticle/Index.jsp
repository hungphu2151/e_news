<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="articles" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>
<jsp:useBean id="writers" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>
    <jsp:body>
        <div class="card">
        <h4 class="card-header d-flex justify-content-between">
            Danh sách bài báo
            <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/Article/AddArticle" role="button">
                <i class="fa fa-plus" aria-hidden="true"></i>
                Thêm bài báo
            </a>
        </h4>
        <c:choose>
            <c:when test="${articles.size() == 0}">
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
                            <th>Tiêu đề</th>
                            <th>Tóm tắt</th>
                            <th>Trạng thái</th>
                            <th>Người viết</th>
                            <th>Ngày xuất bản</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${articles}" var="a">
                            <tr>
                                <td>${a.id_article}</td>
                                <td>${a.title}</td>
                                <td>${a.sumary}</td>
                                <td>${a.status == 1 ? "Đã xuất bản" :a.status ==2 ? "Đã được duyệt và chưa xuất bản" : a.status == 3? "Chưa được duyệt": "Bị từ chối" }</td>
                                <c:forEach items="${writers}" var="w">
                                    <c:if test="${w.id == a.writer_id}">
                                        <td>${w.pen_name}</td>
                                    </c:if>
                                </c:forEach>
                                <td>${a.public_date.dayOfMonth}/${a.public_date.monthValue}/${a.public_date.year}  ${a.public_date.hour}:${a.public_date.minute}:${a.public_date.second}</td>
                                <td class="text-right">
                                    <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/Article/EditArticle?id=${a.id_article}" role="button">
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
        </div>

    </jsp:body>
</t:main>
