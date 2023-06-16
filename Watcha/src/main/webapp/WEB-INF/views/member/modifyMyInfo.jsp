<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
    String ctxPath = request.getContextPath();
%> 

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 테스트</title>

  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <!-- Font Awesome 6 Icons --> 
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

  <!-- 직접 만든 CSS 1 지금은 안쓰니까 막는다-->
  <%-- <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" /> --%>
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.4.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <!-- 글꼴 적용하기 -->
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />
  
  
  <%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>

  <%-- <link rel="icon" href="<%=ctxPath%>/images/파비콘.ico"> --%>
  
<style type="text/css">

.modify-content {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
}

.w60 {
    width: 60vw;
    padding: 0px 0px 2.26562vw;
}

.modify-header {
    text-align: center;
    margin: 0px 0px 3.04688vw;
}

.modify-headtitle {
    font-size: 3.125vw;
    font-weight: 700;
    letter-spacing: -0.0554687vw;
    margin: 0px 0px 0.15625vw;
}

.modify-flex {
    display: flex;
    align-items: flex-start;
}

.mr18 {
    margin: 0px 1.875vw 0px 0px;
}

.modify-img-edge {
    position: relative;
    width: 11.0938vw;
    height: 11.0938vw;
    border-radius: 50%;
    border-width: 0.46875vw !important;
    border-style: solid !important;
    border-color: rgb(42, 43, 44) !important;
}
	
.modify-img-radius {
    overflow: hidden;
    border-radius: 50%;
    position: relative;
    z-index: 1;
    width: 100%;
    height: 100%;
}

.modify-img {
    vertical-align: top;
    width: 100%;
    height: 100%;
}

.colpt15_pl03 {
    display: flex;
    flex-direction: column;
    padding: 1.5625vw 0px 0px 0.3125vw;
}

.modify-img-btn {
    font-size: 1.09375vw;
    letter-spacing: -0.03125vw;
    vertical-align: top;
    white-space: nowrap;
    padding: 0.3125vw 2.73438vw 0.46875vw;
    margin: 7px 0px 0px;
}

.modify-section {
	display: flex;
	flex-direction: column;
	width: 60vw;
    padding: 0 0 0 5vw;
}

.modify-label {
    display: block;
    font-size: 1.40625vw;
    letter-spacing: -0.0390625vw;
    margin-top: 1vw;
}

.requiredInfo {
    display: block;
    width: 29.5312vw;
    padding: 0.78125vw 0.9375vw;
    border: 0.078125vw solid rgb(51, 52, 53);
    margin: 0.703125vw 0px 0px;
}

.mobilenum {
    width: 6vw;
}

.errorbox {
	border: solid 1px red;
}

.modify-phoneNum {
	display:flex;
	align-items: center;
}

ul.pb1 {
	list-style-type: none;
    margin: 0;
    padding: 0 0 1vw 0;
}

.modify-requiredText {
	
    font-size: 1.09375vw;
    letter-spacing: -0.0078125vw;
    line-height: 1.5625vw;
}

.error {
	color: red;
}

.modify-btnspace {

	display: flex;
	justify-content: space-evenly;
	
}

.modify-btn {
    background: no-repeat;
    font-size: 1.40625vw;
    padding: 0.625vw 1.875vw 0.703125vw;
    margin: 0px 0.390625vw;
}

.hover:hover {
	background-color: #c8c8c8;
}
	

</style>

<script type="text/javascript">

//이전에 선택한 파일의 정보를 저장할 변수
let previousFile = null;

let namebool = true;
let pwdbool = true;
let emailbool = true;
let num1bool = true;
let num2bool = true;

$(document).ready(function() {
	
	// 프로필 이미지가 있을 때, 이미지 삭제버튼 나타내기
	if(${not empty sessionScope.loginuser.profile_image}) {
		
		$("#btnDelImg").css("display","");
		
	}

    $('#modifyimg').on('click');

    $('#modifyimg').on('change', handleFileSelection);

});// end of $(document).ready(function()
		
	
// Function Declaration
    
// 파일변경시 이벤트
function handleFileSelection(e) {

    let fileName = $('input#modifyimg').val();
        
	// 이미지 파일인지 확인
	let pathpoint = fileName.lastIndexOf('.');
	let filepoint = fileName.substring(pathpoint+1,fileName.length);
	let filetype = filepoint.toLowerCase();
	if(filetype=='jpg' || filetype=='png' || filetype=='jpeg') { // 이미지 파일일 경우
	
	    // 프로필 미리보기에 보여주기
	    const fileReader = new FileReader();
	    
	    fileReader.readAsDataURL($(e.target).get(0).files[0]);
	    
	    fileReader.onload = function() {
	    
	        $("#img_profile").attr("src", fileReader.result);
	        
	        $("#btnDelImg").css("display",""); // 이미지 삭제버튼 나타내기
	        
	    }
	
	
	} else { // 이미지 파일이 아닐 경우
	    alert('jpg, png, jpeg 파일만 선택할 수 있습니다.');
	
		// 파일 초기화
	    $(e.target).val("");
	
	    return false;
	
	}

}


