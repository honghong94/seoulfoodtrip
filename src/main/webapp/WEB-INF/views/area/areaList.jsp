<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="mapFactory" class="com.finalprj.doldolseo.util.CodeMapFactory"/>
<c:set var="startBlockPage" value="${pagingParam.startBlockPage}"/>
<c:set var="endBlockPage" value="${pagingParam.endBlockPage}"/>
<c:set var="totalPages" value="${pagingParam.totalPages}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AREA LIST</title>
    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--헤더-->
<header id="head_container">
    <jsp:include page="../header.jsp"/>
</header>

<section id="areaList-container">

    <!--네비(카테고리/검색창)-->
    <div id="areaList-nav">

        <!-- 게시판 드릴 다운 메뉴 -->
        <div id="areaL-drilldownBox">
            <span class="common-top__drilldownbox">
                        <a href="${pageContext.request.contextPath}/areaL?sigungu=1}" style="color: #5882FA">지역게시판</a>
                <span> > </span>
                        <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}"
                           style="color: #0080c0">${mapFactory.areaMap.get(sigungu)}</a>
                <span> > </span>
                        <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}">${mapFactory.contentTypeMap.get(contentType)}</a>
            </span>
        </div>

        <!--네비_검색창-->
        <div id="areaList-nav__search">
            <form action="${pageContext.request.contextPath}/areaL" method="get">
                <input type="hidden" name="sigungu" value="${sigungu}">
                <input id="areaList-nav__search__input" name="searchKeyword" type="text"/>
                <button id="areaList-nav__search__btn" type="submit">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="18" fill="white" class="bi bi-search"
                         viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                    </svg>
                </button>
            </form>
        </div>
    </div>

    <!-- 지역 게시글 목록 -->
    <div id="areaList-dataContainer">
        <div id="areaList-dataBox">

            <c:forEach items="${areaList}" var="areaList" varStatus="status">
                <!-- 항목 -->
                <div class="areaList-data">
                    <div id="areaList-dataImg" style="display: inline-block;margin: 20px;">

                        <!-- 상세보기로 이동 -->
                        <a href="javascript:encodeAndLink('${areaList.name}');">

                            <!-- url 예약문자 처리  -->
                            <script>
                                function encodeAndLink(name) {
                                    name = encodeURIComponent(name);
                                    location.href = '${pageContext.request.contextPath}/areaD?name=' + name;
                                }
                            </script>

                            <!-- 이미지 default 처리 -->
                            <c:choose>
                                <c:when test="${areaList.image1 ne null}">
                                    <img src="${pageContext.request.contextPath}/_image/area/${areaList.image1}" width="250" height="250" alt="area image">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/_image/area/areaListData/default.png"
                                         width="250" height="250"
                                         alt="area image">
                                </c:otherwise>
                            </c:choose>

                        </a>
                    </div>

                    <div id="areaList-dataName" style="margin: 0 auto;">
                        <b>${areaList.name}</b>
                    </div>
                </div>
            </c:forEach>
            <div class="clear-both"></div>
        </div>
        <!-- 페이징 처리 -->
        <div id="areaList-dataPage">
            <table class="pagination">
                <tr>
                    <!-- 첫 페이지로 이동 -->
                    <td>
                        <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}&page=0">
                            << </a>
                    </td>

                    <!-- 이전 페이지로 이동 : 첫 페이지 제외 -->
                    <c:if test="${startBlockPage ne 1}">
                        <td>
                            <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}&page=${startBlockPage-2}">
                                < </a>
                        </td>
                    </c:if>

                    <!-- 페이징 블록 1 ~ 10 -->
                    <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="idx">
                        <td>
                            <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}&page=${idx-1}">${idx}</a>
                            <!-- 이거 현재 URL 로 반영되게 바꿀것 -->
                        </td>
                    </c:forEach>

                    <!-- 다음 페이지로 이동 : 마지막 페이지 제외 -->
                    <c:if test="${endBlockPage ne totalPages}">
                        <td>
                            <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}&page=${endBlockPage}">
                                > </a>
                        </td>
                    </c:if>

                    <!-- 마지막 페이지로 이동 -->
                    <td>
                        <a href="${pageContext.request.contextPath}/areaL?sigungu=${sigungu}&contentType=${contentType}&page=${totalPages-1}">
                            >> </a>
                    </td>
                </tr>
            </table>
        </div>

    </div>
</section>
<!--푸터-->
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>
</body>
</html>