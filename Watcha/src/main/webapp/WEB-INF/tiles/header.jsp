<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<% String ctxPath = request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>

<style type="text/css">


	@media (max-width: 991px) and (min-width: 860px) {
		.container {
			max-width: 830px;
		}
	}
	  
	.header-a:hover {
		text-decoration: none;
	}

	.header-li {
		margin: 0 0 0 18px;
	}
	
	.header-list {
	      font-size: 12pt;

		  cursor: pointer;
	}
	
	.header-main-li {
		list-style: none;
		position: relative;
		top: 43%;
	}
	
	.header-second-li {
		list-style: none;
		position: relative;
		top: 43%;
	}
	
	button.btn-search1{
		border: none;
		background-color: #F5F5F6;
	}
	
	input#search-header {
		background-color: #F5F5F6;
		border: none;
		width:100%;
		padding-left: 34px;
	}
	
	input#search-header:focus{   /* input 태그 focus 시 */
		outline:none;
	}
	input#search-header:autofill {   /* 자동완성시 css 부분*/
		-webkit-box-shadow: 0 0 0px 1000px #F5F5F6 inset;
	}
	
	.header-tag-a {
		font-size: 27px;
		font-weight: bold;
		color: black;
		margin-right: 10px;
	}
	.header-tag-a:hover {
		color: black;
	}
	
	.header-tag-a-span {
		margin-right: 10px;
		bottom: 5px;
		position: relative;
	}


    /* 크기가 md 이상일때 */
	@media (min-width: 860px) {
	  
	  .header-li {
	      margin: 0 0 0 24px;
	   }
	   
	  #header-div-input {
		 background: #F5F5F6;
	   }
	   
	   .header-second-li {
			margin: 0 0 0 auto;			
		}
		
		.footer-label {
			width: 300px;
		}
	}
	
	@media (max-width: 992px) and (min-width: 860px) {
		.footer-label {
			width: 280px;
		}
		
	}
	
	/* 크기가 md 사이즈 이하일때 */
	@media (max-width: 859px) {
		.footer-label {
			background-color: transparent;		
		    border: none;
		    cursor: pointer;
		}
		.header-second-li {
			margin: 0 0 0 auto;	
			width: 26px;		
		}
		input#search-header {
			padding-left: 11px;
		}

	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	/* 로그인 회원가입 modal 띄우면, 메인페이지 스크롤 잠그기 */
.disableBodyScrolling {
    overflow: hidden !important;
}

/* 로그인 회원가입 input 테두리 없애기 */
input[type="email"]:focus, 
input[type="password"]:focus, 
input[type="text"]:focus {
    outline: none;
}

/* login_signup-modal 시작 */

    /* modal 기능 css 시작 */
        /* 모바일 */
        .login_signup-modal {
            display: none;
            text-align: center;
            position: absolute;
            inset: 0px;
            z-index: 101;
            background-color: rgba(0,0,0,0.4);
            align-items: center;
            justify-content: center;
        }
        /* pc버전 추가사항 */
        @media (min-width: 719px) {
            .login_signup-modal {
                padding: 20px 0px;
                overflow: auto;
            }
        }
    /* modal 기능 css 끝 */


    /* modal창 css 시작 */
        /* 모바일 */
        .login_signup-modal-dialog {
            position: relative;
            background: rgb(255, 255, 255);
            width: 100%;
            height: 100%;
            box-shadow: rgba(0, 0, 0, 0.12) 0px 0px 6px 0px;
            overflow: hidden;
        }

        /* pc버전 추가사항 */
        @media (min-width: 719px) {
            .login_signup-modal-dialog {
                vertical-align: bottom;
                width: 375px;
                height: auto;
                min-height: 540px;
                border-radius: 6px;
                overflow: auto;
            }
        }

        /* padding-top: 32px padding-bottom: 16px */
        .pt32_pb16 {
            padding: 32px 0px 16px;
        }
    /* modal 창 css 끝 */


    /* modal header 시작 */
        /* modal 제목 */
        .login_signup-modal-title {
            font-size: 17px;
            letter-spacing: -0.5px;
            line-height: 22px;
            font-weight: 700;
            text-align: center;
            margin: 24px 0px 20px;
        }

        /* margin-horizontal: 20px */
        .mx20 {
            margin: 0px 20px;
        }
    /* modal header 끝 */


    /* modal form 시작 */
        /* padding-vertical: 4px */
        .py4 {
        	padding: 4px 0px;
        }

        /* 회색 입력란 */
        .login_signup-label-input {
            display: flex;
            align-items: center;
            background: rgb(245, 245, 245);
            box-sizing: border-box;
            width: 100%;
            height: 44px;
            margin: 0;
            padding: 0px 12px;
            border-radius: 6px;
            border: none;
        }

        /* 입력란 디자인 */
        .login_signup-div-input {
            display: flex;
            flex: 1 1 0%;
        }

        /* 입력란 내용물 디자인 */
        .login_signup-input {
            background: transparent;
            font-weight: 400;
            font-size: 16px;
            letter-spacing: -0.6px;
            line-height: 21px;
            width: 100%;
            padding: 0px;
            border: 0px;
            overflow: hidden;
            text-overflow: ellipsis;
            caret-color: rgb(255, 47, 110);
        }

        /* submit 버튼 */
        .login_signup-btn {
            padding: 0px;
            border: none;
            cursor: pointer;
            background: rgb(255, 47, 110);
            color: rgb(255, 255, 255);
            text-align: center;
            font-size: 17px;
            font-weight: 400;
            letter-spacing: -0.7px;
            line-height: 22px;
            width: 100%;
            height: 44px;
            border-radius: 6px;
            margin: 16px 0px 0px;
        }
    /* modal form 끝 */


    /* 글씨(비번찾기와 로그인 회원가입 모달 전환 버튼) 시작 */
        /* 분홍글씨 */
        .text-button {
            background: none;
            padding: 0px;
            border: none;
            margin: 0px;
            cursor: pointer;
            color: rgb(255, 47, 110);
        }

        /* 서식설정 */
        .textstyle-modal {
            font-size: 15px;
            font-weight: 400;
            letter-spacing: -0.5px;
            line-height: 20px;
            color: rgb(140, 140, 140);
            text-align: center;
        }

        /* margin-top: 20px margin-bottom: 14px */
        .mt20_mb14 {
            margin: 20px 0px 14px;
        }
    /* 글씨(비번찾기와 로그인 회원가입 모달 전환 버튼) 끝 */


    /* SNS 로그인/회원가입 연동 시작 */
        /* 가로선 */
        .or-hr {
            position: relative;
            color: black;
            text-align: center;
            height: 1.5em;
            border: 0px;
            outline: 0px;
            margin: 24px 0px;
        }

        /* ul */
        .ul-otherLogin {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            gap: 14px;
            list-style: none;
            padding-inline-start: 0px;
        }

        /* li 시작 */
            .li-kakao {
                display: flex;
                position: relative;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                background: rgb(247, 227, 23);
                font-weight: 700;
                width: 50px;
                height: 50px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
            }

            .li-google {
                display: flex;
                position: relative;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                background: rgb(255, 255, 255);
                font-weight: 700;
                width: 50px;
                height: 50px;
                border: 1px solid rgb(227, 228, 230);
                border-radius: 50%;
                cursor: pointer;
            }

            .li-twitter {
                display: flex;
                position: relative;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                background: rgb(29, 161, 243);
                font-weight: 700;
                width: 50px;
                height: 50px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
            }

            .li-apple {
                display: flex;
                position: relative;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                background: rgb(0, 0, 0);
                font-weight: 700;
                width: 50px;
                height: 50px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
            }

            .li-line {
                display: flex;
                position: relative;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                background: rgb(0, 195, 0);
                font-weight: 700;
                width: 50px;
                height: 50px;
                border: none;
                border-radius: 50%;
                cursor: pointer;
            }
        /* li 끝 */
    /* SNS 로그인/회원가입 연동 끝 */


    /* 안내문구 회색박스 */
    .textbox {
        background-color: rgb(247, 247, 247);
        color: rgb(140, 140, 140);
        font-size: 15px;
        font-weight: 400;
        letter-spacing: -0.2px;
        line-height: 23px;
        text-align: center;
        padding: 10px 13px;
        margin-top: 48px;
    }
/* modal 끝 */
	


</style>


