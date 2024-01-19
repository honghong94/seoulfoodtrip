<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.finalprj.doldolseo.util.DateTimeFormatUtil" %>
<c:set var="dateYMD" value="${DateTimeFormatUtil.changeToYMD(review.WDate)}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기게시판 - 상세</title>

    <%-- 메인 스타일시트 --%>
    <link href=" ${pageContext.request.contextPath}/_css/mainStyle.css?" rel="stylesheet" type="text/css">

    <%-- jQuery--%>
    <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous">
    </script>
    <%-- 댓글 이벤트 처리 --%>
    <script src="${pageContext.request.contextPath}/_js/comment.js"></script>


</head>
<body>
    <%-- 헤더 --%>
    <header id="head_container">
        <jsp:include page="../header.jsp"/>
    </header>
    <%-- 메인 컨테이너 --%>
    <div class="review-container--main" style="height: auto;">

        <%-- 네비게이션 --%>
        <nav class="review-container__navi" style="height: 1200px">
            <jsp:include page="reviewNavibar.jsp"/>
        </nav>

        <%-- 섹션 --%>
        <section id="reviewD-container">

            <%-- 게시판 드릴다운 및 글쓰기 버튼 --%>
            <div class="review-container--top">
                <%-- 제목 --%>
                <div class="common-top__title" style="color: #F6CECE;">
                    지역게시판
                </div>
                <%-- 게시판 드릴다운 --%>
                <span class="common-top__drilldownbox">
                    <a href="#" style="color: #F78181;">후기게시판</a>
                    <span> > </span>
                    <a href="#">전체</a>
                </span>
            </div>

                <c:if test="${member.id eq review.member.id}">
                    <div class="review-btnBox--reviewEdit">
                        <button class="review-button"
                                onclick="location.href='${pageContext.request.contextPath}/review/${review.reviewNo}/edit'"
                                style="margin-right: 10px;">수정 하기
                        </button>

                        <form:form action="${pageContext.request.contextPath}/review/${review.reviewNo}"
                                   method="delete">
                            <input type="hidden" name="_method" value="delete"/>
                            <input type="hidden" name="reviewNo" value="${review.reviewNo}">
                            <button type="submit" class="review-button">글 삭제</button>
                        </form:form>
                    </div>
                </c:if>

            <%-- 상세 글 목록  --%>
            <table class="reviewD-tablelayout">
                <%-- 글상단 : 프로필 박스 + 댓글 및 조회수 --%>
                <tr class="common-tbl__item">
                    <td>
                        <%-- 프로필 박스 : 회원사진, 닉네임, 작성날짜--%>
                        <div class="profilebox">
                            <%-- 회원사진 --%>
                            <div class="profilebox--photo">
                                <img src="${pageContext.request.contextPath}/_image/profile/${review.member.member_img}">
                            </div>
                            <%-- 닉네임 + 작성날짜 컨테이너 --%>
                            <div class="profilebox--container--sub">
                                <%-- 닉네임 --%>
                                <div class="profilebox--nickname">
                                    ${review.member.nickname}
                                </div>
                                <%-- 작성날짜 --%>
                                <div class="profilebox--wdate">
                                    ${dateYMD}
                                </div>
                            </div>
                        </div>

                        <%-- 댓글 수 , 조회수 표시 --%>
                        <div class="iconbox">
                            <div class="iconbox__comment">
                                <%-- 댓글 아이콘 - bootstrap--%>
                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#F78181"
                                     class="bi bi-chat-square-text-fill" viewBox="0 0 16 16">
                                    <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-2.5a1 1 0 0 0-.8.4l-1.9 2.533a1 1 0 0 1-1.6 0L5.3 12.4a1 1 0 0 0-.8-.4H2a2 2 0 0 1-2-2V2zm3.5 1a.5.5 0 0 0 0 1h9a.5.5 0 0 0 0-1h-9zm0 2.5a.5.5 0 0 0 0 1h9a.5.5 0 0 0 0-1h-9zm0 2.5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5z"></path>
                                </svg>
                            </div>
                            <div id="reviewD-comment_count" class="iconbox__commentcount">
                                <%-- 댓글 수 --%>
                            </div>

                            <div class="iconbox__hit">
                                <%-- 조회수 아이콘 - bootstrap--%>
                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#F78181"
                                     class="bi bi-hand-index-fill" viewBox="0 0 16 16">
                                    <path d="M8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002z"></path>
                                </svg>
                            </div>
                            <div class="iconbox__hitcount">
                                ${review.hit}
                            </div>
                        </div>
                    </td>
                </tr>

                <%-- 글 제목 --%>
                <tr class="common-tbl__item">
                    <td>
                        <span id="reviewD__title">${review.title}</span>
                    </td>
                </tr>

                <%-- 여행 코스 --%>
                <c:if test="${!empty review.courseImgName}">
                    <tr class="common-tbl__item">
                        <td>
                            <div id="reviewD-coursebox">
                                <img src="${pageContext.request.contextPath}/_image/review/${review.reviewNo}/${review.courseImgName}"
                                     alt="여행코스">
                            </div>
                        </td>
                    </tr>
                </c:if>

                <%-- 글 내용 --%>
                <tr class="common-tbl__item">
                    <td>
                        <p id="reviewD-content">
                            ${review.content}
                        </p>
                    </td>
                </tr>
            </table>


            <%-- 댓글 창--%>
            <div id="reviewD-comment__banner">
                <div class="common-top__title" style="font-size: 35px; color: #F6CECE">
                    COMMENT
                </div>

            </div>
            <hr class="line--horizon" style="width:1000px ">

            <%-- RestController 에서 댓글 가져오기 --%>
            <script>
                $j1124.ajax({
                    url: '${pageContext.request.contextPath}/review/${reviewNo}/comment',
                    dataType: 'json',
                    type: 'GET',
                    success: function (data) {
                        appendComment(data, '${pageContext.request.contextPath}', '${member.id}');
                        enableEditMode();
                    }
                });
            </script>

            <%-- 댓글 보기 --%>
            <table class="reviewD-tablelayout" id="reviewD-commentLayout">
                <%-- 댓글 목록 출력 --%>
            </table>

            <%-- 댓글 입력 폼 --%>
            <c:choose>
                <c:when test="${member.id eq null}">
                    <div class="comment__input">
                        <textarea name="content" placeholder="로그인이 필요합니다." readonly="readonly"></textarea>
                        <div class="comment__buttonbox">
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <form id="reviewD-commentForm" method="post">
                        <div class="comment__input" id="reviewD-comment__input">
                            <input type="hidden" name="member.id" value="${member.id}">
                            <input type="hidden" name="review.reviewNo" value=${reviewNo}>
                            <textarea id="comment__input__textarea" name="content" placeholder="댓글을 입력해 보세요"
                                      onfocusin="changeBorderOnFocus()"
                                      onfocusout="changeBorderOnFocusOut()"></textarea>
                            <div class="comment__buttonbox">
                                <button type="button"
                                        onclick="insertComment('${pageContext.request.contextPath}',${reviewNo})"
                                        class="button--comment">등록
                                </button>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>

        </section>

    </div>
    <%-- 푸터 --%>
    <footer>
        <jsp:include page="../footer.jsp"/>
    </footer>
</body>
</html>
