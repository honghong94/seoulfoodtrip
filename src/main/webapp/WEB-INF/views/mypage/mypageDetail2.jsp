<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="startBlockPage" value="${pagingParam.startBlockPage}"/>
<c:set var="endBlockPage" value="${pagingParam.endBlockPage}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 프로필</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainJs.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function (){
            var gender = '<c:out value="${member.gender}" />';

            if(gender == "M"){
                $('#gender').val('M').prop("selected", true);
            }else if(gender == "F"){
                $('#gender').val('F').prop("selected", true);
            }else if(gender == "U"){
                $('#gender').val('U').prop("selected", true);
            }

            var img = '${member.member_img}';
            if(img == null){
                $('#my_img').attr("src","${pageContext.request.contextPath}/_image/profile/sample.png");
            }

            $(".mypageD-buttonbox__button--gray").click(function (){
                var leader = '<c:out value="${member.crleader}" />';

                if(leader == "y"){
                    alert("크루장인 경우, 탈퇴가 불가합니다. 크루장을 위임해주시길 바랍니다.");
                }else{
                    if(!confirm("탈퇴하시면 복구할 수 없습니다. 정말로 탈퇴하시겠습니까?")){
                        return false;
                    }else{
                        window.location.href='${pageContext.request.contextPath}/removeMember?id=${member.id}';
                    }
                }
            });

        });
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
</head>
<body>
<!-- header -->
<div class="memberL-header__div">
    <jsp:include page="../header.jsp"/>
