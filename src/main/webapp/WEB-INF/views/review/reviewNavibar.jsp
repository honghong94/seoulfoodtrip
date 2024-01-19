<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%-- 후기 게시글 목록에 include --%>
<div class="nav-container" style="background-color: #F78181">
    <%-- 제목 --%>
    <div class="nav-titlebox" >
        <span id="nav-titlebox__title" style="color: white">REVIEW</span>
    </div>
    <hr class="line--horizon" style="margin: 0 20px 0 20px;">
    <%-- 네비게이션 리스트 : 광화문, 명동, 홍대, 여의도, 강남, 잠실, 용산, 기타 --%>
    <ul class="nav-list">
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review">
                전체
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=1">
                강남
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=2">
                강북
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=3">
                광화문
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=4">
                명동
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=5">
                여의도
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=6">
                잠실
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=7">
                홍대
            </a>
        </li>
        <li class="nav-list__item">
            <a href="${pageContext.request.contextPath}/review?areaNo=0">
                그외
            </a>
        </li>
    </ul>
</div>
