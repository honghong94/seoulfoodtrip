<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

    <script>
        <%-- select box 카테고리 선택 --%>
        $(function () {
            $('#cBoardU-select--cat').val('${crewPost.category}').prop("selected", true);
        });
    </script>
</head>
<body>
    <%-- 헤더 --%>
    <header id="head_container">
        <jsp:include page="../../header.jsp"/>
    </header>

    <%-- 메인 컨테이너 --%>
    <section class="common-iuContainer--main">

        <%-- 제목 --%>
        <div class="common-iuTop--title" style="color:#F4B7B4 ">
            글수정
        </div>

        <%-- 크루 게시글 수정 폼 카테고리/제목/내용/크루원 추가/코스/ --%>
        <form:form action="${pageContext.request.contextPath}/crew/board/${crewPost.postNo}" method="put">
            <input type="hidden" name="_method" value="put"/>
            <table class="common-iuContainer--writeform">

                <input name="member.id" type="hidden" value="kki7823"/><%-- 추후 세션처리 --%>
                <input name="uploadImg" type="hidden" value="${crewPost.uploadImg}"/><%-- 추후 세션처리 --%>

                    <%-- 카테고리 : select --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        <b>카테고리</b>
                    </td>
                    <td>
                        <select id="cBoardU-select--cat" name="category" class="writeform__component">
                            <option value="맛집">맛집</option>
                            <option value="쇼핑">쇼핑</option>
                            <option value="문화">문화</option>
                            <option value="자유">자유</option>
                        </select>
                    </td>
                </tr>

                    <%-- 제목 : text --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        제목
                    </td>
                    <td>
                        <input value="${crewPost.title}" name="title" style="width: 600px" type="text"/>
                    </td>
                </tr>

                    <%-- 내용 : summernote --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        내용
                    </td>
                    <td>
                        <textarea name="content" id="cBoardU-summernote">${crewPost.content}</textarea>
                        <div id="cBoardU-imageAppend"></div>
                    </td>
                    <script>
                        $(document).ready(function () {
                            $('#cBoardU-summernote').summernote({
                                //summernote 속성
                                width: 1100,
                                height: 400,
                                minHeight: null,
                                maxHeight: null,
                                focus: true,
                                lang: "ko-KR",
                                placeholder: '최대 2048자까지 쓸 수 있습니다',
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
                                url: '${pageContext.request.contextPath}/image/crew',
                                cache: false,
                                contentType: false,
                                processData: false,
                                enctype: 'multipart/form-data',
                                success: function (url) {
                                    $(el).summernote('insertImage', "${pageContext.request.contextPath}" + url, function ($image) {
                                        $image.css('width', "60%");
                                    });
                                    //업로드된 이미지 파일명 input태그 저장
                                    $('#cBoardU-imageAppend').after('<input name="uploadImgs" type="hidden"/>');
                                    document.getElementsByName('uploadImgs')[i].value = url;
                                }
                            });
                        }
                    </script>
                </tr>

                    <%-- 함께한 크루원 추가 --%>
<%--                <tr class="common-tbl__item">--%>
<%--                    <td style="width: 170px">--%>
<%--                        함께한 크루원--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        <select name="addCrewMember">--%>
<%--                            <option value="#회원번호">크루멤버1</option>--%>
<%--                            <option value=#회원번호">크루멤버2</option>--%>
<%--                        </select>--%>

<%--                            &lt;%&ndash; 백엔드 연동시 추후 자바스크립트 작업&ndash;%&gt;--%>
<%--                        <div class="crew-box--addedMember">--%>
<%--                                &lt;%&ndash; 추가된 크루원 &ndash;%&gt;--%>
<%--                            <div class="crew-addedMember--idbox">--%>
<%--                                <div class="crew-member--photo">--%>
<%--                                    <img src="_image/crew/crew_img_sample1.png"/>--%>
<%--                                </div>--%>
<%--                                <div style="display: inline-block; position: relative; bottom: 18px">새튀단원1</div>--%>
<%--                                <span class="common-deleteMark--x"--%>
<%--                                      style="position: relative; bottom: 17px">&Cross;</span>--%>
<%--                            </div>--%>
<%--                                &lt;%&ndash; 추가된 크루원 &ndash;%&gt;--%>
<%--                            <div class="crew-addedMember--idbox">--%>
<%--                                <div class="crew-member--photo">--%>
<%--                                    <img src="_image/crew/crew_img_sample1.png"/>--%>
<%--                                </div>--%>
<%--                                <div style="display: inline-block; position: relative; bottom: 18px">새튀단원2</div>--%>
<%--                                <span class="common-deleteMark--x"--%>
<%--                                      style="position: relative; bottom: 17px">&Cross;</span>--%>
<%--                            </div>--%>
<%--                                &lt;%&ndash; 추가된 크루원 &ndash;%&gt;--%>
<%--                            <div class="crew-addedMember--idbox">--%>
<%--                                <div class="crew-member--photo">--%>
<%--                                    <img src="_image/crew/crew_img_sample1.png"/>--%>
<%--                                </div>--%>
<%--                                <div style="display: inline-block; position: relative; bottom: 18px">새튀단원3</div>--%>
<%--                                <span class="common-deleteMark--x"--%>
<%--                                      style="position: relative; bottom: 17px">&Cross;</span>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
            </table>

            <%-- 저장 버튼 --%>
            <div id="reviewIU-container--bottom">
                <button class="button--exceptionboot"
                        type="submit"
                        style="width: 130px; height: 40px; font-size: 23px; background-color: #F4B7B4">
                    저장
                </button>
            </div>
        </form:form>
    </section>

    <%-- 푸터 --%>
    <footer>
        <jsp:include page="../../footer.jsp"/>
    </footer>
</body>
</html>