</div>
<!-- // header -->

    <!-- 마이페이지 container -->
    <div class="mypageD-mypagecontainer">

        <!-- 마이페이지 네비바 -->
        <div class="mypageD-listcontainer">
            <ul class="mypageD-listcontainer__ul--blue" >
                <li class="mypageD-listcontainer__li--big">마이 페이지</li>
                <li class="mypageD-listcontainer__li--small"><a href="${pageContext.request.contextPath}/mypageD?id=${member.id}" class="mypageD-listcontainer__a--blue"><img class="mypageD-listcontainer__img--small" src="_image/mypage/person.png">&nbsp;  개인 정보</a></li>
                <li class="mypageD-listcontainer__li--small"><a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}" class="mypageD-listcontainer__a--blue"><img class="mypageD-listcontainer__img--small" src="_image/mypage/person.png">&nbsp;  크루 활동 내역</a></li>
            </ul>
        </div>
        <!-- // 마이페이지 네비바 -->

    <!-- 마이페이지 상세 -->
    <div class="mypageD-container">

        <!-- 내 크루 -->
        <div class="mypageD-crewcontainer">
            <span class="mypageD-crewcontainer__span--big">내 크루</span>

            <div class="mypageD-crewbox">
                <c:if test="${crewDTO == null && crewMemberDTO.size() == 0}">
                    <div class="mypageD-crewlistbox">
                        <span class="mypageD-crewlistbox__span--none">가입된 크루가 존재하지 않습니다.</span>
                    </div>
                </c:if>

                <c:if test="${crewDTO != null}">
                    <div class="mypageD-crewlistbox">
                        <span class="mypageD-crewlistbox__span--big">${crewDTO.crewName}</span>
                        <a href="${pageContext.request.contextPath}/crewD?crewNo=${crewDTO.crewNo}" class="mypageD-crewlistbox__a--big"><img src="${pageContext.request.contextPath}/_image/crew/logo/${crewDTO.crewImgFileName}" class="mypageD-crewlistbox__img--big"></a>
                        <button class="mypageD-crewlistbox__button--blue" onclick="location.href='${pageContext.request.contextPath}/crewD?crewNo=${crewDTO.crewNo}'">내 크루 보기</button>
                    </div>
                </c:if>

                <c:forEach items="${crewMemberDTO}" var="crewMember">
                    <div class="mypageD-crewlistbox">
                        <span class="mypageD-crewlistbox__span--big">${crewMember.crew.crewName}</span>
                        <a href="${pageContext.request.contextPath}/crewD?crewNo=${crewMember.crew.crewNo}" class="mypageD-crewlistbox__a--big"><img src="${pageContext.request.contextPath}/_image/crew/logo/${crewMember.crew.crewImgFileName}" class="mypageD-crewlistbox__img--big"></a>
                        <button class="mypageD-crewlistbox__button--blue" onclick="location.href='${pageContext.request.contextPath}/crewD?crewNo=${crewMember.crew.crewNo}'">내 크루 보기</button>
                    </div>
                </c:forEach>

            </div>
        </div>
        <!-- // 내 크루 -->

        <!-- 내가 쓴 글 / 컨트롤러에게 값 받아서 글 부분 c:forEach 사용 -->
        <div class="mypageD-boardcontainer">
            <span class="mypageD-boardcontainer__span--big">내가 쓴 글</span>

            <div class="mypageD-boardbox">
                <table class="mypageD-boardbox__table--big">
                    <tr class="mypageD-boardbox__tr--blue">
                        <th class="mypageD-boardbox__td--num">번호</th>
                        <th class="mypageD-boardbox__td--title">제목</th>
                        <th class="mypageD-boardbox__td--date">날짜</th>
                    </tr>

                    <c:if test="${reviewList.hasContent() == false}">
                        <tr class="mypageD-boardbox__tr--white">
                            <td colspan="3" class="mypageD-boardbox__td--none">작성한 글이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${reviewList.content}" var="reviewList" varStatus="status">
                        <tr class="mypageD-boardbox__tr--white">
                            <td class="mypageD-boardbox__td--white">${reviewList.reviewNo}</td>
                            <td class="mypageD-boardbox__td--long"><a href="${pageContext.request.contextPath}/review/${reviewList.reviewNo}" class="mypageD-boardbox__a--white">${reviewList.title}</a></td>
                            <td class="mypageD-boardbox__td--white">
                                    <fmt:parseDate value="${reviewList.WDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <ul class="mypageD-boardpage">
                    <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=0" class="mypageD-boardpage__a--num">&laquo;</a>
                    </li>

                    <c:if test="${reviewListPaging.startBlockPage ne 1}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewListPaging.startBlockPage-2}" class="mypageD-boardpage__a--num">&lt;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${reviewListPaging.startBlockPage}" end="${reviewListPaging.endBlockPage}" var="status">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${status-1}" class="mypageD-boardpage__a--num">${status}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${reviewListPaging.endBlockPage ne reviewListPaging.totalPages}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewListPaging.endBlockPage}" class="mypageD-boardpage__a--num">&gt;</a>
                        </li>
                    </c:if>

                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewListPaging.totalPages-1}" class="mypageD-boardpage__a--num">&raquo;</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- / 내가 쓴 글 -->

        <!-- 내가 쓴 크루 활동글 / 컨트롤러에게 값 받아서 글 부분 c:forEach 사용 -->
        <div class="mypageD-crewpostcontainer">
            <span class="mypageD-boardcontainer__span--big">내가 쓴 크루 활동글</span>

            <div class="mypageD-boardbox">
                <table class="mypageD-boardbox__table--big">
                    <tr class="mypageD-boardbox__tr--blue">
                        <th class="mypageD-boardbox__td--num">번호</th>
                        <th class="mypageD-boardbox__td--title">제목</th>
                        <th class="mypageD-boardbox__td--date">날짜</th>
                    </tr>

                    <c:if test="${crewPostList.hasContent() == false}">
                        <tr class="mypageD-boardbox__tr--white">
                            <td colspan="3" class="mypageD-boardbox__td--none">작성한 크루 활동글이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${crewPostList.content}" var="crewPostList" varStatus="status">
                        <tr class="mypageD-boardbox__tr--white">
                            <td class="mypageD-boardbox__td--white">${crewPostList.postNo}</td>
                            <td class="mypageD-boardbox__td--long"><a href="${pageContext.request.contextPath}/crew/board/${crewPostList.postNo}" class="mypageD-boardbox__a--white">${crewPostList.title}</a></td>
                            <td class="mypageD-boardbox__td--white">
                                <fmt:parseDate value="${crewPostList.WDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <ul class="mypageD-boardpage">
                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=0" class="mypageD-boardpage__a--num">&laquo;</a>
                    </li>

                    <c:if test="${crewPostPaging.startBlockPage ne 1}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewPostPaging.startBlockPage-2}" class="mypageD-boardpage__a--num">&lt;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${crewPostPaging.startBlockPage}" end="${crewPostPaging.endBlockPage}" var="status">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${status-1}" class="mypageD-boardpage__a--num">${status}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${crewPostPaging.endBlockPage ne crewPostPaging.totalPages}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewPostPaging.endBlockPage}" class="mypageD-boardpage__a--num">&gt;</a>
                        </li>
                    </c:if>

                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewPostPaging.totalPages-1}" class="mypageD-boardpage__a--num">&raquo;</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- / 내가 쓴 크루 활동글 -->


        <!-- 내가 쓴 댓글 / 컨트롤러에게 값 받아서 댓글 부분 c:forEach 사용 -->
        <div class="mypageD-commentcontainer">
            <span class="mypageD-boardcontainer__span--big">내가 쓴 댓글</span>

            <div class="mypageD-boardbox">
                <table class="mypageD-boardbox__table--big">
                    <tr class="mypageD-boardbox__tr--blue">
                        <th class="mypageD-boardbox__td--num">번호</th>
                        <th class="mypageD-boardbox__td--title">제목</th>
                        <th class="mypageD-boardbox__td--date">날짜</th>
                    </tr>

                    <c:if test="${commentList.hasContent() == false}">
                        <tr class="mypageD-boardbox__tr--white">
                            <td colspan="3" class="mypageD-boardbox__td--none">작성한 댓글이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${commentList.content}" var="commentList" varStatus="status">
                        <tr class="mypageD-boardbox__tr--white">
                            <td class="mypageD-boardbox__td--white">${commentList.commentNo}</td>
                            <td class="mypageD-boardbox__td--long"><a href="${pageContext.request.contextPath}/review/${commentList.review.reviewNo}" class="mypageD-boardbox__a--white">${commentList.content}</a></td>
                            <td class="mypageD-boardbox__td--white">
                                <fmt:parseDate value="${commentList.WDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>

                </table>

                <ul class="mypageD-boardpage">
                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=0" class="mypageD-boardpage__a--num">&laquo;</a>
                    </li>

                    <c:if test="${reviewCommentPaging.startBlockPage ne 1}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewCommentPaging.startBlockPage-2}" class="mypageD-boardpage__a--num">&lt;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${reviewCommentPaging.startBlockPage}" end="${reviewCommentPaging.endBlockPage}" var="status">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${status-1}" class="mypageD-boardpage__a--num">${status}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${reviewCommentPaging.endBlockPage ne reviewCommentPaging.totalPages}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewCommentPaging.endBlockPage}" class="mypageD-boardpage__a--num">&gt;</a>
                        </li>
                    </c:if>

                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${reviewCommentPaging.totalPages-1}" class="mypageD-boardpage__a--num">&raquo;</a>
                    </li>
                </ul>

            </div>
        </div>
        <!-- // 내가 쓴 댓글 -->


        <!-- 내가 쓴 내가 쓴 크루활동 댓글  -->
        <div class="mypageD-crewcommentcontainer">
            <span class="mypageD-boardcontainer__span--big">내가 쓴 크루 활동 댓글</span>

            <div class="mypageD-boardbox">
                <table class="mypageD-boardbox__table--big">
                    <tr class="mypageD-boardbox__tr--blue">
                        <th class="mypageD-boardbox__td--num">번호</th>
                        <th class="mypageD-boardbox__td--title">제목</th>
                        <th class="mypageD-boardbox__td--date">날짜</th>
                    </tr>

                    <c:if test="${crewCommentList.hasContent() == false}">
                        <tr class="mypageD-boardbox__tr--white">
                            <td colspan="3" class="mypageD-boardbox__td--none">작성한 크루 활동 댓글이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${crewCommentList.content}" var="crewCommentList" varStatus="status">
                        <tr class="mypageD-boardbox__tr--white">
                            <td class="mypageD-boardbox__td--white">${crewCommentList.commentNo}</td>
                            <td class="mypageD-boardbox__td--long"><a href="${pageContext.request.contextPath}/crew/board/${crewCommentList.crewPost.postNo}" class="mypageD-boardbox__a--white">${crewCommentList.content}</a></td>
                            <td class="mypageD-boardbox__td--white">
                                <fmt:parseDate value="${crewCommentList.WDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>

                </table>

                <ul class="mypageD-boardpage">
                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=0" class="mypageD-boardpage__a--num">&laquo;</a>
                    </li>

                    <c:if test="${crewCommentPaging.startBlockPage ne 1}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewCommentPaging.startBlockPage-2}" class="mypageD-boardpage__a--num">&lt;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${crewCommentPaging.startBlockPage}" end="${crewCommentPaging.endBlockPage}" var="status">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${status-1}" class="mypageD-boardpage__a--num">${status}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${crewCommentPaging.endBlockPage ne crewCommentPaging.totalPages}">
                        <li class="mypageD-boardpage__li--link">
                            <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewCommentPaging.endBlockPage}" class="mypageD-boardpage__a--num">&gt;</a>
                        </li>
                    </c:if>

                    <li class="mypageD-boardpage__li--link">
                        <a href="${pageContext.request.contextPath}/mypageD2?id=${member.id}&page=${crewCommentPaging.totalPages-1}" class="mypageD-boardpage__a--num">&raquo;</a>
                    </li>
                </ul>

            </div>
        </div>
        <!-- // 내가 쓴 크루활동 댓글 -->

    </div>
    </div>
    <!-- // 마이페이지 상세 -->
        </div>
    <!-- -->
    <div class="mypageD-footer">
        <%@ include file="../footer.jsp" %>
    </div>
    <!-- -->
</body>
</html>
