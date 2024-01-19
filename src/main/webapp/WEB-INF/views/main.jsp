<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style>

        #header-nav__area ul li a {
            color: black;
        }

        #main_container {
            display: flex;
            max-width: 1800px;
            margin: 0 auto;
        }

        #main_local .main_img_row, #main_crew #main_crew--container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        #main_crew--text {
            display: flex;
            justify-content: space-between;
        }

        #main_crew--bc {
            display: flex;
            align-items: center;
        }

        #main_crew--bcp--table {
            overflow: auto;
        }

    </style>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://davidlynch.org/projects/maphilight/jquery.maphilight.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            if(${result == "true"}){
                alert("로그아웃되었습니다.");
            }

            if(${removeResult == 0}){
                alert("계정 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.");
            }
        });

        $(function () {
            $.fn.maphilight.defaults = {
                fill: true,
                fillColor: '000000',
                fillOpacity: 0.2,
                stroke: true,
                strokeColor: '495c75',
                strokeOpacity: 1,
                strokeWidth: 1.2,
                fade: true,
                alwaysOn: false
            }
            $('.map').maphilight();
        });
    </script>

    <title>MAIN</title>
</head>
<body>
<!--헤더-->
<header id="head_container">
    <jsp:include page="header.jsp"/>
</header>

<div id="main_container">



    <div id="main_local">

        <div class="main_img_row">
            <a href="${pageContext.request.contextPath}/areaL?sigungu=1" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_1.png" width="650">
            </a>
            <a href="${pageContext.request.contextPath}/areaL?sigungu=2" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_2.png" width="650">
            </a>
        </div>

        <div class="main_img_row">
            <a href="${pageContext.request.contextPath}/areaL?sigungu=3" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_3.png" width="650">
            </a>
            <a href="${pageContext.request.contextPath}/areaL?sigungu=4" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_4.png" width="650">
            </a>
        </div>

        <div class="main_img_row">
            <a href="${pageContext.request.contextPath}/areaL?sigungu=5" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_5.png" width="650">
            </a>
            <a href="${pageContext.request.contextPath}/areaL?sigungu=6" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_6.png" width="650">
            </a>
        </div>

        <div class="main_img_row">
            <a href="${pageContext.request.contextPath}/areaL?sigungu=7" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_7.png" width="650">
            </a>
            <a href="${pageContext.request.contextPath}/areaL?sigungu=8" style="display: inline-block; border-radius: 10px; overflow: hidden;">
                <img src="${pageContext.request.contextPath}/_image/area/areaBanner/areaImage_0.png" width="650">
            </a>
        </div>
    </div>

    <!--인기크루-->

    <div id="main_crew--container">

        <div id="main_crew--text1" style="margin-bottom:-25px; margin-top:-20px; margin-left:40px;">
            <p style="border: 1px solid; background-color: #F4B7B4; color: white; padding: 10px; border-radius: 10px;" >
                인기글</p>
        </div>
        <div id="main_crew--bcp" style="max-width: 350px; height:370px; margin-left:40px;">

            <div id="main_crew--bcp--table" >

                <table style="width: 100%; height: 250px; border-collapse: collapse">
                    <thead>
                    <tr style="height:35px; line-height: 40px; text-align:center; color: white; font-size: 18px; background-color: #f2afac;">
                        <th>CREW</th>
                        <th>TITLE</th>

                    </tr>
                    </thead>
                    <tbody style="text-align: center; font-family: nanumB; font-size: 16px;">
                    <c:forEach items="${crewPosts}" var="post">
                        <tr>
                            <td>${post.crew.crewName}</td>
                            <td><a href="${pageContext.request.contextPath}/crew/board/${post.postNo}"><b>${post.title}</b></a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="main_crew--text1" style="margin-bottom:-28px; margin-top:40px; margin-left:40px;">
            <p style="border: -15px solid; background-color: #F4B7B4; color: white; padding: 10px; border-radius: 10px;">
                크루</p>
        </div>
        <div id="main_crew--bc" style="margin-left:35px;">

            <div class="crewBox">
                <div id="main_crew--bc">
                    <button id="prevBtn"> &#10094;</button>
                    <div id="main_crew--bc--photo">
                        <c:forEach items="${crewList}" var="crew">
                            <div class="crewList">
                                <a href="${pageContext.request.contextPath}/crewD?crewNo=${crew.crewNo}"><img src="${pageContext.request.contextPath}/_image/crew/logo/${crew.crewImgFileName}" width="230px" height="200px" alt="${crew.crewName}" class="crewImg"></a>
                                <span class="crewName">${crew.crewName}</span>
                            </div>
                        </c:forEach>
                    </div>

                    <button id="nextBtn">&#10095;</button>
                    <script src ="${pageContext.request.contextPath}/_js/main.js"></script>
                </div>
            </div>
        </div>
    </div>
</div>

<!--푸터-->
<div>
    <jsp:include page="footer.jsp"/>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainUtil.js"></script>
</body>
</html>
