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
    <jsp:attribute name="css">
        <style>
            .select-input {
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: relative;
                min-width: 200px;
                height: 34px;
                padding: 0 12px;
                background-color: white;
                font-size: 1rem;
            }
            .select-input:hover .select-input-list {
                display: block;
                z-index: 10;
            }
            .select-input-list {
                position: absolute;
                left: 0;
                right: 0;
                top: 35px;
                background-color: white;
                padding: 12px 12px;
                border-radius: 2px;
                display: none;
                list-style-type: none;
            }
            .select-input-link {
                font-size: 1rem;
                display: block;
                padding: 10px;
                width: 100%;
                color: black;
            }
            .select-input-link:hover {
                text-decoration: none;
             }
        </style>
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
            Danh sách bài báo
            <div class="select-input">
                <span class="select-input-label">Trạng thái bài viết</span>
                <ul class="select-input-list">
                    <li class="select-input-item">
                        <a class="select-input-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=0">Tất cả</a>
                    </li>
                    <li class="select-input-item">
                        <a class="select-input-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=1">Đã xuất bản</a>
                    </li>
                    <li class="select-input-item">
                        <a class="select-input-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=2">Đã duyệt và chưa xuất bản</a>
                    </li>
                    <li class="select-input-item">
                        <a class="select-input-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=3">Chưa được duyệt</a>
                    </li>
                    <li class="select-input-item">
                        <a class="select-input-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=4">Bị từ chối</a>
                    </li>
                </ul>
            </div>
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
                            <th></th>
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
                                <c:choose>
                                    <c:when test="${a.premium == 1}">
                                        <td><i class="fa fa-star text-warning" aria-hidden="true"></i></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
                                <td>${a.id_article}</td>
                                <td>${a.title}</td>
                                <td>${a.sumary}</td>
                                <c:choose>
                                    <c:when test="${a.status == 1 }">
                                        <td  style="color: #28a745">
                                            Đã xuất bản
                                        </td>
                                    </c:when>
                                    <c:when test="${a.status == 2 }">
                                        <td  style="color: blue">
                                            Đã được duyệt và chưa xuất bản
                                        </td>
                                    </c:when>
                                    <c:when test="${a.status == 3}">
                                        <td style="color: sandybrown">
                                            Chưa được duyệt
                                        </td>
                                    </c:when>
                                    <c:otherwise >
                                        <td  style="color: red">
                                            Bị từ chối
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach items="${writers}" var="w">
                                    <c:if test="${w.id == a.writer_id}">
                                        <td>${w.pen_name}</td>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${a.public_date!=null}">
                                        <td>${a.public_date.dayOfMonth}/${a.public_date.monthValue}/${a.public_date.year}  ${a.public_date.hour}:${a.public_date.minute}:${a.public_date.second}</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
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
        <c:choose>
            <c:when test="${status==0}">
                <ul class="pagination justify-content-center mt-4">
                    <li class="page-item ${currentPage==1? "disabled":''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${currentPage-1}">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <c:choose>
                        <c:when test="${totalPage>5}">
                            <li class="page-item ${currentPage==1 ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=1">1</a></li>

                            <c:if test="${currentPage>3}">
                                <li class="page-item"><a class="page-link">...</a></li>
                            </c:if>

                            <c:forEach begin="${currentPage==1? 2:currentPage-2}" end="${currentPage+2}" var="u">
                                <c:if test="${u>1 && u <totalPage}">
                                    <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${u}">${u}</a></li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${currentPage<totalPage-2}">
                                <li class="page-item"><a class="page-link">...</a></li>
                            </c:if>

                            <li class="page-item ${currentPage==totalPage ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${totalPage}">${totalPage}</a></li>

                        </c:when>
                        <c:otherwise>
                            <c:forEach begin="1" end="${totalPage}" var="u">
                                <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${u}">${u}</a></li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <li class="page-item ${currentPage==totalPage? "disabled":''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${currentPage+1}">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="pagination justify-content-center mt-4">
                    <li class="page-item ${currentPage==1? "disabled":''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${currentPage-1}&status=${status}">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <c:choose>
                        <c:when test="${totalPage>5}">
                            <li class="page-item ${currentPage==1 ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=1&status=${status}">1</a></li>

                            <c:if test="${currentPage>3}">
                                <li class="page-item"><a class="page-link">...</a></li>
                            </c:if>

                            <c:forEach begin="${currentPage==1? 2:currentPage-2}" end="${currentPage+2}" var="u">
                                <c:if test="${u>1 && u <totalPage}">
                                    <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${u}&status=${status}">${u}</a></li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${currentPage<totalPage-2}">
                                <li class="page-item"><a class="page-link">...</a></li>
                            </c:if>

                            <li class="page-item ${currentPage==totalPage ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${totalPage}&status=${status}">${totalPage}</a></li>

                        </c:when>
                        <c:otherwise>
                            <c:forEach begin="1" end="${totalPage}" var="u">
                                <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${u}&status=${status}">${u}</a></li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <li class="page-item ${currentPage==totalPage? "disabled":''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/Admin/Article?page=${currentPage+1}&status=${status}">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
        </div>

    </jsp:body>
</t:main>
