//댓글 1개 추가 :
function appendComment(data, contextPath, loginId) {

    let count = data.length
    $("#cBoardD-comment_count").append(count);

    for (let i = 0; i < data.length; i++) {
        let nickname = data[i].member.nickname;
        let id = data[i].member.id;
        let wdate = data[i].wdate;
        let postNo = data[i].crewPost.postNo;
        let commentNo = data[i].commentNo;
        let imgPath = data[i].member.member_img;
        let context = '\"' + contextPath + '\"'

        if (loginId === id) {
            $('#cBoardD-tablelayout').append(
                "<tr class='comment-tablelayout'> " +
                "<td style='padding: 10px 10px 10px 10px;'> " +
                "<div class='profilebox' style='margin-top: 7px'> " +
                "<div class='profilebox--photo'><img src=" + contextPath + "/_image/profile/" + imgPath + "></div> " +
                "<div class='profilebox--container--sub'>" +
                "<div class='profilebox--nickname'>" + nickname + "</div>" +
                "<div class='profilebox--wdate'>" + wdate.substring(0, 10) + "</div>" +
                "</div> </div> " +
                "<div class='commentbox'> " +
                "<form id='cBoardD-commentUpdateForm-" + commentNo + "' method='post'>" +
                "<button type='button' class='comment__deleteUpdateButton'> <<</button> " +
                "<div class='comment__deleteUpdateBox'> " +
                "<div class='comment__deleteUpdatelist'> " +
                "<button type='button' class='comment__updateButton'>수정</button> " +
                "</div> <div class='comment__deleteUpdatelist'> " +
                "<button type='button' onclick='deleteComment(" + commentNo + "," + postNo + "," + context + ")'>삭제</button> " +
                "</div> </div> " +
                "<input type='hidden' name='member.id' value='"+id+"'/>" +
                "<textarea name='content' class='comment__textarea_edit' readonly='readonly'>" + data[i].content + "</textarea> " +
                "<div class='comment-editSubbox'> " +
                "<button type='button' class='comment-editSub__btn--ok' onclick='updateComment(" + commentNo + "," + postNo + "," + context + ")'>완료</button> " +
                "<button type='button' class='comment-editSub__btn--cancle'>취소</button> " +
                "</form>" +
                "</div></div> </td> </tr>");
        } else {
            $('#cBoardD-tablelayout').append(
                "<tr class='comment-tablelayout'> " +
                "<td style='padding: 10px 10px 10px 10px;'> " +
                "<div class='profilebox' style='margin-top: 7px'> " +
                "<div class='profilebox--photo'><img src=" + contextPath + "/_image/profile/" + imgPath + "></div> " +
                "<div class='profilebox--container--sub'>" +
                "<div class='profilebox--nickname'>" + id + "</div>" +
                "<div class='profilebox--wdate'>" + wdate.substring(0, 10) + "</div>" +
                "</div> </div> " +
                "<div class='commentbox'> " +
                "<textarea name='content' class='comment__textarea' readonly='readonly'>" + data[i].content + "</textarea> " +
                "</div></div> </td> </tr>");

        }
    }

}

//댓글 입력 : textarea에 포커스in시 inputbox 테두리 강조
function changeBorderOnFocus() {
    document.getElementById("cBoardD-comment__input").style.border = "3px solid #A9E2F3";
}

//댓글 입력 : textarea에 포커스out시 inputbox 테두리 원래대로 변경
function changeBorderOnFocusOut() {
    document.getElementById("cBoardD-comment__input").style.border = "1px #CDCECF solid";
}

