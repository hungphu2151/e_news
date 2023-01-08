<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>



<t:main>
    <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
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

            var check = function() {
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
            <div class="card">
                <h4 class="card-header">
                    Accout Registration
                </h4>
                <div class="card-body">
                    <h5>Account</h5>
                    <div class="form-group">
                        <label for="txtUsernane">User name</label>
                        <input type="text" class="form-control" id="txtUsernane" name="username">
                    </div>
                    <div class="form-group">
                        <label for="txtPassword" >Password</label>
                        <input type="password" class="form-control" id="txtPassword" name="rawpwd" onkeyup="check()" required>
                    </div>
                    <div class="form-group">
                        <label for="txtConfirm">Confirm Password</label>
                        <input type="password" class="form-control" id="txtConfirm" onkeyup="check()" required>
                        <span id='message'></span>
                    </div>

                    <h5 class="mt-5">Personal Information</h5>
                    <div class="form-row">
                        <div class="col">
                            <label for="txtName">Name</label>
                            <input type="text" class="form-control" id="txtName" name="name" required>

                        </div>
                        <div class="col">
                            <label for="txtPenName">Pen Name</label>
                            <input type="text" class="form-control" id="txtPenName" name="pen_name" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="form-control" id="txtEmail" name="email">
                    </div>
                    <div class="form-group">
                        <label for="txtDOB">Date of Birth</label>
                        <input type="text" class="form-control" id="txtDOB" name="dob">
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Register
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>