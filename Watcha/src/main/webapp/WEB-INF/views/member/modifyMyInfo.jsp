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

.custom-rl46ge {
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    height: 100%;
}

.custom-59gfth {
    transform: scale(0.83);
    width: 42.5781vw;
    padding: 0px 0px 2.26562vw;
}

.custom-18z088c {
    text-align: center;
    margin: 0px 0px 3.04688vw;
}

.custom-126gohh {
    font-size: 3.125vw;
    font-weight: 700;
    letter-spacing: -0.0554687vw;
    margin: 0px 0px 0.15625vw;
}

.custom-ojf8hg {
    display: flex;
    align-items: flex-start;
}

.custom-ukz0js {
    margin: 0px 1.875vw 0px 0px;
}

.custom-h6u2zi {
    position: relative;
    width: 11.0938vw;
    height: 11.0938vw;
    border-radius: 50%;
}
	
.custom-1futllh-StyledRoundedImage-LargeProfileImage {
    overflow: hidden;
    border-radius: 50%;
    position: relative;
    z-index: 1;
    width: 100%;
    height: 100%;
}

.custom-1d033rf {
    vertical-align: top;
    width: 100%;
    height: 100%;
    opacity: 1;
    object-fit: cover;
    transition: opacity 420ms ease 0s;
}

.custom-1m5i00r {
    display: flex;
    flex-direction: column;
    padding: 1.5625vw 0px 0px 0.3125vw;
}

.custom-1n8p132 {
    font-size: 1.09375vw;
    font-weight: 400;
    letter-spacing: -0.03125vw;
    vertical-align: top;
    white-space: nowrap;
    padding: 0.3125vw 2.73438vw 0.46875vw;
}

.custom-lmypq6 {
    font-size: 1.09375vw;
    font-weight: 400;
    letter-spacing: -0.03125vw;
    vertical-align: top;
    white-space: nowrap;
    padding: 0.3125vw 2.73438vw 0.46875vw;
    margin: 7px 0px 0px;
    visibility: visible;
}

.custom-1kg1q4l {
    padding: 1.01562vw 0px 0px;
}

.custom-1ri5295 {
    display: block;
    font-size: 1.40625vw;
    font-weight: 400;
    letter-spacing: -0.0390625vw;
}

.custom-10fyvny {
    display: block;
    width: 29.5312vw;
    padding: 0.78125vw 0.9375vw;
    border: 0.078125vw solid rgb(51, 52, 53);
    margin: 0.703125vw 0px 0px;
}

.custom-19ksx78 {
    margin: 0.78125vw 0px 0px;
}

.custom-1k0sbwm {
    font-size: 1.09375vw;
    font-weight: 400;
    letter-spacing: -0.0078125vw;
    line-height: 1.5625vw;
}

.custom-kl4b6s [class*="Button"] {
    margin: 0px 0.390625vw;
}

.custom-8o4jzm-Button {
    background: no-repeat;
    font-size: 1.40625vw;
    font-weight: 400;
    letter-spacing: -0.0390625vw;
    line-height: 2.10938vw;
    padding: 0.625vw 1.875vw 0.703125vw;
}
	

</style>

