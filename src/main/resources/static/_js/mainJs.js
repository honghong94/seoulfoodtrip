

/**
 * 로그인시 유효성 체크 및 ID 기억하기 함수
 */
function loginCheck(){
    if(document.getElementById('login_id').value.length == 0){
        alert("아이디를 입력해주세요.");
        document.getElementById('login_id').focus();
        return false;
    }

    if(document.getElementById('login_pw').value.length == 0){
        alert("비밀번호를 입력해주세요.");
        document.getElementById('login_pw').focus();
        return false;
    }

    function setCookie(name, value, expiredays) //쿠키 저장함수
    {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires="
            + todayDate.toGMTString() + ";"
    }

    if(document.getElementById('remember_id').checked == true){
        setCookie("id", document.getElementById('login_id').value,7);
    }else{
        setCookie("id", document.getElementById('login_id').value,0);
    }
    return true;
}
/**
 * 프로필 사진 업로드 시 회원가입 화면에 보여주는 함수
 */

function setImg(event){
    var reader = new FileReader();

    reader.onload = function (event){
        document.getElementById('my_img').setAttribute("src",event.target.result);
    }
    reader.readAsDataURL(event.target.files[0]);
}

/**
 *  비밀번호 유효성 검사 함수
 */

function pwCheck(){
    var pw = document.joinFrm.password.value;
    var num = /[0-9]/;
    var eng = /[a-zA-Z]/;
    var spe = /[~!@\#$%<>^&*]/;

    if(num.test(pw) && eng.test(pw) && spe.test(pw) && pw.length >7 && pw.length <= 20) {
        document.joinFrm.check_pw.value = "y";
        document.joinFrm.password.style.backgroundImage = "url('_image/member/lock/lock_blue.png')";
        document.getElementById('validate_pw').innerText = "";
    }else{
        document.joinFrm.check_pw.value = "";
        document.joinFrm.password.style.backgroundImage = "url('_image/member/lock/lock_red.png')"
        document.getElementById('validate_pw').innerText = "8~20자 영문, 숫자, 특수문자를 사용하세요.";
    }
}
/**
 *  비밀번호 재입력 일치하는지 확인하는 함수
 */

function pw2Check(){
    var pw = document.joinFrm.password.value;
    var re_pw = document.joinFrm.password2.value;
    if(pw == re_pw){
        document.joinFrm.check_pw2.value = "y";
        document.joinFrm.password2.style.backgroundImage = "url('_image/member/lock/lock_blue.png')";
        document.getElementById('validate_pw2').innerText = "";
    }else{
        document.joinFrm.check_pw2.value = "";
        document.joinFrm.password2.style.backgroundImage = "url('_image/member/lock/lock_red.png')"
        document.getElementById('validate_pw2').innerText = "비밀번호가 일치하지 않습니다. ";
    }
}
/**
 * 유효성 검사하는 함수
 */

function joinCheck(){
    var id = document.joinFrm.id;
    var pw = document.joinFrm.password;
    var pw2 = document.joinFrm.password2;
    var name = document.joinFrm.name;
    var nickname = document.joinFrm.nickname;
    var year = document.joinFrm.yy;
    var month = document.joinFrm.mm;
    var date = document.joinFrm.dd;
    var gender = document.joinFrm.gender;
    var email = document.joinFrm.email;
    var check = document.joinFrm.check_rule;

    if(id.value.length ==0 || document.joinFrm.check_id.value.length ==0){
        document.getElementById('validate_id').innerText = "아이디를 다시 입력해주세요.";
        id.focus();
        return false;
    }else if(pw.value.length ==0 || document.joinFrm.check_pw.value.length ==0){
        document.getElementById('validate_pw').innerText = "8~20자 영문, 숫자, 특수문자를 사용하세요.";
        pw.focus();
        return false;
    }else if(pw2.value.length ==0 || document.joinFrm.check_pw2.value.length ==0){
        document.getElementById('validate_pw2').innerText = "비밀번호가 일치하지 않습니다.";
        pw2.focus();
        return false;
    }else if(name.value.length ==0){
       document.getElementById('validate_name').innerText = "이름을 입력해주세요.";
        name.focus();
       return false;
    }else if(nickname.value.length ==0 || document.joinFrm.check_nickname.value.length ==0){
        document.getElementById('validate_nickname').innerText = "닉네임을 다시 입력해주세요.";
        nickname.focus();
        return false;
    }else if(year.value.length != 4 || isNaN(year.value) || year.value > 2021){
        document.getElementById('validate_birth').innerText = "생년월일을 입력해주세요.";
        year.focus();
        return false;
    }else if(month.value.length == 0){
        document.getElementById('validate_birth').innerText = "생년월일을 입력해주세요.";
        month.focus();
        return false;
    }else if(date.value.length != 2 || isNaN(date.value) || parseInt(date.value) <1 || 31 < parseInt(date.value)){
        document.getElementById('validate_birth').innerText = "생년월일을 입력해주세요.";
        date.focus();
        return false;
    }else if(gender.value.length == 0){
        document.getElementById('validate_gender').innerText = "성별을 선택해주세요.";
        gender.focus();
        return false;
    }else if(email.value == ""){
        document.getElementById('validate_email').innerText = "이메일을 입력해주세요";
        email.focus();
        return false;
    }else if(check.checked != true){
        document.getElementById('validate_check_rule').innerText = "이용약관을 체크해주세요.";
        check.focus();
        return false;
    }else{
        var birth_string = year.value + "/" + month.value + "/" + date.value;
        var birth_date = new Date(birth_string);
        var birth_form = document.getElementById('birth');
        birth_form.valueAsDate = birth_date;
        return true;
    }
}

/**
 * 회원 정보 수정 버튼 클릭시 입력값 유효성 검사 함수
 */

function myinfoCheck(){
    var name = document.myinfoFrm.name;
    var pw = document.myinfoFrm.password;
    var re_pw = document.myinfoFrm.password2;
    var email = document.myinfoFrm.email;
    var gender = document.myinfoFrm.gender;

    var num = /[0-9]/;
    var eng = /[a-zA-Z]/;
    var spe = /[~!@\#$%<>^&*]/;

    if(name.value.length == 0){
        alert("이름을 입력해주세요.");
        name.focus();
        return false;
    }else if(pw.value.length == 0) {
        alert("비밀번호를 입력해주세요.");
        pw.focus();
        return false;
    }else if(!(num.test(pw.value) && eng.test(pw.value) && spe.test(pw.value) && pw.value.length >7 && pw.value.length <= 20)){
        alert("비밀번호는 8~20자 영문, 숫자, 특수문자를 사용하세요.");
        pw.focus();
        return false;
    }else if(re_pw.value.length == 0) {
        alert("비밀번호 확인란을 입력해주세요.");
        re_pw.focus();
        return false;
    }else if(re_pw.value != pw.value){
        alert("비밀번호가 일치하지 않습니다.");
        re_pw.focus();
        return false;
    }else if(email.value.length == 0) {
        alert("이메일을 입력해주세요.");
        email.focus();
        return false;
    }else if(gender.value.length == 0) {
        alert("성별을 선택해주세요.");
        gender.focus();
        return false;
    }
    return true;
}

/**
 * 팝업창에서 플래너 만들기 버튼 클릭시 입력한 내용을 controller에게 넘겨주는 함수
 */
function popupCheck(){
    var f_date = new Date(document.popupFrm.fDate.value);
    var l_date = new Date(document.popupFrm.lDate.value);

    if(l_date<f_date){
        alert("도착 날짜가 출발 날짜보다 빠릅니다.");
        return false;
    }else{
        return true;
    }
}

/**
 * DAY 1 버튼 클릭시 해당하는 날짜의 지도 경로 보여주는 함수
 */
function mapChange(){
    var select = document.getElementById("select_day");
    var current = select.options[select.selectedIndex].value;
    var slide = document.querySelectorAll(".planD-map");
    var listslides = document.querySelectorAll(".planD-placelist");

    for(var k=0;k<slide.length;k++){
        slide[k].style.display = "none";
    }
    slide[current].style.display = "block";

    for(var j=0;j<listslides.length;j++){
        listslides[j].style.display = "none";
    }
    listslides[current].style.display = "block";
}

/**
 *  DAY 버튼 클릭시 해당하는 날짜의 일정만 보여주는 함수
 */
var planslide =  document.querySelectorAll(".planI-plansbox");

var plans_current = 1;
// 왜냐면 index로 적용해야 하는데 지금은 시험삼아 1번부터 시작하기에

// function plansChange(n){
//     n -= 1;
//     for(var i=0;i<planslide.length;i++){
//         planslide[i].style.display = "none";
//     }
//     planslide[n].style.display = "block";
// }
// plansChange(plans_current);todo 로딩 속도 떄문에 주석처리

/**
 * 장소 검색 후 추가 버튼 클릭시 일정 부분에 일정 추가하는 함수
 */
function planInsert(place_name,place_y,place_x, contextPath){
     var parent =  $('.planI-plansbox[style*="display: block"]');
     var data_date = parent.attr('data-date');
     var num = parent.children().length; // 하위 엘리먼트기에 일정 - 제목 (DAY) 부분도 포함됨

    if(num<10){ // 일정은 9개까지만 추가 가능
        parent.append(getHtml(place_name,place_y,place_x,num, data_date,contextPath));
    }else{
        alert("일정은 최대 9개로 제한됩니다.");
    }
}

/**
 * 일정 추가시 일정 관련 <div> 코드 생성하는 함수
 */
function getHtml(place_name,place_y,place_x,num, data_date, contextPath){
    var div = '<div class="planI-planbox" data-date="' + data_date + '" data-y = "' + place_y + '" data-x = "' + place_x + '" data-place = "' + place_name + '" data-planNo="">';
    div += '<div class="planI-plannum">';
    div += '<img src="' + contextPath + '/_image/plan/num/number' + num + '.png" class="planI-plannum__img-navy">';
    div += '<span class="planI-plannum__span--time">시간</span>';
    div += '<span class="planI-plannum__span--memo">메모</span></div>';
    div += '<div class="planI-plandetail">';
    div += '<span class="planI-plandetail__span--place">' + place_name + '</span>';
    div += '<input type="time" name="time" class="planI-plandetail__input--time" required >';
    div += '<input type="text" name="intro" class="planI-plandetail__input--intro" placeholder="20자 내로 메모를 입력해주세요."  maxlength="20">';
    div += '<button class="planI-plandetail__button--blue" onclick="planDelete(' + num +  ')">&times;</button></div> </div>';

    return div;
}

/**
 * 일정 부분에서 삭제(X) 버튼 클릭시 해당 div 삭제 후 그 후의 일정 순서(숫자) 변경(1개씩 줄여주는)하는 함수
 */
function planDelete(num){
    var parent =  $('.planI-plansbox[style*="display: block"]');
    var kid = parent.children().eq(num); // 일정 부분에 제목도 자식에 포함되기에 index +1
    var next_kids = kid.nextAll();

    kid.detach();

    next_kids.each(function (index, element){
        var url = "_image/plan/num/number" + num + ".png";
        $(this).find('img').attr("src", url);

        var btn = "planDelete(" + num + ")";
        $(this).find('button').attr("onclick", btn);
        ++ num;
    });
}

/**
 * 플래너 삭제 기능
 */
function deletePlanner(plannerNo,userId, contextPath){
    var result = confirm("플래너를 삭제하시겠습니까?");

    if(result == false){
        return false;
    }else if(result == true){
        $.ajax({
            type:'DELETE',
            url: contextPath + '/api/users/' + userId +'/planners/' + plannerNo,
            success: function (data, textStatus, request) {
                // 응답 결과 메세지 알림
                alert(data);
                // 플래너 목록 페이지로 이동하는 Controller 호출
                location.replace(request.getResponseHeader("location"));
            },
            error: function (request,status,error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    }
}
