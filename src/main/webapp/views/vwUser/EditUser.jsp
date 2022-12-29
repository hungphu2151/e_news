<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:useBean id="user" scope="request" type="com.example.e_news.beans.User"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftAdmin.jsp"/>
    </jsp:attribute>

    <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>

    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>

            $('#save').click(function (e){
                const username = $('#txtUsername').val();
                const name = $('#txtname').val();
                const penname = $('#txtPenname').val();
                const psw = $('#txtPassword').val();
                const email = $('#txtEmail').val();
                const dob =$('#txtDOB').val();
                if(username.length===0 || name.length===0 || penname.length===0 || psw.length === 0 || email.length===0 || dob.length===0){
                    alert('Vui lòng nhập đầy đủ!!!');
                    e.preventDefault();
                }
                else {
                    $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?user='+ username,function (data){
                        if (data === false){
                            alert('Tên đã tồn tại');
                            e.preventDefault();
                        }
                    });
                }
            })
            $('#txtDOB').datetimepicker({
                format:'d/m/Y',
                timepicker: false,
                mask: true
            });
            $('#txtDOB').val('<fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy"/>');
            $('#txtUsernane').select();
        </script>
    </jsp:attribute>


    <jsp:body>
        <form action="" method="post" id="frmUser">
            <div class="card">
                <h4 class="card-header ">
                    Thêm người dùng
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtID">ID</label>
                        <input type="text" class="form-control w-25" id="txtID" name="id" value="${user.id}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="txtname">Tên</label>
                        <input type="text" class="form-control w-25" id="txtname" name="name" value="${user.name}" autofocus>
                    </div>
                    <div class="form-group">
                        <label for="txtPenname">Kí danh</label>
                        <input type="text" class="form-control w-25" id="txtPenname" name="pen_name" value="${user.pen_name}">
                    </div>
                    <div class="form-group">
                        <label for="txtUsername">Username</label>
                        <input type="text" class="form-control w-25" id="txtUsername" name="username" value="${user.username}" >
                    </div>

                    <div class="form-group">
                        <label for="txtPassword">Mật khẩu</label>
                        <input type="password" class="form-control w-25" id="txtPassword" name="rawpassword">
                    </div>

                    <div class="form-group">
                        <label for="txtEmail">Email</label>
                        <input type="email" class="form-control w-25" id="txtEmail" name="email" value="${user.email}">
                    </div>

                    <div class="form-group">
                        <label for="inputGroupSelect">Vai trò</label>
                        <select class="form-control w-25" id="inputGroupSelect" name="role" >
                            <c:if test="${user.role==1}">
                                <option value="1" selected>Admin</option>
                                <option value="2">Biên tập viên</option>
                                <option value="3">Nhà báo</option>
                                <option value="4">Người đọc</option>
                            </c:if>
                            <c:if test="${user.role==2}">
                                <option value="1" >Admin</option>
                                <option value="2"selected>Biên tập viên</option>
                                <option value="3">Nhà báo</option>
                                <option value="4">Người đọc</option>
                            </c:if>
                            <c:if test="${user.role==3}">
                                <option value="1" >Admin</option>
                                <option value="2">Biên tập viên</option>
                                <option value="3" selected>Nhà báo</option>
                                <option value="4">Người đọc</option>
                            </c:if>
                            <c:if test="${user.role==4}">
                                <option value="1" >Admin</option>
                                <option value="2">Biên tập viên</option>
                                <option value="3">Nhà báo</option>
                                <option value="4" selected>Người đọc</option>
                            </c:if>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="txtIssue_at">Ngày tạo tài khoản</label>
                        <input type="text" class="form-control" id="txtIssue_at" name="issue_at"value="${user.issue_at}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="txtDOB">Ngày sinh</label>
                        <input type="text" class="form-control" id="txtDOB" name="dob" value="${user.dob}">
                    </div>
                </div>
                <div class="card-footer">
                    <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/User/" role="button">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        Quay lại
                    </a>
                    <button type="submit" id="save" class="btn btn-primary" formaction="${pageContext.request.contextPath}/Admin/User/UpdateUser">
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Lưu
                    </button>
                    <button type="submit" id="delete" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Admin/User/DeleteUser">
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Xóa
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>

