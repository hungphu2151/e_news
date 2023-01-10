<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="card">
    <a class="btn btn-secondary mb-1" href="${pageContext.request.contextPath}/Misc/Writer" role="button">
       Đăng bài viết
    </a>
    <a class="btn btn-secondary mb-1" href="${pageContext.request.contextPath}/Misc/Publish" role="button">
        Những bài viết đã xuất bản
    </a>
    <a class="btn btn-secondary mb-1" href="${pageContext.request.contextPath}/Misc/Accept" role="button">
        Những bài viết đã được duyệt và chờ xuất bản
    </a>
    <a class="btn btn-secondary mb-1" href="${pageContext.request.contextPath}/Misc/Unapproved" role="button">
        Những bài viết chưa được duyệt
    </a>
    <a class="btn btn-secondary mb-1" href="${pageContext.request.contextPath}/Misc/Deny" role="button">
        Những bài viết bị từ chối
    </a>
</div>
