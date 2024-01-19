<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>후기게시판 - 글쓰기</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <%-- 코스 그리기 --%>
    <script src="${pageContext.request.contextPath}/_js/draw_course.js"></script>

    <!-- include summernote css -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

    <script>
        <!-- 코스그리기 추가되는 부분 -->
        $(function () {
            $('#reviewI-select--course').change(function () {
                var selected = $('#reviewI-select--course option:selected').val();

                if (selected === 'yes') {
                    $('#reviewI-selectBox').after(
                        "<tr class='common-tbl__item' id='reviewI-course--title'>" +
                        "<td style='width: 170px'>코스 이름 </td> " +
                        "<td> <input style='width: 400px;' id='placeTitle' type='text'/> " +
                        "<button type='button' class='button--exceptionboot' onclick='addTitle();'>적용</button> " +
                        "</td> </tr> " +

                        "<tr class='common-tbl__item' id='reviewI-course--drawcourse'>> " +
                        "<td style='width: 180px'> 여행 코스 그리기 </td>" +
                        "<td><div id='writeform__item--course'>" +
                        "<input id='placeName' type='text'/> " +
                        "<input type='radio' name='placeType' value='1' checked='checked'/>음식점 " +
                        "<input type='radio' name='placeType' value='2'/>쇼핑 " +
                        "<input type='radio' name='placeType' value='3'/>문화 " +
                        "<button type='button' class='button--exceptionboot' onclick='drawNodeAndLine();'>여행지 추가 </button>" +
                        "<button type='button' class='button--exceptionboot' onclick='clearNode();'>초기화</button> " +
                        "<canvas id='canvas' width='1100' height='550'></canvas>" +
                        "</div></td></tr>");

                    [x, y] = drawDefaultNode(x, y);
                } else {
                    $('#reviewI-course--title').remove();
                    $('#reviewI-course--drawcourse').remove();
                }
            });
        });
    </script>

</head>
<body>
    <%-- 헤더 --%>
    <header id="head_container">
        <jsp:include page="../header.jsp"/>
    </header>

    <%-- 메인 컨테이너 --%>
    <section class="common-iuContainer--main">

        <%-- 제목 --%>
        <div class="common-iuTop--title" style="color:#F4B7B4 ">
            글쓰기
        </div>

        <%-- 글쓰기 폼 지역/제목/내용/코스추가/코스/ --%>
        <form id="reviewIU-form" enctype="multipart/form-data">
            <table class="common-iuContainer--writeform">

                <%-- id : hidden --%>
                <input name="member.id" type="hidden" value="${member.id}"/><%-- 추후 세션처리 --%>

                <%-- 지역 : select --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        <b>지역</b>
                    </td>
                    <td>
                        <select name="areaNo" class="writeform__component">
                            <option value="1">강남</option>
                            <option value="2">강북</option>
                            <option value="3">광화문</option>
                            <option value="4">명동</option>
                            <option value="5">여의도</option>
                            <option value="6">잠실</option>
                            <option value="7">홍대</option>
                            <option value="0">기타</option>
                        </select>
                    </td>
                </tr>

                <%-- 제목 : text --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        제목
                    </td>
                    <td>
                        <input  name="title" style="width: 600px" type="text"/>
                    </td>
                </tr>

                <%-- 내용 : summernote --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        내용
                    </td>
                    <td>
                        <textarea id="summernote" name="content"></textarea>
                        <div id="reviewI-imageAppend"></div>
                        <%-- summernote 실행 --%>
                        <script>
                            $(function () {
                                $('#summernote').summernote({
                                    //summernote 속성
                                    width: 1100,
                                    height: 400,
                                    minHeight: null,
                                    maxHeight: null,
                                    focus: true,
                                    lang: "ko-KR",
                                    placeholder: '최대 2048자까지 쓸 수 있습니다',
                                    //이미지 업로드시 콜백 호출 :
                                    callbacks: {
                                        onImageUpload: function (files, editor, welEditable) {
                                            for (var i = 0; i < files.length; i++) {
                                                sendFile(files[i], this, i);
                                            }
                                        }
                                    }
                                });
                            });

                            //Base64 mulipart file로 이미지 컨트롤러에 전달
                            function sendFile(file, el, i) {
                                var formData = new FormData();
                                formData.append('file', file);
                                $j1124.ajax({
                                    data: formData,
                                    type: 'POST',
                                    url: '${pageContext.request.contextPath}/image',
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    enctype: 'multipart/form-data',
                                    success: function (url) {
                                        $(el).summernote("insertImage", '${pageContext.request.contextPath}' + url, function ($image) {
                                            $image.css('width', "60%");
                                        });
                                        //업로드된 이미지 파일명 input태그 저장
                                        $('#reviewI-imageAppend').after('<input name="uploadImgs" type="hidden"/>');
                                        document.getElementsByName('uploadImgs')[i].value = url;
                                    }
                                });
                            }
                        </script>
                    </td>
                </tr>

                <%-- 코스 그리기 추가 : select (선택시 코스 이름, 코스그리기 항목 추가) --%>
                <tr class="common-tbl__item" id="reviewI-selectBox">
                    <td style="width: 170px">
                        여행 코스 추가
                    </td>
                    <td>
                        <select id="reviewI-select--course">
                            <option value="no">추가 안함</option>
                            <option value="yes">추가</option>
                        </select>
                    </td>
                </tr>
            </table>

            <%-- 저장 버튼 --%>
            <div id="reviewIU-container--bottom">
                <button type="button" onclick="uploadCanvasData('${pageContext.request.contextPath}');"
                        id="reviewIU-btn--submit"
                        class="button--exceptionboot" style="width: 130px; height: 40px; font-size: 23px">
                    저장
                </button>
            </div>
        </form>
    </section>

    <%-- 푸터 --%>
    <footer>
        <jsp:include page="../footer.jsp"/>
    </footer>
</body>
</html>
