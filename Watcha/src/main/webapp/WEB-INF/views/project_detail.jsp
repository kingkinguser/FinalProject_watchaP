<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String ctxPath = request.getContextPath();
%>     
    
<!DOCTYPE html>
<html>

<head>

<style type="text/css">

	body {
		word-break: break-all; /* 공백없이 영어로만 되어질 경우 해당구역을 뚫고 빠져나감으로 이것을 막기 위해서 사용한다 */
		padding: 0;            /* 상 우 하 좌 모두 안쪽여백을 0px을 준 것이다. 즉, 바깥여백을 없는 것으로 한 것이다.*/
	}	

	div#container{
		width: 70%;
		margin: 0px auto 20px auto; /* 상 하는 20px 우 좌는 남은 20%에서 좌우로 균등하게 주겠다. 즉, 화면의 가운데로 위치하겠다는 말이다.*/
	}
	
	div#left{
		 float: left;
		 width: 15%;
		 height: 420px; 
		 background-color: white; 
	} 
	
	img#middle {
		 float: left;
		 background-repeat: no-repeat;
		 background-size:cover;  
		 background-position: center center; 
		 height: 400px;
  	     width: 70%; 
  	     background-blend-mode: multiply;
  	     border-radius: 10px 10px;
	} 
	
	
	div#right{
		 float: left;
		 width: 15%;
		 height: 420px; 
		 background-color: white;
		 
	}  

	img#poster{
	    float: left;
		border: solid 1px #b3b3b3;
		width: 23%;
		height: 350px;
		border-radius: 10px 10px;
		background-repeat: no-repeat;
		background-size:cover;  
	}	
	  
	div#posterInfo{
	    float: left;
		border: solid 1px #b3b3b3;
		width: 75%;
		height: 350px; 
		margin: 0px 0px 20px 20px; 
		border-radius: 10px 10px;
	}	
	
	
	div#BasicInfo{
		border: solid 1.5px #b3b3b3;
		width: 100%;
		display: inline-block;
		border-radius: 10px 10px;
	}	
	
	div#cast{
		border: solid 1.5px #b3b3b3;
		width: 100%;
		display: inline-block;
		height: 410px;
		margin-top: 20px;
		border-radius: 10px 10px;	
	}	 
	
	div#Comment{
		border: solid 1.5px #b3b3b3;
		width: 100%;
		display: inline-block;
		margin-top: 20px;
		border-radius: 10px 10px;
	}

	div#rating{
		border: solid 1.5px #b3b3b3;
		width: 100%;
		display: inline-block;
		margin-top: 20px;
		border-radius: 10px 10px;
	}
	
	/*평가하기 시작*/
    .rate { display: inline-block;border: 0;margin-right: 15px;}
	.rate > input {display: none;}
	.rate > label {float: right;color: #ddd}
	.rate > label:before {display: inline-block;font-size: 2rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
	.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
	.rate input:checked ~ label, 
	.rate label:hover,.rate label:hover ~ label { color: #FDD346} 
	.rate input:checked + .rate label:hover,
	.rate input input:checked ~ label:hover,
	.rate input:checked ~ .rate label:hover ~ label,  
	.rate label:hover ~ input:checked ~ label { color: #FDD346} 
	/*평가하기 끝*/
	
	/* 출연,제작 시작 */ 
	@media (max-width: 768px) {
	    .carousel-inner .carousel-item > div {
	        display: none;
	    }
	    .carousel-inner .carousel-item > div:first-child {
	        display: block;
	    }
	}
	
	.carousel-inner .carousel-item.active,
	.carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	    display: flex;
	}
	
	/* display 3 */
	@media (min-width: 768px) {
	    
	    .carousel-inner .carousel-item-right.active,
	    .carousel-inner .carousel-item-next {
	      transform: translateX(33.333%);
	    }
	    
	    .carousel-inner .carousel-item-left.active, 
	    .carousel-inner .carousel-item-prev {
	      transform: translateX(-33.333%);
	    }
	}
	
	.carousel-inner .carousel-item-right,
	.carousel-inner .carousel-item-left{ 
	  transform: translateX(0);
	}
	/* 출연,제작 끝 */
	
	/*보고싶어요 시작*/
	input[type="checkbox"] {  
	   opacity: 0;
	}
    /*보고싶어요 끝*/
	
	/*코멘트 시작*/
	<%-- 한줄평등록/수정 모달 --%>
	div#registerReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
	div#editReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
	.modal-body textarea:focus,
	.modal-body input:focus {outline: none;}
	.fa-face-meh:hover{cursor: pointer;}	
	/*코멘트 끝*/
	
	.actor {
	    font-size: 13px;
		margin: 0;
		padding: 0;
	}
	
	.card { 
		height: 320px;
	}
	
	#posterInfo > div > span > a {
	
		color: #808080; 
	}
	
	#posterInfo > div > span > a:hover {
	
		color: #ff0558;
	}
	 
</style>
 
<script type="text/javascript">
	$(document).ready(function(){
	
	/* 컬렉션 값 유지 */
	if($('#moviecollectionSelect').val() == 1) {  
		$(".collectioni").css({"color":"#ff0558"}); 	  
	}
	
	if($('#moviecollectionSelect').val() == 0) { 
		$(".collectioni").css({"background-color":"","color":""}); 
	}
	
	/* 출연, 제작 시작*/	
	$('#recipeCarousel').carousel({ 
		  interval: 10000
	});
	
	$('.carousel .carousel-item').each(function(){
	    var minPerSlide = 4;
	    var next = $(this).next(); 
	    if (!next.length) {
	        next = $(this).siblings(':first');
	    }
	    next.children(':first-child').clone().appendTo($(this));
	    
	    for (var i=0;i<minPerSlide;i++) {
	        next=next.next();
	        if (!next.length) {
	        	next = $(this).siblings(':first');
	      	}
	        
	        next.children(':first-child').clone().appendTo($(this));
	   }
	});
	/* 출연, 제작 끝*/
	
	/*코멘트 시작*/		
	$("input:checkbox[name='check_comment']").click(function(){
		
		if($('input:checkbox[name="check_comment"]').is(":checked")) {
			 
		 	$(".commenti").css({"color":"#ff0558"}); 
		}
		else if(!$('input:checkbox[name="check_comment"]').is(":checked")) {

			$(".commenti").css({"background-color":"","color":""}); 
		}
		
		$("input:checkbox[name='check_comment']").toggle();
		
	 }); 
	 /*코멘트 끝*/
	
	/*컬렉션 시작*/		
	$("input:checkbox[name='check_collection']").click(function(){
		 
			if($('input:checkbox[name="check_collection"]').is(":checked")) {
				 
				$(".collectioni").css({"color":"#ff0558"}); 	 
			}
			else if(!$('input:checkbox[name="check_collection"]').is(":checked")) {

				$(".collectioni").css({"background-color":"","color":""}); 
			}
		
			 const commentData = { user_id : '${sessionScope.loginuser.user_id}',
			                       movie_id : '${requestScope.movieDetail.movie_id}'
				}
			
	 		  $.ajax({
	  			 url: "<%= ctxPath%>/view/insert_collection.action",
	  			 type: "post",
	  			 data: commentData,
	  			 dataType: "json",
	  			 success:function(json){
	  				 
	  			 },
	  			 error: function(request, status, error){
	   	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     	     }	 
	  		 }); 
		
		$("input:checkbox[name='check_collection']").toggle();
		
		location.reload(true); 
		
	});
	/*컬렉션 끝*/ 	

     
});//end of $(document).ready(function())----------------------------------------------------------------------------------
</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<meta charset="UTF-8">
<title>제품상세</title>
</head>
<body>
	
	<div>
		<div id="left"></div> 
		<img id="middle" src="https://image.tmdb.org/t/p/w1280${requestScope.movieDetail.backdrop_path}"/>
		<div id="right"></div>
	</div>
	
	<div id="container">  
		 
		<img id="poster" src="https://image.tmdb.org/t/p/w780${requestScope.movieDetail.poster_path}"/>
	
		<div id="posterInfo"> 
			<div style="margin: 15px 0 0 30px;">
			
				<div style="margin: 0 0 0 0; font-size: 40px; font-weight: bolder;">${requestScope.movieDetail.movie_title}</div>
				
	             <c:forEach var="genres" items="${requestScope.movieDetail.genres}" varStatus="status">
	               <c:choose>
	                  <c:when test="${not status.last}">
	                     <span style="font-weight: bold; font-size: 15px;" ><a href="<%= ctxPath%>/myWatcha/preference.action?genre_id=${genres.genre_id}" style="text-decoration: none; ">${genres.genre_name}</a></span><span style="color: #eee;">&nbsp;|&nbsp;</span>
	                  </c:when> 
	                  <c:otherwise> 
	                     <span style="font-weight: bold; font-size: 15px;"><a href="<%= ctxPath%>/myWatcha/preference.action?genre_id=${genres.genre_id}" style="text-decoration: none; ">${genres.genre_name}</a></span>
	                  </c:otherwise>
	               </c:choose>
	              </c:forEach>  
				
				<div style="margin-top: 10px; font-weight: bold; font-size: 17px;">${requestScope.movieDetail.tagline}</div>
	
				<hr style="margin-right: 40px;">	 
				
				<div style="font-weight: bold;">
					개봉일자:&nbsp;${requestScope.movieDetail.release_date}&nbsp;&nbsp;
					<span style="color: #eee;">|</span>
					러닝타임:&nbsp;${requestScope.movieDetail.runtime}분&nbsp;&nbsp;
				</div>  
				
				<hr style="margin-right: 40px;"> 
					
					<c:if test="${not empty sessionScope.loginuser}">
					
					<div style="margin: 20px 0 0px 135px; font-weight: bold;">평가하기</div> 
					
					<div style="margin-left: 60px;"> 
						<fieldset class="rate">
		                     <input type="radio" id="rating10" name="rating" value="10"><label for="rating10" title="5점"></label>
		                     <input type="radio" id="rating9" name="rating" value="9"><label class="half" for="rating9" title="4.5점"></label>
		                     <input type="radio" id="rating8" name="rating" value="8"><label for="rating8" title="4점"></label>
		                     <input type="radio" id="rating7" name="rating" value="7"><label class="half" for="rating7" title="3.5점"></label>
		                     <input type="radio" id="rating6" name="rating" value="6"><label for="rating6" title="3점"></label>
		                     <input type="radio" id="rating5" name="rating" value="5"><label class="half" for="rating5" title="2.5점"></label>
		                     <input type="radio" id="rating4" name="rating" value="4"><label for="rating4" title="2점"></label>
		                     <input type="radio" id="rating3" name="rating" value="3"><label class="half" for="rating3" title="1.5점"></label>
		                     <input type="radio" id="rating2" name="rating" value="2"><label for="rating2" title="1점"></label>
		                     <input type="radio" id="rating1" name="rating" value="1"><label class="half" for="rating1" title="0.5점"></label>
		                 </fieldset>
					</div>
					
					<div style="margin: 7px 0 0 310px; position: relative; bottom: 60px;">  
						
				        <%-- 한줄평 등록하기 --%> 
				        <div style="width: 150px;"> 
				          <label for="check_comment" style="cursor: pointer;">
				             <span class="commenti">
				               
				                 <c:if test="${empty requestScope.reviewInfo}">
				                   <button type="button" data-toggle="modal" data-target="#registerReview" style="font-weight: bold; border: none; background-color: transparent;">
				                     <i style="font-size: 18px;" class="fas fa-pen-nib commenti"></i>&nbsp;&nbsp;한줄평 등록
				                   </button>
				                 </c:if>
				                 
				                 <c:if test="${not empty requestScope.reviewInfo}">
				                   <button type="button" data-toggle="modal" data-target="#editReview" style="font-weight: bold; border: none; background-color: transparent;">
				                     <i style="font-size: 18px;" class="fas fa-pen-nib commenti"></i>&nbsp;&nbsp;한줄평 수정
				                   </button>
				                 </c:if>

				             </span>
				          </label>
				        </div> 				         

						<%-- 컬렉션에 추가 --%> 
						<div style="position: relative; left: 170px; bottom: 35px; width: 150px;"> 
						    <label for="check_collection" style="cursor: pointer;">
						    <i class="fas fa-book collectioni"></i><span class="collectioni" style="font-size: 15px; font-weight: bolder">&nbsp;컬렉션에 추가</span></label>
							<input type="checkbox" id="check_collection" name="check_collection"/>
							
							<input type="hidden" name="moviecollectionSelect" id="moviecollectionSelect" value="${requestScope.moviecollectionSelect}" /> 
						</div>    
					</div>  
				   </c:if> 
				   
				   <c:if test="${empty sessionScope.loginuser}">
						<div style="margin: 60px 0 0 150px">로그인을 하여 왓챠피디아의 숨은 기능을 사용 해보세요!!</div>				   	
				   </c:if>
				   
			</div>
		</div>
		
		<div id="BasicInfo">
		
			<h4 style="margin: 20px 0 20px 30px; font-weight: bolder; ">기본 정보</h4>
		       
		       <div style="margin-left: 50px;"> 
			       <span style="margin-right: 65px;">원제</span><span>${requestScope.movieDetail.movie_title}</span>
			       
			       <hr style="margin-right: 40px;"> 
			        
			       <span style="margin-right: 5px;">개봉일자 </span><span style="margin-left: 27px;">${requestScope.movieDetail.release_date}</span>
			       
			       <hr style="margin-right: 40px;"> 
			       
			       <span>상영시간 </span><span style="margin-left: 35px;">${requestScope.movieDetail.runtime}분</span>
			       
			       <hr style="margin-right: 40px;"> 
			        
			       <span style="margin-right: 64px;">장르</span> 
			       <c:forEach var="genres" items="${requestScope.movieDetail.genres}" varStatus="status">
						
						<c:choose>
							<c:when test="${not status.last}"><span>${genres.genre_name}</span><span style="color: #eee;">&nbsp;|&nbsp;</span></c:when>
							<c:otherwise><span>${genres.genre_name}</span></c:otherwise>
						</c:choose>
						
			       </c:forEach>  
			       
			       <hr style="margin-right: 40px;">   
			         
			       <span style="margin-right: 55px;">슬로건</span><span>${requestScope.movieDetail.tagline}</span>  
			       
			       <hr style="margin-right: 40px;"> 
			       
			       <span style="width: 10%; vertical-align: top; display: inline-block;">내용</span>
			       
			       <span style="width: 80%; display: inline-block; margin-bottom: 20px;">${requestScope.movieDetail.overview}</span> 
			   </div>
		</div>
		
		<div id="cast">
		
			<h4 style="margin: 20px 0 10px 30px; font-weight: bolder; ">출연/제작</h4>

				<div class="row mx-auto my-auto">
			        <div id="recipeCarousel" class="carousel slide w-100" data-ride="carousel">
			            <div class="carousel-inner w-100" role="listbox">
			               <c:forEach var="movieRoles" items="${requestScope.movieDetail.movieRoles}" varStatus="status">
			                  <c:if test="${status.index == 0}">
					            <div class="carousel-item active">
				                    <div class="col-md-2">
				                        <div class="card"> 
				                            <img class="img-fluid card-img-top" src="https://image.tmdb.org/t/p/w1280${movieRoles.actor.profile_image_path}">
				                            <div class="card-body">
										    <h5 class="card-title actor" style="font-size: 16px; font-weight:bold; margin-bottom: 3px;">${movieRoles.actor.actor_name}</h5>
										    
										    <c:if test="${not empty movieRoles.actor.date_of_birth}">
										    	<p class="card-text actor">생일: ${movieRoles.actor.date_of_birth}</p>
										  	</c:if>
										  	
											<c:choose>
												<c:when test="${movieRoles.actor.gender eq 2}"><div class="actor">성별: 남자</div></c:when>
												<c:otherwise><div class="actor">성별: 여자</div></c:otherwise>
											</c:choose>
										  	
										  </div> 
				                        </div>
				                    </div>
				                </div> 
				              </c:if>
				              
			                  <c:if test="${status.index > 0}">
					            <div class="carousel-item">
				                    <div class="col-md-2">
				                        <div class="card"> 
				                            <img class="img-fluid card-img-top" src="https://image.tmdb.org/t/p/w1280${movieRoles.actor.profile_image_path}">
				                            <div class="card-body">
										    <h5 class="card-title actor" style="font-size: 16px; font-weight:bold; margin-bottom: 3px;">${movieRoles.actor.actor_name}</h5>
										   
										    <c:if test="${not empty movieRoles.actor.date_of_birth}">
										    	<p class="card-text actor">생일: ${movieRoles.actor.date_of_birth}</p>
										  	</c:if>

											<c:choose>
												<c:when test="${movieRoles.actor.gender eq 2}"><div class="actor">성별: 남자</div></c:when>
												<c:otherwise><div class="actor">성별: 여자</div></c:otherwise>
											</c:choose>
										  	
 										  </div>
				                        </div>
				                    </div>
				                </div> 
				              </c:if>
			               </c:forEach>
			                
			            </div>
			            <a class="carousel-control-prev w-auto" href="#recipeCarousel" role="button" data-slide="prev">
			                <span class="carousel-control-prev-icon bg-dark border border-dark rounded-circle" aria-hidden="true"></span>
			                <span class="sr-only">Previous</span>
			            </a>
			            <a class="carousel-control-next w-auto" href="#recipeCarousel" role="button" data-slide="next">
			                <span class="carousel-control-next-icon bg-dark border border-dark rounded-circle" aria-hidden="true"></span>
			                <span class="sr-only">Next</span>
			            </a>
			        </div>
			</div>  
		 
		</div>

		<div id="rating">
		
			<h4 style="margin: 20px 0 0 30px; font-weight: bolder; ">별점차트</h4>
      		
      		   <c:if test="${requestScope.movieDetail.rating_count ne 0}">
			     <h5 style="font-weight: 600; text-align: center; padding: 0px 30px;">별점 평균 <span style="color: #ff0558;">★${requestScope.movieDetail.rating_avg}</span>&nbsp;(<span style="color: #ff0558;">${requestScope.movieDetail.rating_count}명</span>의 평가)</h5>
			   </c:if>
			   
			   <div id="div_rating" style="width: 80%; padding: 0px 30px; margin: auto;"></div>
      		
		</div>
		
		<div id="Comment">
		
			<h4 style="margin: 20px 0 0 30px; font-weight: bolder; ">한줄평</h4>
      		
      		<jsp:include page="myWatcha/movieReview.jsp" />
      		
		</div>
		
	</div>
	
</body>
</html>