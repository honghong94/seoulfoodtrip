//전역 변수
let doNameCheck = false; //크루명 중복 체크 유무
var btnCount = 0; //질문 갯수 버튼 카운트


/* crewInsert */
function addQuestion() {
    $(function () {
        $('#crewI-btn--addQuestion').click(function () {
            var num = btnCount + 2
            if (btnCount >= 2) {
                alert("질문은 3개이상 추가하실 수 없습니다.");
            } else {
                $('#crewI-insertTbl__recuit').append("<tr class='common-tbl__item'>" +
                    "<td style='width: 170px;'>" +
                    "가입 질문 (추가)" +
                    "</td>" +
                    "<td>" +
                    "<input name='question" + num + "\'" + " type='text' style='width: 850px'/>" +
                    "</td></tr>");
            }
            btnCount += 1;
        });
    });
}

function setImg_i(event) {
    var reader = new FileReader();

    reader.onload = function (event) {
        document.getElementById('crewI_img').setAttribute("src", event.target.result);
        /*
        * document.getElementById('my_img').src = event.target.result;
        */
    }
    reader.readAsDataURL(event.target.files[0]);
}

function checkCrewName(contextPath) {
    $(function () {
        $('#crewI-btn--checkName').click(function () {
            var crewName = $('#crewI-input--name').val()
            var klen = 0;
            var elen = 0;
            var msg = "";

            //1. null 체크
            if (crewName == null || crewName == '') {
                msg = "* 크루명을 입력 하세요.";
                document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                document.getElementById('crewI-nameCheckMsg').innerText = msg;
                return false;
            }

            //2. 공백 체크
            var blank_pattern = /[\s]/g;
            if (blank_pattern.test(crewName) == true) {
                msg = "* 크루명에 공백은 사용할 수 없습니다.";
                document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                document.getElementById('crewI-nameCheckMsg').innerText = msg;
                return false;
            }

            //3. 일부 문자 제외
            var special_character_pattern = /[.]/;
            if (special_character_pattern.test(crewName) == true) {
                msg = "* 크루명에 사용할수 없는 문자가 포함되어 있습니다.";
                document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                document.getElementById('crewI-nameCheckMsg').innerText = msg;
                return false;
            }

            //4. 한글 자음모음 체크
            var kr_notword_pattern = /([^가-힣\x20^\d^\w])/i;
            if (kr_notword_pattern.test(crewName) == true) {
                msg = "* 한글은 글자 단위로만 입력 가능 합니다";
                document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                document.getElementById('crewI-nameCheckMsg').innerText = msg;
                return false;
            }

            //5. 글자수 제한
            for (var i = 0; i < crewName.length; i++) {
                if (escape(crewName.charAt(i)).length === 6) {
                    klen++;
                } else {
                    elen++;
                }
            }
            if (elen > 12 || klen > 8 || elen + klen > 9) {
                msg = "* 크루명은 한글 8자 이하, 영문,숫자 12자 이내로 작성 하셔야 합니다.";
                document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                document.getElementById('crewI-nameCheckMsg').innerText = msg;
                return false;
            }

            //6. 크루명 중복 체크
            let crewNameForm = $('#crewI-input--name').serialize();

            $j1124.ajax({
                async: false,
                url: contextPath + '/crewI/check',
                type: 'GET',
                data: crewNameForm,
                dataType: 'json',
                contentType: "application/json; charset=UTF-8",
                success: function (data) {
                    if (data) {
                        msg = "* 이미 존재하는 크루명 입니다."
                        document.getElementById('crewI-nameCheckMsg').style.color = 'red'
                        document.getElementById('crewI-nameCheckMsg').innerText = msg;
                        return false;
                    } else {
                        msg = "* 사용가능한 크루명 입니다."
                        document.getElementById('crewI-nameCheckMsg').style.color = 'green'
                        document.getElementById('crewI-nameCheckMsg').innerText = msg;
                        doNameCheck = true;
                        return false;
                    }
                }
            });
        });
    });
}


function limitAreaList() {
    $(function () {
        $("input[name=areaListValues]").on("click", function () {
            let count = $("input:checked[name=areaListValues]").length;

            if (count > 3) {
                $(this).prop("checked", false);
                alert("관심 지역은 최대 3개까지 선택 가능 합니다.");
            }
        });
    });
}