// 이미지 변경 버튼
function upload_prfimg() {
	
	$("#modifyimg").click();
	
}


// 이미지 삭제 버튼
function del_prfimg() {
	$("#modifyimg").val(null);
	$("#img_profile").attr("src","<%= ctxPath%>/resources/images/프로필없음.jpg");
	$("input[name='profile_image']").val(null);
	$("#btnDelImg").css("display","none");
}

		
// ----- 이름 입력태그 ------ //
function nameChange(e) {

	if( $(e).val().trim().length < 2 ) {
		// 2글자 미만일 경우 
		$(e).addClass("errorbox");
		$("#li-name").addClass("error");
		namebool = false;
	}
	else {
		// 2글자 이상일 경우
		$(e).removeClass("errorbox");
		$("#li-name").removeClass("error");
		namebool = true;
	}
	
}



// ----- 비밀번호 입력태그 ------ //
function pwdChange(e) {

	// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 2
	const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	
	const bool = regExp.test($(e).val()); // 정규표현식에 맞으면 true 아니면 false
	
	if($(e).val()!="" && !bool) {
		// 암호가 정규표현식에 맞지 않는 경우
		$(e).addClass("errorbox");
		$("#li-pwd").addClass("error");
		pwdbool = false;
	}
	
	else {
		// 암호가 정규표현식에 맞거나 공백인 경우
		$(e).removeClass("errorbox");
		$("#li-pwd").removeClass("error");
		pwdbool = true;
	}
}
		
		
///////////////////////////////////////////////////////////////////////////
// 변경된 암호가 현재 사용중인 암호라면 새로운 암호를 입력해야 한다.
///////////////////////////////////////////////////////////////////////////
function dupPwdCheck() {
	$.ajax({
		url:"<%= ctxPath%>/duplicatePwdCheck.action",
		data:{"new_pwd":$("input#modifypwd").val(),
			"user_id":"${sessionScope.loginuser.user_id}"},
		type:"post",
		dataType:"json",
		async: false, <%-- 동기방식 --%>
		success:function(json){
			// json ==> {"n":1} 또는 {"n":0}
			
			if(json.n == 1) {
				$("#li-duppwd").val("현재 사용중인 암호로 변경은 불가합니다.");
				$("#modifypwd").addClass("errorbox");
				$("#li-pwd").addClass("error");
				pwdbool = false;
			}
			else {
				$("#li-duppwd").val("");
				$("#modifypwd").removeClass("errorbox");
				$("#li-pwd").removeClass("error");
				pwdbool = false;
			}
		},
		error: function(request, status, error){
	        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});		
}

		
// ----- 이메일 입력태그 ------ //		
function emailChange(e) {

	//3.이메일 체크 정규식
	const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
	
	const bool = regExp.test($(e).val()); // 정규표현식에 맞으면 true 아니면 false
	
	if(!bool) {
		// 이메일이 정규표현식에 맞지 않는 경우
		$(e).addClass("errorbox");
		$("#li-email").addClass("error");
		$("#li-dupmail").val("");
		emailbool = false;
	}
	
	else {
		// 이메일이 정규표현식에 맞는 경우
		emailDuplicateCheck();
	}
}


function emailDuplicateCheck() {
	
   	$.ajax({
   		url:"<%= ctxPath%>/emailDuplicateCheck.action",
   		data:{"email":$("input#modifyemail").val()},
   		type:"post",
		dataType:"json",
		success:function(json){ 
               
			if(json.isExists > 0) {
				$("#li-dupmail").addClass("error");
				$("#li-dupmail").val($("input#modifyemail").val()+"은 중복된 email 이므로 사용이 불가능합니다.");
				emailbool = false;
			}
			else if( json.isExists == 0 ) { // 중복되지 않는 이메일인 경우
				$("#li-dupmail").removeClass("error");
				$("#li-dupmail").val($("input#modifyemail").val()+"은 중복되지 않은 email 이므로 사용이 가능합니다.");
				$("#modifyemail").removeClass("errorbox");
				$("#li-email").removeClass("error");
				emailbool = true;
			}
		},
		
		error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});		
	
}	
		

// ----- 연락처 입력태그 ------ //
function numChange(e) {

	//3.연락처 체크 정규식
	const regExp = /^\d{4}$/g;
	// 숫자 4자리만 들어오도록 검사해주는 객체 생성
	const bool = regExp.test($(e).val()); // 정규표현식에 맞으면 true 아니면 false
	
	if(!bool) {
		// 정규표현식에 맞지 않는 경우
		$(e).addClass("errorbox");
		$("#li-mobile").addClass("error");
		num2bool = false;
	}
	
	else {
		// 정규표현식에 맞는 경우
		$(e).removeClass("errorbox");
		$("#li-mobile").removeClass("error");
		num2bool = true;
		$("input[name='mobile']").val($("#hp1").val()+$("#hp2").val()+$("#hp3").val())
	}
	
}


		
// "수정" 버튼 클릭시 호출되는 함수		
function goEdit() {
	
	if( namebool * pwdbool * emailbool * num1bool * num2bool == 0) {
		alert("입력을 완료해주세요");
		return false;
	}
	else {
		
		const frm = document.editFrm;
		frm.action = "<%= ctxPath%>/modifyInfo.action";
		frm.method = "post";
		frm.submit();
	}
	
	
	
}// end of function()---------------------------------

</script>

</head>
<body>

<div class="modify-content">
  <section class="w60">
    <header class="modify-header">
      <h1 class="modify-headtitle">프로필 수정</h1>
    </header>
    <form name="editFrm" enctype="multipart/form-data" onsubmit="return goEdit()">
      <div class="modify-flex">
        <div class="mr18">
          <div class="modify-img-edge">
            <div class="modify-img-radius">
              <c:if test="${not empty sessionScope.loginuser.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/${sessionScope.loginuser.profile_image}" class="modify-img e18xnnz0"/>
			  	<input type="hidden" name="profile_image" value="${sessionScope.loginuser.profile_image}">
			  </c:if>
			  <c:if test="${empty sessionScope.loginuser.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg" class="modify-img e18xnnz0"/>
  			    <input type="hidden" name="profile_image">
			  </c:if>
              
            </div>
          </div>
          <div class="colpt15_pl03">
            <button type="button" class="modify-img-btn hover" onclick="upload_prfimg()">이미지 변경</button>
            <button type="button" class="modify-img-btn hover" id="btnDelImg" style="display:none;" onclick="del_prfimg()">이미지 삭제</button>
          </div>
        </div>
        <section class="modify-section">
          <input type="file" id="modifyimg" name="attach" style="display:none;" accept="image/*">
          
          <input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}">
             
          <label autofocus for="name" class="modify-label">이름
            <input type="text" name="name" id="modifyname" class="requiredInfo"
         	minlength="2" maxlength="20" value="${sessionScope.loginuser.name}" oninput="nameChange(this)" />
          </label>
          
          <ul class="pb1">
            <li class="modify-requiredText" id="li-name">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          
          <label for="name" class="modify-label">소개
            <input type="text" name="profile_message" id="modifymessage" class="requiredInfo"
  			maxlength="60" title="소개는 60자 까지 입력이 가능합니다." value="${sessionScope.loginuser.profile_message}" />
          </label>
          <ul class="pb1">
            <li class="modify-requiredText" id="li-message">• 소개는 최대 60자 까지 입력이 가능해요</li>
          </ul>
          
          <label for="name" class="modify-label">비밀번호
            <input type="password" name="password" id="modifypwd" class="requiredInfo" oninput="pwdChange(this)" />
          </label>
          <ul class="pb1">
            <li class="modify-requiredText" id="li-pwd">• 비밀번호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력이 가능해요</li>
            <li class="modify-requiredText error" id="li-duppwd" />
          </ul>
          
          
          <label for="name" class="modify-label">전화번호
            <div class="modify-phoneNum">
              <input type="text" class="requiredInfo mobilenum" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
              <input type="text" class="requiredInfo mobilenum" id="hp2" name="hp2" size="6" maxlength="4"
               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); numChange(this)" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" />&nbsp;-&nbsp;
              <input type="text" class="requiredInfo mobilenum" id="hp3" name="hp3" size="6" maxlength="4"
               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); numChange(this)" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" />
              <input type="hidden" name="mobile" value="${sessionScope.loginuser.mobile}">
            </div>
          </label>
          <ul class="pb1">
            <li class="modify-requiredText" id="li-mobile">• 전화번호를 입력해주세요</li>
          </ul>
          
          <label for="name" class="modify-label">이메일
            <input type="text" name="email" id="modifyemail" value="${sessionScope.loginuser.email}"
             class="requiredInfo" oninput="emailChange(this)" />
          </label>
          <ul class="pb1" id="ul-email">
            <li class="modify-requiredText" id="li-email">• 이메일을 입력해주세요</li>
            <li class="modify-requiredText" id="li-dupmail" />
          </ul>
          
        </section>
      </div>
      <hr>
      <div class="modify-btnspace">
        <button type="submit" class="modify-btn hover">완료</button>
        <button type="button" class="modify-btn hover" onclick="location.href='<%= ctxPath%>/myWatcha.action'">취소</button>
      </div>
    </form>
  </section>
</div>



      
</body>
</html>