<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기게시판 - 글수정</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css?ch2axa" rel="stylesheet" type="text/css">

    <%-- 코스 그리기 --%>
    <script src="${pageContext.request.contextPath}/_js/draw_course.js"></script>

    <!-- include summernote css -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

    <script>
        <%-- select box 지역 선택 --%>
        $(function () {
            $('#reviewU-select--area').val(${review.areaNo}).prop("selected", true);
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
            글수정
        </div>

        <%-- 글 수정 폼 지역/제목/내용/코스추가/코스/ --%>
        <form:form action="${pageContext.request.contextPath}/review/${review.reviewNo}" method="put">
            <input type="hidden" name="_method" value="put"/>
            <table class="common-iuContainer--writeform">
                    <%-- id : hidden --%>
                <input name="member.id" type="hidden" value="${member.id}"/>
                <input name="uploadImgNames" type="hidden" value="${review.uploadImgNames}"/>

                    <%-- 지역 : select --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        <b>지역</b>
                    </td>

                    <td>
                        <select id="reviewU-select--area" name="areaNo" class="writeform__component">
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
                        <input value="${review.title}" name="title" style="width: 600px" type="text"/>
                    </td>
                </tr>

                    <%-- 내용 : summernote --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        내용
                    </td>
                    <td>
                        <textarea name="content" id="summernote">${review.content}</textarea>
                        <div id="reviewU-imageAppend"></div>
                    </td>

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
                                type: "POST",
                                url: '${pageContext.request.contextPath}/image',
                                cache: false,
                                contentType: false,
                                processData: false,
                                enctype: 'multipart/form-data',
                                success: function (url) {
                                    $(el).summernote('insertImage', "${pageContext.request.contextPath}" + url, function ($image) {
                                        $image.css('width', "60%");
                                    });
                                    //업로드된 이미지 파일명 input태그 저장
                                    $('#reviewU-imageAppend').after('<input name="uploadImgs" type="hidden"/>');
                                    document.getElementsByName('uploadImgs')[i].value = url;
                                }
                            });
                        }
                    </script>
                    <script>

                    </script>
                </tr>

                    <%-- 코스 수정 기능 : 미구현 --%>
                    <%-- 저장 버튼 --%>
                <div id="reviewIU-container--bottom">
                    <button class="button--exceptionboot"
                            type="submit"
                            style="width: 130px; height: 40px; font-size: 23px">저장
                    </button>
                </div>
            </table>
        </form:form>
    </section>


    <%-- 푸터 --%>
    <footer>
        <jsp:include page="../footer.jsp"/>
    </footer>
</body>
</html>