<script type="text/javascript">

	$(document).ready(function(){
		randomInput() ; // INPUT에 PLACEHOLDER 가 랜덤하게 들어가게 하는 방법
		$('button.btn-search1').on('click', function(event) {   // 버튼 클릭시 
		    event.preventDefault(); // 새로고침 안함
		    gosearch();
		});
		
		$(window).on('resize', function() {					// 실시간 창 사이즈가 859 이상일때 버튼이 클릭해서 input 크기가 커졌을때 초기 상태로 돌린다.
			gosize();    
		});
		gosearch();
		gosize();
		
		$('input#search-header').on('keyup', function(event){
	    	if( event.keyCode == 13 ){
	    		goSearchWord();
	    	}
	    });
		
		
		///////////////////////////////////////////////////
		
		
		// modal 닫기 기능
	    $(".login_signup-modal").click(function(e) {
	        if (e.target === this) {
	            modalClose();
	        }
	    });

	    // 
	    $("#loginForm").submit(function(e) {
	        e.preventDefault();
	        // Perform login logic here
	    });

	    $("#signupForm").submit(function(e) {
	        e.preventDefault();
	        // Perform registration logic here
	    });

	    
	    $("button#btnLOGIN").click(function(){
	        func_Login();
	    });
	    

	    // input 태그에 enter 눌렀을 때
	    $("input.login_signup-input").keydown(function(e){
	        if(e.keyCode == 13) { // enter를 했을 경우
	            submitForm(); // form 기능 실행	
	        }
	    });


		
		
	}); 
	
	
	
	function randomInput(){
	  const placeholders = [
	    '가디언즈 오브 갤럭시: Volume 3',
	    '분노의 질주: 더 얼티메이트',
	    '슬픔의 삼각형',
	    '인어 공주',
	    'CSI: 뉴욕',
	    '범죄도시3'
	  ];
	  const randomIndex = Math.floor(Math.random() * placeholders.length);
	  const button = $('<button>', { 'class': 'position-absolute btn-search1' }).append($('<i>', { 'class': 'fa-solid fa-magnifying-glass' }));
	  const input = $('<input>', { id: 'search-header', type: 'text', placeholder: placeholders[randomIndex],name:'searchWord' });
	  $('span.header-div-input').empty().append(button).append(input);
	}
	
	// 검색창 부분 사이즈 변경마다 다르게 
	let gosearchone = true;
	
	function gosearch() {
		
	  let windowWidth = $(window).width();   // 크기를 알아오기 위해 

	  if (gosearchone && windowWidth < 859) {   // 버튼 누를때마다 달라지며 창크기가 859 미만일때 실행 
		$('.header-second-li').css({
	      width: ''
	    });
	    $('.footer-label').css({
		      width: ''
		});
	    $('input#search-header').css({
		     padding: '0 0 0 11px'
	    });
	    $('.header-li').css({
	    	display: 'flex'
	    });
	    $('button.btn-search1').css(
			'background-color', 'white'
		);
	    $('input#search-header ').css(
	    	'background-color', 'white'   
	    );
	    
	  } else if(!gosearchone && windowWidth < 859){  // 버튼 누를때마다 달라지며 창 크기가 859미만일대 실행 
	    
		$('.header-second-li').css({
	      width: '349px'
	    });
	    $('.footer-label').css({
		      width: '349px',
		      margin: '0 0 0 auto'
		      
		    });
	    $('input#search-header').css({
		     padding: '0 0 0 34px'
	    });
	    $('.header-li').css({
	    	display: 'none'
	    });
	    $('button.btn-search1').css(
			 'background-color', '#F5F5F6'
		);
	    $('input#search-header ').css(
	    	'background-color', '#F5F5F6'   
	    );
	  }
	  
	  gosearchone = ! gosearchone; // 누를때마다 css 추가
	}
	
	// 사이즈 변경 마다 평가하기 부분 & 검색 버튼 아이콘 부분  
	function gosize() {
		 let windowWidth = $(window).width();
		    
		if(windowWidth > 859){
	  	   $('.header-star').text('평가하기');
	  	   $('.header-star').css({
	  		   color: '#999999'
	  	   });
	  	   $('.header-login').text('로그인');
	  	   $('.header-login').css({
	  		 color: 'black' 
	  	   });
		   $('input#search-header').css({
			    padding: '0 0 0 34px'
		   });
		   $('button.btn-search1').css(
			    'background-color', '#F5F5F6'
		   );
		   $('input#search-header ').css(
		    	'background-color', '#F5F5F6'   
		   );
		   gosearchone = true;
	    } else {
	       $('.header-star').html('<i class="fa-solid fa-star fa-lg"></i>');
	       $('.header-star').css({
		   	 color: '#999999'
		   });
	       $('.header-login').text('로그인');
	       $('.header-login').css({
		  		 color: 'black'
		   });
	       $('button.btn-search1').css(
			    'background-color', 'white'
		   );
	       $('input#search-header ').css(
	    		'background-color', 'white'   
	       );
	       gosearchone = false;
	    }
	
		if (windowWidth > 859 && gosearchone) {
	      $('.header-second-li').css({
	        width: ''
	      });
	      $('.footer-label').css({
	        width: ''
	      });
	      $('input#search-header').css({
			     padding: '0 0 0 34px'
		  });
	      $(".header-li").css({
	        display: 'flex'
	      });
	    }
	}
	
	function goSearchWord(){
		// console.log( '확인용 ~~')
		const searchText = $('input#search-header').val();
		
		const searchFrm = document.searchFrm;
		searchFrm.action="<%=ctxPath%>/go.action";     /* // action 인것 바꾸기 */ 
		searchFrm.method="get";
		searchFrm.submit();	
		
	
	}
	
	///////////////////////////////////////////////////////////////
	
	
	// modal 여는 기능
	function modalOpen(btn) {
	    let modalId = $(btn).attr("data-modal");
	    $(modalId).css("display","flex");
	    $("html").addClass("disableBodyScrolling");
	}
	
	// modal 바깥을 클릭했을 때 닫는 기능
	function modalClose() {
	    $(".login_signup-modal").css("display","none");
	    $("html").removeClass("disableBodyScrolling");
	    resetForm();
	}
	
	// modal 창에서 입력된 값 초기화 시키기
	function resetForm(){
	    const modal_frmArr = $("form.form");
	    for(let i=0; i<modal_frmArr.length; i++) {
	        modal_frmArr[i].reset();
	    }
	}




	
</script>