<script type="text/javascript">

	let b_flag_email_change = false;
	// 이메일을 수정했는지 안했는지 여부를 알아오기 위한 용도

	let b_flag_emailDuplicate_click = false;
	// "이메일 중복확인" 를 클릭했는지 안했는지 여부를 알아오기 위한 용도
	
	$(document).ready(function() {
		
		$("span.error").hide(); <%-- 폼태그 옆에 경고문구를 에러가 나기 전엔 감추기 --%>
		
		
		// ----- 이름 입력태그 ------ //
		$("input#modifyname").blur( (e) => {

			if( $(e.target).val().trim() == "" ) {
				// 입력하지 않거나 공백만 입력했을 경우 
			
				$(e.target).parent().find("span.error").show(); // 해당 부분만 error 문구 출력해주기

			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$(e.target).parent().find("span.error").hide();
			}
			
		}); // 아이디가 name인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------
		
		
		
		// ----- 비밀번호 입력태그 ------ //		
		$("input#modifypwd").blur( (e) => {

			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 2
			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			
			const bool = regExp.test($(e.target).val()); // 정규표현식에 맞으면 true 아니면 false
			
			if(!bool) {
				
				$(e.target).parent().find("span.error").show(); // 해당 부분만 error 문구 출력해주기
	
				
				
			}
			
			else {
				// 암호가 정규표현식에 맞는 경우
				$(e.target).parent().find("span.error").hide();
				
			}
			
			
		}); // 아이디가 pwd인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------	
				
				
				
		
				
		// ----- 비밀번호 확인 입력태그 ------ //			
		$("input#pwdcheck").blur( (e) => {
	 		
	 		if( $("input#modifypwd").val() != $(e.target).val() ) {
	 			// 암호와 암호확인값이 다른 경우
	 			$(e.target).parent().find("span.error").show();
	 		}
	 		
	 		else {
	 			// 암호와 암호확인값이 같은 경우
	 			$(e.target).parent().find("span.error").hide();
	 		}
	 		
		}); // 아이디가 pwdcheck인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------				
				
				
				
		
		// ----- 이메일 입력태그 ------ //		
		$("input#modifyemail").blur( (e) => {

			//3.이메일 체크 정규식
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			
			const bool = regExp.test($(e.target).val()); // 정규표현식에 맞으면 true 아니면 false
			
			if(!bool) {
				$(e.target).parent().find("span.error").show(); // 해당 부분만 error 문구 출력해주기
				$("span#emailCheckResult").html("");			// 이메일중복체크확인 메세지를 지워준다
	
			}
			
			else {
				// 이메일이 정규표현식에 맞는 경우
				
				$(e.target).parent().find("span.error").hide(); // 해당 부분만 error 문구 출력해주기
			}
			
		}); // 아이디가 email인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------			
				
				
				
				
		// ----- 연락처 입력태그 ------ //		
		
		$("input#hp2").blur( (e) => {

			//3.연락처 체크 정규식
			const regExp = /^[1-9][0-9]{2,3}$/g; // g 는 전체 i 는 대소문자 구분 
			
			const bool = regExp.test($(e.target).val()); // 정규표현식에 맞으면 true 아니면 false
			
			if(!bool) {
				$(e.target).parent().find("span.error").show(); // 해당 부분만 error 문구 출력해주기
			}
			
			else {
				// 국번이 정규표현식에 맞는 경우
				$(e.target).parent().find("span.error").hide();
			}
			
		}); // 아이디가 hp2인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------			
				
				
				
				
		
		// ----- 연락처 입력태그 ------ //		
		
		$("input#hp3").blur( (e) => {

			//3.연락처 체크 정규식
			//	const regExp = /^[0-9]{4}$/g; // g 는 전체 i 는 대소문자 구분 
			// 또는
			const regExp = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 객체 생성
			const bool = regExp.test($(e.target).val()); // 정규표현식에 맞으면 true 아니면 false
			
			if(!bool) {
				$(e.target).parent().find("span.error").show(); // 해당 부분만 error 문구 출력해주기
	
				
				
			}
			
			else {
				// 마지막 전화번호 네자리가 정규표현식에 맞는 경우
				$(e.target).parent().find("span.error").hide(); // 해당 부분만 error 문구 출력해주기 
			}
			
		}); // 아이디가 hp3인 것은 focus를 잃어버렸을 경우(blur)  이벤트를 처리해주는 것이다. end of $("input#modifyname").blur(function()--------------------				
				


		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////

		
		
		//----- 년도 입력하기 ----- //
		
		
		$("input#birthyyyy").keyup(function(e) {
			
			alert("생년월일을 마우스로 선택하세요");
		
			$(e.target).val("1950");
			
		});
		
		
		
		//----- 월 고르기 ----- //
		let mm_html = "";
		
		for(let i=1; i<=12; i++) {
			if(i<10) {			
				mm_html += "<option>0"+i+"</option>";
			}
			else {
				mm_html += "<option>"+i+"</option>";
			}// javascript 반복문
			
		}// end of for()-------------------------------			
				
		

		
		//----- 일 고르기 ----- 백틱 사용해보기 //
		$("select#birthmm").html(mm_html);	

		let dd_html = ``;
	    
		for(let i=1; i<=31; i++) {
	         
	         if(i<10) {
	            dd_html += `<option>0\${i}</option>`;
	         }
	         else {
	            dd_html += `<option>\${i}</option>`;
	         }
	         
	    }// end of for---------------------
		
	    
	    $("select#birthdd").html(dd_html);
	    
	    <%-- 아래는 로그인한 아이디의 생월 및 생일을 넣어주는 것이다. --%>
	    const birthday = "${sessionScope.loginuser.birthday}";
	    // birthday ==> 19940308
	    
	    $("input#birthyyyy").val(birthday.substring(0,4));
	    $("select#birthmm").val(birthday.substring(4,6));
	    $("select#birthdd").val(birthday.substring(6));
	    ////////////////////////////////////////////////////////
	    

        // ------- "우편번호찾기"를 클릭했을 때 이벤트 처리하기 ------- //
        $("img#zipcodeSearch").click(function() {
        	b_flag_zipcodeSearch_click = true;
        	// "우편번호찾기" 를 클릭했는지 안했는지 여부를 알아오기 위한 용도
		});
        
        // 우편번호 입력란에 키보드로 입력할 경우 이벤트 처리하기
//        $("input:text[id='postcode']").bind("keyup", function(){});
        // 또는
        $("input:text[id='postcode']").keyup(function(){
        	alert(`우편번호 입력은 "우편번호찾기"를 클릭으로만 됩니다.`);
        	//또는
//        	alert("우편번호 입력은 \"우편번호찾기\"를 클릭으로만 됩니다."");
        	$(this).val("");
        });
	
});// end of $(document).ready(function()
		
