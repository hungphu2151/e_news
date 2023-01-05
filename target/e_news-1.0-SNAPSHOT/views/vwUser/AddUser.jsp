<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
            $('#frmUser').on('submit', function (e){
                e.preventDefault();
                const username = $('#txtUsername').val();
                const name = $('#txtname').val();
                const penname = $('#txtPenname').val();
                const psw = $('#txtPassword').val();
                const email = $('#txtEmail').val();
                const dob = $('#txtDOB').val();
                if(username.length===0 || name.length===0 || penname.length===0 || psw.length === 0 || email.length===0 || dob.length===0){
                    alert('Vui lòng nhập đầy đủ!!!');
                    return;
                }
                else {
                    $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?user='+ username,function (data){
                        if (data === true){
                            $('#frmUser').off('submit').submit();
                        }
                        else {
                            alert('Tên đã tồn tại');
                        }
                    });
                }
            });

            $('#txtDOB').datetimepicker({
                format:'d/m/Y',
                timepicker: false,
                mask: true
            });

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
                        <label for="txtname">Tên</label>
                        <input type="text" class="form-control w-25" id="txtname" name="name" autofocus>
                    </div>
                    <div class="form-group">
                        <label for="txtPenname">Kí danh</label>
                        <input type="text" class="form-control w-25" id="txtPenname" name="pen_name">
                    </div>
                    <div class="form-group">
                        <label for="txtUsername">Username</label>
                        <input type="text" class="form-control w-25" id="txtUsername" name="username" >
                    </div>

                    <div class="form-group">
                        <label for="txtPassword">Mật khẩu</label>
                        <input type="password" class="form-control w-25" id="txtPassword" name="rawpassword">
                    </div>

                    <div class="form-group">
                        <label for="txtEmail">Email</label>
                        <input type="email" class="form-control w-25" id="txtEmail" name="email">
                    </div>

                    <div class="form-group">
                        <label for="inputGroupSelect">Vai trò</label>
                        <select class="form-control w-25" id="inputGroupSelect" name="role" >
                            <option value="1">Admin</option>
                            <option value="2">Biên tập viên</option>
                            <option value="3">Phóng viên</option>
                            <option value="4">Đọc giả</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="txtDOB">Ngày sinh</label>
                        <input type="text" class="form-control" id="txtDOB" name="dob">
                    </div>
                </div>
                <div class="card-footer">
                    <a  class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/User/" role="button">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary" >
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Thêm
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>
