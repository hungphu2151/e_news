<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="da_xuat_ban" scope="request" type="java.util.List<com.example.e_news.beans.Article>"/>
<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.example.e_news.beans.Category>"/>
<t:main>
  <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftWriter.jsp"/>
  </jsp:attribute>
    <jsp:body>
        <div class="card">
            <div class="card-header">
                <h5 class="">Những bài viết đã xuất bản</h5>
            </div>
            <c:choose>
            <c:when test="${da_xuat_ban.size() == 0}">
                <div class="card-body">
                    <p class="card-text">Không có dữ liệu phù hợp!</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${da_xuat_ban}" var="a">
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
                                        <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Misc/Detail?id=${a.id_article}" role="button">
                                            Xem chi tiết
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

