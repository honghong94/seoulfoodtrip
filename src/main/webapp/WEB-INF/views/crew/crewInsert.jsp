<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루게시판 - 크루 생성</title>

    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <!-- include jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>

    <!-- include summernote css -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

    <script src="${pageContext.request.contextPath}/_js/crewUtils.js"></script>
    <script>
        addQuestion();
        checkCrewName('${pageContext.request.contextPath}');
        limitAreaList();
    </script>
</head>
<body>
    <%-- 헤더 --%>
    <header id="head_container">
        <jsp:include page="../header.jsp"/>
    </header>

    <section class="crew-mainContainer" style="width: 1115px;">

        <%-- topContainer --%>
        <div class="crew-topContainer" style="width: 1115px;">
            <%-- 제목 --%>
            <div class="common-top__title" style="color: #FAAC58; top: 45px;">
                크루 생성
            </div>
        </div>

        <%-- 크루 정보 입력 폼 : 로고, 크루명, 관심지역, 크루 소개(간략, 상세) --%>
        <div class="common-miniTitle" style="top:45px; width: 1115px;">
            크루 정보 입력
        </div>
        <form id="crewI-form" action="${pageContext.request.contextPath}/crewI" method="post" enctype="multipart/form-data">
            <table class="crewI-insertTbl">
                <tr class="common-tbl__item">
                    <td rowspan="2">
                        로고
                    </td>
                    <td rowspan="2" style="border-right: 1px solid #CDCECF;">
                        <div class="crew-logobox">
                            <img id="crewI_img"
                                 src="${pageContext.request.contextPath}/_image/crew/crew-logo-default.jpeg"
                                 alt="crew-logo"/><%-- 기본로고 --%>
                            <label id="crewI-label--img" class="crew-label--upload" for="crewI_input--image">변경</label>
                            <input type="file" name="crewImgFile" id="crewI_input--image" onchange="setImg_i(event)">
                        </div>
                    </td>
                    <td>
                        크루명
                    </td>
                    <td style="position: relative">
                        <input name="crewName" id="crewI-input--name" type="text" style="width: 200px"/>
                        <button type="button" class="crew-button" id="crewI-btn--checkName"
                                style="height:30px; position: relative; top: 4px">중복 확인
                        </button>
                        <span id="crewI-nameCheckMsg" style="font-size: 10px;color: #6E6E6E;"></span>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td style>
                        관심지역
                    </td>
                    <td>
                        <input type="checkbox" name="areaListValues" value="강남">
                        <span style="line-height: 26px; font-size: 13px">강남</span>
                        <input type="checkbox" name="areaListValues" value="강북">
                        <span style="line-height: 26px; font-size: 13px">강북</span>
                        <input type="checkbox" name="areaListValues" value="광화문">
                        <span style="line-height: 26px; font-size: 13px">광화문</span>
                        <input type="checkbox" name="areaListValues" value="명동">
                        <span style="line-height: 26px; font-size: 13px">명동</span>
                        <input type="checkbox" name="areaListValues" value="여의도">
                        <span style="line-height: 26px; font-size: 13px">여의도</span>
                        <input type="checkbox" name="areaListValues" value="잠실">
                        <span style="line-height: 26px; font-size: 13px">잠실</span>
                        <input type="checkbox" name="areaListValues" value="홍대">
                        <span style="line-height: 26px; font-size: 13px">홍대</span>
                        <input type="checkbox" name="areaListValues" value="etc">
                        <span style="line-height: 26px; font-size: 13px">etc</span>
                    </td>
                </tr>
                <tr class="common-tbl__item">
                    <td colspan="2">
                        크루 소개 (간략)
                    <td colspan="2">
                        <textarea id="crewI-intro" name="intro" style="width: 845px; height: 50px"></textarea>
                    </td>
                </tr>
                <tr class="common-tbl__item" style="height: 200px">
                    <td colspan="2">
                        크루 소개 (상세)
                    <td colspan="2">
                        <textarea id="crewI-introDetail" name="introDetail"
                                  style="width: 850px; height: 90px"></textarea>
                    <%-- summernote 실행 --%>
                    <script>
                        $(function () {
                            $('#crewI-introDetail').summernote({
                                //summernote 속성
                                width: 865,
                                height: 200,
                                minHeight: null,
                                maxHeight: null,
                                focus: true,
                                lang: "ko-KR",
                                placeholder: '최대 2048자까지 쓸 수 있습니다',
                                toolbar: [
                                    // [groupName, [list of button]]
                                    ['style', ['bold', 'italic', 'underline', 'clear']],
                                ]
                            });
                        });
                    </script>
                    </td>
                </tr>
            </table>

            <%-- 크루 모집 공고 입력 폼 : 모집공고, 가입양식 질문 , 짋문추가 기능 --%>
            <div class="common-miniTitle" style="top:45px; width: 1115px;">
                크루 모집 공고 입력
                <button type="button" id="crewI-btn--addQuestion" class="crew-button">질문 추가</button>
                <%-- 클릭시 가입 질문 양식 추가 됨 --%>
            </div>
            <table id="crewI-insertTbl__recuit" class="crewI-insertTbl">
                <tr class='common-tbl__item'>
                    <td style='width: 170px;'>
                        모집 공고
                    </td>
                    <td>
                        <textarea id="crewI-recuit" name="recruit" style='width: 850px; height: 90px'></textarea>
                        <%-- summernote 실행 --%>
                        <script>
                            $(function () {
                                $('#crewI-recuit').summernote({
                                    //summernote 속성
                                    width: 865,
                                    height: 200,
                                    minHeight: null,
                                    maxHeight: null,
                                    focus: true,
                                    lang: "ko-KR",
                                    placeholder: '최대 2048자까지 쓸 수 있습니다',
                                    toolbar: [
                                        // [groupName, [list of button]]
                                        ['style', ['bold', 'italic', 'underline', 'clear']],
                                    ]
                                });
                            });
                            </script>
                    </td>
                </tr>
                <tr class='common-tbl__item'>
                    <td style="width: 170px;">
                        가입 질문
                    </td>
                    <td>
                        <input id="question1" name="question1" type='text' style='width: 847px' maxlength="50"/>
                    </td>
                </tr>
            </table>

            <%-- id --%>
            <input type="hidden" name="member.id" value="${member.id}">
            <%-- 저장 버튼 --%>
            <div style="width: 1115px; margin-top: 30px">
                <button type="button" onclick="checkCrewParam()" class="crew-button" style="position: relative; left: 510px; width: 100px">저장
                </button>
            </div>
        </form>
    </section>

    <%-- footer --%>
    <footer>
        <jsp:include page="../footer.jsp"/>
    </footer>
</body>
</html>
