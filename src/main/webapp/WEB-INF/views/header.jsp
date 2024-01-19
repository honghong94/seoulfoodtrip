<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%-- 날씨 아이콘 css --%>
<link href="${pageContext.request.contextPath}/_css/weather-icons.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/_css/weather-icons-wind.css" type="text/css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<%-- jquery 충돌 해소--%>
<script>
    var $j1124 = jQuery.noConflict();
</script>

<%-- 날씨 위젯 --%>
<script>
    var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=876eb9965cb5694a2644df701fa197dd";
    $j1124.ajax({
        url: apiURI,
        dataType: "json",
        type: "GET",
        async: "false",
        success: function (resp) {
            /* 테스트 코드 */
            // console.log(resp);
            // console.log("현재온도 : " + (resp.main.temp - 273.15));
            // console.log("현재습도 : " + resp.main.humidity);
            // console.log("날씨 : " + resp.weather[0].main);
            // console.log("상세날씨설명 : " + resp.weather[0].description);
            // console.log("날씨 이미지 : " + resp.weather[0].icon);
            // console.log("바람   : " + resp.wind.speed);
            // console.log("나라   : " + resp.sys.country);
            // console.log("도시이름  : " + resp.name);
            // console.log("구름  : " + (resp.clouds.all) + "%");

            var text = resp.weather[0].description;
            var tmp = Math.floor(resp.main.temp - 273.15);
            var imgSrc = resp.weather[0].icon;

            document.getElementById("weatherText").append(text);
            document.getElementById("weatherTmp").append(tmp + "ºc");
            document.getElementById("weatherImg").setAttribute("src","http://openweathermap.org/img/wn/" + imgSrc + "@2x.png");
            // document.getElementById("weatherImg").src = "http://openweathermap.org/img/wn/" + imgSrc + "@2x.png";
        }
    })
</script>

<script>
    var areaMenuVisible = false;

    function showAreaMenu() {
        document.getElementById('header-nav__area').style.display = 'block';
    }

    function hideAreaMenu() {
        if (!areaMenuVisible) {
            document.getElementById('header-nav__area').style.display = 'none';
        }
    }

    function cancelHide() {
        areaMenuVisible = true;
    }

    function toggleAreaMenu() {
        areaMenuVisible = !areaMenuVisible;
    }
</script>


<!--미니 헤더 : 로고, 검색, 날씨위젯-->
<div id="headerM-container" style="font-size: 0">


        <div id="header-img__logo2">
                <img src="${pageContext.request.contextPath}/_image/header/logo/서울푸드트립.png"
                style="margin-top: -30px; margin-left: 500px; width: 250px; height: 150px; cursor: pointer;"
                onclick="window.location.href='${pageContext.request.contextPath}/main';">

        </div>


    <!--날씨-->
    <div id="headerM-weatherBox">
        <div id="headerM-weatherBox__area">
            <h4>서울</h4>
        </div>
        <div id="headerM-weatherBox__icon">
            <img id="weatherImg">
        </div>
        <div id="weatherText" class="headerM-weatherBox__text">
            <!--날씨 설명 들어가는 란-->
        </div>
        <div id="weatherTmp" class="headerM-weatherBox__tmp">
            <i class="wi wi-thermometer"></i>
            <!--기온 들어가는 란-->
        </div>
    </div>
</div>

<!-- 헤더 -->
<div id="header_container">

    <!-- 메인 네비바 -->
    <div id="header-nav">
        <ul>
            <li onmouseover="showAreaMenu();" onmouseout="hideAreaMenu();" onclick="toggleAreaMenu();">
                <a href="#">
                    <span id="areaText" style="color: black;" onmouseover="this.style.color='#F4B7B4';" onmouseout="this.style.color='black';">구역</span>
                    <div id="header-nav__area" style="position: absolute; top: 70%; left: 5px; display: none;" onmouseover="cancelHide();">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=1">강남</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=2">강북</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=3">광화문</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=4">명동</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=5">여의도</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=6">잠실</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=7">홍대</a></li>
                            <li><a href="${pageContext.request.contextPath}/areaL?sigungu=0">그외</a></li>
                        </ul>
                    </div>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/review">
                    <span style="color: black;" onmouseover="this.style.color='#F4B7B4';" onmouseout="this.style.color='black';">후기</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/crewL">
                    <span style="color: black;" onmouseover="this.style.color='#F4B7B4';" onmouseout="this.style.color='black';">크루</span>
                </a>
            </li>
        </ul>
    </div>

    <!--미니프로필 -->
    <jsp:include page="mypage/mypageIntro.jsp"/>

</div>

