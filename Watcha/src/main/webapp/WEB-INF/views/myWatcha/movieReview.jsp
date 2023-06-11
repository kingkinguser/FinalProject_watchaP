<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>    
    
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <!-- Font Awesome 6 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap');
</style>

<style type="text/css">
<%-- 유저한줄평 --%>
div#userReview {font-family: 'Noto Sans KR', sans-serif; cursor: default;}
img#img_profile {width: 40px; height: 40px; box-sizing: inherit; border:solid 1px #e6e6e6; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; margin: 0 6px;}
p.movieRate{height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px 15px; background-color: #ffffff;}
</style>

<script>

	$(document).ready(function(){
		
		userReview(); // 영화별 유저들 한줄평 (카드 캐러셀, Ajax) 보여주는 함수 호출
		
		// 스포일러가 포함된 한줄평에서 "한줄평 보기" 버튼 클릭 시
		$(document).on("click", "button.showContent", function(){
			$(this).parent().css('display', 'none');
			$(this).parent().next().fadeIn('slow').css('display', '');
 		}); // end of $(document).on("click", "button.showContent", function(){})

		
	}); // end of $(document).ready(function(){})

	// 영화별 유저들 한줄평 (카드 캐러셀) 보여주기(Ajax)
	function userReview(){
		$.ajax({
			url:"<%= ctxPath%>/movieReview.action",
			data:{"movie_id":"${requestScope.movie_id}"},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 영화에 대한 유저들의 한줄평이 존재하는 경우
					
					html += '<div id="userReview" class="container" style="padding: 0px;">'
					      +   '<div style="position: relative; float: right; z-index: 2;">'
					      +     '<a href="<%= request.getContextPath()%>/allReview.action?movie_id='+${requestScope.movie_id}+'" style="color: black; text-decoration: none;">전체보기</a>'
						  +   '</div>'
						  +   '<div id="review" style="z-index: 1;" class="mx-auto mt-2 mb-3 p-1 carousel slide w-100" data-ride="carousel">'
						  +     '<div class="p-0 carousel-inner w-90 mx-auto">';
						
					<%-- 유저들의 한줄평 보여주기 시작 --%>
					$.each(json, function(index, item){
						if(index == 0){
							html += '<div class="carousel-item active">'
							      +	  '<div class="row col-md-12 mx-auto my-1">';
						}
						else if(index != 0 && (index %4 == 0)){
							html += '<div class="carousel-item">'
							      +	  '<div class="row col-md-12 mx-auto my-1">';
						}
						
						html += '<div id="'+item.review_id+'" class="col-md-3 p-1">'
				       		  +   '<div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">'
				       		  +     '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">';
				       		  
				        if(item.profile_image == null){ // 유저의 프로필이미지가 없는 경우
					       	html +=   '<img id="img_profile" src="<%= request.getContextPath()%>/resources/images/프로필없음.jpg"/>';
				        }
				        else {
					       	html +=   '<img id="img_profile" src="<%= request.getContextPath()%>/resources/images/'+item.profile_image+'"/>';
				        }
				        html +=       '<h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">'+item.nickname+'</h5>'
				       		  +     '</div>'
				       		  +     '<div class="mx-auto my-auto p-2">';
				       		  
				       	if(item.spoiler_status == 1){ // 해당 한줄평에 스포일러가 포함된 경우
					       	html +=	  '<div class="text-center m-0 p-0 my-2" style="height: 120px; overflow: auto;">'
					       		  +	    '<p style="padding: 10px; margin: 0px;">스포일러가 포함되어 있어요.</p>'
					       		  +     '<button type="button" class="showContent" style="border: none; color: #ff0558; background-color: transparent; font-weight: bold;">한줄평 보기</button>'
					       		  +	  '</div>'
					       		  +   '<div class="text-center m-0 p-0 my-2" style="display: none; height: 120px; overflow: auto;">'
					       		  +     '<p style="padding: 10px; margin: 0px;">'+item.review_content+'</p>'
					       		  +	  '</div>';
				       	}
				       	else {
					       	html +=   '<div class="m-0 p-0 my-2" style="height: 120px; overflow: auto;">'
					       		  +     '<p style="padding: 10px; margin: 0px;">'+item.review_content+'</p>'
					       		  +	  '</div>';
				       	}
				       	
				       	html +=       '<div style="display: flex;">'
				       		  +         '<p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="ml-2">'+item.review_date+'</span></p>';
				       		  
				        if(item.rating == 0){ // 별점평가를 하지 않은 경우
					       	html +=   	'<p class="movieRate">평가안함</p>';
				        }
				        else {
					       	html +=   	'<p class="movieRate">★&nbsp;<span>'+item.rating+'</span></p>';
				        }

				       	html +=   	 '</div>'
				       		  +      '<div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">';

				       	if(item.like_review == 1){ // 로그인한 회원이 해당 한줄평에 좋아요를 한 경우
				       		html +=     '<p class="m-2">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i><span class="pl-2">'+item.number_of_likes+'</span></p>';
				       	}	  
				       	else {
				       		html +=     '<p class="m-2">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #e6e6e6;"></i><span class="pl-2">'+item.number_of_likes+'</span></p>';
				       	}

				       	html +=    		'<p class="m-2">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #e6e6e6;"></i><span class="pl-2">'+item.number_of_comments+'</span></p>'
				       		  +       '</div>'
				       		  +     '</div>'
				       		  +   '</div>'
				       		  + '</div>';

				        if((index+1) == json.length || (index+1) %4 == 0){
							html +=   '</div>'
							      +	'</div>';
						}
					}); // end of $.each(json, function(index, item){})
					<%-- 유저들의 한줄평 보여주기 끝 --%>
				       	  
					html +=     '</div>'
					      +	  '</div>'
					      +	  '<a class="carousel-control-prev" href="#review" role="button" data-slide="prev">'
					      +	    '<span class="carousel-control-prev-icon" aria-hidden="true"><i class="fa-solid fa-angle-left fa-2xl" style="color: #cccccc;"></i></span>'
					      +	    '<span class="sr-only">Previous</span>'
					      +	  '</a>'
					      +	  '<a class="carousel-control-next" href="#review" role="button" data-slide="next">'
					      +	    '<span class="carousel-control-next-icon" aria-hidden="true"><i class="fa-solid fa-angle-right fa-2xl" style="color: #cccccc;"></i></span>'
					      +	    '<span class="sr-only">Next</span>'
					      +	  '</a>'
					      +	'</div>';
				}
				else {
					html += '<h4 style="text-align: left; padding: 5px; font-weight: 600;">이 영화에 대한 한줄평이 존재하지 않아요.</h4>';
				}
				$("div#container").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function userReview()
	
</script>

<div id="container" class="container" style="padding: 0px;"></div>
