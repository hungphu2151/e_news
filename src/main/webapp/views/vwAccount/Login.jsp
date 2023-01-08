<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="authUser" scope="session" type="com.example.e_news.beans.User"/>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>E Newpaper</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Numans');
        html,body{
            background-image: url('https://i.pinimg.com/originals/42/49/b7/4249b715a8d9919ded604f6f2b159531.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            font-family: 'Numans', sans-serif;
            height: 100%;
            width: 100%;
        }
        .container{
            height: 100%;
            align-content: center;
        }
        .card{
            height: 370px;
            margin-top: auto;
            margin-bottom: auto;
            width: 500px;
            background-color: rgba(0,0,0,0.5) !important;
        }
        .social_icon span{
            font-size: 60px;
            margin-left: 10px;
            color: #FFC312;
        }
        .social_icon span:hover{
            color: white;
            cursor: pointer;
        }
        .card-header h3{
            color: white;
        }
        .social_icon{
            position: absolute;
            right: 20px;
            top: -45px;
        }
        .input-group-prepend span{
            width: 50px;
            background-color: #FFC312;
            color: black;
            border:0 !important;
        }
        input:focus{
            outline: rgba(0,0,0,0.0)  !important;
            box-shadow: 0 0 0 0 !important;

        }
        .login_btn{
            color: black;
            background-color: #FFC312;
            width: 100px;
        }
        .login_btn:hover{
            color: black;
            background-color: white;
        }
        .links{
            color: white;
        }
        .links a{
            margin-left: 4px;
        }
        .role-login{
            color: white;
        }
    </style>


</head>
<body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>Sign In</h3>
                        <div class="d-flex justify-content-end social_icon">
                            <span><i class="fab fa-google-plus-square"></i></span>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:if test="${hasError}">
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <strong>Login failed!</strong> ${errorMassage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        <form action="" method="post">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <label class="sr-only" for="txtUsername">Username</label>
                                <input type="text" class="form-control" id="txtUsername" name="username" autofocus placeholder="Username">
                            </div>
                            <div class="input-group form-group">
                                <label class="sr-only" for="txtPassword">Password</label>
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" class="form-control" id="txtPassword" name="password" placeholder="Password">
                            </div>
                            <select class="role-user" name="role">
                                <option value="1">Administrator</option>
                                <option value="2">Editor</option>
                                <option value="3">Writer</option>
                                <option value="4">Subscriber</option>
                            </select>
                            <div class="form-group">
                                <button type="submit" class="btn float-right login_btn">Sign In</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            Don't have an account?<a href="${pageContext.request.contextPath}/Account/Register">Sign Up</a>
                        </div>
                        <div class="d-flex justify-content-center">
                            <a href="#">Forgot your password?</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
</body>
</html>
