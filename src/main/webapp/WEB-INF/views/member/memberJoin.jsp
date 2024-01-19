<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainJs.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            var form_id = document.getElementById("id");

            form_id.addEventListener("focusout", function(event) {
                var id = $('#id').val();
                $.ajax({
                    async: true,
                    url: "${pageContext.request.contextPath}/member/checkId", /* requestMapping*/
                    type: "post",
                    data: id,
                    dataType : "json",
                    contentType: "application/json; charset=UTF-8",
                    success: function (data) {
                        if (data.result == 1) {
                            document.joinFrm.check_id.value = "y";
                            document.getElementById('validate_id').innerText = "";
                        } else if(data.result == 0){
                            document.joinFrm.check_id.value = "";
                            document.getElementById('validate_id').innerText = "중복된 아이디가 있습니다.";
                        }
                    }
                });
            });

            var form_nickname = document.getElementById("nickname");

            form_nickname.addEventListener("focusout", function(event) {
                var nickname = $('#nickname').val();
                $.ajax({
                    async: true,
                    url: "${pageContext.request.contextPath}/member/checkNickname", /* requestMapping*/
                    type: "post",
                    data: nickname,
                    dataType : "json",
                    contentType: "application/json; charset=UTF-8",
                    success: function (data) {
                        if (data.result == 1) {
                            document.joinFrm.check_nickname.value = "y";
                            document.getElementById('validate_nickname').innerText = "";
                        } else if(data.result == 0){
                            document.joinFrm.check_nickname.value = "";
                            document.getElementById('validate_nickname').innerText = "중복된 닉네임이 있습니다.";
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <!-- header  -->
    <header id="head_container">
        <jsp:include page="../header.jsp"/>
    </header>
    <!-- // header  -->

    <!-- container -->
    <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data" name="joinFrm" onsubmit="return joinCheck()">
    <div id="memberJ-container">

        <!-- 아아디, 비밀번호 입력 -->
        <div id="memberJ-idcontainer">
            <h4 class="memberJ-container__h4--big">아이디</h4>
            <input type="text" name="id" id="id" class="memberJ-container__input--big" maxlength="20" pattern="^([a-z0-9]){4,20}$" placeholder="4~20자 영문, 숫자를 사용하세요">
            <input type="hidden" name="check_id">
            <div class="msg" id="validate_id"></div>

            <h4 class="memberJ-container__h4--big">비밀번호</h4>
            <div id="drop">
                <input type="password" class="memberJ-container__input--big" id="memberJ-idcontainer__input--pw" name="password" maxlength="30" onkeyup="pwCheck()">
                <input type="hidden" name="check_pw">
            </div>
            <div class="msg" id="validate_pw"></div>

            <h4 class="memberJ-container__h4--big">비밀번호 재확인</h4>
            <div id="drop2">
                <input type="password" class="memberJ-container__input--big" id="memberJ-idcontainer__input--pw2" name="password2" maxlength="30" onkeyup="pw2Check()">
                <input type="hidden" name="check_pw2" >
            </div>
            <div class="msg" id="validate_pw2"></div>
        </div>
        <!-- // 아아디, 비밀번호 입력 -->

        <!-- 이름, 닉네임, 생년월일,성별 입력-->
        <div id="memberJ-namecontainer">
            <h4 class="memberJ-container__h4--big">이름</h4>
            <input type="text" class="memberJ-container__input--big" name="name" maxlength="20">
            <div class="msg" id="validate_name"></div>

            <h4 class="memberJ-container__h4--big">닉네임</h4>
            <input type="text" class="memberJ-container__input--big" name="nickname" id="nickname" maxlength="20">
            <input type="hidden" name="check_nickname">
            <div class="msg" id="validate_nickname"></div>

            <h4 class="memberJ-container__h4--big">생년월일</h4>
            <input type="date" name="birth" id="birth" class="memberJ-container__input--date">

            <div id="birth_wrap">
                <input type="text" class="memberJ-namecontainer__input--blue" name="yy" maxlength="4" placeholder="년(4자)">

                <select id="mm" class="memberJ-namecontainer__birth--blue" name="mm">
                    <option value="">월</option>
                    <option value="01">
                        1
                    </option>
                    <option value="02">
                        2
                    </option>
                    <option value="03">
                        3
                    </option>
                    <option value="04">
                        4
                    </option>
                    <option value="05">
                        5
                    </option>
                    <option value="06">
                        6
                    </option>
                    <option value="07">
                        7
                    </option>
                    <option value="08">
                        8
                    </option>
                    <option value="09">
                        9
                    </option>
                    <option value="10">
                        10
                    </option>
                    <option value="11">
                        11
                    </option>
                    <option value="12">
                        12
                    </option>
                </select>

                <input type="text" class="memberJ-namecontainer__input--blue" name="dd" maxlength="2" placeholder="일(2자)">
            </div>
            <div class="msg" id="validate_birth"></div>

            <!-- 성별 입력하는 구역 -->
            <h4 class="memberJ-container__h4--big">성별</h4>
            <select id="gender" class="memberJ-namecontainer__gender--blue" name="gender">
                <option value="">성별</option>
                <option value="M">남자</option>
                <option value="F">여자</option>
                <option value="U">선택 안함</option>
            </select>
            <!-- 성별 입력하는 구역 -->

            <div class="msg" id="validate_gender"></div>
        </div>
        <!-- 이름, 닉네임, 생년월일, 성별  입력-->

        <!-- 프로필 사진 등록 -->
        <div class="memberJ-imgcontainer">
            <h4 class="memberJ-container__h4--big">프로필 사진 (선택)</h4>
            <img id="my_img" class="memberJ-imgcontainer__img-small" src="${pageContext.request.contextPath}/_image/member/sample.png">
            <label id="my_img_label" class="memberJ-imgcontainer__label-blue" for="member_img">업로드</label>
            <input type="file" name="memberimg" id="member_img" class="memberJ-imgcontainer__input-disappear" value="" onchange="setImg(event);">
        </div>
        <!-- 프로필 사진 등록 -->

        <!-- 이메일, 전화번호 입력 -->
        <div class="memberJ-emailcontainer">
            <h4 class="memberJ-container__h4--big">이메일</h4>
            <input type="email" class="memberJ-container__input--big" name="email" maxlength="50">
            <div class="msg" id="validate_email"></div>

            <h4 class="memberJ-container__h4--big">전화번호 (선택)</h4>
            <input type="tel" class="memberJ-container__input--big" name="phone" maxlength="30" value="" pattern="[0-9]{11}">
        </div>
        <!-- 이메일, 전화번호 입력 -->

        <!-- 이용약관 체크 여부 -->
        <div class="memberJ-rulecontainer">
            <input type="button" class="memberJ-rulecontainer__button-blue" value="이용방침" onclick="window.open('${pageContext.request.contextPath}/memberP')">
            <input type="button" class="memberJ-rulecontainer__button-blue" value="가입약관" onclick="window.open('${pageContext.request.contextPath}/memberR')"> <br/>
            <label class="memberJ-rulecontainer__label--move">
                <input type="checkbox" class="memberJ-container__input--focus" name="check_rule"> 이용약관 체크 여부
                <div class="msg" id="validate_check_rule"></div>
            </label>
        </div>
        <!-- 이용약관 체크 여부 -->

        <div class="memberJ-buttoncontainer">
            <input type="submit" class="memberJ-buttoncontainer__input--blue" value="회원가입">
            <input type="hidden" name="crleader" value="n">
        </div>
    </div>
    </form>
    <!-- // container -->

</body>
</html>
