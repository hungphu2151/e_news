<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"/>


<t:main>
    <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            const check = function() {
                if (document.getElementById('txtNewPass').value ==
                    document.getElementById('txtConfirm').value) {
                    document.getElementById('message').style.color = 'green';
                    document.getElementById('message').innerHTML = 'Mật khẩu trùng khớp';
                } else {
                    document.getElementById('message').style.color = 'red';
                    document.getElementById('message').innerHTML = 'Mật khẩu không trùng khớp';
                }
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <form method="post" action="" id="frmRegister">
            <div class="card">
                <div class="card-header">
                    <h1> ĐỔI MẬT KHẨU </h1>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtUsernane">Username</label>
                                <input type="text" class="form-control" id="txtUsernane" name="username" value="${authUser.username}">
                            </div>
                            <div class="form-group">
                                <label for="txtConfirm">Mật khẩu mới</label>
                                <input type="password" class="form-control" id="txtNewPass" onkeyup="check()" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtPassword">Mật khẩu cũ</label>
                                <input type="password" class="form-control" id="txtPassword" name="rawpwd" required> <b class="text-danger">${errorMassage}</b>
                            </div>
                            <div class="form-group">
                                <label for="txtConfirm">Xác nhận mật khẩu mới</label>
                                <input type="password" class="form-control" id="txtConfirm" name="newRawpwd" onkeyup="check()" required>
                                <span id='message'></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary" id="btn-update" >
                        Cập nhật mật khẩu
                    </button>
                </div>
            </div>

        </form>
    </jsp:body>
</t:main>