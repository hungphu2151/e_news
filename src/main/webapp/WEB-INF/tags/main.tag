<%@ tag pageEncoding="UTF-8"%>
<%@attribute name="css" fragment="true" required="false" %>
<%@attribute name="js" fragment="true" required="false" %>
<%@attribute name="reader" fragment="true" required="false" %>
<%@attribute name="left_witer" fragment="true" required="false" %>
<%@attribute name="left_home" fragment="true" required="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>E Newpaper</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <jsp:invoke fragment="css"/>
    <style>
        html{
            height: 100%;
        }
        body{
            min-height: 100%;
        }
    </style>
</head>
<body>
<jsp:include page="../../views/partials/nav.jsp"/>
<div class="container-fluid mt-3">
    <div class="row">
        <div class="col-sm-2">
            <jsp:invoke fragment="reader"/>
            <jsp:invoke fragment="left_home"/>
        </div>
        <div class="col-sm-10">
            <jsp:doBody/>
        </div>
    </div>
</div>
<jsp:include page="../../views/partials/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<jsp:invoke fragment="js"/>
</body>
</html>
