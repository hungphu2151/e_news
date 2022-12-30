<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="users" scope="request" type="java.util.List<com.example.e_news.beans.User>"/>
<jsp:useBean id="now" scope="request" type="com.example.e_news.beans.DateTime"/>



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
                                <c:when test="${u.expriration.isBefore(now.now) == true}">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.name}</td>
                                        <td>${u.pen_name}</td>
                                        <td>${u.username}</td>
                                        <td>${u.email}</td>
                                        <td>${u.issue_at.dayOfMonth}/${u.issue_at.monthValue}/${u.issue_at.year}  ${u.issue_at.hour}:${u.issue_at.minute}:${u.issue_at.second}</td>
                                        <td style="color: red">Hết hạn</td>
                                        <td>${u.role == 1 ? "Admin" :u.role ==2 ? "Biên tập viên" : u.role == 3? "Nhà báo": "Người đọc" }</td>
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
                                        <td>${u.role == 1 ? "Admin" :u.role ==2 ? "Biên tập viên" : u.role == 3? "Nhà báo": "Người đọc" }</td>
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
        </div>

    </jsp:body>
</t:main>
