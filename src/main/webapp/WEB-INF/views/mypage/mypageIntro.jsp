<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>미니프로필</title>
    <script>
        window.onload = function () {
            if (${member != null}) {
                document.getElementById('header-miniprofileBox__guest').style.display = "none";
                document.getElementById('header-miniprofileBox').style.display = "block";
            } else {
                document.getElementById('header-miniprofileBox__guest').style.display = "block";
                document.getElementById('header-miniprofileBox').style.display = "none";
            }
        }
    </script>
</head>
<body>
<!--미니프로필-->
<div id="header-miniprofile">

    <!--로그인 후 화면-->
    <div id="header-miniprofileBox">
        <div id="header-miniprofile__photo">
            <img src="${pageContext.request.contextPath}/_image/profile/${member.member_img}">
        </div>
        <div id="header-miniprofile__info">
            <span style="color:black;" id="header-miniprofile__span--nickname">${member.nickname}</span>
            <span id="header-miniprofile__span--white">님</span>
            <br/>
            안녕하세요
        </div>

        <%-- 버튼 박스 : 로그아웃, 마이 페이지 --%>
        <div id="header-miniprofile__button">
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/logout'">로그아웃</button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/mypageD?id=${member.id}'">
                내정보
            </button>
        </div>
    </div>
    <!-- // 로그인 후 화면-->

    <!--로그인 전 화면-->
    <div id="header-miniprofileBox__guest">
        <button id="header-button__b1" type="button"
                onclick="location.href='${pageContext.request.contextPath}/memberL'">로그인
        </button>
        <button id="header-button__b2" type="button"
                onclick="location.href='${pageContext.request.contextPath}/member'">회원가입
        </button>
    </div>
    <!-- // 로그인 전 화면-->
</div>

</body>
</html>