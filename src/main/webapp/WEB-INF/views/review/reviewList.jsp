<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:useBean id="mapFactory" class="com.finalprj.doldolseo.util.CodeMapFactory"/>
<%@ page import="com.finalprj.doldolseo.util.DateTimeFormatUtil" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기게시판</title>

    <%-- 메인 스타일시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

</head>
<body>
    <%-- 헤더 --%>
    <header id="head_container">
        <jsp:include page="../header.jsp"/>
    </header>

    <%-- 메인 컨테이너 --%>
    <div class="review-container--main">

        <%-- 네비게이션 --%>
        <nav class="review-container__navi" style="height: 1100px">
            <jsp:include page="reviewNavibar.jsp"/>
        </nav>

        <%-- 섹션 --%>
        <section id="reviewL-listbox">

            <%-- 게시판 드릴다운 및 글쓰기 버튼 --%>
            <div class="review-container--top">

                <span class="common-top__drilldownbox">
                    <a href="${pageContext.request.contextPath}/review" style="color: #F78181">후기게시판</a>
                    <span> > </span>
                    <a>${mapFactory.areaMap.get(areaNo)}</a>
                </span>

                <%-- 글쓰기 버튼 --%>
                <div id="reviewL-top__buttonbox">
                    <button class="review-button"
                            onclick="location.href='${pageContext.request.contextPath}/review/new'">글쓰기
                    </button>
                </div>
            </div>

            <%-- 글 목록--%>
            <table id="reviewL-list">
                <tr class="list--header">
                    <td style="width: 100px">지역</td>
                    <td>제목</td>
                    <td style="width: 100px">닉네임</td>
                    <td style="width: 150px">등록일</td>
                    <td style="width: 100px">조회수</td>
                </tr>
                <c:forEach items="${reviewList}" var="review" begin="0" end="40">
                    <c:set var="dateYMDMH" value="${DateTimeFormatUtil.changeToYMDHM(review.WDate)}"/>

                    <tr class="list--item">
                        <td>${mapFactory.areaMap.get(review.areaNo)}</td>
                        <td><a href="${pageContext.request.contextPath}/review/${review.reviewNo}">${review.title}</a>
                        </td>
                        <td>${review.member.nickname}</td>
                        <td>${dateYMDMH}</td>
                        <td>${review.hit}</td>
                    </tr>
                </c:forEach>
            </table>

            <%-- 페이지네이션 및 검색창--%>
            <div id="reviewL-container--bottom">

                <%-- 페이지네이션 --%>
                <c:set var="START_BLOCK_PAGE" value="${pagingParam.startBlockPage}"/>
                <c:set var="END_BLOCK_PAGE" value="${pagingParam.endBlockPage}"/>
                <c:set var="TOTAL_PAGES" value="${pagingParam.totalPages}"/>
                <div id="reviewL-bottom__pagination">
                    <table class="pagination">
                        <tr>
                            <!-- 첫 페이지로 이동 -->
                            <td>
                                <a href="${pageContext.request.contextPath}/review?page=0">
                                    << </a>
                            </td>

                            <!-- 이전 페이지로 이동 : 첫 페이지 제외 -->
                            <c:if test="${START_BLOCK_PAGE ne 1}">
                                <td>
                                    <a href="${pageContext.request.contextPath}/review?page=${START_BLOCK_PAGE-2}">
                                        < </a>
                                </td>
                            </c:if>

                            <!-- 페이징 블록 1 ~ 10 -->
                            <c:forEach begin="${START_BLOCK_PAGE}" end="${END_BLOCK_PAGE}" var="idx">
                                <td>
                                    <a href="${pageContext.request.contextPath}/review?page=${idx-1}">${idx}</a>
                                </td>
                            </c:forEach>

                            <!-- 다음 페이지로 이동 : 마지막 페이지 제외 -->
                            <c:if test="${END_BLOCK_PAGE ne TOTAL_PAGES}">
                                <td>
                                    <a href="${pageContext.request.contextPath}/review?page=${END_BLOCK_PAGE}">
                                        > </a>
                                </td>
                            </c:if>

                            <!-- 마지막 페이지로 이동 -->
                            <td>
                                <a href="${pageContext.request.contextPath}/review?page=${TOTAL_PAGES-1}">
                                    >> </a>
                            </td>
                        </tr>
                    </table>
                </div>
                <%-- 검색창 --%>
                <div id="reviewL-bottom_search" class="common-searchbar">
                    <select name="search"><%-- 검색 조건 --%>
                        <option value="0">제목</option>
                        <option value="1">내용</option>
                        <option value="2">닉네임</option>
                    </select>
                    <input type="text"><%-- 검색어 입력 --%>
                    <button class="review-button"><%-- 검색 버튼 --%>
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentcolor"
                             class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                        </svg>
                    </button>
                </div>
            </div>
        </section>
    </div>

    <%-- 푸터 --%>
    <footer>
        <jsp:include page="../footer.jsp"/>
    </footer>
</body>
</html>
