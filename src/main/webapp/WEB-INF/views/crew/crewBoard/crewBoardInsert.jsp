<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루 활동 - 글 쓰기</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <!-- include summernote css -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

</head>
<body>
<%-- 헤더 --%>
<header id="head_container">
    <jsp:include page="../../header.jsp"/>
</header>

<%-- 메인 컨테이너 --%>
<section class="common-iuContainer--main">

    <%-- 제목 --%>
    <div class="common-iuTop--title" style="color:#F4B7B4">
        글쓰기
    </div>

    <%-- 글쓰기 폼 카테고리/제목/내용/크루원 추가/코스/ --%>
    <form id="cBoardI-form" enctype="multipart/form-data">
        <table class="common-iuContainer--writeform">

            <%-- 카테고리 : select --%>
            <tr class="common-tbl__item">
                <td style="width: 170px">
                    <b>카테고리</b>
                </td>
                <td>
                    <select name="category" class="writeform__component">
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
                    <input name="title" style="width: 600px" type="text"/>
                </td>
            </tr>

            <%-- 내용 : summernote --%>
            <tr class="common-tbl__item">
                <td style="width: 170px">
                    내용
                </td>
                <td>
                    <textarea id="cBoardD-summernote" name="content"></textarea>
                    <div id="cBoardD-imageAppend"></div>
                    <%-- summernote 실행 --%>
                    <script>
                        $(function () {
                            $('#cBoardD-summernote').summernote({
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
                                url: '${pageContext.request.contextPath}/image/crew',
                                cache: false,
                                contentType: false,
                                processData: false,
                                enctype: 'multipart/form-data',
                                success: function (url) {
                                    $(el).summernote("insertImage", '${pageContext.request.contextPath}' + url, function ($image) {
                                        $image.css('width', "60%");
                                    });
                                    //업로드된 이미지 파일명 input태그 저장
                                    $('#cBoardD-imageAppend').after('<input name="uploadImgs" type="hidden"/>');
                                    document.getElementsByName('uploadImgs')[i].value = url;
                                }
                            });
                        }
                    </script>
                </td>
            </tr>

            <%-- 내 크루 목록 --%>
            <tr class="common-tbl__item">
                <td style="width: 170px">
                    내 크루 목록
                </td>
                <td>
                    <select id="cBoardI-select--crew" name="crew.crewNo" onchange="selectCrew()">
                        <option value="">선택안함</option>
                        <c:forEach items="${myCrewList}" var="crewDTO">
                            <option value="${crewDTO.crew.crewNo}">${crewDTO.crew.crewName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <script>
                <%-- 선택된 크루 번호로 크루원 명단 조회 --%>

                function selectCrew() {
                    let crewNo = $("#cBoardI-select--crew option:selected").val();
                    let param = {crewNo: crewNo};

                    $("#cBoardI-addMemberBox").empty();
                    if (crewNo === "") {
                        $("#cBoardI-select--crewMember").empty();
                        $("#cBoardI-select--crewMember").append(
                            " <option value=''>선택</option>");

                    } else {
                        $j1124.ajax({
                            data: JSON.stringify(param),
                            type: 'POST',
                            url: '${pageContext.request.contextPath}/crew/board/new',
                            contentType: "application/json",
                            cache: false,
                            processData: false,
                            success: function (data) {
                                $("#cBoardI-select--crewMember").empty();
                                $("#cBoardI-select--crewMember").append(
                                    " <option value=''>선택</option>");
                                $.each(data, function (index, item) { // 데이터 =item
                                    $("#cBoardI-select--crewMember").append(
                                        "<option value='" + item.member.member_img + "'>" + item.member.nickname + "/" + item.member.id + "</option>"
                                    );

                                });
                            }
                        });
                    }
                }
            </script>

            <c:if test="${myCrewList ne null}">
                <%-- 함께한 크루원 추가 --%>
                <tr class="common-tbl__item">
                    <td style="width: 170px">
                        함께한 크루원
                    </td>
                    <td>
                        <select id="cBoardI-select--crewMember" name="addCrewMember"
                                onchange="appendMember('${pageContext.request.contextPath}')">
                        </select>
                        <script>
                            //크루원 박스 추가
                            function appendMember(context) {
                                let member = $("#cBoardI-select--crewMember option:selected").text();
                                let img = $("#cBoardI-select--crewMember option:selected").val();

                                let memberName = '\"' + member + '\"';
                                if (member !== '') {
                                    $("#cBoardI-addMemberBox").append(
                                        "<div class='crew-addedMember--idbox'> " +
                                        "<div class='crew-member--photo'> " +
                                        "<img src='" + context + "/_image/profile/" + img + "'/>" +
                                        "</div> " +
                                        "<div style='display: inline-block; position: relative; bottom: 18px'>" + member + "</div> " +
                                        "<input type='hidden' name='memberName' value='" + memberName + "'>" +
                                        "<span class='common-deleteMark--x' onclick='deleteMember($(this).parent().index()," + memberName + ")' style='position: relative; bottom: 17px'>" +
                                        "&Cross;</span></div>"
                                    );
                                    $("#cBoardI-select--crewMember option:selected").remove();
                                }
                            }

                            //x 클릭시 해당 크루원 박스 삭제
                            function deleteMember(idx, member) {
                                alert("해당 멤버를 삭제하시겠습니까?");
                                $(".crew-addedMember--idbox")[idx].remove();
                                //선택목록에 해방 멤버 다시 추가
                                $("#cBoardI-select--crewMember").append(
                                    "<option value='" + member
                                    + "'>" + member + "</option>");
                            }

                        </script>

                        <div id="cBoardI-addMemberBox" class="crew-box--addedMember">
                                <%-- 추가된 크루원 --%>
                        </div>
                    </td>
                </tr>
            </c:if>
        </table>

        <%-- id : hidden --%>
        <input name="member.id" type="hidden" value="${member.id}"/>

        <%-- 저장 버튼 --%>
        <div id="reviewIU-container--bottom">
            <button class="button--exceptionboot" type="button" onclick="submitCrewBoard()"
                    style="width: 130px; height: 40px; font-size: 23px; background-color: #FF8000">
                저장
            </button>

            <script>
                function submitCrewBoard() {
                    $(function () {
                            let form = $("#cBoardI-form")[0];
                            let formData = new FormData(form);

                            $j1124.ajax({
                                type: 'POST',
                                url: '${pageContext.request.contextPath}/crew/board',
                                data: formData,
                                processData: false,	// data 파라미터 강제 string 변환 방지
                                contentType: false,	// application/x-www-form-urlencoded; 방지
                                cache: false,
                                success: function (data) {
                                    alert("게시글이 등록 되었습니다.");
                                    location.replace('${pageContext.request.contextPath}/crew/board');
                                },
                                error: function (request, status, error) {
                                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                                }
                            });
                        }
                    )
                }
            </script>
        </div>
    </form>
</section>

<%-- 푸터 --%>
<footer>
    <jsp:include page="../../footer.jsp"/>
</footer>
</body>
</html>
