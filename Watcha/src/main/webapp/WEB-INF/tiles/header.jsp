<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<% String ctxPath = request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%=ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
    
<!-- Optional JavaScript -->
<script src="<%=ctxPath%>/js/jquery-3.6.4.min.js" type="text/javascript"></script>
<script src="<%=ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>

<!-- Font Awesome 6 Icons --> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<!-- 글꼴 적용하기 -->
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />

<%-- <link rel="icon" href="<%=ctxPath%>/images/파비콘.ico"> --%>

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
	  const button = $('<button>', { class: 'position-absolute btn-search1' }).append($('<i>', { class: 'fa-solid fa-magnifying-glass' }));
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
	
	function goNewMember() {
		// 회원가입 하러 가기 모달창?? 
		alert("회원가입 ");
	}


	
</script>




<title>Insert title here</title>
</head>
<body>
	<div class="d-none d-md-block">
		<div class="container">
			<div class="row">
				<ul style="display: flex; padding: 0; margin: 0; overflow: hidden; width: 100%;">
					<li style="list-style: none;">
						<a href="#"><img src="./images/watchapedia.png" style="top: 10%; position: relative; width: 85%;"></a>
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
							 <a href="#" class="header-a"><span class="header-login"></span></a> 
						<!-- </c:if> -->
						
						
						<!-- <c:if test="">  로그인 되어 있으면 평가하기 나타내기 -->
							<!-- <a href="#" class="header-a"><span class="header-star"></span></a> -->
						<!-- </c:if> -->
						
					</li>
					<li class="header-main-li" style="margin-left: 24px;">
						
						<!-- <c:if test="">  로그인 안 되어 있으면 나타내기 -->	
							 <button type="button" style="border-radius: 5px; bottom: 2px; position: relative; background-color: white; border: solid 1px #999999;"  onclick="goNewMember()">회원가입</button> 
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

</body>
</html>