function checkCrewParam() {
    $(function () {
        let intro = $('#crewI-intro')
        let introDetail = $('#crewI-introDetail')
        let recruit = $('#crewI-recuit')
        let question1 = $('#question1')
        let areaList = $("input:checked[name=areaListValues]")


        if (!doNameCheck) {
            alert("크루명 중복 체크는 필수 입니다.")
            $('#crewI-btn--checkName').focus();
            return false;
        }

        if (areaList.length === 0) {
            alert("관심지역은 하나이상 선택 하셔야 합니다.")
            return false;
        }

        if (intro.val() == null || intro.val() === '') {
            alert("크루 소개(간략)는 필수 항목 입니다.")
            intro.focus();
            return false;
        }

        if (introDetail.val() == null || introDetail.val() === '') {
            alert("크루 소개(상세)는 필수 항목 입니다.")
            introDetail.focus();
            return false;
        }

        if (recruit.val() == null || recruit.val() === '') {
            alert("모집 공고는 필수 항목 입니다.")
            recruit.focus();
            return false;
        }

        if (question1.val() == null || question1.val() === '') {
            alert("질문은 최소 1개이상 입력 하셔야 합니다.")
            question1.focus();
            return false;
        }

        $('#crewI-form').submit();
    });
}


/* crewManage */

//크루 로고 이미지 변경 -> 파일 업로드
function setImg_m(event, contextPath, crewNo) {


    var reader = new FileReader();
    reader.onload = function (event) {
        document.getElementById('crewM_img').setAttribute("src", event.target.result);
        /*
        * document.getElementById('my_img').src = event.target.result;
        */
    }
    reader.readAsDataURL(event.target.files[0]);

    let imgFile = $("#crewM_input--image").val();
    let form = $("#crewM-form-img")[0];
    var formData = new FormData(form);
    formData.append("crewImageFile", imgFile);
    formData.append("crewNo", crewNo);

    $j1124.ajax({
        data: formData,
        type: 'POST',
        url: contextPath + '/crewM/edit/img',
        cache: false,
        contentType: false,
        processData: false,
        enctype: 'multipart/form-data',
        success: function (data) {
            location.reload();
        }
    });
}

//라벨 보이기->안보이기 + 관심지역 선택창 생성
function goAreaEditMode(contextPath, crewNo) {
    $(function () {
        let label = $("#crewM-label--area");
        let infoArew = $("#crewM-info--area");
        let btnModify = $("#crewM-btn--modifyArea");
        let context = '\"' + contextPath + '\"'

        if (label.css("display") === 'inline-block') {
            label.css("display", "none");
            btnModify.css("display", "none");

            $(infoArew).append(
                "<form id='crewM-form--area' method='post'>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='강남'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>강남</span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='강북'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>강북</span>" +
                "<input class='crewM-checkbox--area'type='checkbox' name='areaListValues' value='광화문'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>광화문</span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='명동'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>명동</span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='여의도'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>여의도</span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='잠실'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>잠실<br/></span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='홍대'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>홍대</span>" +
                "<input class='crewM-checkbox--area' type='checkbox' name='areaListValues' value='etc'>" +
                "<span class='crewM-name--area' style='line-height: 26px; font-size: 13px'>etc</span>" +
                " <button id='crewM-btn--submitArea' class='crew-button' onclick='submitAreaEdit(" + context + "," + crewNo + ")'>완료</button>" +
                "</form>"
            );
        }
    });
}

//관심지역 수정사항 비동기 전숭, 체크박스 제거 , 라벨 원복
function submitAreaEdit(contextPath, crewNo) {
    $(function () {
        let form = $("#crewM-form--area")[0]
        let formData = new FormData(form);
        formData.append("crewNo", crewNo);

        $j1124.ajax({
            data: formData,
            type: 'POST',
            url: contextPath + '/crewM/edit/area',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
            }
        });

        let label = $("#crewM-label--area");
        let infoArew = $("#crewM-info--area");
        let btnModify = $("#crewM-btn--modifyArea");
        let areaCheckBox = $(".crewM-checkbox--area");
        let areaName = $(".crewM-name--area");
        let btnSubmit = $("#crewM-btn--submitArea");

        if (label.css("display") === 'none') {
            areaCheckBox.remove();
            areaName.remove();
            btnSubmit.remove();
            label.css("display", "inline-block");
            btnModify.css("display", "inline-block");
        }
    });
    alert("관심지역이 변경 되었습니다.");
    location.reload();
}

//크루 소개 수정모드 전환
function goIntroEditMode(content, contextPath, crewNo) {
    $(function () {
        let context = '\"' + contextPath + '\"'
        let introLabel = $("#crewM-label-introD");
        let btnModify = $("#crewM-btn--modifyInfo");
        let editBox = $("#crewM-editBox--intro");

        //크루 소개란 -> disappear,수정 버튼 ->disappear
        introLabel.css("display", "none");
        btnModify.css("display", "none");

        //summernote 추가 , 완료버튼 추가
        editBox.append("<textarea id='crewM-editForm--introD' name='introDetail'>" + content + "</textarea>");
        $('#crewM-editForm--introD').summernote({
            //summernote 속성
            width: 520,
            height: 266,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: "ko-KR",
            placeholder: '최대 2048자까지 쓸 수 있습니다',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']]
            ]
        });
        editBox.append("<button id='crewM-btn--submitIntro' class='crew-button' onclick='submitIntroDEdit(" + context + "," + crewNo + ")'>완료</button>");

    });
}