// Function Declaration
function isExistEmailCheck() {
	
	b_flag_emailDuplicate_click = true;


      	
     	$.ajax({
     		url:"<%= ctxPath%>/member/emailDuplicateCheck.up",
     		data:{"email":$("input#modifyemail").val()},
     		type:"post",
			dataType:"json",
			success:function(json){ 
                
				if(json.isExists) { 
					$("span#emailCheckResult").html($("input#modifyemail").val()+"은 중복된 email 이므로 사용이 불가능합니다.").css("color","red");
					$("input#modifyemail").val(""); // 중복된 이메일이므로 입력 받은 값을 비운다.
			}
			else if( !json.isExists && $("input#modifyemail").val().trim != "" ) { // 중복되지 않는 이메일면서 공백이 아닌 경우
				// 입력한 email이 존재하지 않으면
				$("span#emailCheckResult").html($("input#modifyemail").val()+"은 중복되지 않은 email 이므로 사용이 가능합니다.").css("color","blue");					}
			
		},
		
		error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});		
	
}

		
// "수정" 버튼 클릭시 호출되는 함수		
function goEdit() {
	
  // **** 필수입력사항에 모두 입력이 됐는지 검사한다. **** //
  $("input.requiredInfo").each( (index, elmt) => {
     if($(elmt).val().trim() == "") {
        alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
        return false; // break; 라는 뜻이다.
     }
  });
	

	
/////////////////////////////////////////////////////////////////////////////////////////////////		
	

	
	let gogo = true;
	
	///////////////////////////////////////////////////////////////////////////
	// 변경된 암호가 현재 사용중인 암호라면 새로운 암호를 입력해야 한다.
	///////////////////////////////////////////////////////////////////////////
	$.ajax({
		url:"<%= ctxPath%>/member/duplicatePwdCheck.up",
		data:{"new_pwd":$("input#modifypwd").val(),
			"user_id":"${sessionScope.loginuser.user_id}"},
		type:"post",
		dataType:"json",
		async: false, <%-- 동기방식 --%>
		success:function(json){
			// json ==> {"n":1} 또는 {"n":0}
			
			if(json.n == 1) {
				$("span#duplicate_pwd").html("현재 사용중인 암호로 변경은 불가합니다.");
				gogo = false;
			}
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});

	if( gogo ) {
		const frm = document.editFrm;
		frm.action = "<%= ctxPath%>/member/modifyInfo.action";
		frm.method = "post";
		frm.submit();
	}
	// 모두 알맞게 한다면 넘겨주기.
	
	
	
	
}// end of function()---------------------------------

</script>

</head>
<body>

<div class="custom-rl46ge">
  <section class="custom-59gfth">
    <header class="custom-18z088c">
      <h1 class="custom-126gohh">프로필 수정</h1>
    </header>
    <form name="editFrm">
      <div class="custom-ojf8hg">
        <div class="custom-ukz0js">
          <input type="file" class="custom-38lglc">
          <div class="custom-h6u2zi">
            <div class="custom-1futllh-StyledRoundedImage-LargeProfileImage e18xnnz1">
              <img src="https://an2-img.amz.wtchn.net/image/v2/fI_WvAQSvffohcgztgGKkg.jpg?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1SZk16QXdlRE13TUNKZExDSndJam9pTDNZeUwzTjBiM0psTDNWelpYSXZNbTEzZG1jeVRGQXhaM0ZOWVM5d2NtOW1hV3hsTHpFMk9EWXhNalF6TmpFeU56Z3lNakEyTkRnaWZRLmNnWVljemNrV0pERFRXcXpXb0VRUmFITmJvWjdGNWVWUW5zQVBsT2UtZlU"
              class="custom-1d033rf e18xnnz0">
            </div>
          </div>
          <div class="custom-1m5i00r">
            <button type="button" class="custom-1n8p132">이미지 변경</button>
            <button type="button" class="custom-lmypq6">이미지 삭제</button>
          </div>
        </div>
        <section class="custom-1kg1q4l">
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
          <label for="name" class="custom-1ri5295">이름<input name="name" type="text" class="custom-10fyvny" value="시체매">
          </label>
          <ul class="custom-19ksx78">
            <li class="custom-1k0sbwm">• 이름은 최소 2자, 최대 20자 까지 입력이 가능해요</li>
          </ul>
        </section>
      </div>
      <hr>
      <div class="custom-kl4b6s">
        <button type="submit" class="custom-8o4jzm-Button">완료</button>
        <button type="button" class="custom-8o4jzm-Button">취소</button>
      </div>
    </form>
  </section>
</div>






  		<div style="padding: 0 50px; margin: 0px;">
  		  <div id="div_myProfile">
  		    <%-- 회원의 프로필  --%>
			<div style="display: flex; margin: 0px; position: relative; top: -2rem;" class="row">
			  <c:if test="${not empty requestScope.userInfo.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/${requestScope.userInfo.profile_image}"/>
			  </c:if>
			  <c:if test="${empty requestScope.userInfo.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
			  </c:if>
		    </div>
			<div style="position: relative; top: -2rem;" class="p-0 m-0">
			  <form name="editFrm">
  			      <h5 style="text-align: left; padding: 0 5px; font-size: 20pt; font-weight: 900; margin: 10px 0px;">
  			        <input type="text" name="nickname" id="modifynickname" class="requiredInfo"
  			         minlength="2" maxlength="20" title="이름은 최소 2자, 최대 20자 까지 입력이 가능합니다." value="테스트" required/>
  			      </h5>
  			        <p style="text-align: left; padding: 0 5px; font-weight: 600; margin-top: 5px;">
  			          <input type="text" name="profile_message" id="modifymessage" class="requiredInfo"
  			           maxlength="60" title="소개는 60자 까지 입력이 가능합니다." value="프로필 메세지입니다." />
  			        </p>
             <input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" readonly />
             <input type="text" name="name" id="modifyname" value="${sessionScope.loginuser.name}" class="requiredInfo" minlength="2" maxlength="20" title="이름은 최소 2자, 최대 20자 까지 입력이 가능합니다." required /> 
            <span class="error">이름은 최소 2자, 최대 20자 까지 입력이 가능합니다.</span>
            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
            <span id="duplicate_pwd" style="color: red;"></span>
            <span class="error">암호가 일치하지 않습니다.</span>
             <span class="error">이메일 형식에 맞지 않습니다.</span>
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" />&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" />
             
           <%-- <input type="text" name="mobile" id="mobile" value="${sessionScope.loginuser.mobile}" size="20" maxlength="20" /> --%>  
             <span class="error">올바른 전화번호 형식이 아닙니다.</span>
      
        <%-- ==== 생년월일 시작 ==== --%>
            <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="${fn:substring(sessionScope.loginuser.birthday, 0, 4)}" style="width: 80px;" required />
            
            <select id="birthmm" name="birthmm" style="margin-left: 2%; width: 60px; padding: 8px;">
            </select> 
            
            <select id="birthdd" name="birthdd" style="margin-left: 2%; width: 60px; padding: 8px;">
            </select> 
      <%-- ==== 생년월일 끝 ==== --%>      
      
            <input type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate" onClick="goEdit();" value="수정" style="font-size: 15pt;" />
            <input type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()" value="취소" style="font-size: 15pt;" /> 
		        </form>
  			  </div>  
  		    </div>
  		  </div>
	  	
<div align="center">

   <div id="head" align="center">
   </div>

	</div>
	  	
	  	
	  	
	  </div>
	 </div>
	</div>
	 
  		



</body>
</html>