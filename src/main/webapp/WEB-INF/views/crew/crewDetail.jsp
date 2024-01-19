<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.finalprj.doldolseo.util.DateTimeFormatUtil" %>
<c:set var="dateYMD" value="${DateTimeFormatUtil.changeToYMD(crew.CDate)}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루게시판 - 크루 상세</title>

    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
    x
    <%-- 크루가입 팝업 --%>
    <script>
        function popupCrewJoin() {
            window.open("${pageContext.request.contextPath}/crewJ?crewNo=${crew.crewNo}", "크루가입", "width = 900, height = 770");
        }
    </script>
</head>
<body>
<%-- 헤더 --%>
<header id="head_container">
    <jsp:include page="../header.jsp"/>
</header>

<section class="crew-mainContainer" style="width: 1120px; text-align: left">
    <%-- 상단 제목,드릴다운 : 공통 --%>
    <div class="crew-topContainer" style="width: 1120px;">
        <%-- 제목 --%>
        <div class="common-top__title" style="color: #F4B7B4">
            크루 정보
        </div>
        <%-- 게시판 드릴다운 --%>
        <span class="common-top__drilldownbox">
                    <a href="${pageContext.request.contextPath}/crewL">크루</a>
                    <span> > </span>
                    <a href="#">크루 정보</a>
            </span>
    </div>

    <%-- 크루 정보 컨테이너 --%>
    <div class="crew-infoContainer">
        <div class="crew-info__infobox">
            <%-- 크루 로고 --%>
            <div class="crew-info__item" style="margin-top: 20px">

                <div class="crew-logobox" style="width: 100px; height: 110px;">
                    <img src="${pageContext.request.contextPath}/_image/crew/logo/${crew.crewImgFileName}"
                         alt="crew-logo"/>
                </div>

                <div class="crew-info__detail">
                    <div>크루명: <span class="crew-namelabel">${crew.crewName}</span></div>
                    <div>관심지역: <span class="crew-namelabel">${crew.areaList}</span></div>
                    <div>크루설립일: <span class="crew-namelabel">${dateYMD}</span></div>
                </div>
            </div>

            <div class="crew-info__member">
                <div>
                    <span>크루원 정보</span>
                </div>
                <%-- 크루 멤버 컨테이너 --%>
                <div class="crew-memberContainer">
                    <table class="crew-memberTbl--top">
                        <tr class="crew-memberTbl__header">
                            <td style="width: 160px">멤버등급</td>
                            <td>멤버</td>
                        </tr>
                    </table>
                    <%-- 크루장 --%>
                    <table class="crew-memberTbl--bottom">
                        <tr class="common-tbl__item">
                            <td>
                                <div class="crew-master--decorate">
                                    <span class="crew-master--decotext">크루장</span>
                                    <img src="${pageContext.request.contextPath}/_image/crew/crew_master_crown.png"
                                         alt="crown">
                                </div>
                            </td>
                            <td>
                                <div class="crew-member--idbox">
                                    <div class="crew-member--photo">
                                        <img src="${pageContext.request.contextPath}/_image/profile/${crew.member.member_img}"
                                             alt="profile"/>
                                    </div>
                                    <div style="display: inline-block; position: relative; bottom: 18px">${crew.member.nickname}</div>
                                </div>
                            </td>
                        </tr>

                        <c:forEach items="${crewMembers}" var="crewMember">
                            <%-- 크루원 --%>
                            <tr class="common-tbl__item">
                                <td>
                                    <span class="crew-member-decotext">크루원</span>
                                </td>
                                <td>
                                    <div class="crew-member--idbox">
                                        <div class="crew-member--photo">
                                            <img src="${pageContext.request.contextPath}/_image/profile/${crewMember.member.member_img}"/>
                                        </div>
                                        <div style="display: inline-block; position: relative; bottom: 18px">${crewMember.member.id}</div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <div class="crew-info__introbox">

            <div class="crew-info__right" style="border: none">
                <div>크루소개</div>
                <div class="crew-infolabel">
                    ${crew.introDetail}
                </div>
            </div>

            <%-- 모집 공고 및 크루 가입 --%>
            <div class="crew-info__right">

                <div>
                    <div>모집 공고</div>

                    <security:authorize access="isAuthenticated()">
                        <c:choose>
                            <c:when test="${crewMembers.contains(member.id)}">
                                <button class="crew-button" style="float: right; margin-top: 2px">
                                    크루
                                    탈퇴
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="crew-button" style="float: right; margin-top: -25px"
                                        onclick="popupCrewJoin()">
                                    크루
                                    가입
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </security:authorize>
                </div>

                <div class="crew-infolabel">
                    ${crew.recruit}
                </div>
            </div>
        </div>
    </div>

</section>

<%-- footer --%>
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>

</body>
</html>