function submitIntro(contextPath, crewNo) {
    $(function () {
        let form = $("#crewM-form--intro")[0];
        var formData = new FormData(form);
        formData.append("crewNo", crewNo);

        $j1124.ajax({
            data: formData,
            type: 'POST',
            url: contextPath + '/crewM/edit/intro',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
            }
        });
        location.reload();
    });
}

//완료버튼 클릭시 수정사항 submit -> 크루 소개 수정모드 원복
function submitIntroDEdit(contextPath, crewNo) {
    $(function () {
        let introLabel = $("#crewM-label-introD");
        let editBox = $("#crewM-editBox--intro");
        let btnModify = $("#crewM-btn--modifyInfo");

        let form = $("#crewM-form--introD")[0];
        var formData = new FormData(form);
        formData.append("crewNo", crewNo);

        $j1124.ajax({
            data: formData,
            type: 'POST',
            url: contextPath + '/crewM/edit/introD',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
            }
        });
        location.reload();

        //수정 폼, 완료 버튼 삭제
        editBox.empty();

        //기존 요소 원복
        introLabel.css("display", "block");
        btnModify.css("display", "inline-block");
    });
}

//모집 공고 수정모드 전환
function goRecruitEditMode(contextPath, crewNo) {
    $(function () {
        let recruit = $("#crewM-recruit");
        let recruitBox = $("#crewM-recruiutBox");
        let recruitText = recruit.text();
        let btnModify = $("#crewM-btn--modifyRecuit")
        let editBox = $("#crewM-editBox--recuit");
        let context = '\"' + contextPath + '\"'

        //모집 공고, 버튼 숨기기
        recruit.css("display", "none");
        btnModify.css("display", "none");

        //summernote 추가 , 완료버튼 추가
        editBox.append("<textarea id='crewM-editForm--recuit' name='recruit'>" + recruitText + "</textarea>");
        $('#crewM-editForm--recuit').summernote({
            //summernote 속성
            width: 530,
            height: 200,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: "ko-KR",
            placeholder: '최대 2048자까지 쓸 수 있습니다',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']]
            ]
        });
        recruitBox.after("<button id='crewM-btn--submitRecuruit' class='crew-button' onclick='submitRecruitEdit(" + context + "," + crewNo + ")' style='float: right; margin-top: 7px'>완료</button>");

    });
}

//모집 공고 수정사항 전송 -> 수정모드 원복
function submitRecruitEdit(contextPath, crewNo) {
    $(function () {
        let editBox = $("#crewM-editBox--recuit");
        let btnSubmit = $("#crewM-btn--submitRecuruit");
        let btnModify = $("#crewM-btn--modifyRecuit")
        let recruit = $("#crewM-recruit");

        let form = $("#crewM-form--recruit")[0];
        var formData = new FormData(form);
        formData.append("crewNo", crewNo);

        $j1124.ajax({
            data: formData,
            type: 'POST',
            url: contextPath + '/crewM/edit/recruit',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
            }
        });
        location.reload();

        //수정 폼, 완료 버튼 삭제
        editBox.empty();
        btnSubmit.remove();

        //기존 요소 원복
        btnModify.css("display", "inline-block");
        recruit.css("display", "inline")

    });
}

//가입 승인 클릭시
function agreeJoin(contextPath, regNo) {

    var data = {regNo: regNo};

    $j1124.ajax({
        data: JSON.stringify(data),
        type: 'POST',
        url: contextPath + '/crewJ/agree',
        contentType: "application/json",
        cache: false,
        processData: false,
        success: function (data) {
            alert("해당 멤버의 가입이 승인 되었습니다.")
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

//크루 가입 거절 및 강퇴
function DenyOrKick(contextPath, regNo) {

    var data = {regNo: regNo};

    $j1124.ajax({
        data: JSON.stringify(data),
        type: 'POST',
        url: contextPath + '/crewJ/deny',
        contentType: "application/json",
        cache: false,
        processData: false,
        success: function (data) {
            alert("해당 멤버의 가입을 거절 하였습니다.")
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

//크루장 위임
function giveCrewMaster(contextPath,crewNo) {

    let form = $("#crewM-form--assign")[0];
    var formData = new FormData(form);

    if (confirm("해당 멤버를 크루장으로 위임 하겠습니까?") === true) {
        $j1124.ajax({
            data: formData,
            type: 'POST',
            url: contextPath + '/crewJ/give',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                alert(data)
                location.replace(contextPath+'/crewD?crewNo='+crewNo);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    } else {   //취소
        return false;
    }

}