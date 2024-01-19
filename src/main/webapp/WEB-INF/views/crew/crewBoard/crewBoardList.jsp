<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.finalprj.doldolseo.util.DateTimeFormatUtil" %>
<c:set var="startBlockPage" value="${pagingParam.startBlockPage}"/>
<c:set var="endBlockPage" value="${pagingParam.endBlockPage}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루 활동 게시판</title>

    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<%-- 헤더 --%>
<header id="head_container">
    <jsp:include page="../../header.jsp"/>
</header>

<section class="crew-mainContainer">
    <%-- 크루 네비게이션 : 공통 --%>
        <nav class="crew-navi">
            <span class="crew-navi__btn"><a href="${pageContext.request.contextPath}/crew/board">크루활동</a></span>
            <span class="crew-navi__btn"><a href="#">가입한크루</a></span>
        </nav>

    <%-- 크루활동 게시판 네비 바 : 전체/맛집/쇼핑/문화/자유 --%>
<%--    <div class="cBoard-nav">--%>
<%--        <a href="${pageContext.request.contextPath}/crew/board">전체</a>--%>
<%--        <a href="${pageContext.request.contextPath}/crew/board?cat=맛집">맛집</a>--%>
<%--        <a href="${pageContext.request.contextPath}/crew/board?cat=쇼핑">쇼핑</a>--%>
<%--        <a href="${pageContext.request.contextPath}/crew/board?cat=문화">문화</a>--%>
<%--        <a href="${pageContext.request.contextPath}/crew/board?cat=자유">자유</a>--%>
<%--    </div>--%>

    <%-- 상단 정렬버튼 --%>
    <div class="crew-topContainer__sub" style="width: 1100px; top: 20px">
        <div class="crew-topContainer__subBtnbox" style="text-align: left;">
            <button class="crew-button">크루 전체</button>
            <button class="crew-button">내 크루만</button>
        </div>
<%--        <c:if test="${isJoinedCrew}">--%>
            <button id="cBoardL-btn--write" class="crew-button"
                    onclick=location.href="${pageContext.request.contextPath}/crew/board/new?id=${member.id}">글쓰기
            </button>
<%--        </c:if>--%>
    </div>

    <table id="cBoardL-list">
        <tr class="list--header" style="background-color: #F4B7B4">
            <td>크루명</td>
            <td>카테고리</td>
            <td>제목</td>
            <td>닉네임</td>
            <td>등록일</td>
            <td>조회수</td>
        </tr>

        <%-- 게시글 목록 --%>
        <c:forEach items="${crewPosts.content}" var="crewPosts" begin="0" end="40">
            <c:set var="dateYMDMH" value="${DateTimeFormatUtil.changeToYMDHM(crewPosts.WDate)}"/>
            <tr class="list--item">
                <td>${crewPosts.crew.crewName}</td>
                <td>${crewPosts.category}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/crew/board/${crewPosts.postNo}">${crewPosts.title}</a>
                </td>
                <td>${crewPosts.member.nickname}</td>
                <td>${dateYMDMH}</td>
                <td>${crewPosts.hit}</td>
            </tr>
        </c:forEach>
    </table>

    <%-- 페이지네이션 및 검색창--%>
    <div id="cBoardL-container--bottom">

        <%-- 페이지네이션 --%>
        <table class="pagination">
            <tr>
                <!-- 첫 페이지로 이동 -->
                <td>
                    <a href="${pageContext.request.contextPath}/crew/board?page=0">
                        << </a>
                </td>

                <!-- 이전 페이지로 이동 : 첫 페이지 제외 -->
                <c:if test="${startBlockPage ne 1}">
                    <td>
                        <a href="${pageContext.request.contextPath}/crew/board?page=${startBlockPage-2}">
                            < </a>
                    </td>
                </c:if>

                <!-- 페이징 블록 1 ~ 10 -->
                <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="idx">
                    <td>
                        <a href="${pageContext.request.contextPath}/crew/board?page=${idx-1}">${idx}</a>
                    </td>
                </c:forEach>

                <!-- 다음 페이지로 이동 : 마지막 페이지 제외 -->
                <c:if test="${endBlockPage ne crewPosts.totalPages}">
                    <td>
                        <a href="${pageContext.request.contextPath}/crew/board?page=${endBlockPage}">
                            > </a>
                    </td>
                </c:if>

                <!-- 마지막 페이지로 이동 -->
                <td>
                    <a href="${pageContext.request.contextPath}/crew/board?page=${reviewList.totalPages-1}">
                        >> </a>
                </td>
            </tr>
        </table>
    </div>
    <%-- 검색창 --%>
    <div id="cBoardL-bottom_search" class="common-searchbar">
        <select name="search"><%-- 검색 조건 --%>
            <option value="0">제목</option>
            <option value="1">내용</option>
            <option value="2">닉네임</option>
            <option value="2">크루명</option>
        </select>
        <input type="text"><%-- 검색어 입력 --%>
        <button class="crew-button"><%-- 검색 버튼 --%>
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="white"
                 class="bi bi-search" viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
        </button>
    </div>
</section>


<%-- footer --%>
<footer>
    <jsp:include page="../../footer.jsp"/>
</footer>
</body>
</html>
