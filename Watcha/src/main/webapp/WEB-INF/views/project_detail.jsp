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
		height: 600px;
		margin-top: 20px;
		border-radius: 10px 10px;
	}
	
	.eee{
		color: #eee; 
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

    // 한줄평 등록/수정 모달에서 checkbox 를 체크했을 때
     $("input#spoiler_status").change(function(){
        if($(this).prop("checked")){ // 체크박스 체크 ==> 스포일러 포함
           $(this).prev().css("color","#ff0558");
           $(this).next().text("한줄평에 스포일러가 포함되었어요.");
           $(this).val("1");
        }
        else { // 체크박스 체크해제 ==> 스포일러 미포함
           $(this).prev().css("color","#cccccc");
           $(this).next().text("스포일러가 포함된 한줄평을 가려보세요.");
           $(this).val("0");
        }
     }); // end of $("input#spoiler_status").change(function(){})

     // 한줄평 "등록" 버튼 클릭 시
     $("button#btnAdd").click(function(){

        let review_content = document.querySelector("div#registerReview textarea#review_content").value;

        if(review_content.trim() == ""){
           alert("한줄평 내용을 적어주세요.");
        }
        else {
          const queryString = $("form[name='registerReviewFrm']").serialize();
             
           $.ajax({
              url:"<%= ctxPath%>/addReview.action",
             data:queryString, 
              type:"post",
              dataType:"json",
              success:function(json){
              //   console.log("확인용 : "+JSON.stringify(json));
                location.href="<%= request.getContextPath()%>/allReview.action?movie_id="+"${requestScope.movieDetail.movie_id}";
                // 추후 수정예정
              },
              error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }         
           });
        }
     }); // end of $("button#btnAdd").click(function(){})
 
     // 한줄평 "수정" 버튼 클릭 시
     $("button#btnEdit").click(function(){
        let review_content = document.querySelector("div#editReview textarea#review_content").value;
        
        if(review_content.trim() == ""){
           alert("한줄평 내용을 적어주세요.");
        }
        else {
           const queryString = $("form[name='editReviewFrm']").serialize();
           $.ajax({
              url:"<%= ctxPath%>/updateReview.action",
              data:queryString, 
              type:"post",
              dataType:"json",
              success:function(json){
              //   console.log("확인용 : "+JSON.stringify(json));
                  history.go(0); // 새로고침
              },
              error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }         
           });
        }
     }); // end of $("button#btnEdit").click(function(){})
	
     // 특정 영화에 대하여 회원이 매긴 별점 (원래 값)
     $("input:radio[name='rating']").each(function(index, item){
        if(Number($(item).val())/2 == "${requestScope.reviewInfo.rating}"){
           $(item).prop("checked", true);
           return false;
        }
     }); // end of $("input:radio[name='rating']").each(function(index, item){})

     // 영화에 대한 별점 등록 또는 수정 하는 경우
     $("input:radio[name='rating']").change(function(){
        if("${empty requestScope.reviewInfo.rating}"){ // 별점 등록하는 경우
            $.ajax({
              url:"<%= ctxPath%>/myWatcha/registerRating.action",
              data:{"movie_id":"${requestScope.movieDetail.movie_id}",
                   "user_id":"${sessionScope.loginuser.user_id}",
                   "rating":Number($(this).val())/2}, 
              type:"post",
              dataType:"json",
              success:function(json){
              //   console.log("확인용 : "+JSON.stringify(json));
              },
              error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }         
            });
        }
        else { // 별점 수정하는 경우
            $.ajax({
              url:"<%= ctxPath%>/myWatcha/updateRating.action",
              data:{"movie_id":"${requestScope.movieDetail.movie_id}",
                   "user_id":"${sessionScope.loginuser.user_id}",
                   "rating":Number($(this).val())/2}, 
              type:"post",
              dataType:"json",
              success:function(json){
              //   console.log("확인용 : "+JSON.stringify(json));
              },
              error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }         
            });
        }
     }); // end of $("input:radio[name='rating']").change(function(){})     
     
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
						<c:when test="${not status.last}"><span style="font-weight: bold; font-size: 13px;" >${genres.genre_name}</span><span style="color: #eee;">&nbsp;|&nbsp;</span></c:when>
						<c:otherwise><span style="font-weight: bold; font-size: 13px;">${genres.genre_name}</span></c:otherwise>
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
				
					<div style="margin: 20px 0 0px 77px; font-weight: bold;">평가하기</div> 
					
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
					
					<div style="margin: 7px 0 0 240px; position: relative; bottom: 60px;">  
						
				        <%-- 한줄평 등록하기 --%>
				        <div style="position: relative; left: 150px; bottom: 33px; width: 150px;">
				          <label for="check_comment" style="cursor: pointer;">
				             <span class="commenti">
				               <c:if test="${not empty sessionScope.loginuser}">
				                 <c:if test="${empty requestScope.reviewInfo}">
				                   <button type="button" data-toggle="modal" data-target="#registerReview" style="font-weight: bold; border: none; background-color: transparent;">
				                     <i style="font-size: 23px;" class="fas fa-pen-nib commenti"></i>&nbsp;&nbsp;한줄평 등록
				                   </button>
				                 </c:if>
				                 <c:if test="${not empty requestScope.reviewInfo}">
				                   <button type="button" data-toggle="modal" data-target="#editReview" style="font-weight: bold; border: none; background-color: transparent;">
				                     <i style="font-size: 23px;" class="fas fa-pen-nib commenti"></i>&nbsp;&nbsp;한줄평 수정
				                   </button>
				                 </c:if>
				               </c:if>
				               <c:if test="${empty sessionScope.loginuser}">
				               
				               </c:if>
				             </span>
				          </label>
				        </div> 				        

						<%-- 컬렉션에 추가 --%> 
						<div style="position: relative; left: 330px; bottom: 100px; width: 150px;"> 
						    <label for="check_collection" style="cursor: pointer;">
						    <i class="fas fa-book collectioni"></i><span class="collectioni" style="font-size: 15px; font-weight: bolder">&nbsp;컬렉션에 추가</span></label>
							<input type="checkbox" id="check_collection" name="check_collection"/>
							
							<input type="hidden" name="moviecollectionSelect" id="moviecollectionSelect" value="${requestScope.moviecollectionSelect}" /> 
		    	  
						</div>    
					</div>  
				
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
		
			<h4 style="margin: 30px 0 10px 30px; font-weight: bolder; ">출연/제작</h4>

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
		
		<div id="Comment">
		
			<h4 style="margin: 30px 0 0 30px; font-weight: bolder; ">한줄평</h4>
				
		     <%-- 한줄평 등록 모달창 --%>
		      <c:if test="${empty requestScope.reviewInfo}">
		      <div class="modal fade registerReview" id="registerReview" data-keyboard="false">
		      <form name="registerReviewFrm">
		        <input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}" />
		        <input type="hidden" name="movie_id" value="${requestScope.movieDetail.movie_id}" />
		        <div class="modal-dialog modal-dialog-centered">
		          <div class="modal-content">
		            <div class="modal-body">
		              <h5 class="modal-title" style="font-weight: bold;">${requestScope.movieDetail.movie_title}<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
		               <div class="my-2">
		                 <textarea id="review_content" name="review_content" style="width: 100%; height: 450px; resize: none; border: none;" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요."></textarea>
		               </div>
		               <div style="display: inline-block; width: 100%;">
		                 <div style="display: inline-block; width: 83%;">
		                   <label for="spoiler_status">
		                    <i class="fa-solid fa-face-meh fa-2xl" style="color: #cccccc;"></i>
		                    <input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="0" />
		                    <span style="color: #666666; cursor: pointer;">스포일러가 포함된 한줄평을 가려보세요.</span>
		                   </label>
		                 </div>
		                 <div style="display: inline-block; width: 16%; text-align: right;">
		                  <button type="button" class="btn" id="btnAdd" style="color: #ffffff; background-color: #ff0558;">등록</button>
		                 </div>
		               </div>
		            </div>
		          </div>
		        </div>
		      </form>
		      </div>
		     </c:if>
		      <%-- 한줄평 등록 모달창 끝 --%>
		      
		      <%-- 한줄평 수정 모달창 --%>
		      <c:if test="${not empty requestScope.reviewInfo}">
		          <div class="modal fade editReview" id="editReview" data-keyboard="false">
		      <form name="editReviewFrm">
		        <input type="hidden" name="review_id" value="${requestScope.reviewInfo.review_id}" />
		        <div class="modal-dialog modal-dialog-centered">
		         <div class="modal-content">
		           <div class="modal-body">
		              <h5 class="modal-title" style="font-weight: bold;">${requestScope.movieDetail.movie_title}<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
		              <div class="my-2">
		                <textarea id="review_content" name="review_content" style="width: 100%; height: 450px; resize: none; border: none;">${requestScope.reviewInfo.review_content}</textarea>
		              </div>
		              <div style="display: inline-block; width: 100%;">
		                <div style="display: inline-block; width: 83%;">
		              
		                  <label for="spoiler_status">
		               <c:if test="${requestScope.reviewInfo.spoiler_status eq 0}">
		                 <i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #cccccc;"></i>
		                   <input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="0" />
		                   <span id="spoiler_status" style="color: #666666; cursor: pointer;">스포일러가 포함된 한줄평을 가려보세요.</span>
		               </c:if>
		               <c:if test="${requestScope.reviewInfo.spoiler_status eq 1}">
		                 <i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #ff0558;"></i>
		                   <input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="1" checked />
		                   <span id="spoiler_status" style="color: #666666; cursor: pointer;">한줄평에 스포일러가 포함되었어요.</span>
		               </c:if>
		                 </label>
		                
		              </div>
		              <div style="display: inline-block; width: 16%; text-align: right;">
		                  <button type="button" class="btn" id="btnEdit" style="color: #ffffff; background-color: #ff0558;">수정</button>
		                </div>
		              </div>
		           </div>
		         </div>
		        </div>
		      </form>
		      </div>
		     </c:if>
		      <%-- 한줄평 수정 모달창 끝 --%>	
      	
		</div>
		
	</div>
	
</body>
</html>