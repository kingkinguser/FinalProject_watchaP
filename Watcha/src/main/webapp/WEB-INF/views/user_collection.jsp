<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>     
    
<!DOCTYPE html>
<html>

<head>

<style type="text/css">

	body {
		border: solid 0px gray;
		word-break: break-all; /* 공백없이 영어로만 되어질 경우 해당구역을 뚫고 빠져나감으로 이것을 막기 위해서 사용한다 */
		padding: 0;            /* 상 우 하 좌 모두 안쪽여백을 0px을 준 것이다. 즉, 바깥여백을 없는 것으로 한 것이다.*/
	}	

	div#container{
		border: solid 0px purple;
		width: 70%;
		margin: 20px auto; /* 상 하는 20px 우 좌는 남은 20%에서 좌우로 균등하게 주겠다. 즉, 화면의 가운데로 위치하겠다는 말이다.*/
	}

	.box {
	    width: 50px;
	    height: 50px; 
	    border-radius: 70%;
	    overflow: hidden;
	}
	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    
	}
			
	/*버튼 시작*/		
	.btnP{
	  background: white;
	  color: black;
	  border:none;
	  position:relative;
	  height:50px;
	  font-size: 15px;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none;
	}
	.btnP:hover{
	  background:#fff;
	  color: #f3578d;
	}
	.btnP:before,.btnP:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #f3578d;
	  transition:400ms ease all;
	}
	.btnP:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	.btnP:hover:before,.btnP:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}
	/*버튼 끝*/		
		
	.commentP {
	  width: 700px;
	  height: 40px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 15px;
	  outline: none;
	  padding-left: 10px;
	  background-color: rgb(233, 233, 233);
	}	
	
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
	
	input[type="checkbox"] { 
	   opacity: 0;
	}
	
		
</style>

<script type="text/javascript">

	
	$(document).ready(function(){
		
	/* 출연, 제작 시작*/	
	$('#recipeCarousel').carousel({ 
		  interval: 10000
	});
	
	$('.carousel .carousel-item').each(function(){
	    var minPerSlide = 5;
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
	
	/*좋아요 시작*/		
	$("input:checkbox[name='check_good']").click(function(){
		  
		if($('input:checkbox[name="check_good"]').is(":checked")) {
			 
		 	$(".goodi").css({"color":"#f3578d"}); 
		}
		else if(!$('input:checkbox[name="check_good"]').is(":checked")) {

			$(".goodi").css({"background-color":"","color":""}); 
		}
		
		$("input:checkbox[name='check_good']").toggle();
		
	  });
	/*좋아요 끝*/	
	
	
	
});	
</script>

<meta charset="UTF-8">
<title></title>
</head>
<body>

	<div id="container">
		<div class="card">
		    <img src="<%= ctxPath %>/resources/KING/watchaOgImage.png" class="card-img-top"  style="width: 100%;" height="350px;"/>
		    <div class="card-body"> <!-- .card-body에는 카드 내용이 들어갑니다. -->
		        
		        <hr style="margin-right: 20px;">  	
		        
		        <span style="margin-left: 50px;"></span>
		        
		        <div class="box" style=" margin-left: 50px; display: inline-block;">
				    <img class="profile" src="<%= ctxPath %>/resources/KING/watchaOgImage.png">
				</div>
				
				<div style="display: inline-block; position: relative; left: 10px; bottom: 17px; font-weight: bolder; font-size: 16px;">유저이름</div>
				
				<span style="position: relative; right:55px; top: 20px;">좋아요&nbsp;<span>10</span>&nbsp;&nbsp;<span style="color: #eee;">|</span>&nbsp;&nbsp;댓글&nbsp;<span>10</span></span>
 
				<span style="position: relative; left: 460px; bottom: 10px; width: 100px;"> 
				  <label for="check_good" style="cursor: pointer;">
				    <i class="far fa-thumbs-up goodi"></i><span class="goodi" style="font-weight: bolder">&nbsp;&nbsp;좋아요</span></label>
					<input type="checkbox" id="check_good" name="check_good"/>
				</span>
			
				
				<hr style="margin-right: 20px;">  	    
		    
		    	<div style="font-size: 20px; font-weight: bold; margin-left: 30px;">작품들</div>	
		    	
			<div class="container text-center my-3">
			    <div class="row mx-auto my-auto">
			        <div id="recipeCarousel" class="carousel slide w-100" data-ride="carousel">
			            <div class="carousel-inner w-100" role="listbox">
			                <div class="carousel-item active">
			                    <div class="col-md-2">
			                        <div class="card">
									  <img src="https://image.tmdb.org/t/p/w780/jbremGnsRR4XZMDj97YHt20isRP.jpg" class="card-img-top" style="width: 100%" />
									  <div class="card-body">
									    <h5 class="card-title">ㅇㅇ</h5>
									    <p class="card-text">ㅇㅇ</p>
									    <a href="#" class="stretched-link"></a>
									  </div>
									</div>
			                    </div>
			                </div>
			                <div class="carousel-item">
			                    <div class="col-md-2">
			                        <div class="card">
									  <img src="https://image.tmdb.org/t/p/w780/jbremGnsRR4XZMDj97YHt20isRP.jpg" class="card-img-top" style="width: 100%" />
									  <div class="card-body">
									    <h5 class="card-title">ㅇㅇ</h5>
									    <p class="card-text">ㅇㅇ</p>
									    <a href="#" class="stretched-link"></a>
									  </div>
									</div>
			                    </div>
			                </div>
			                <div class="carousel-item">
			                    <div class="col-md-2">
			                        <div class="card">
									  <img src="https://image.tmdb.org/t/p/w780/jbremGnsRR4XZMDj97YHt20isRP.jpg" class="card-img-top" style="width: 100%" />
									  <div class="card-body">
									    <h5 class="card-title">ㅇㅇ</h5>
									    <p class="card-text">ㅇㅇ</p>
									    <a href="#" class="stretched-link"></a>
									  </div>
									</div>
			                    </div>
			                </div>
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
		    		
		    	<hr style="margin-right: 20px;">  	
		    		
		    	<div style="font-size: 20px; font-weight: bold; margin-left: 40px;">댓글<span style="margin-left: 30px;"><input class="commentP" type="text"><button class="btnP"><i class="far fa-comment"></i>제출</button></span></div>		
		    		
		    		
		    		
		    		
		    		
		    </div>
		</div>
	</div> 
	
</body>
</html>