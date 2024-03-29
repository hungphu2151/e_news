<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<t:main>
    <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
                    body {
                        margin: 0;
                        line-height: 1.8em;
                        text-transform: none;
                        letter-spacing: .075em;
                        font-weight: bold;
                        font-style: normal;
                        text-decoration: none;
                        display: block;
                    }
                    .form-control {
                        border-radius: 1.5rem;
                    }
                    .btnSubmit
                    {
                        border: none;
                        border-radius: 1.5rem;
                        padding: 1%;
                        width: 20%;
                        cursor: pointer;
                        background: #0062cc;
                        color: #fff;
                    }
                    h1 {
                        display: block;
                        font-size: 1rem;
                        font-weight: bold;
                        text-align: center;
                        letter-spacing: 3px;
                        text-transform: uppercase;
                        padding-top: 20px;
                    }
                    a {
                        text-decoration: none;
                        color: #fff;
                    }
                    a:hover {
                        text-decoration: none;
                        color: #fff;
                    }
                </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            if(${success == 'true'}){
                alert("Đăng ký thành công");
            }
            $('#frmRegister').on('submit', function (e){
                e.preventDefault();
                const username = $('#txtUsernane').val();
                if(username.length===0){
                    alert('Vui lòng nhập tên');
                    return;
                }
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?user='+ username,function (data){
                    if (data === true){
                        $('#frmRegister').off('submit').submit();
                    }
                    else {
                        alert('Tên đã tồn tại');
                    }
                });

            });

            $('#txtDOB').datetimepicker({
                format:'d/m/Y',
                timepicker: false,
                mask: true
            });
            $('#txtUsernane').select();

            const check = function() {
                if (document.getElementById('txtPassword').value ==
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
        <form action="" method="post" id="frmRegister">
            <div class="container register-form">
                <div class="card">
                    <div class="card-header">
                        <h1> Đăng ký </h1>
                    </div>
                    <div class="card-body">
                        <h3>Tài khoản</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="txtUsernane">Username</label>
                                        <input type="text" class="form-control" id="txtUsernane" name="username" value="${username}">
                                    </div>
                                    <div class="form-group">
                                        <label for="txtName">Tên</label>
                                        <input type="text" class="form-control" id="txtName" name="name" required value="${name}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtPassword">Mật khẩu</label>
                                    <input type="password" class="form-control" id="txtPassword" name="rawpwd" onkeyup="check()" required value="${rawpwd}">
                                </div>
                                <div class="form-group">
                                    <label for="txtConfirm">Xác nhận mật khẩu</label>
                                    <input type="password" class="form-control" id="txtConfirm" onkeyup="check()" required value="${rawpwd}">
                                    <span id='message'></span>
                                </div>
                            </div>
                        </div>
                        <h3 class="mt-5">Thông tin chi tiết</h3>
                        <div class="row align-items-center mt-4">
                            <div class="col">
                                <label for="txtEmail">Email</label>
                                <input type="text" class="form-control" id="txtEmail" name="email" value="${email}">
                            </div>
                        </div>
                        <div class="row align-items-center mt-4">
                            <div class="col">
                                <label for="txtDOB">Ngày sinh</label>
                                <input type="text" class="form-control" id="txtDOB" name="dob" value="${dob}">
                            </div>
                        </div>
                        <div class="row align-items-center mt-4 d-flex">
                            <div class="col">
                                <label>Captcha</label>
                                <img src="${pageContext.request.contextPath}/captcha-image.jpg"/>
                                <input type="text" name="captcha" id="txtCaptcha" onfocus="$('#txtError').addClass('d-none')"> <i id="txtError" style="color: red">${error}</i>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btnSubmit">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Đăng ký
                        </button>
                    </div>
            </div>
            </div>
        </form>
    </jsp:body>
</t:main>