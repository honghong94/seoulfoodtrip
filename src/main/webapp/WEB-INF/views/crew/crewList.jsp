<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="startBlockPage" value="${pagingParam.startBlockPage}"/>
<c:set var="endBlockPage" value="${pagingParam.endBlockPage}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루게시판 - 크루 목록</title>
    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <%-- jQuery--%>
    <script
            src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
            crossorigin="anonymous">
    </script>
</head>
<body>
<%-- 헤더 --%>
<header id="head_container">
    <jsp:include page="../header.jsp"/>
</header>

<section class="crew-mainContainer">
    <%-- 크루 네비게이션 : 공통 --%>
    <nav class="crew-navi">
        <span class="crew-navi__btn"><a href="${pageContext.request.contextPath}/crew/board">크루활동</a></span>
        <span class="crew-navi__btn"><a href="#">가입한크루</a></span>
        <%--            <button id="crew-navi__btn--mycrew" type="button" class="crew-button">My Crew</button>--%>
    </nav>

    <%-- 상단 제목,드릴다운 : 공통 --%>
    <div class="crew-topContainer">

        <security:authorize access="isAuthenticated()">
            <c:choose>
                <c:when test="${member.crleader.toString() eq 'y' }">
                    <button id="crew-topContainer__crewBtn"
                            onclick="location.href='${pageContext.request.contextPath}/crewM'">
                        크루 관리
                    </button>
                </c:when>
                <c:otherwise>
                    <button id="crew-topContainer__crewBtn"
                            onclick="location.href='${pageContext.request.contextPath}/crewI'">
                        크루 생성
                    </button>
                </c:otherwise>
            </c:choose>
        </security:authorize>

    </div>

    <%-- 상단 정렬버튼 + 검색창 --%>
    <div class="crew-topContainer__sub">
        <%--        검색창--%>
        <div class="common-searchbar" id="crewL-searchBar">
            <select name="search"><%-- 검색 조건 --%>
                <option value="0">크루명</option>
                <option value="1">지역</option>
                <option value="2">크루장</option>
            </select>
            <input type="text"><%-- 검색어 입력 --%>
            <button class="crew-button" style="background-color: #f7b5b2"><%-- 검색 버튼 --%>
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#F6CEEC" class="bi bi-search"
                     viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                </svg>
            </button>
        </div>
    </div>

    <%-- 크루 목록 --%>
    <%-- * 크루이름 최대 8자 까지 --%>
    <div class="crew-listContainer">
        <c:forEach items="${crewPage.content}" var="crewDTO" begin="0" end="20">
            <%-- 크루프로필 start --%>
            <div class="crew-crewProfile">

                <div class="crew-crewProfile__logo">
                    <img src="${pageContext.request.contextPath}/_image/crew/logo/${crewDTO.crewImgFileName}"
                         alt="crew_logo">
                </div>

                <div id="crew-crewProfile-info">

                    <div class="crew-crewProfile__crewnameBox">
                            <%--                        크루명--%>
                        <span class="crew-crewProfile__crewnameBox__name">
                            <a href="${pageContext.request.contextPath}/crewD?crewNo=${crewDTO.crewNo}">${crewDTO.crewName}</a>
                        </span>
                    </div>

                    <div class="crew-crewProfile__master">
                        <span class="crew-label--crewmaster">크루장</span>&nbsp;${crewDTO.member.nickname}
                    </div>

                    <div class="crew-crewProfile__region">
                        <span style="color: black">지역</span> > ${crewDTO.areaList}
                    </div>

                    <div class="crew-crewProfile__intro">
                            ${crewDTO.intro}
                    </div>
                </div>
            </div>
            <%-- 크루프로필 end --%>
        </c:forEach>
    </div>

    <%-- 페이지네이션 및 검색창--%>
    <div id="crewL-container--bottom">
        <%-- 페이지네이션 --%>
        <div id="crewL-bottom__pagination">
            <table class="pagination">
                <tr>
                    <!-- 첫 페이지로 이동 -->
                    <td>
                        <a href="${pageContext.request.contextPath}/crewL?page=0">
                            << </a>
                    </td>

                    <!-- 이전 페이지로 이동 : 첫 페이지 제외 -->
                    <c:if test="${startBlockPage ne 1}">
                        <td>
                            <a href="${pageContext.request.contextPath}/crewL?page=${startBlockPage-2}">
                                < </a>
                        </td>
                    </c:if>

                    <!-- 페이징 블록 1 ~ 10 -->
                    <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="idx">
                        <td>
                            <a href="${pageContext.request.contextPath}/crewL?page=${idx-1}">${idx}</a>
                        </td>
                    </c:forEach>

                    <!-- 다음 페이지로 이동 : 마지막 페이지 제외 -->
                    <c:if test="${endBlockPage ne crewPage.totalPages}">
                        <td>
                            <a href="${pageContext.request.contextPath}/crewL?page=${endBlockPage}">
                                > </a>
                        </td>
                    </c:if>

                    <!-- 마지막 페이지로 이동 -->
                    <td>
                        <a href="${pageContext.request.contextPath}/crewL?page=${crewPage.totalPages-1}">
                            >> </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</section>

<%-- footer --%>
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>
</body>
</html>
