<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>     

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>

<!-- slick 이용하기 위한 링크 -->
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />


<style type="text/css">

	
	/* 로그인 회원가입 modal 띄우면, 메인페이지 스크롤 잠그기 */
 	.disableBodyScrolling {
	    overflow: hidden !important;
	} 

  .main-h5 {
    font-weight: bold;
    text-align: left;
    left: 13px;
    position: relative;
  }
  
  .main-h5-2 {
  	margin-top: 40px;
  }
  
  .main-ad-span {
  	font-size: 10pt;
  	padding-left: 10px;
  	display: block;
  }
  
  .centered-container {
	display: flex;
	justify-content: center;
	align-items: center;
  }
  
  .Main-card {
  	border: none;
  	height: 430px;
  }
  
  .Main-card-header {
  	height: 300px;
  	padding: 0 10px;
  }
  
  .Main-card-header-fin {
  	height: 50%;
  	padding: 0;
  	display: flex;
  	background-color: gray;
  }
  
  .Main-card-header > img {  	
  	height: 300px;
  }
  
  .Main-card-body {
  	padding: 10px 10px 0 10px;
  	height: 100px;
  	font-size: 11pt;
  	color: black;
  }
  
  .Main-card-body > h5{
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 13pt;
  }
  
  .Main-card2 {
  	border: none;
  	height: 350px;
  }
  
  .Main-card-header2 {
  	height: 200px;
  	padding: 0 10px;
  }
  
  .Main-card-header2 > img {  	
  	height: 200px;
  }
  
  .Main-card-body2 {
  	padding: 10px 10px 0 10px;
  	height: 100px;
  	font-size: 11pt;
  	color: black;
  }
  
  .Main-card-body2 > h5{
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 13pt;
  }
  
  .Main-card-body3 > h5 {
  	font-size: 13pt;
  	padding: 0 10px;
  	color: black;
  }
  
  .Main-card4 {
  	border: none;
  	height: 350px;
  }
  
  .card-img-top {
  	border: solid 1px #e6e6e6;
  }
  
  .card-img-top-fin {
  	width: 50%;
  	padding: 1px;
  }

  
  .Main-a:hover {
  	text-decoration-line: none;
  }
  
  .slick-prev:before {
		color: gray;
    	font-size: xx-large;
  }
	
  .slick-next:before {
		color: gray;
    	font-size: xx-large;
    	right: 13px;
   		position: relative;
  }

  .centered-container > a{
  	color: black;
  }
  
  .centered-container > a:hover{
  	text-decoration-line: none;
  }
  
  .Main-card-in-no {
  	position: relative;
    bottom: 24px;
  }
  
  .main-number {
  	bottom: 290px;
    position: relative;
    left: 15px;
    background-color: rgba(0, 0, 0, 0.77);
    color: rgb(255, 255, 255);
    font-weight: 700;
    letter-spacing: normal;
    font-size: 14px;
    line-height: 22px;
    text-align: center;
    width: 24px;
    height: 24px;
    border-radius: 4px;
    opacity: 1;
    transition: opacity 300ms ease 0s;
  }


   
  
  
  @media (max-width: 768px) {
	    .carousel-inner .carousel-item > div {
		    display: none;
		  }
		  .carousel-inner .carousel-item > div:nth-child(-n+2) {
		    display: block;
		  }
		  .main-ad-btn{
			position: relative; 
			bottom: 35px;
			margin-left: 10px;
		}
		  
	}
	
	.carousel-inner .carousel-item.active,
	.carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	    display: flex;
	}
	
	/* display 3 */
	@media (min-width: 768px) {
		.main-ad-div {
		  	display: flex;
		}
		.main-ad-btn{
			margin: 10% 5% 5% 5%; 
			width: 92%;
		}
	}
	
	
	
	
	/* ////////////////////////////////////////////////////// */


	
/* 	img.card-size {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    height: 100%;
    }  */
	

</style>




<script type="text/javascript">

