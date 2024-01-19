<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루 가입서</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <%-- Jquery --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>

    <%-- 상단 제목,드릴다운 : 공통 --%>
    <div class="crew-topContainer" style="width: 600px">
        <%-- 제목 --%>
        <div class="common-top__title" style="color: #FAAC58">
            크루 가입
        </div>
        <%-- 게시판 드릴다운 --%>
        <span class="common-top__drilldownbox">
                    <a href="#" style="color: #F4B7B4;">크루 게시판</a>
                    <span> > </span>
                    <a href="#">크루 목록</a>
                    <span> > </span>
                    <a href="#">크루 가입</a>
            </span>
    </div>

    <%-- 크루 가입 폼 --%>
    <section id="crewJ-container">
        <form id="crewJ-form">
            <table id="crewJ-tbl">
                <tr class="common-tbl__item">
                    <td style="width: 170px; height: 30px">
                        <b>질문1</b>
                    </td>
                    <td>
                        <span style="color: green">${crew.question1}</span>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td>
                        답변
                    </td>
                    <td>
                        <input name="answer1" type="text" style="width: 300px"/>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td style="width: 170px; height: 30px">
                        <b>질문2</b>
                    </td>
                    <td height="30px">
                        <span style="color: green;">${crew.question2}</span>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td>
                        답변
                    </td>
                    <td>
                        <input name="answer2" type="text" style="width: 300px"/>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td style="width: 170px; height: 30px">
                        <b>질문3</b>
                    </td>
                    <td>
                        <span style="color: green">${crew.question3}</span>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td>
                        답변
                    </td>
                    <td>
                        <input name="answer3" type="text" style="width: 300px"/>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td colspan="2">
                        모집 공고 및 크루 규칙에 동의 하십니까?
                        <input type="checkbox" style="height: 20px; position: relative; top: 3px">
                    </td>
                </tr>
            </table>

            <input type="hidden" name="crew.crewNo" value="${crew.crewNo}">
            <input type="hidden" name="member.id" value="${member.id}">

            <div id="crewJ-container-bottom">
                <button type="button" class="crew-button" onclick="submitCrewJoin()">가입</button>
                <button type="button" class="crew-button" onclick="window.close()">취소</button>
            </div>
            <script>
                //폼 데이터 생성
                function submitCrewJoin() {
                    var form = $('#crewJ-form')[0];
                    var formData = new FormData(form);

                    $.ajax({
                        type: 'POST',
                        url: '${pageContext.request.contextPath}/crewJ',
                        data: formData,
                        processData: false,	// data 파라미터 강제 string 변환 방지
                        contentType: false,	// application/x-www-form-urlencoded; 방지
                        cache: false,
                        success: function (data) {
                            alert(data);
                            window.close();
                        },
                        error: function (request, status, error) {
                            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }
                    });
                }
            </script>
        </form>
    </section>
</body>
</html>
