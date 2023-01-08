<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"/>

<t:main>
    <jsp:attribute name="reader">
        <jsp:include page="../../views/partials/leftReader.jsp"/>
    </jsp:attribute>

    <jsp:attribute name="css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>

    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            $('#frmProfile').on('submit', function (e){
                e.preventDefault();
                const name = $('#name').val();
                const penname = $('#pen_name').val();
                const email = $('#email').val();
                const dob = $('#txtDOB').val();
                if(name.length===0 || penname.length===0 || email.length===0 || dob.length===0){
                    alert('Vui lòng nhập đầy đủ!!!');
                    return;
                }
                $('#frmProfile').off('submit').submit();
            });
            $('#txtDOB').datetimepicker({
                format:'d/m/Y',
                timepicker: false,
                mask: true
            });
            $('#txtDOB').val('<fmt:formatDate value="${authUser.dob}" pattern="dd/MM/yyyy"/>');
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" id="frmProfile">
            <div class="card">
                <h4 class="card-header">
                    Profile
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtUsernane">User name</label>
                        <input type="text" class="form-control" id="txtUsernane" name="username" value="${authUser.username}" readonly>
                    </div>
                    <div class="form-row">
                        <div class="col">
                            <label for="name">Họ và tên</label>
                            <input type="text" class="form-control" id="name" value="${authUser.name}" name="name">
                        </div>
                        <div class="col">
                            <label for="pen_name">Bút danh</label>
                            <input type="text" class="form-control" id="pen_name" value="${authUser.pen_name}" name="pen_name">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" value="${authUser.email}" name="email">
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="txtDOB">Ngày sinh</label>
                                <input type="text" class="form-control" id="txtDOB" value="${authUser.dob}" name="dob">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary" id="btn-update" >
                        Cập nhật thông tin
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:main>