$(document).ready(function() {
/* 	let resizeTimer;						// 창 크기가 빠르게 변경되면 안되는 현상을 고치기 위해 타임아웃 사용
	$(window).on('resize', function() {    // 창 크기가 변경될 때마다 다시 실행 
	    clearTimeout(resizeTimer);			// 타임아웃 사용 (일정시간 지난후에 실행한다.)
	    resizeTimer = setTimeout(function() {
	        CarouselGO();
	    }, 150); // 150ms의 딜레이를 사용하여 타임아웃 설정
	}); */
	Carousel();
	//StarRank();
	
	
});
		
function Carousel(){
	
    $('.main-carousel-card').slick({
    	  dots: false,     /* 밑에 점으로 표시되는것  */
    	  infinite: false,  /* 반복할것인지 파악하기 */
    	  speed: 300,		/* 슬라이드 스피드 */
    	  slidesToShow: 5,	/* 몇개씩 보여줄것인지 파악 */
    	  slidesToScroll: 5,	/* 몇개씩 넘길것인지 파악 */
    	  responsive: [
    	    {
    	      breakpoint: 1024,		/* 사이즈가 1024 보다 작으면 시작 */
    	      settings: {  
      	        dots: false,
      	        infinite: false,  
    	    	slidesToShow: 4,
    	        slidesToScroll: 4
    	      }
    	    },
    	    {
    	      breakpoint: 768,
    	      settings: {
    	    	dots: false,
        	    infinite: false,   
    	        slidesToShow: 2,
    	        slidesToScroll: 2
    	      }
    	    }

    	  ]
    	});	
    
    
    $('.main-carousel-card2').slick({
  	  dots: false,     /* 밑에 점으로 표시되는것  */
  	  infinite: false,  /* 반복할것인지 파악하기 */
  	  speed: 300,		/* 슬라이드 스피드 */
  	  slidesToShow: 6,	/* 몇개씩 보여줄것인지 파악 */
  	  slidesToScroll: 6,	/* 몇개씩 넘길것인지 파악 */
  	  responsive: [
  	    {
  	      breakpoint: 1024,		/* 사이즈가 1024 보다 작으면 시작 */
  	      settings: {  
    	        dots: false,
    	        infinite: false,  
  	    	slidesToShow: 5,
  	        slidesToScroll: 5
  	      }
  	    },
  	    {
  	      breakpoint: 768,
  	      settings: {
  	    	dots: false,
      	    infinite: false,   
  	        slidesToShow: 3,
  	        slidesToScroll: 3
  	      }
  	    }

  	  ]
  	});	
}

