<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루 가입서 정보</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
    <section id="crewJ-container">
        <div class="crew-topContainer" style="width: 600px; height: 70px">
            <%-- 제목 --%>
            <div class="common-top__title" style="color: #FAAC58; ">
                크루 가입서
            </div>
        </div>
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
                        <span>${crewMember.answer1}</span>
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
                        <span>${crewMember.answer2}</span>
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
                        <span>${crewMember.answer3}</span>
                    </td>
                </tr>
            </table>
    </section>
</body>
</html>
