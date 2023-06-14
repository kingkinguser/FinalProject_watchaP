<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- slick 이용하기 위한 링크 -->
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />




<style type="text/css">

	.searchWord_header {
		border-bottom: solid 1px  #f2f2f2;
		background-color: #f8f9fa!important;
		padding: 12px 0 ;
		position: relative;
		bottom: 20px;
	}
	
	.searchWord_div_nav {
		margin-bottom: 10px; 
		position: relative;
		bottom: 20px;
		border-bottom: solid 1px #cccccc;
	}
	.searchWord_nav {
		padding-bottom: 0;
		background-color: white;
	}
	
	nav.navbar > ul.navbar-nav > li.nav-item > button.nav-link {
		border: none;
		background-color: white;
		margin-right: 10px;
	}
	
	
	/* 케러셀 부분 */
  .searchWord-card {
  	border: none;
  	height: 350px;
  }
  
  .searchWord-card-header {
  	height: 200px;
  	padding: 0 10px;
  }
  
  .searchWord-card-header > img {  	
  	height: 200px;
  }
  
  .searchWord-card-body {
  	padding: 10px 10px 0 10px;
  	height: 100px;
  	font-size: 11pt;
  	color: black;
  }
  
  .searchWord-card-body > h5{
  	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 13pt;
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

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#contants").css({'border-bottom': 'solid 1px black'});
		Carousel();
		
		/*영화 눌렀을때 */
		$("button#contants").click(function(){
			SearchContants();
		});
		
		/* 인물 눌렀을때  */
		$("button#people").click(function(){
			SearchPeople();
		});
		
		/* 컬렉션 눌렀을때 */
		$("button#collection").click(function(){
			SearchCollection();
		});
		
		/* 유저 눌렀을때 */
		$("button#user").click(function(){
			SearchUser();
		});

	});
	
	
	function Carousel(){
		
		 $('.searchWord-carousel-card').slick({
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
	
	// 더보기 눌렀을때 
	function moreMovie() {
		const searchText = $('input#lastSearchWord').val();
		const novalueInput = $('input#novalue').val();
		
		const FrmMovieSearchDetail = document.FrmMovieSearchDetail;
		FrmMovieSearchDetail.action="<%=ctxPath%>/goSearchDetail.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchDetail.method="get";
		FrmMovieSearchDetail.submit();	
	}
	
	
	
	// 영화 버튼을 눌렀을때 
	function SearchContants() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchMovie = document.FrmMovieSearchDetail;
		FrmMovieSearchMovie.action="<%=ctxPath%>/goSearch.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchMovie.method="get";
		FrmMovieSearchMovie.submit();	
	}
	
	
	// 인물 버튼을 눌렀을때 
	function SearchPeople() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchPeople = document.FrmMovieSearchDetail;
		FrmMovieSearchPeople.action="<%=ctxPath%>/goSearchPeople.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchPeople.method="get";
		FrmMovieSearchPeople.submit();	
		
	}
	
	// 컬렉션 버튼을 눌렀을때 
	function SearchCollection() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchCollection = document.FrmMovieSearchDetail;
		FrmMovieSearchCollection.action="<%=ctxPath%>/goSearchCollection.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchCollection.method="get";
		FrmMovieSearchCollection.submit();	
		
	}
	
	// 유저 버튼을 눌렀을때 
	function SearchUser() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchUser = document.FrmMovieSearchDetail;
		FrmMovieSearchUser.action="<%=ctxPath%>/goSearchUser.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchUser.method="get";
		FrmMovieSearchUser.submit();	
		
	}
	
	
</script>


</head>
<body>

	<div class="searchWord_header">
		<div class="container">
			<span class="h5" style="margin: 0;">"  <c:out value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />  "의 검색결과</span>  <!-- 스크립트 공격 방어 -->
			<span>[ 영화 검색결과 숫자 : ${requestScope.total_count} 개 ]</span>
		</div>
	</div>
		
		
	<div class="container">
		
		<div class="searchWord_div_nav">
			<nav class="navbar  navbar-expand  navbar-light searchWord_nav">
		
			  <ul class="navbar-nav">
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="0" id="contants">영화</button>
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="1" id="people">인물</button>			      
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="2" id="collection">컬렉션</button>	
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="3" id="user">유저</button>	
			    </li>
			  </ul>
			</nav>
		</div>
		
		<div>
			<c:if test="${empty requestScope.showMovie}">
				<div style='text-align: center; padding: 100px 0;' class='h4'>
					<p style='margin-bottom: 40px;'><i class='fa-solid fa-question fa-2xl' style='color: #9a9da2;'></i></p>
					<p class="h4 mb-4" style="text-align: center;">검색한 영화 정보가 없습니다.</p>
				</div>
			</c:if>
			<c:if test="${not empty requestScope.showMovie}">
				<span class="h5 mb-4">찾으신 영화가 없으면 영화 더보기를 눌러주세요</span>
				<button type="button"  class="btn btn-outline-danger" style="float: right; bottom: 5px; position: relative;" onclick="moreMovie()">더보기</button>
			</c:if>
			<form id="FrmMovieSearchDetail" name="FrmMovieSearchDetail">
				<input type="hidden" id="novalue" name="novalue" value="0"/>
				<input type="hidden" id="lastSearchWord" name="lastSearchWord" value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />
			</form>
		</div>
		
		<div class="container my-4" style="border-bottom: solid 1px #cccccc;">
			<div class="card-deck searchWord-carousel-card mb-1" style="border-bottom: 1px black;">
			  
			  <c:forEach var="showMovie" items="${requestScope.showMovie}" varStatus="status">
			  
				  <a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${showMovie.movie_id}" title="${showMovie.movie_title}" class="Main-a">
					  <div class="searchWord-card">
					  	<div class="searchWord-card-header">
					    	<img src="https://image.tmdb.org/t/p/w500/${showMovie.poster_path}" class="card-img-top" alt="...">
					    </div>					   
					    <div class="searchWord-card-body Main-card-in-no">
					      <h5 class="card-title card-font" >${showMovie.movie_title}</h5>
					      <p style="margin: 0;"><span class="text-muted">개봉일자 : ${showMovie.release_date}</span></p>
					      <p style="margin: 0;"><span class="text-muted">언어 : ${showMovie.original_language}</span></p>
					      <p><span class="text-muted">평균★<span id="">${showMovie.rating_avg}</span></span></p>
					    </div>
					  </div>
				  </a> 
			  </c:forEach>
			</div>
		</div>	 

		
	</div>
</body>
</html>