</head>
<body>
	<div class="d-none d-md-block">
		<div class="container">
			<div class="row">
				<ul style="display: flex; padding: 0; margin: 0; overflow: hidden; width: 100%;">
					<li style="list-style: none;">
						<a href="#"><img src="<%= ctxPath%>/resources/images/watchapedia.png" style="top: 10%; position: relative; width: 85%;"></a>
					</li>
					<li class="header-main-li header-li" style="margin: 0;">	
						<span class="header-list"><a href="#" style="color: #999999" class="header-a">영화</a></span>
					</li>
					<li class="header-main-li header-li">	
						<span class="header-list"><a href="#" style="color: #999999" class="header-a">TV</a></span> 
					</li>	
					<li class="header-main-li header-li">	
						<span class="header-list"><a href="#" style="color: #999999" class="header-a">책</a></span>
					</li>
					<li class="header-main-li header-li">	
						<span class="header-list"><a href="#" style="color: #999999" class="header-a">웹툰</a></span>
					</li>
					<li class="header-second-li">
						<div style="    position: relative; width: 100%;">
						<form name="searchFrm" id="searchFrm">
							<label class="footer-label">
							
								<span class="header-div-input" style="top:40%; position: relative;"></span>	
							
							</label>
						</form>
						</div>
					</li>	
					<li class="header-main-li" style="margin-left: 24px;">
						
						<!-- <c:if test="">  로그인 안되어있으면 login 할 수 있게 나타내기 -->
							 
							 <!-- 로그인 버튼 -->
    						 <button type="button" class="header-a" id="loginBtn" data-modal="#loginModal" onclick="modalOpen(this)" style="border: none; background-color: white; padding: 0;"><span class="header-login"></span></button>
						<!-- </c:if> -->
						
						
						<!-- <c:if test="">  로그인 되어 있으면 평가하기 나타내기 -->
							<!-- <a href="#" class="header-a"><span class="header-star"></span></a> -->
						<!-- </c:if> -->
						
					</li>
					<li class="header-main-li" style="margin-left: 24px;">
						
						<!-- <c:if test="">  로그인 안 되어 있으면 나타내기 -->	
							 <button type="button" id="signupBtn" data-modal="#signupModal" style="border-radius: 5px; bottom: 2px; position: relative; background-color: white; border: solid 1px #999999;" onclick="modalOpen(this)" >회원가입</button>
							 
						<!-- </c:if> -->
						
						
						<!-- <c:if test="">  로그인 되어 있으면 나타내기 -->	
							<!-- <a href="#"><i class="fa-solid fa-user fa-lg" style="color: #999999"></i></a> -->
						<!-- </c:if> -->	
					
					
					</li>
				</ul>
				
				<div style="border: solid 1px #F5F5F6; width: 100%; margin: 10px 0 30px 0;"></div>
			</div>
		</div>
	</div>
	
	<div class="d-block d-md-none" >
		<div class="container">
			<div class="row">
				<ul style="display: flex; padding-left: 0; margin-bottom: 30px;">
					<li class="header-main-li">
						<a href="#" class="header-tag-a header-a">영화</a>
						<span class="header-tag-a-span">|</span>
					</li>
					<li class="header-main-li">
						<a href="#" class="header-tag-a header-a">TV</a>
						<span class="header-tag-a-span">|</span>
					</li>
					<li class="header-main-li">
						<a href="#" class="header-tag-a header-a">책</a>
						<span class="header-tag-a-span">|</span>
					</li>
					<li class="header-main-li">
						<a href="#" class="header-tag-a header-a">웹툰</a>
					</li>
				</ul>
			</div>
		</div>	
	</div>
	
	
	
	<!-- ////////////////////////////////////////////////////////// -->
		
	<!-- 로그인 modal -->
    <div id="loginModal" class="login_signup-modal">
        <div class="login_signup-modal-dialog">
            <div class="pt32_pb16">
                <div>
                	<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUxIiBoZWlnaHQ9IjI5IiB2aWV3Qm94PSIwIDAgMTUxIDI5IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxwYXRoIGQ9Ik03My40MjQyIDE0LjYzOTFINjkuODAxOFY2LjEzNTE5SDY1LjEwMTNWMjcuNzIyMUg2OS44MDE4VjE5LjEzMDlINzMuNDI0MlYyNy43MjIxSDc4LjEyNDhWNi4xMzUxOUg3My40MjQyVjE0LjYzOTFaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTM3Ljg0NjggMTAuNjI3SDQxLjY0MTdWMjcuNzIyMUg0Ni4zNDIyVjEwLjYyN0g0OS45MjE1VjYuMTM1MTlIMzcuODQ2OFYxMC42MjdaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTI4LjQwMjcgNi4xMzUxOUwyNC42MDc3IDI3LjcyMjFIMjkuMTc4OUwyOS42OTIxIDI0LjIzMzNIMzQuMDIxN0wzNC41MjYzIDI3LjcyMjFIMzkuMTQwNUwzNS4zMDI1IDYuMTM1MTlIMjguNDAyN1pNMzAuMjY5OSAyMC4zMDg0TDMxLjU5MzggMTEuMzI0OEgzMi4xNTQ0TDMzLjQ1NDYgMjAuMzA4NEgzMC4yNjk5WiIgZmlsbD0iI0ZGMDU1OCIvPgogIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMjAuMzA5IDBMMTguOTAyMiAyMC42NTAyTDE4LjUyNDEgMjAuNjcwMUwxNS4xNzgyIDYuMDYwNUgxMS4wNDM4TDguNTQwNzYgMjEuMTk4NEw4LjAwNDI5IDIxLjIyNjdMNS43NjMyNiA2LjA2MDVIMEw1LjI0MzMxIDI4LjYzNzlMMTEuMTA0NSAyOC4yNDczTDEzLjAxMTQgMTQuMjMzM0wxMy41NzA3IDE0LjIwMjZMMTYuMTI0MiAyNy45MDg3TDIxLjczNCAyNy41MzIzTDI2LjE4ODkgMEgyMC4zMDlaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTU3LjE2NjQgNS45MTcxMkM1Mi45NDAyIDUuOTE3MTIgNTAuOTEzNCA4LjIyODQ1IDUwLjkxMzQgMTEuODA0NVYyMi4wNTI4QzUwLjkxMzQgMjUuNjI4OCA1Mi45NDAyIDI3Ljk0MDEgNTcuMTY2NCAyNy45NDAxQzYxLjM5MjYgMjcuOTQwMSA2My40MTk0IDI1LjYyODggNjMuNDE5NCAyMi4wNTI4VjE4LjM0Nkg1OC43MTg5VjIyLjQ4ODlDNTguNzE4OSAyMy42MjI4IDU4LjI4NzYgMjQuMDE1MiA1Ny4xNjY0IDI0LjAxNTJDNTYuMDQ1MiAyNC4wMTUyIDU1LjYxMzkgMjMuNjIyOCA1NS42MTM5IDIyLjQ4ODlWMTEuMzY4NEM1NS42MTM5IDEwLjIzNDUgNTYuMDQ1MiA5Ljg0MjAxIDU3LjE2NjQgOS44NDIwMUM1OC4yODc2IDkuODQyMDEgNTguNzE4OSAxMC4yMzQ1IDU4LjcxODkgMTEuMzY4NFYxMy44MTA1SDYzLjQxOTRWMTEuODA0NUM2My40MTk0IDguMjI4NDUgNjEuMzkyNiA1LjkxNzEyIDU3LjE2NjQgNS45MTcxMloiIGZpbGw9IiNGRjA1NTgiLz4KICA8cGF0aCBkPSJNODMuMDQwOCA2LjEzNTE5TDc5LjI0NTkgMjcuNzIyMUg4My44MTcxTDg0LjMzMDIgMjQuMjMzM0g4OC42NTk5TDg5LjE2NDUgMjcuNzIyMUg5My43Nzg3TDg5Ljk0MDcgNi4xMzUxOUg4My4wNDA4Wk04NC45MDgxIDIwLjMwODRMODYuMjMyIDExLjMyNDhIODYuNzkyNkw4OC4wOTI4IDIwLjMwODRIODQuOTA4MVoiIGZpbGw9IiNGRjA1NTgiLz4KICA8cGF0aCBkPSJNMTI1LjY4NiA2LjEzNTI1SDEyMC45NDNWMjcuNzIyMkgxMjUuNjg2QzEyOC4zNiAyNy43MjIyIDEzMC4xMjggMjYuNjc1NSAxMzAuOTkxIDI0Ljc1NjdDMTMxLjUwOCAyMy42MjI4IDEzMS42MzggMjIuNTc2MiAxMzEuNjM4IDE2LjkwNjlDMTMxLjYzOCAxMS4yODEyIDEzMS41MDggMTAuMjM0NiAxMzAuOTkxIDkuMTAwNzNDMTMwLjEyOCA3LjE4MTg5IDEyOC4zNiA2LjEzNTI1IDEyNS42ODYgNi4xMzUyNVpNMTI4LjM2IDIzLjUzNTZDMTI3LjkyOSAyNC41ODIzIDEyNy4wMjMgMjUuMTQ5MiAxMjUuNDI4IDI1LjE0OTJIMTIzLjc0NlY4LjcwODI0SDEyNS40MjhDMTI3LjAyMyA4LjcwODI0IDEyNy45MjkgOS4yNzUxNyAxMjguMzYgMTAuMzIxOEMxMjguNzA1IDExLjA2MzIgMTI4Ljc5MSAxMS43MTczIDEyOC43OTEgMTYuOTUwNUMxMjguNzkxIDIyLjE0MDEgMTI4LjcwNSAyMi43OTQyIDEyOC4zNiAyMy41MzU2WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xNDcuMDc2IDYuMTM1MjVIMTQyLjgwN0wxMzguODM5IDI3LjcyMjJIMTQxLjY0MkwxNDIuMzMyIDIzLjM2MTJIMTQ3LjUwN0wxNDguMjQgMjcuNzIyMkgxNTFMMTQ3LjA3NiA2LjEzNTI1Wk0xNDIuNzY0IDIwLjkxOUwxNDQuODc3IDguNDAyOTdIMTQ0Ljk2M0wxNDcuMDc2IDIwLjkxOUgxNDIuNzY0WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xMzYuODEyIDYuMTM1MjVIMTM0LjAwOVYyNy43MjIySDEzNi44MTJWNi4xMzUyNVoiIGZpbGw9IiMyOTJBMzIiLz4KICA8cGF0aCBkPSJNMTAzLjk1MiA2LjEzNTI1SDk4Ljg2MzNWMjcuNzIyMkgxMDEuNjIzVjE3LjY0ODNIMTAzLjk1MkMxMDYuMTA4IDE3LjY0ODMgMTA3LjQ4OCAxNy4wMzc3IDEwOC4wOTIgMTUuNjg1OEMxMDguMzk0IDE0LjkwMDggMTA4LjQ4IDE0LjI5MDMgMTA4LjQ4IDExLjg5MThDMTA4LjQ4IDkuNDkzMjIgMTA4LjM5NCA4LjgzOTA3IDEwOC4wOTIgOC4xNDEzMUMxMDcuNDg4IDYuNzQ1NzkgMTA2LjEwOCA2LjEzNTI1IDEwMy45NTIgNi4xMzUyNVpNMTA1LjQ2MSAxNC4xMTU5QzEwNS4xNTkgMTQuOTAwOCAxMDQuNDI2IDE1LjA3NTMgMTAzLjI2MiAxNS4wNzUzSDEwMS42MjNWOC41MzM4SDEwMy4yNjJDMTA0LjQyNiA4LjUzMzggMTA1LjE1OSA4Ljc1MTg1IDEwNS40NjEgOS40OTMyMkMxMDUuNjM0IDkuODg1NzEgMTA1LjY3NyAxMC4xMDM4IDEwNS42NzcgMTEuODA0NUMxMDUuNjc3IDEzLjQ2MTcgMTA1LjYzNCAxMy43NjcgMTA1LjQ2MSAxNC4xMTU5WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xMTAuNTA3IDI3LjcyMjJIMTE4LjM1NVYyNS4xNDkySDExMy4zMVYxNy41NjExSDExOC4yMjZWMTQuOTg4MUgxMTMuMzFWOC43MDgyNEgxMTguMzU1VjYuMTM1MjVIMTEwLjUwN1YyNy43MjIyWiIgZmlsbD0iIzI5MkEzMiIvPgo8L3N2Zz4K" width="198px" height="38.03px">
                </div>
                <h2 class="login_signup-modal-title">로그인</h2>
                <section>
                    <div class="mx20">
                        <form id="loginForm" class="form">
                            <div class="py4">
                                <label class="login_signup-label-input">
                                    <div class="login_signup-div-input">
                                        <input autocomplete="off" placeholder="이메일" type="email" name="email" class="login_signup-input" value="">
                                    </div>
                                </label>
                            </div>
                            
                            <div class="py4">
                                <label class="login_signup-label-input">
                                    <div class="login_signup-div-input">
                                        <input autocomplete="off" placeholder="비밀번호" type="password" name="password" class="login_signup-input" value="">
                                    </div>
                                </label>
                            </div>
                            <button type="button" class="login_signup-btn" id="btnLOGIN">로그인</button>
                        </form>
                        <div class="textstyle-modal mt20_mb14">
                            <button class="text-button">비밀번호를 잊어버리셨나요?</button>
                        </div>
                        <div class="textstyle-modal">
                            계정이 없으신가요?
                            <button type="button" id="switchToSignupBtn" data-modal="#signupModal" class="text-button" onclick="modalClose(), modalOpen(this)">회원가입</button>
                        </div>
                        <hr>
                        <ul class="ul-otherLogin">
                            <li>
                                <button class="li-kakao" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTIuMDM5NCAxOC4zQzE3LjAzMTggMTguMyAyMS4wNzg5IDE1LjA5ODggMjEuMDc4OSAxMS4xNUMyMS4wNzg5IDcuMjAxMTYgMTcuMDMxOCA0IDEyLjAzOTQgNEM3LjA0NzA5IDQgMyA3LjIwMTE2IDMgMTEuMTVDMyAxMy43MjQ5IDQuNzIwNzUgMTUuOTgxOSA3LjMwMjI5IDE3LjI0MDdDNy4wMzYwNyAxOC4zNTU0IDYuNTY4NTUgMjAuMzE5OCA2LjU1MTQ3IDIwLjQzODVDNi41Mjc1NCAyMC42MDQ4IDYuNzE5MjUgMjAuNzQwNiA2Ljg4NzU4IDIwLjYyNTFDNy4wMTA1IDIwLjU0MDggOS4yNTI5NSAxOS4wMTAyIDEwLjQ1NDEgMTguMTkwNEMxMC45Njg4IDE4LjI2MjQgMTEuNDk4NiAxOC4zIDEyLjAzOTQgMTguM1oiIGZpbGw9IiMzQzFFMUUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>                      
                            <li>
                                <button class="li-google" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMjAuNjQgMTIuMjA0MkMyMC42NCAxMS41NjYgMjAuNTgyNyAxMC45NTI0IDIwLjQ3NjQgMTAuMzYzM0gxMlYxMy44NDQ2SDE2Ljg0MzZDMTYuNjM1IDE0Ljk2OTYgMTYuMDAwOSAxNS45MjI4IDE1LjA0NzcgMTYuNTYxVjE4LjgxOTJIMTcuOTU2NEMxOS42NTgyIDE3LjI1MjQgMjAuNjQgMTQuOTQ1MSAyMC42NCAxMi4yMDQyVjEyLjIwNDJaIiBmaWxsPSIjNDI4NUY0Ii8+CiAgICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjk5OTggMjFDMTQuNDI5OCAyMSAxNi40NjcgMjAuMTk0MSAxNy45NTYxIDE4LjgxOTVMMTUuMDQ3NSAxNi41NjEzQzE0LjI0MTYgMTcuMTAxMyAxMy4yMTA3IDE3LjQyMDQgMTEuOTk5OCAxNy40MjA0QzkuNjU1NjcgMTcuNDIwNCA3LjY3MTU4IDE1LjgzNzIgNi45NjM4NSAxMy43MUgzLjk1NzAzVjE2LjA0MThDNS40Mzc5NCAxOC45ODMxIDguNDgxNTggMjEgMTEuOTk5OCAyMVYyMVoiIGZpbGw9IiMzNEE4NTMiLz4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNi45NjQwOSAxMy43MDk4QzYuNzg0MDkgMTMuMTY5OCA2LjY4MTgyIDEyLjU5MyA2LjY4MTgyIDExLjk5OThDNi42ODE4MiAxMS40MDY2IDYuNzg0MDkgMTAuODI5OCA2Ljk2NDA5IDEwLjI4OThWNy45NTgwMUgzLjk1NzI3QzMuMzQ3NzMgOS4xNzMwMSAzIDEwLjU0NzYgMyAxMS45OTk4QzMgMTMuNDUyMSAzLjM0NzczIDE0LjgyNjYgMy45NTcyNyAxNi4wNDE2TDYuOTY0MDkgMTMuNzA5OFYxMy43MDk4WiIgZmlsbD0iI0ZCQkMwNSIvPgogICAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xMi4wNDI3IDYuNTc5NTVDMTMuMzY0MSA2LjU3OTU1IDE0LjU1MDUgNy4wMzM2NCAxNS40ODMyIDcuOTI1NDVMMTguMDY0NSA1LjM0NDA5QzE2LjUwNTkgMy44OTE4MiAxNC40Njg2IDMgMTIuMDQyNyAzQzguNTI0NTUgMyA1LjQ4MDkxIDUuMDE2ODIgNCA3Ljk1ODE4TDcuMDA2ODIgMTAuMjlDNy43MTQ1NSA4LjE2MjczIDkuNjk4NjQgNi41Nzk1NSAxMi4wNDI3IDYuNTc5NTVWNi41Nzk1NVoiIGZpbGw9IiNFQTQzMzUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>
                            <li>
                                <button class="li-twitter" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNOC40NzUzNSAxOS43QzE1LjY0NTUgMTkuNyAxOS41NjY1IDEzLjg1MjcgMTkuNTY2NSA4Ljc4MjM1QzE5LjU2NjUgOC42MTYxOSAxOS41NjMxIDguNDUwNzggMTkuNTU1MyA4LjI4NjI3QzIwLjMxNjQgNy43NDQ3MSAyMC45NzggNy4wNjg5NCAyMS41IDYuMjk5NTFDMjAuODAxNSA2LjYwNDg5IDIwLjA0OTggNi44MTA3NyAxOS4yNjEzIDYuOTAzNTRDMjAuMDY2MiA2LjQyODYzIDIwLjY4NDEgNS42NzY5MyAyMC45NzU0IDQuNzgwOTlDMjAuMjIyMSA1LjIyMDUxIDE5LjM4ODIgNS41NDAxOCAxOC41MDAzIDUuNzEyMzJDMTcuNzg5IDQuOTY2NTIgMTYuNzc1OSA0LjUgMTUuNjU0OSA0LjVDMTMuNTAyIDQuNSAxMS43NTYyIDYuMjE4NDkgMTEuNzU2MiA4LjMzNjkyQzExLjc1NjIgOC42MzgxMSAxMS43OTA1IDguOTMwODUgMTEuODU3MyA5LjIxMTg0QzguNjE3NjIgOS4wNTE1MiA1Ljc0NDgyIDcuNTI0NTQgMy44MjI0IDUuMjAyNzhDMy40ODczMiA1Ljc2OTcgMy4yOTQ1IDYuNDI4NjMgMy4yOTQ1IDcuMTMxMzRDMy4yOTQ1IDguNDYyNjggMy45ODI2OCA5LjYzNzg5IDUuMDI5MTMgMTAuMzI1NEM0LjM4OTgyIDEwLjMwNiAzLjc4OTA0IDEwLjEzMzEgMy4yNjM2NSA5Ljg0NTM0QzMuMjYyNzQgOS44NjEzNSAzLjI2Mjc0IDkuODc3NDMgMy4yNjI3NCA5Ljg5NDI3QzMuMjYyNzQgMTEuNzUyOSA0LjYwNjY0IDEzLjMwNDMgNi4zOTAxNCAxMy42NTYxQzYuMDYyOCAxMy43NDM4IDUuNzE4MjIgMTMuNzkxMSA1LjM2MjU0IDEzLjc5MTFDNS4xMTE0NCAxMy43OTExIDQuODY3MTcgMTMuNzY2NiA0LjYyOTc1IDEzLjcyMTlDNS4xMjYwMyAxNS4yNDY0IDYuNTY1MDEgMTYuMzU1OCA4LjI3MTM2IDE2LjM4NzFDNi45MzY5NiAxNy40MTYyIDUuMjU2MjkgMTguMDI5NSAzLjQyOTk0IDE4LjAyOTVDMy4xMTUzNyAxOC4wMjk1IDIuODA1MTQgMTguMDExOSAyLjUgMTcuOTc2NEM0LjIyNTI4IDE5LjA2NDcgNi4yNzM2MyAxOS43IDguNDc1MzUgMTkuNyIgZmlsbD0id2hpdGUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>
                            <li>
                                <button class="li-apple" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTQuNTk1NyA1LjAzMTc5QzEzLjk1NTYgNS44MDQ4MyAxMi44ODA1IDYuMzg0NjIgMTIuMDIyOSA2LjM4NDYyQzExLjkyNjMgNi4zODQ2MiAxMS44Mjk3IDYuMzcyNTQgMTEuNzY5MyA2LjM2MDQ2QzExLjc1NzIgNi4zMTIxNCAxMS43MzMgNi4xNjcyIDExLjczMyA2LjAyMjI1QzExLjczMyA1LjAzMTc5IDEyLjIyODMgNC4wNjU0OCAxMi43NzE4IDMuNDQ5NDZDMTMuNDYwMyAyLjY0MDE4IDE0LjYwNzggMi4wMzYyNCAxNS41NjIgMkMxNS41ODYyIDIuMTA4NzEgMTUuNTk4MyAyLjI0MTU4IDE1LjU5ODMgMi4zNzQ0NEMxNS41OTgzIDMuMzUyODMgMTUuMTc1NSA0LjMzMTIxIDE0LjU5NTcgNS4wMzE3OVpNMTAuMzk1MSAyMC42Mzk5QzkuOTY0NjMgMjAuODI0OCA5LjU1NjcxIDIxIDkuMDAzMjMgMjFDNy44MTk1IDIxIDYuOTk4MTQgMTkuOTEyOSA2LjA1NiAxOC41ODQyQzQuOTU2ODIgMTcuMDE0IDQuMDYyOTkgMTQuNTg2MSA0LjA2Mjk5IDEyLjI5MTJDNC4wNjI5OSA4LjU5NTA0IDYuNDY2NjggNi42MzgyNyA4LjgzNDEzIDYuNjM4MjdDOS41MjUxMiA2LjYzODI3IDEwLjE1NjUgNi44OTE2NCAxMC43MTc5IDcuMTE2OTNDMTEuMTY3MyA3LjI5NzI4IDExLjU3MTkgNy40NTk2MyAxMS45MjYzIDcuNDU5NjNDMTIuMjMzNyA3LjQ1OTYzIDEyLjYxNjkgNy4zMDgyMyAxMy4wNjM0IDcuMTMxNzdDMTMuNjg3MSA2Ljg4NTMxIDE0LjQzNDUgNi41ODk5NiAxNS4yNzIxIDYuNTg5OTZDMTUuODAzNiA2LjU4OTk2IDE3Ljc0ODMgNi42MzgyNyAxOS4wMjg3IDguNDc0MjVDMTkuMDIxMyA4LjQ3OTk2IDE5LjAwNTcgOC40OTAyOSAxOC45ODI5IDguNTA1MzVDMTguNjY3OCA4LjcxMzMyIDE2Ljk4NzMgOS44MjI2OSAxNi45ODczIDEyLjA5NzlDMTYuOTg3MyAxNC45MTIzIDE5LjQzOTMgMTUuOTE0OCAxOS41MjM5IDE1LjkzOUMxOS41MjE3IDE1Ljk0NDQgMTkuNTE2NyAxNS45NTk5IDE5LjUwODggMTUuOTg0NUMxOS40MjgyIDE2LjIzNCAxOS4wNDM5IDE3LjQyMzIgMTguMjE5NCAxOC42MzI1QzE3LjQxMDEgMTkuNzkyMSAxNi41NTI1IDIwLjk3NTggMTUuMjcyMSAyMC45NzU4QzE0LjY0MTEgMjAuOTc1OCAxNC4yMzkgMjAuNzk3OCAxMy44MjM4IDIwLjYxMzlDMTMuMzgwNyAyMC40MTc3IDEyLjkyMjggMjAuMjE0OSAxMi4xNTU4IDIwLjIxNDlDMTEuMzg0NyAyMC4yMTQ5IDEwLjg3NTggMjAuNDMzNCAxMC4zOTUxIDIwLjYzOTlaIiBmaWxsPSJ3aGl0ZSIvPgo8L3N2Zz4K" class="css-1hfgk44">
                                </button>
                            </li>
                            <li>
                                <button class="li-line" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsaXAtcGF0aD0idXJsKCNjbGlwMF8yNjMzXzIxNjkpIj4KICAgICAgICA8cGF0aCBkPSJNMjIgMTAuNjE2MkMyMiA2LjEzNjM2IDE3LjUxMDggMi41IDEyIDIuNUM2LjQ4OTIyIDIuNSAyIDYuMTM2MzYgMiAxMC42MTYyQzIgMTQuNjI3NSA1LjU2MTM5IDE3Ljk4MjcgMTAuMzU5OSAxOC42MkMxMC42ODc5IDE4LjY5NDkgMTEuMTI4NCAxOC44MzU1IDExLjI0MDkgMTkuMTE2N0MxMS4zNDQgMTkuMzY5NyAxMS4zMDY1IDE5Ljc2MzQgMTEuMjY5IDIwLjAxNjRDMTEuMjY5IDIwLjAxNjQgMTEuMTQ3MSAyMC43MTkzIDExLjEyODQgMjAuODY5M0MxMS4wODE1IDIxLjEyMjMgMTAuOTMxNiAyMS44NTMzIDExLjk5MDYgMjEuNDEyOEMxMy4wNTkgMjAuOTYzIDE3Ljc0NTEgMTguMDIwMiAxOS44NDQ0IDE1LjYxMTVDMjEuMzA2NSAxNC4wMTgzIDIyIDEyLjQwNjMgMjIgMTAuNjE2MlpNOC40NjY3MyAxMy4wMDYxQzguNDY2NzMgMTMuMTA5MiA4LjM4MjM4IDEzLjE5MzUgOC4yNzkyOSAxMy4xOTM1SDUuNDc3MDRDNS4zNzM5NSAxMy4xOTM1IDUuMjg5NiAxMy4xMDkyIDUuMjg5NiAxMy4wMDYxVjguNjM4NzFDNS4yODk2IDguNTM1NjEgNS4zNzM5NSA4LjQ1MTI3IDUuNDc3MDQgOC40NTEyN0g2LjE4OTMyQzYuMjkyNDEgOC40NTEyNyA2LjM3Njc2IDguNTM1NjEgNi4zNzY3NiA4LjYzODcxVjEyLjEwNjRIOC4yNzkyOUM4LjM4MjM4IDEyLjEwNjQgOC40NjY3MyAxMi4xOTA3IDguNDY2NzMgMTIuMjkzOFYxMy4wMDYxWk0xMC4xNjMxIDEzLjAwNjFDMTAuMTYzMSAxMy4xMDkyIDEwLjA3ODcgMTMuMTkzNSA5Ljk3NTYzIDEzLjE5MzVIOS4yNjMzNkM5LjE2MDI2IDEzLjE5MzUgOS4wNzU5MSAxMy4xMDkyIDkuMDc1OTEgMTMuMDA2MVY4LjYzODcxQzkuMDc1OTEgOC41MzU2MSA5LjE2MDI2IDguNDUxMjcgOS4yNjMzNiA4LjQ1MTI3SDkuOTc1NjNDMTAuMDc4NyA4LjQ1MTI3IDEwLjE2MzEgOC41MzU2MSAxMC4xNjMxIDguNjM4NzFWMTMuMDA2MVpNMTQuOTg5NyAxMy4wMDYxQzE0Ljk4OTcgMTMuMTA5MiAxNC45MDUzIDEzLjE5MzUgMTQuODAyMiAxMy4xOTM1SDE0LjA5QzE0LjA3MTIgMTMuMTkzNSAxNC4wNTI1IDEzLjE5MzUgMTQuMDQzMSAxMy4xODQySDE0LjAzMzdDMTQuMDMzNyAxMy4xODQyIDE0LjAzMzcgMTMuMTg0MiAxNC4wMjQ0IDEzLjE4NDJIMTQuMDE1SDE0LjAwNTZDMTQuMDA1NiAxMy4xODQyIDE0LjAwNTYgMTMuMTg0MiAxMy45OTYzIDEzLjE4NDJMMTMuOTg2OSAxMy4xNzQ4QzEzLjk2ODEgMTMuMTY1NCAxMy45NDk0IDEzLjE0NjcgMTMuOTQgMTMuMTI3OUwxMS45MzQ0IDEwLjQxOTRWMTMuMDA2MUMxMS45MzQ0IDEzLjEwOTIgMTEuODUgMTMuMTkzNSAxMS43NDcgMTMuMTkzNUgxMS4wMzQ3QzEwLjkzMTYgMTMuMTkzNSAxMC44NDcyIDEzLjEwOTIgMTAuODQ3MiAxMy4wMDYxVjguNjM4NzFDMTAuODQ3MiA4LjUzNTYxIDEwLjkzMTYgOC40NTEyNyAxMS4wMzQ3IDguNDUxMjdIMTEuNzM3NkMxMS43Mzc2IDguNDUxMjcgMTEuNzM3NiA4LjQ1MTI3IDExLjc0NyA4LjQ1MTI3SDExLjc1NjNIMTEuNzY1N0gxMS43NzUxSDExLjc4NDRDMTEuNzg0NCA4LjQ1MTI3IDExLjc4NDQgOC40NTEyNyAxMS43OTM4IDguNDUxMjdIMTEuODAzMkMxMS44MDMyIDguNDUxMjcgMTEuODAzMiA4LjQ1MTI3IDExLjgxMjYgOC40NTEyN0MxMS44MTI2IDguNDUxMjcgMTEuODIxOSA4LjQ1MTI3IDExLjgyMTkgOC40NjA2NEMxMS44MjE5IDguNDYwNjQgMTEuODIxOSA4LjQ2MDY0IDExLjgzMTMgOC40NjA2NEMxMS44MzEzIDguNDYwNjQgMTEuODQwNyA4LjQ2MDY0IDExLjg0MDcgOC40NzAwMUMxMS44NDA3IDguNDcwMDEgMTEuODQwNyA4LjQ3MDAxIDExLjg1IDguNDcwMDFDMTEuODUgOC40NzAwMSAxMS44NTk0IDguNDcwMDEgMTEuODU5NCA4LjQ3OTM4QzExLjg1OTQgOC40NzkzOCAxMS44NTk0IDguNDc5MzggMTEuODY4OCA4LjQ3OTM4TDExLjg3ODIgOC40ODg3NUwxMS44ODc1IDguNDk4MTNDMTEuODk2OSA4LjUwNzUgMTEuODk2OSA4LjUwNzUgMTEuOTA2MyA4LjUxNjg3TDEzLjkwMjUgMTEuMjM0OFY4LjYzODcxQzEzLjkwMjUgOC41MzU2MSAxMy45ODY5IDguNDUxMjcgMTQuMDkgOC40NTEyN0gxNC44MDIyQzE0LjkwNTMgOC40NTEyNyAxNC45ODk3IDguNTM1NjEgMTQuOTg5NyA4LjYzODcxVjEzLjAwNjFaTTE4Ljg2MDQgOS4zNTA5OEMxOC44NjA0IDkuNDU0MDggMTguNzc2IDkuNTM4NDMgMTguNjcyOSA5LjUzODQzSDE2Ljc2MVYxMC4yNzg4SDE4LjY3MjlDMTguNzc2IDEwLjI3ODggMTguODYwNCAxMC4zNjMyIDE4Ljg2MDQgMTAuNDY2M1YxMS4xNzg1QzE4Ljg2MDQgMTEuMjgxNiAxOC43NzYgMTEuMzY2IDE4LjY3MjkgMTEuMzY2SDE2Ljc2MVYxMi4xMDY0SDE4LjY3MjlDMTguNzc2IDEyLjEwNjQgMTguODYwNCAxMi4xOTA3IDE4Ljg2MDQgMTIuMjkzOFYxMy4wMDYxQzE4Ljg2MDQgMTMuMTA5MiAxOC43NzYgMTMuMTkzNSAxOC42NzI5IDEzLjE5MzVIMTUuODcwN0MxNS43Njc2IDEzLjE5MzUgMTUuNjgzMiAxMy4xMDkyIDE1LjY4MzIgMTMuMDA2MVY4LjY0ODA4QzE1LjY4MzIgOC41NDQ5OSAxNS43Njc2IDguNDYwNjQgMTUuODcwNyA4LjQ2MDY0SDE4LjY3MjlDMTguNzc2IDguNDYwNjQgMTguODYwNCA4LjU0NDk5IDE4Ljg2MDQgOC42NDgwOFY5LjM1MDk4WiIgZmlsbD0id2hpdGUiLz4KICAgIDwvZz4KICAgIDxkZWZzPgogICAgICAgIDxjbGlwUGF0aCBpZD0iY2xpcDBfMjYzM18yMTY5Ij4KICAgICAgICAgICAgPHJlY3Qgd2lkdGg9IjIwIiBoZWlnaHQ9IjE5LjA1MzQiIGZpbGw9IndoaXRlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyIDIuNSkiLz4KICAgICAgICA8L2NsaXBQYXRoPgogICAgPC9kZWZzPgo8L3N2Zz4K" class="css-1hfgk44">
                                </button>
                            </li>
                        </ul>
                        <div class="textbox">TIP.왓챠 계정이 있으신가요? 왓챠와 왓챠피디아는 같은 계정을 사용해요.</div>
                    </div>
                </section>
            </div>
        </div>
    </div>


    <!-- 회원가입 modal -->
    <div id="signupModal" class="login_signup-modal">
        <div class="login_signup-modal-dialog">
            <div class="pt32_pb16">
                <div>
                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUxIiBoZWlnaHQ9IjI5IiB2aWV3Qm94PSIwIDAgMTUxIDI5IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxwYXRoIGQ9Ik03My40MjQyIDE0LjYzOTFINjkuODAxOFY2LjEzNTE5SDY1LjEwMTNWMjcuNzIyMUg2OS44MDE4VjE5LjEzMDlINzMuNDI0MlYyNy43MjIxSDc4LjEyNDhWNi4xMzUxOUg3My40MjQyVjE0LjYzOTFaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTM3Ljg0NjggMTAuNjI3SDQxLjY0MTdWMjcuNzIyMUg0Ni4zNDIyVjEwLjYyN0g0OS45MjE1VjYuMTM1MTlIMzcuODQ2OFYxMC42MjdaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTI4LjQwMjcgNi4xMzUxOUwyNC42MDc3IDI3LjcyMjFIMjkuMTc4OUwyOS42OTIxIDI0LjIzMzNIMzQuMDIxN0wzNC41MjYzIDI3LjcyMjFIMzkuMTQwNUwzNS4zMDI1IDYuMTM1MTlIMjguNDAyN1pNMzAuMjY5OSAyMC4zMDg0TDMxLjU5MzggMTEuMzI0OEgzMi4xNTQ0TDMzLjQ1NDYgMjAuMzA4NEgzMC4yNjk5WiIgZmlsbD0iI0ZGMDU1OCIvPgogIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMjAuMzA5IDBMMTguOTAyMiAyMC42NTAyTDE4LjUyNDEgMjAuNjcwMUwxNS4xNzgyIDYuMDYwNUgxMS4wNDM4TDguNTQwNzYgMjEuMTk4NEw4LjAwNDI5IDIxLjIyNjdMNS43NjMyNiA2LjA2MDVIMEw1LjI0MzMxIDI4LjYzNzlMMTEuMTA0NSAyOC4yNDczTDEzLjAxMTQgMTQuMjMzM0wxMy41NzA3IDE0LjIwMjZMMTYuMTI0MiAyNy45MDg3TDIxLjczNCAyNy41MzIzTDI2LjE4ODkgMEgyMC4zMDlaIiBmaWxsPSIjRkYwNTU4Ii8+CiAgPHBhdGggZD0iTTU3LjE2NjQgNS45MTcxMkM1Mi45NDAyIDUuOTE3MTIgNTAuOTEzNCA4LjIyODQ1IDUwLjkxMzQgMTEuODA0NVYyMi4wNTI4QzUwLjkxMzQgMjUuNjI4OCA1Mi45NDAyIDI3Ljk0MDEgNTcuMTY2NCAyNy45NDAxQzYxLjM5MjYgMjcuOTQwMSA2My40MTk0IDI1LjYyODggNjMuNDE5NCAyMi4wNTI4VjE4LjM0Nkg1OC43MTg5VjIyLjQ4ODlDNTguNzE4OSAyMy42MjI4IDU4LjI4NzYgMjQuMDE1MiA1Ny4xNjY0IDI0LjAxNTJDNTYuMDQ1MiAyNC4wMTUyIDU1LjYxMzkgMjMuNjIyOCA1NS42MTM5IDIyLjQ4ODlWMTEuMzY4NEM1NS42MTM5IDEwLjIzNDUgNTYuMDQ1MiA5Ljg0MjAxIDU3LjE2NjQgOS44NDIwMUM1OC4yODc2IDkuODQyMDEgNTguNzE4OSAxMC4yMzQ1IDU4LjcxODkgMTEuMzY4NFYxMy44MTA1SDYzLjQxOTRWMTEuODA0NUM2My40MTk0IDguMjI4NDUgNjEuMzkyNiA1LjkxNzEyIDU3LjE2NjQgNS45MTcxMloiIGZpbGw9IiNGRjA1NTgiLz4KICA8cGF0aCBkPSJNODMuMDQwOCA2LjEzNTE5TDc5LjI0NTkgMjcuNzIyMUg4My44MTcxTDg0LjMzMDIgMjQuMjMzM0g4OC42NTk5TDg5LjE2NDUgMjcuNzIyMUg5My43Nzg3TDg5Ljk0MDcgNi4xMzUxOUg4My4wNDA4Wk04NC45MDgxIDIwLjMwODRMODYuMjMyIDExLjMyNDhIODYuNzkyNkw4OC4wOTI4IDIwLjMwODRIODQuOTA4MVoiIGZpbGw9IiNGRjA1NTgiLz4KICA8cGF0aCBkPSJNMTI1LjY4NiA2LjEzNTI1SDEyMC45NDNWMjcuNzIyMkgxMjUuNjg2QzEyOC4zNiAyNy43MjIyIDEzMC4xMjggMjYuNjc1NSAxMzAuOTkxIDI0Ljc1NjdDMTMxLjUwOCAyMy42MjI4IDEzMS42MzggMjIuNTc2MiAxMzEuNjM4IDE2LjkwNjlDMTMxLjYzOCAxMS4yODEyIDEzMS41MDggMTAuMjM0NiAxMzAuOTkxIDkuMTAwNzNDMTMwLjEyOCA3LjE4MTg5IDEyOC4zNiA2LjEzNTI1IDEyNS42ODYgNi4xMzUyNVpNMTI4LjM2IDIzLjUzNTZDMTI3LjkyOSAyNC41ODIzIDEyNy4wMjMgMjUuMTQ5MiAxMjUuNDI4IDI1LjE0OTJIMTIzLjc0NlY4LjcwODI0SDEyNS40MjhDMTI3LjAyMyA4LjcwODI0IDEyNy45MjkgOS4yNzUxNyAxMjguMzYgMTAuMzIxOEMxMjguNzA1IDExLjA2MzIgMTI4Ljc5MSAxMS43MTczIDEyOC43OTEgMTYuOTUwNUMxMjguNzkxIDIyLjE0MDEgMTI4LjcwNSAyMi43OTQyIDEyOC4zNiAyMy41MzU2WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xNDcuMDc2IDYuMTM1MjVIMTQyLjgwN0wxMzguODM5IDI3LjcyMjJIMTQxLjY0MkwxNDIuMzMyIDIzLjM2MTJIMTQ3LjUwN0wxNDguMjQgMjcuNzIyMkgxNTFMMTQ3LjA3NiA2LjEzNTI1Wk0xNDIuNzY0IDIwLjkxOUwxNDQuODc3IDguNDAyOTdIMTQ0Ljk2M0wxNDcuMDc2IDIwLjkxOUgxNDIuNzY0WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xMzYuODEyIDYuMTM1MjVIMTM0LjAwOVYyNy43MjIySDEzNi44MTJWNi4xMzUyNVoiIGZpbGw9IiMyOTJBMzIiLz4KICA8cGF0aCBkPSJNMTAzLjk1MiA2LjEzNTI1SDk4Ljg2MzNWMjcuNzIyMkgxMDEuNjIzVjE3LjY0ODNIMTAzLjk1MkMxMDYuMTA4IDE3LjY0ODMgMTA3LjQ4OCAxNy4wMzc3IDEwOC4wOTIgMTUuNjg1OEMxMDguMzk0IDE0LjkwMDggMTA4LjQ4IDE0LjI5MDMgMTA4LjQ4IDExLjg5MThDMTA4LjQ4IDkuNDkzMjIgMTA4LjM5NCA4LjgzOTA3IDEwOC4wOTIgOC4xNDEzMUMxMDcuNDg4IDYuNzQ1NzkgMTA2LjEwOCA2LjEzNTI1IDEwMy45NTIgNi4xMzUyNVpNMTA1LjQ2MSAxNC4xMTU5QzEwNS4xNTkgMTQuOTAwOCAxMDQuNDI2IDE1LjA3NTMgMTAzLjI2MiAxNS4wNzUzSDEwMS42MjNWOC41MzM4SDEwMy4yNjJDMTA0LjQyNiA4LjUzMzggMTA1LjE1OSA4Ljc1MTg1IDEwNS40NjEgOS40OTMyMkMxMDUuNjM0IDkuODg1NzEgMTA1LjY3NyAxMC4xMDM4IDEwNS42NzcgMTEuODA0NUMxMDUuNjc3IDEzLjQ2MTcgMTA1LjYzNCAxMy43NjcgMTA1LjQ2MSAxNC4xMTU5WiIgZmlsbD0iIzI5MkEzMiIvPgogIDxwYXRoIGQ9Ik0xMTAuNTA3IDI3LjcyMjJIMTE4LjM1NVYyNS4xNDkySDExMy4zMVYxNy41NjExSDExOC4yMjZWMTQuOTg4MUgxMTMuMzFWOC43MDgyNEgxMTguMzU1VjYuMTM1MjVIMTEwLjUwN1YyNy43MjIyWiIgZmlsbD0iIzI5MkEzMiIvPgo8L3N2Zz4K" width="198px" height="38.03px">
                </div>
                <h2 class="login_signup-modal-title">회원가입</h2>
                <section>
                    <div class="mx20">
                        <form id="signupForm" class="form">

                            <div class="py4">
                                <label class="login_signup-label-input">
                                    <div class="login_signup-div-input">
                                        <input autocomplete="off" placeholder="이름" type="text" name="name" class="login_signup-input" value="">
                                    </div>
                                </label>
                            </div>

                            <div class="py4">
                                <label class="login_signup-label-input">
                                    <div class="login_signup-div-input">
                                        <input autocomplete="off" placeholder="이메일" type="email" name="email" class="login_signup-input" value="">
                                    </div>
                                </label>
                            </div>
                            
                            <div class="py4">
                                <label class="login_signup-label-input">
                                    <div class="login_signup-div-input">
                                        <input autocomplete="off" placeholder="비밀번호" type="password" name="password" class="login_signup-input" value="">
                                    </div>
                                </label>
                            </div>
                            <button type="button" class="login_signup-btn">회원가입</button>
                        </form>
                        <div class="textstyle-modal mt20_mb14">
                            이미 가입하셨나요?
                            <button type="button" id="switchToLoginBtn" data-modal="#loginModal" class="text-button" onclick="modalClose(), modalOpen(this)">로그인</button>
                        </div>
                        <hr>
                        <ul class="ul-otherLogin">
                            <li>
                                <button class="li-kakao" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTIuMDM5NCAxOC4zQzE3LjAzMTggMTguMyAyMS4wNzg5IDE1LjA5ODggMjEuMDc4OSAxMS4xNUMyMS4wNzg5IDcuMjAxMTYgMTcuMDMxOCA0IDEyLjAzOTQgNEM3LjA0NzA5IDQgMyA3LjIwMTE2IDMgMTEuMTVDMyAxMy43MjQ5IDQuNzIwNzUgMTUuOTgxOSA3LjMwMjI5IDE3LjI0MDdDNy4wMzYwNyAxOC4zNTU0IDYuNTY4NTUgMjAuMzE5OCA2LjU1MTQ3IDIwLjQzODVDNi41Mjc1NCAyMC42MDQ4IDYuNzE5MjUgMjAuNzQwNiA2Ljg4NzU4IDIwLjYyNTFDNy4wMTA1IDIwLjU0MDggOS4yNTI5NSAxOS4wMTAyIDEwLjQ1NDEgMTguMTkwNEMxMC45Njg4IDE4LjI2MjQgMTEuNDk4NiAxOC4zIDEyLjAzOTQgMTguM1oiIGZpbGw9IiMzQzFFMUUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>                      
                            <li>
                                <button class="li-google" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMjAuNjQgMTIuMjA0MkMyMC42NCAxMS41NjYgMjAuNTgyNyAxMC45NTI0IDIwLjQ3NjQgMTAuMzYzM0gxMlYxMy44NDQ2SDE2Ljg0MzZDMTYuNjM1IDE0Ljk2OTYgMTYuMDAwOSAxNS45MjI4IDE1LjA0NzcgMTYuNTYxVjE4LjgxOTJIMTcuOTU2NEMxOS42NTgyIDE3LjI1MjQgMjAuNjQgMTQuOTQ1MSAyMC42NCAxMi4yMDQyVjEyLjIwNDJaIiBmaWxsPSIjNDI4NUY0Ii8+CiAgICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjk5OTggMjFDMTQuNDI5OCAyMSAxNi40NjcgMjAuMTk0MSAxNy45NTYxIDE4LjgxOTVMMTUuMDQ3NSAxNi41NjEzQzE0LjI0MTYgMTcuMTAxMyAxMy4yMTA3IDE3LjQyMDQgMTEuOTk5OCAxNy40MjA0QzkuNjU1NjcgMTcuNDIwNCA3LjY3MTU4IDE1LjgzNzIgNi45NjM4NSAxMy43MUgzLjk1NzAzVjE2LjA0MThDNS40Mzc5NCAxOC45ODMxIDguNDgxNTggMjEgMTEuOTk5OCAyMVYyMVoiIGZpbGw9IiMzNEE4NTMiLz4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNNi45NjQwOSAxMy43MDk4QzYuNzg0MDkgMTMuMTY5OCA2LjY4MTgyIDEyLjU5MyA2LjY4MTgyIDExLjk5OThDNi42ODE4MiAxMS40MDY2IDYuNzg0MDkgMTAuODI5OCA2Ljk2NDA5IDEwLjI4OThWNy45NTgwMUgzLjk1NzI3QzMuMzQ3NzMgOS4xNzMwMSAzIDEwLjU0NzYgMyAxMS45OTk4QzMgMTMuNDUyMSAzLjM0NzczIDE0LjgyNjYgMy45NTcyNyAxNi4wNDE2TDYuOTY0MDkgMTMuNzA5OFYxMy43MDk4WiIgZmlsbD0iI0ZCQkMwNSIvPgogICAgPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xMi4wNDI3IDYuNTc5NTVDMTMuMzY0MSA2LjU3OTU1IDE0LjU1MDUgNy4wMzM2NCAxNS40ODMyIDcuOTI1NDVMMTguMDY0NSA1LjM0NDA5QzE2LjUwNTkgMy44OTE4MiAxNC40Njg2IDMgMTIuMDQyNyAzQzguNTI0NTUgMyA1LjQ4MDkxIDUuMDE2ODIgNCA3Ljk1ODE4TDcuMDA2ODIgMTAuMjlDNy43MTQ1NSA4LjE2MjczIDkuNjk4NjQgNi41Nzk1NSAxMi4wNDI3IDYuNTc5NTVWNi41Nzk1NVoiIGZpbGw9IiNFQTQzMzUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>
                            <li>
                                <button class="li-twitter" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNOC40NzUzNSAxOS43QzE1LjY0NTUgMTkuNyAxOS41NjY1IDEzLjg1MjcgMTkuNTY2NSA4Ljc4MjM1QzE5LjU2NjUgOC42MTYxOSAxOS41NjMxIDguNDUwNzggMTkuNTU1MyA4LjI4NjI3QzIwLjMxNjQgNy43NDQ3MSAyMC45NzggNy4wNjg5NCAyMS41IDYuMjk5NTFDMjAuODAxNSA2LjYwNDg5IDIwLjA0OTggNi44MTA3NyAxOS4yNjEzIDYuOTAzNTRDMjAuMDY2MiA2LjQyODYzIDIwLjY4NDEgNS42NzY5MyAyMC45NzU0IDQuNzgwOTlDMjAuMjIyMSA1LjIyMDUxIDE5LjM4ODIgNS41NDAxOCAxOC41MDAzIDUuNzEyMzJDMTcuNzg5IDQuOTY2NTIgMTYuNzc1OSA0LjUgMTUuNjU0OSA0LjVDMTMuNTAyIDQuNSAxMS43NTYyIDYuMjE4NDkgMTEuNzU2MiA4LjMzNjkyQzExLjc1NjIgOC42MzgxMSAxMS43OTA1IDguOTMwODUgMTEuODU3MyA5LjIxMTg0QzguNjE3NjIgOS4wNTE1MiA1Ljc0NDgyIDcuNTI0NTQgMy44MjI0IDUuMjAyNzhDMy40ODczMiA1Ljc2OTcgMy4yOTQ1IDYuNDI4NjMgMy4yOTQ1IDcuMTMxMzRDMy4yOTQ1IDguNDYyNjggMy45ODI2OCA5LjYzNzg5IDUuMDI5MTMgMTAuMzI1NEM0LjM4OTgyIDEwLjMwNiAzLjc4OTA0IDEwLjEzMzEgMy4yNjM2NSA5Ljg0NTM0QzMuMjYyNzQgOS44NjEzNSAzLjI2Mjc0IDkuODc3NDMgMy4yNjI3NCA5Ljg5NDI3QzMuMjYyNzQgMTEuNzUyOSA0LjYwNjY0IDEzLjMwNDMgNi4zOTAxNCAxMy42NTYxQzYuMDYyOCAxMy43NDM4IDUuNzE4MjIgMTMuNzkxMSA1LjM2MjU0IDEzLjc5MTFDNS4xMTE0NCAxMy43OTExIDQuODY3MTcgMTMuNzY2NiA0LjYyOTc1IDEzLjcyMTlDNS4xMjYwMyAxNS4yNDY0IDYuNTY1MDEgMTYuMzU1OCA4LjI3MTM2IDE2LjM4NzFDNi45MzY5NiAxNy40MTYyIDUuMjU2MjkgMTguMDI5NSAzLjQyOTk0IDE4LjAyOTVDMy4xMTUzNyAxOC4wMjk1IDIuODA1MTQgMTguMDExOSAyLjUgMTcuOTc2NEM0LjIyNTI4IDE5LjA2NDcgNi4yNzM2MyAxOS43IDguNDc1MzUgMTkuNyIgZmlsbD0id2hpdGUiLz4KPC9zdmc+Cg==" class="css-1hfgk44">
                                </button></li>
                            <li>
                                <button class="li-apple" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBkPSJNMTQuNTk1NyA1LjAzMTc5QzEzLjk1NTYgNS44MDQ4MyAxMi44ODA1IDYuMzg0NjIgMTIuMDIyOSA2LjM4NDYyQzExLjkyNjMgNi4zODQ2MiAxMS44Mjk3IDYuMzcyNTQgMTEuNzY5MyA2LjM2MDQ2QzExLjc1NzIgNi4zMTIxNCAxMS43MzMgNi4xNjcyIDExLjczMyA2LjAyMjI1QzExLjczMyA1LjAzMTc5IDEyLjIyODMgNC4wNjU0OCAxMi43NzE4IDMuNDQ5NDZDMTMuNDYwMyAyLjY0MDE4IDE0LjYwNzggMi4wMzYyNCAxNS41NjIgMkMxNS41ODYyIDIuMTA4NzEgMTUuNTk4MyAyLjI0MTU4IDE1LjU5ODMgMi4zNzQ0NEMxNS41OTgzIDMuMzUyODMgMTUuMTc1NSA0LjMzMTIxIDE0LjU5NTcgNS4wMzE3OVpNMTAuMzk1MSAyMC42Mzk5QzkuOTY0NjMgMjAuODI0OCA5LjU1NjcxIDIxIDkuMDAzMjMgMjFDNy44MTk1IDIxIDYuOTk4MTQgMTkuOTEyOSA2LjA1NiAxOC41ODQyQzQuOTU2ODIgMTcuMDE0IDQuMDYyOTkgMTQuNTg2MSA0LjA2Mjk5IDEyLjI5MTJDNC4wNjI5OSA4LjU5NTA0IDYuNDY2NjggNi42MzgyNyA4LjgzNDEzIDYuNjM4MjdDOS41MjUxMiA2LjYzODI3IDEwLjE1NjUgNi44OTE2NCAxMC43MTc5IDcuMTE2OTNDMTEuMTY3MyA3LjI5NzI4IDExLjU3MTkgNy40NTk2MyAxMS45MjYzIDcuNDU5NjNDMTIuMjMzNyA3LjQ1OTYzIDEyLjYxNjkgNy4zMDgyMyAxMy4wNjM0IDcuMTMxNzdDMTMuNjg3MSA2Ljg4NTMxIDE0LjQzNDUgNi41ODk5NiAxNS4yNzIxIDYuNTg5OTZDMTUuODAzNiA2LjU4OTk2IDE3Ljc0ODMgNi42MzgyNyAxOS4wMjg3IDguNDc0MjVDMTkuMDIxMyA4LjQ3OTk2IDE5LjAwNTcgOC40OTAyOSAxOC45ODI5IDguNTA1MzVDMTguNjY3OCA4LjcxMzMyIDE2Ljk4NzMgOS44MjI2OSAxNi45ODczIDEyLjA5NzlDMTYuOTg3MyAxNC45MTIzIDE5LjQzOTMgMTUuOTE0OCAxOS41MjM5IDE1LjkzOUMxOS41MjE3IDE1Ljk0NDQgMTkuNTE2NyAxNS45NTk5IDE5LjUwODggMTUuOTg0NUMxOS40MjgyIDE2LjIzNCAxOS4wNDM5IDE3LjQyMzIgMTguMjE5NCAxOC42MzI1QzE3LjQxMDEgMTkuNzkyMSAxNi41NTI1IDIwLjk3NTggMTUuMjcyMSAyMC45NzU4QzE0LjY0MTEgMjAuOTc1OCAxNC4yMzkgMjAuNzk3OCAxMy44MjM4IDIwLjYxMzlDMTMuMzgwNyAyMC40MTc3IDEyLjkyMjggMjAuMjE0OSAxMi4xNTU4IDIwLjIxNDlDMTEuMzg0NyAyMC4yMTQ5IDEwLjg3NTggMjAuNDMzNCAxMC4zOTUxIDIwLjYzOTlaIiBmaWxsPSJ3aGl0ZSIvPgo8L3N2Zz4K" class="css-1hfgk44">
                                </button>
                            </li>
                            <li>
                                <button class="li-line" type="button">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGNsaXAtcGF0aD0idXJsKCNjbGlwMF8yNjMzXzIxNjkpIj4KICAgICAgICA8cGF0aCBkPSJNMjIgMTAuNjE2MkMyMiA2LjEzNjM2IDE3LjUxMDggMi41IDEyIDIuNUM2LjQ4OTIyIDIuNSAyIDYuMTM2MzYgMiAxMC42MTYyQzIgMTQuNjI3NSA1LjU2MTM5IDE3Ljk4MjcgMTAuMzU5OSAxOC42MkMxMC42ODc5IDE4LjY5NDkgMTEuMTI4NCAxOC44MzU1IDExLjI0MDkgMTkuMTE2N0MxMS4zNDQgMTkuMzY5NyAxMS4zMDY1IDE5Ljc2MzQgMTEuMjY5IDIwLjAxNjRDMTEuMjY5IDIwLjAxNjQgMTEuMTQ3MSAyMC43MTkzIDExLjEyODQgMjAuODY5M0MxMS4wODE1IDIxLjEyMjMgMTAuOTMxNiAyMS44NTMzIDExLjk5MDYgMjEuNDEyOEMxMy4wNTkgMjAuOTYzIDE3Ljc0NTEgMTguMDIwMiAxOS44NDQ0IDE1LjYxMTVDMjEuMzA2NSAxNC4wMTgzIDIyIDEyLjQwNjMgMjIgMTAuNjE2MlpNOC40NjY3MyAxMy4wMDYxQzguNDY2NzMgMTMuMTA5MiA4LjM4MjM4IDEzLjE5MzUgOC4yNzkyOSAxMy4xOTM1SDUuNDc3MDRDNS4zNzM5NSAxMy4xOTM1IDUuMjg5NiAxMy4xMDkyIDUuMjg5NiAxMy4wMDYxVjguNjM4NzFDNS4yODk2IDguNTM1NjEgNS4zNzM5NSA4LjQ1MTI3IDUuNDc3MDQgOC40NTEyN0g2LjE4OTMyQzYuMjkyNDEgOC40NTEyNyA2LjM3Njc2IDguNTM1NjEgNi4zNzY3NiA4LjYzODcxVjEyLjEwNjRIOC4yNzkyOUM4LjM4MjM4IDEyLjEwNjQgOC40NjY3MyAxMi4xOTA3IDguNDY2NzMgMTIuMjkzOFYxMy4wMDYxWk0xMC4xNjMxIDEzLjAwNjFDMTAuMTYzMSAxMy4xMDkyIDEwLjA3ODcgMTMuMTkzNSA5Ljk3NTYzIDEzLjE5MzVIOS4yNjMzNkM5LjE2MDI2IDEzLjE5MzUgOS4wNzU5MSAxMy4xMDkyIDkuMDc1OTEgMTMuMDA2MVY4LjYzODcxQzkuMDc1OTEgOC41MzU2MSA5LjE2MDI2IDguNDUxMjcgOS4yNjMzNiA4LjQ1MTI3SDkuOTc1NjNDMTAuMDc4NyA4LjQ1MTI3IDEwLjE2MzEgOC41MzU2MSAxMC4xNjMxIDguNjM4NzFWMTMuMDA2MVpNMTQuOTg5NyAxMy4wMDYxQzE0Ljk4OTcgMTMuMTA5MiAxNC45MDUzIDEzLjE5MzUgMTQuODAyMiAxMy4xOTM1SDE0LjA5QzE0LjA3MTIgMTMuMTkzNSAxNC4wNTI1IDEzLjE5MzUgMTQuMDQzMSAxMy4xODQySDE0LjAzMzdDMTQuMDMzNyAxMy4xODQyIDE0LjAzMzcgMTMuMTg0MiAxNC4wMjQ0IDEzLjE4NDJIMTQuMDE1SDE0LjAwNTZDMTQuMDA1NiAxMy4xODQyIDE0LjAwNTYgMTMuMTg0MiAxMy45OTYzIDEzLjE4NDJMMTMuOTg2OSAxMy4xNzQ4QzEzLjk2ODEgMTMuMTY1NCAxMy45NDk0IDEzLjE0NjcgMTMuOTQgMTMuMTI3OUwxMS45MzQ0IDEwLjQxOTRWMTMuMDA2MUMxMS45MzQ0IDEzLjEwOTIgMTEuODUgMTMuMTkzNSAxMS43NDcgMTMuMTkzNUgxMS4wMzQ3QzEwLjkzMTYgMTMuMTkzNSAxMC44NDcyIDEzLjEwOTIgMTAuODQ3MiAxMy4wMDYxVjguNjM4NzFDMTAuODQ3MiA4LjUzNTYxIDEwLjkzMTYgOC40NTEyNyAxMS4wMzQ3IDguNDUxMjdIMTEuNzM3NkMxMS43Mzc2IDguNDUxMjcgMTEuNzM3NiA4LjQ1MTI3IDExLjc0NyA4LjQ1MTI3SDExLjc1NjNIMTEuNzY1N0gxMS43NzUxSDExLjc4NDRDMTEuNzg0NCA4LjQ1MTI3IDExLjc4NDQgOC40NTEyNyAxMS43OTM4IDguNDUxMjdIMTEuODAzMkMxMS44MDMyIDguNDUxMjcgMTEuODAzMiA4LjQ1MTI3IDExLjgxMjYgOC40NTEyN0MxMS44MTI2IDguNDUxMjcgMTEuODIxOSA4LjQ1MTI3IDExLjgyMTkgOC40NjA2NEMxMS44MjE5IDguNDYwNjQgMTEuODIxOSA4LjQ2MDY0IDExLjgzMTMgOC40NjA2NEMxMS44MzEzIDguNDYwNjQgMTEuODQwNyA4LjQ2MDY0IDExLjg0MDcgOC40NzAwMUMxMS44NDA3IDguNDcwMDEgMTEuODQwNyA4LjQ3MDAxIDExLjg1IDguNDcwMDFDMTEuODUgOC40NzAwMSAxMS44NTk0IDguNDcwMDEgMTEuODU5NCA4LjQ3OTM4QzExLjg1OTQgOC40NzkzOCAxMS44NTk0IDguNDc5MzggMTEuODY4OCA4LjQ3OTM4TDExLjg3ODIgOC40ODg3NUwxMS44ODc1IDguNDk4MTNDMTEuODk2OSA4LjUwNzUgMTEuODk2OSA4LjUwNzUgMTEuOTA2MyA4LjUxNjg3TDEzLjkwMjUgMTEuMjM0OFY4LjYzODcxQzEzLjkwMjUgOC41MzU2MSAxMy45ODY5IDguNDUxMjcgMTQuMDkgOC40NTEyN0gxNC44MDIyQzE0LjkwNTMgOC40NTEyNyAxNC45ODk3IDguNTM1NjEgMTQuOTg5NyA4LjYzODcxVjEzLjAwNjFaTTE4Ljg2MDQgOS4zNTA5OEMxOC44NjA0IDkuNDU0MDggMTguNzc2IDkuNTM4NDMgMTguNjcyOSA5LjUzODQzSDE2Ljc2MVYxMC4yNzg4SDE4LjY3MjlDMTguNzc2IDEwLjI3ODggMTguODYwNCAxMC4zNjMyIDE4Ljg2MDQgMTAuNDY2M1YxMS4xNzg1QzE4Ljg2MDQgMTEuMjgxNiAxOC43NzYgMTEuMzY2IDE4LjY3MjkgMTEuMzY2SDE2Ljc2MVYxMi4xMDY0SDE4LjY3MjlDMTguNzc2IDEyLjEwNjQgMTguODYwNCAxMi4xOTA3IDE4Ljg2MDQgMTIuMjkzOFYxMy4wMDYxQzE4Ljg2MDQgMTMuMTA5MiAxOC43NzYgMTMuMTkzNSAxOC42NzI5IDEzLjE5MzVIMTUuODcwN0MxNS43Njc2IDEzLjE5MzUgMTUuNjgzMiAxMy4xMDkyIDE1LjY4MzIgMTMuMDA2MVY4LjY0ODA4QzE1LjY4MzIgOC41NDQ5OSAxNS43Njc2IDguNDYwNjQgMTUuODcwNyA4LjQ2MDY0SDE4LjY3MjlDMTguNzc2IDguNDYwNjQgMTguODYwNCA4LjU0NDk5IDE4Ljg2MDQgOC42NDgwOFY5LjM1MDk4WiIgZmlsbD0id2hpdGUiLz4KICAgIDwvZz4KICAgIDxkZWZzPgogICAgICAgIDxjbGlwUGF0aCBpZD0iY2xpcDBfMjYzM18yMTY5Ij4KICAgICAgICAgICAgPHJlY3Qgd2lkdGg9IjIwIiBoZWlnaHQ9IjE5LjA1MzQiIGZpbGw9IndoaXRlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyIDIuNSkiLz4KICAgICAgICA8L2NsaXBQYXRoPgogICAgPC9kZWZzPgo8L3N2Zz4K" class="css-1hfgk44">
                                </button>
                            </li>
                        </ul>
                    </div>
                </section>
            </div>
        </div>
    </div>

			

</body>
</html>