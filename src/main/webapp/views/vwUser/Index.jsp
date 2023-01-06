<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="users" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>


<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>

    <jsp:body>
        <div class="card">
        <h4 class="card-header d-flex justify-content-between">
            Danh sách người dùng
            <a  class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/Admin/User/AddUser" role="button">
                <i class="fa fa-plus" aria-hidden="true"></i>
                Thêm người dùng
            </a>
        </h4>
        <c:choose>
            <c:when test="${users.size() == 0}">
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
                            <th>Kí danh</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Ngày tạo tài khoản</th>
                            <th>Hạn</th>
                            <th>Vai trò</th>
                            <th>Ngày sinh</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${users}" var="u">
                            <c:choose>
                                <c:when test="${u.expriration.isBefore(now) == true}">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.name}</td>
                                        <td>${u.pen_name}</td>
                                        <td>${u.username}</td>
                                        <td>${u.email}</td>
                                        <td>${u.issue_at.dayOfMonth}/${u.issue_at.monthValue}/${u.issue_at.year}  ${u.issue_at.hour}:${u.issue_at.minute}:${u.issue_at.second}</td>
                                        <td style="color: red">Hết hạn</td>
                                        <td>${u.role == 1 ? "Admin" :u.role ==2 ? "Biên tập viên" : u.role == 3? "Phóng viên": "Đọc giả" }</td>
                                        <td><fmt:formatDate value="${u.dob}" pattern="dd/MM/yyyy"/></td>
                                        <td class="text-right">
                                            <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/User/EditUser?username=${u.username}" role="button">
                                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.name}</td>
                                        <td>${u.pen_name}</td>
                                        <td>${u.username}</td>
                                        <td>${u.email}</td>
                                        <td>${u.issue_at.dayOfMonth}/${u.issue_at.monthValue}/${u.issue_at.year}  ${u.issue_at.hour}:${u.issue_at.minute}:${u.issue_at.second}</td>
                                        <td>${u.expriration.dayOfMonth}/${u.expriration.monthValue}/${u.expriration.year}  ${u.expriration.hour}:${u.expriration.minute}:${u.expriration.second}</td>
                                        <td>${u.role == 1 ? "Admin" :u.role ==2 ? "Biên tập viên" : u.role == 3? "Phóng viên": "Đọc giả" }</td>
                                        <td><fmt:formatDate value="${u.dob}" pattern="dd/MM/yyyy"/></td>
                                        <td class="text-right">
                                            <a  class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/Admin/User/EditUser?username=${u.username}" role="button">
                                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
            </c:otherwise>
        </c:choose>
        <ul class="pagination justify-content-center mt-4">
            <li class="page-item ${currentPage==1? "disabled":''}">
                <a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=${currentPage-1}">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>

            <c:choose>
                <c:when test="${totalPage>5}">
                    <li class="page-item ${currentPage==1 ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=1">1</a></li>

                    <c:if test="${currentPage>3}">
                        <li class="page-item"><a class="page-link">...</a></li>
                    </c:if>

                    <c:forEach begin="${currentPage==1? 2:currentPage-2}" end="${currentPage+2}" var="u">
                        <c:if test="${u>1 && u <totalPage}">
                            <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=${u}">${u}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${currentPage<totalPage-2}">
                        <li class="page-item"><a class="page-link">...</a></li>
                    </c:if>

                    <li class="page-item ${currentPage==totalPage ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=${totalPage}">${totalPage}</a></li>

                </c:when>
                <c:otherwise>
                    <c:forEach begin="1" end="${totalPage}" var="u">
                        <li class="page-item ${currentPage==u ? "active":''}" ><a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=${u}">${u}</a></li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <li class="page-item ${currentPage==totalPage? "disabled":''}">
                <a class="page-link" href="${pageContext.request.contextPath}/Admin/User?page=${currentPage+1}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>

        </div>

    </jsp:body>
</t:main>