function enableEditMode() {
    //댓글 : 선택한 인덱스의 버튼 클릭하여(버튼 인덱스 = 첨삭박스 인덱스) 첨삭박스 보이기/숨기기
    $('.comment__deleteUpdateButton').click(function () {
        var idx = $(".comment__deleteUpdateButton").index(this);  // 존재하는 모든 버튼을 기준으로 index
        appearDeleteUpdateBox(idx);
    });

    //댓글 : 수정버튼 클릭시 수정모드 활성화
    $('.comment__updateButton').click(function () {
        var idx = $(".comment__updateButton").index(this);  // 존재하는 모든 버튼을 기준으로 index
        doUpdateMode(idx);
    });

    //댓글 : 수정 완료 및 취소
    $('.comment-editSub__btn--ok').click(function () {
        var idx = $(".comment-editSub__btn--ok").index(this);  // 존재하는 모든 버튼을 기준으로 index
        editOkOrCancle(idx);
    });
    $('.comment-editSub__btn--cancle').click(function () {
        var idx = $(".comment-editSub__btn--cancle").index(this);  // 존재하는 모든 버튼을 기준으로 index
        editOkOrCancle(idx);
    });

}

//댓글 :  첨삭박스 보이기/숨기기
function appearDeleteUpdateBox(idx) {
    if (document.getElementsByClassName('comment__deleteUpdateBox')[idx].style.display === "block") {
        document.getElementsByClassName('comment__deleteUpdateBox')[idx].style.display = "none";
    } else {
        document.getElementsByClassName('comment__deleteUpdateBox')[idx].style.display = "block"
    }
}

//댓글 : 수정모드 활성화
function doUpdateMode(idx) {
    //수정/삭제 박스 비활성
    document.getElementsByClassName('comment__deleteUpdateBox')[idx].style.display = "none";
    //서브버튼 활성화
    document.getElementsByClassName('comment-editSubbox')[idx].style.display = "block";
    //textarea readonly제거후 포커스
    var editArea = document.getElementsByClassName('comment__textarea_edit')[idx];
    editArea.removeAttribute("readonly");
    editArea.focus();
}

//댓글 : 수정 완료 및 취소시
function editOkOrCancle(idx) {
    //서브버튼 비활성
    document.getElementsByClassName('comment-editSubbox')[idx].style.display = "none";
    //textarea 수정불가
    var editArea = document.getElementsByClassName('comment__textarea_edit')[idx];
    editArea.setAttribute('readonly', 'readonly');
}

//댓글 입력
function insertComment(contextPath, postNo) {

    //폼 데이터 생성
    var form = $('#cBoardD-commentForm')[0];
    var formData = new FormData(form);

    if (contextPath == null) {
        contextPath = "";
    }

    $j1124.ajax({
        type: 'POST',
        url: contextPath + '/crew/board/' + postNo + '/comment',
        data: formData,
        processData: false,	// data 파라미터 강제 string 변환 방지
        contentType: false,	// application/x-www-form-urlencoded; 방지
        cache: false,
        success: function (data) {
            location.replace(contextPath + '/crew/board/' + postNo);
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

//댓글 수정
function updateComment(commentNo, postNo, contextPath) {
    //폼 데이터 생성
    let form = $('#cBoardD-commentUpdateForm-' + commentNo)[0];
    let formData = new FormData(form);

    if (contextPath == null) {
        contextPath = "";
    }
    $j1124.ajax({
        type: 'PUT',
        url: contextPath + '/crew/board/' + postNo + '/comment/' + commentNo,
        data: formData,
        processData: false,	// data 파라미터 강제 string 변환 방지
        contentType: false,	// application/x-www-form-urlencoded; 방지
        cache: false,
        success: function (data) {
            alert("댓글이 수정 되었습니다.");
            location.reload();
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

//댓글 삭제
function deleteComment(commentNo, postNo, contextPath) {
    if (confirm("댓글을 삭제하시겠습니까?") == true) {

        //폼 데이터 생성
        let form = $('#cBoardD-commentUpdateForm-' + commentNo)[0];
        let formData = new FormData(form);

        if (contextPath == null) {
            contextPath = "";
        }
        $j1124.ajax({
            type: 'DELETE',
            url: contextPath + '/crew/board/' + postNo + '/comment/' + commentNo,
            data: formData,
            processData: false,	// data 파라미터 강제 string 변환 방지
            contentType: false,	// application/x-www-form-urlencoded; 방지
            cache: false,
            success: function (data) {
                alert("댓글이 삭제 되었습니다.");
                location.reload();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

    } else {   //취소
        return false;
    }
}