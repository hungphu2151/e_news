<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="chua_duoc_duyet" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftWriter.jsp"/>
  </jsp:attribute>
    <jsp:body>
        <div class="card">
            <div class="card-header">
                <h5 class="">Những bài viết chưa được duyệt</h5>
            </div>
            <c:choose>
            <c:when test="${chua_duoc_duyet.size() == 0}">
                <div class="card-body">
                    <p class="card-text">Không có bài báo nào!</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${chua_duoc_duyet}" var="a">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-12 mb-2 mt-2 d-flex justify-content-around">
                                <div class="col-sm-3 mb-2 mt-2 align-self-center">
                                    <img src="${pageContext.request.contextPath}/public/imgs/articles/${a.id_article}/main.jpg" alt="${a.title}" title="${a.title}" class="card-img-top">
                                </div>
                                <div class="col-sm-9 mb-2 mt-2">
                                    <div class="card-body">
                                        <h5 class="card-title">${a.title}</h5>
                                        <p class="card-text">${a.sumary}</p>
                                        <div class="d-flex justify-content-end">
                                                ${a.public_date}
                                        </div>
                                        <div class="d-flex justify-content-end text-danger">
                                            <c:forEach items="${categoriesWithDetails}" var="c">
                                                <c:if test="${a.category_id==c.id_category}">
                                                    ${c.name}
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="card-footer d-flex justify-content-end">
                                        <a id="btn_detail" class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Misc/Upload?id=${a.id_article}" role="button">
                                            Chỉnh sửa
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </div>
    </jsp:body>
</t:main>