<%-- // 평점 순위 일때 
function StarRank() {
	$.ajax({
		url:"<%= ctxPath%>/view/main.action",
		method:"GET",
		success:function(){
			console.log("안녕");
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
		
		
		
	});
}
 --%>


</script>

</head>
<body>

<div class="container" style="padding: 0;">
   <h5 class="h5 main-h5">평점 순위</h5>
   
	<div class="container my-3">
		
		<div class="card-deck main-carousel-card mb-1">
		  
		  <c:forEach var="starRankvo" items="${requestScope.starRankvo}" varStatus="status">
		  
			  <a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${starRankvo.movie_id}" title="${starRankvo.movie_title}" class="Main-a">
				  <div class="Main-card">
				  	<div class="Main-card-header">
				    	<img src="https://image.tmdb.org/t/p/w500/${starRankvo.poster_path}" class="card-img-top" alt="...">
				    </div>
				    <div class="main-number">${status.index + 1}</div>
				    <div class="Main-card-body Main-card-in-no">
				      <h5 class="card-title card-font" >${starRankvo.movie_title}</h5>
				      <p style="margin: 0;"><span class="text-muted">개봉일자 : ${starRankvo.release_date}</span></p>
				      <p style="margin: 0;"><span class="text-muted">언어 : ${starRankvo.original_language}</span></p>
				      <p><span class="text-muted">평균★<span id="">${starRankvo.rating_avg}</span></span></p>
				    </div>
				  </div>
			  </a> 
		  </c:forEach>
		</div>
	</div>	
	    
	
	
	<h5 class="h5 main-h5 main-h5-2">보고싶어요 순위</h5>
   	 <div class="container my-3">

		<div class="card-deck main-carousel-card mb-1">
		  
		 <c:forEach var="seeRankvo" items="${requestScope.seeRankvo}" varStatus="status">
		  
			  <a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${seeRankvo.movie_id}" title="${seeRankvo.movie_title}" class="Main-a">
				  <div class="Main-card">
				  	<div class="Main-card-header">
				    	<img src="https://image.tmdb.org/t/p/w500/${seeRankvo.poster_path}" class="card-img-top" alt="...">
				    </div>
				    <div class="main-number">${status.index + 1}</div>
				    <div class="Main-card-body Main-card-in-no">
				      <h5 class="card-title card-font" >${seeRankvo.movie_title}</h5>
				      <p style="margin: 0;"><span class="text-muted">개봉일자 : ${seeRankvo.release_date}</span></p>
				      <p style="margin: 0;"><span class="text-muted">언어 : ${seeRankvo.original_language}</span></p>
				      <p><span class="text-muted">평균★<span id="">${seeRankvo.rating_avg}</span></span></p>
				    </div>
				  </div>
			  </a> 
		  </c:forEach>
		  
		</div>
	</div>	  
	
	<h5 class="h5 main-h5 main-h5-3">한줄평 많은 순위</h5>
   	<div class="container my-3">

		<div class="card-deck main-carousel-card mb-1">
		  
		 <c:forEach var="commentRankvo" items="${requestScope.commentRankvo}" varStatus="status">
		  
			  <a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${commentRankvo.movie_id}" title="${commentRankvo.movie_title}" class="Main-a">
				  <div class="Main-card">
				  	<div class="Main-card-header">
				    	<img src="https://image.tmdb.org/t/p/w500/${commentRankvo.poster_path}" class="card-img-top" alt="...">
				    </div>
				    <div class="main-number">${status.index + 1}</div>
				    <div class="Main-card-body Main-card-in-no">
				      <h5 class="card-title card-font" >${commentRankvo.movie_title}</h5>
				      <p style="margin: 0;"><span class="text-muted">개봉일자 : ${commentRankvo.release_date}</span></p>
				      <p style="margin: 0;"><span class="text-muted">언어 : ${commentRankvo.original_language}</span></p>
				      <p><span class="text-muted">평균★<span id="">${commentRankvo.rating_avg}</span></span></p>
				    </div>
				  </div>
			  </a> 
		  </c:forEach>
		  
		</div>
	</div>	
	
	<%-- 광고 부분 --%>	   
	<div style="margin: 30px 0 ;">
		<div style="max-width: 60%; margin: 0px auto; text-align: left; border: solid 1px black;">
			<section>
				<div class="main-ad-div">
					<a href="https://www.frombio.co.kr/product/detail.html?product_no=797&cate_no=101&display_group=1&utm_source=watcha&utm_medium=da&utm_campaign=100deal&browser_open_type=external">
						<img src="<%= ctxPath%>/resources/images/광고.png" style="width: 100%; height: 100%;">	
					</a>
					<div class="centered-container">
					  <a href="https://www.frombio.co.kr/product/detail.html?product_no=797&cate_no=101&display_group=1&utm_source=watcha&utm_medium=da&utm_campaign=100deal&browser_open_type=external" style="padding: 5%">
					    <span class="main-ad-span">프롬바이오 100원 딜!</span>
					    <span class="main-ad-span">오직 여디서만,</span>
					    <span class="main-ad-span">건강즙이 100원</span>
					    <img src="<%= ctxPath%>/resources/images/광고1.png">
					    <button type="button" class="btn btn-danger main-ad-btn">구매하기</button>
					  </a>
					</div>

				</div>
			</section>
		</div>
	</div>
	
	<%-- 다시 캐러셀 --%>
	<!-- 로그인을 하고 평가를 1개라도 했을때   -->
	<c:if test="${not empty login_userid and not empty requestScope.actorCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">${login_username} 회원님이 많이 보신 
			<c:forEach items="${requestScope.actor}" var="rating">
	   			<span>${rating.actor_name}</span>
			</c:forEach>배우의 작품
		</h5>
	   	
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="movie" items="${requestScope.starRatings}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${movie.movie_id}" title="${movie.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${movie.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${movie.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${movie.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${movie.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${movie.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
			  
		</div>	
	</c:if>
	
	<!-- 로그인을 하고 평가를 안했을때 || 로그인을 안했을때   -->
	<c:if test="${empty login_userid || empty requestScope.actorCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">  화재의
			<c:if test="${not empty requestScope.actorCheckFinal}">   <!-- 결과값이 있을때 []괄호는 제거한다. -->
			    <c:set var="actorName" value="${requestScope.actorCheckFinal[0].actor}" />
 				<span>${fn:replace(fn:replace(actorName, '[', ''), ']', '')}</span>
			</c:if>
			배우의 작품
		</h5>
	   	
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="actorCheckFinal" items="${requestScope.actorCheckFinal}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${actorCheckFinal.movie_id}" title="${actorCheckFinal.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${actorCheckFinal.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${actorCheckFinal.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${actorCheckFinal.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${actorCheckFinal.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${actorCheckFinal.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
			  
		</div>	
	</c:if>
	
	
	<!-- 로그인을 했을때 그리고 평가를 하나라도 했을때   -->
	<c:if test="${not empty login_userid and not empty requestScope.actorCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">${login_username} 회원님이 많이 보신 
			<c:forEach items="${requestScope.genres}" var="genres">
	   			<span>${genres.genre_name}</span>
			</c:forEach>장르 TOP 10
		</h5>
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="starRating22" items="${requestScope.starRating22}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${starRating22.movie_id}" title="${starRating22.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${starRating22.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${starRating22.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${starRating22.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${starRating22.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${starRating22.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
		</div>	
	</c:if>
	
	<!-- 로그인을 했을때 그리고 평가를 안했을때 || 로그인을 안했을때   -->
	<c:if test="${empty login_userid || empty requestScope.actorCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">회원님들이 많이 보신 
			<c:forEach items="${requestScope.genres}" var="genres">
	   			<span>${genres.genre_name}</span>
			</c:forEach>장르 TOP 10
		</h5>
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="starRating22" items="${requestScope.starRating22}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${starRating22.movie_id}" title="${starRating22.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${starRating22.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${starRating22.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${starRating22.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${starRating22.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${starRating22.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
		</div>	
	</c:if>
	
	
	<!-- 로그인을 했을때 그리고 컬렉션이 하나라도 있을때   -->
	<c:if test="${not empty login_userid and not empty requestScope.celCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">${login_username} 회원님의 컬렉션</h5>
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="usercol" items="${requestScope.usercol}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${usercol.movie_id}" title="${usercol.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${usercol.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${usercol.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${usercol.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${usercol.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${usercol.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
		</div>	
	</c:if>
	
	<!-- 로그인을 했을때 그리고 콜렉션을 설정 안했을때 || 로그인을 안했을때   -->
	<c:if test="${empty login_userid || empty requestScope.celCheck}">
		<h5 class="h5 main-h5 main-h5-3 mt-5">포함된 영화가 가장 많은 컬렉션 </h5>
	   	 <div class="container my-3">
	
			<div class="card-deck main-carousel-card2 mb-1">
			  
			  <c:forEach var="collection" items="${requestScope.collection}" varStatus="status">
		        <a href="<%= ctxPath%>/view/project_detail.action?movie_id=${collection.movie_id}" title="${collection.movie_title}" class="Main-a">
		            <div class="Main-card2">
		                <div class="Main-card-header2">
		                    <img src="https://image.tmdb.org/t/p/w500/${collection.poster_path}" class="card-img-top" alt="...">
		                </div>
		                <div class="main-number">${status.index + 1}</div>
		                <div class="Main-card-body2 Main-card-in-no">
		                    <h5 class="card-title card-font">${collection.movie_title}</h5>
		                    <p style="margin: 0;"><span class="text-muted">개봉일자: ${collection.release_date}</span></p>
		                    <p style="margin: 0;"><span class="text-muted">언어 : ${collection.original_language}</span></p>
		                    <p><span class="text-muted">평균★<span id="">${collection.rating_avg}</span></span></p>
		                </div>
		            </div>
		        </a>
			</c:forEach>
			  
			  
			</div>
		</div>	
	</c:if>
	
		    
	
	<h5 class="h5 main-h5 main-h5-3">왓챠피디아 회원들의 컬렉션</h5>
   	 <div class="container my-3">

		<div class="card-deck main-carousel-card mb-5">
		  <c:forEach var="finduser" items="${requestScope.finduser}" varStatus="status">
			   
			   <c:set var="mergedCollectionIndex" value="${status.index}" />
			   
					  <a href = "" title="" class="Main-a">
						  <div class="Main-card4">
							  <div class="Main-card-header">
							  	<div class="Main-card-header-fin">
							  		 
				 				    	<c:if  test="${not empty requestScope.mergedCollectionFinal[mergedCollectionIndex][0].poster_path}">		
				 				    		<img src="https://image.tmdb.org/t/p/w500/${requestScope.mergedCollectionFinal[mergedCollectionIndex][0].poster_path}" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										<c:if  test="${empty requestScope.mergedCollectionFinal[mergedCollectionIndex][0].poster_path}">		
				 				    		<img src="<%= ctxPath%>/resources/images/이미지없음.png" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										
										<c:if  test="${not empty requestScope.mergedCollectionFinal[mergedCollectionIndex][1].poster_path}">		
				 				    		<img src="https://image.tmdb.org/t/p/w500/${requestScope.mergedCollectionFinal[mergedCollectionIndex][1].poster_path}" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										<c:if  test="${empty requestScope.mergedCollectionFinal[mergedCollectionIndex][1].poster_path}">		
				 				    		<img src="<%= ctxPath%>/resources/images/이미지없음.png" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
					                	
			 						 
							    </div>	
							    <div class="Main-card-header-fin">	
							    	
							    		<c:if  test="${not empty requestScope.mergedCollectionFinal[mergedCollectionIndex][2].poster_path}">		
				 				    		<img src="https://image.tmdb.org/t/p/w500/${requestScope.mergedCollectionFinal[mergedCollectionIndex][2].poster_path}" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										<c:if  test="${empty requestScope.mergedCollectionFinal[mergedCollectionIndex][2].poster_path}">		
				 				    		<img src="<%= ctxPath%>/resources/images/이미지없음.png" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										
										<c:if  test="${not empty requestScope.mergedCollectionFinal[mergedCollectionIndex][3].poster_path}">		
				 				    		<img src="https://image.tmdb.org/t/p/w500/${requestScope.mergedCollectionFinal[mergedCollectionIndex][3].poster_path}" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
										<c:if  test="${empty requestScope.mergedCollectionFinal[mergedCollectionIndex][3].poster_path}">		
				 				    		<img src="<%= ctxPath%>/resources/images/이미지없음.png" class="card-img-top card-img-top-fin" alt="...">
										</c:if>
	  						
							    </div>
						    </div>			 
						    <div class="Main-card-body3">
						      <h5 class="card-title card-font" >"${finduser.user_id}"<br>님의 컬렉션</h5>
						    </div>
						  </div>
					  </a>
					  
		  </c:forEach>
		  
		</div>
	</div>	
		    
</div>


</body>
</html>
