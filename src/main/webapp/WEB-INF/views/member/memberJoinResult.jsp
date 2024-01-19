<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 완료</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
</head>
<body>
    <!-- header -->
    <div class="memberL-header__div">
        <jsp:include page="../header.jsp"/>
    </div>
    <!-- // header -->

    <!-- 회원가입 완료 안내 container -->
    <div class="memberJR-container">
        <p class="memberJR-container__p1-bold">환영합니다!</p>
        <p class="memberJR-container__p2-bold">
            ${nickname}님, 회원가입을 축하합니다. <br />
                ${nickname}님의 새로운 아이디는 ${id}입니다.
        </p>
        <p>
            서울푸드트립은 항상 회원님들의 입장에서<br />
            보다 좋은 서비스를 받을 수 있도록 노력하겠습니다.<br />
        </p>
        <button class="memberJR-container__button-blue" onclick="location.href='${pageContext.request.contextPath}/memberL'">로그인하러 가기</button>
    </div>
    <!-- // 회원가입 완료 안내 container -->

    <!-- footer -->
    <div class="memberL-footer">
        <%@ include file="../footer.jsp" %>
    </div>
    <!-- // footer -->
</body>
</html>
