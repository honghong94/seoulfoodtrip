<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루 게시판- 가입양식 수정</title>

    <%-- 메인 스타일시트 --%>
    <link href=" ${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</head>
<body>

    <div class="crew-topContainer" style="width: 800px; height: 70px">
        <%-- 제목 --%>
        <div class="common-top__title" style="color: #FAAC58">
            가입 양식 수정
        </div>
    </div>
    <form id="crewEJ-form--question" method="post">
        <div class="crew_popupContainer">
            <span>가입질문1 :</span>
            <span><input class="crewEJ-input--modify" name="question1" type="text" value="${crew.question1}"/></span>
        </div>
        <div class="crew_popupContainer">
            <span>가입질문2 :</span>
            <span><input class="crewEJ-input--modify" name="question2" type="text" value="${crew.question2}"/></span>
        </div>
        <div class="crew_popupContainer">
            <span>가입질문3 :</span>
            <span><input class="crewEJ-input--modify" name="question3" type="text" value="${crew.question3}"/></span>
        </div>
        <div style="width: 800px; height: 70px; margin: 0 auto; text-align: right">
            <button class="crew-button"
                    type="button"
                    onclick="submitQuestion('${pageContext.request.contextPath}',${crew.crewNo})"
                    style="position: relative; right: 20px">수정
            </button>
            <script>
                function submitQuestion(contextPath, crewNo) {
                    $(function () {
                        let form = $("#crewEJ-form--question")[0]
                        let formData = new FormData(form);
                        formData.append("crewNo", crewNo);

                        $.ajax({
                            data: formData,
                            type: 'POST',
                            url: contextPath + '/crewM/edit/question',
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (data) {
                                alert("가입양식이 변경 되었습니다.");
                            }
                        });

                    });
                }

            </script>
        </div>
    </form>
</body>
</html>
