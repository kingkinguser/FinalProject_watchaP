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
div#div_container {width: 100%; display: flex; background-color: #ffffff; cursor: default;
				 /*font-family: 'IBM Plex Sans KR', sans-serif;*/
				  font-family: 'Noto Sans KR', sans-serif;}
div#div_content {width: 80%; margin: 0px 30px auto; padding-bottom: 30px;}
span#count_rating {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
img#img_movie {border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}
</style>

<script>

	$(document).ready(function(){
		
		$("div#mycontent").css('padding-top','0px');
		$("div#mycontent").css('background-color','#ffffff');

		let currentShowPageNo = 1;
		viewRateMovies(currentShowPageNo);
		
		$(window).scroll(function(){
			// 스크롤된 스크롤탑의 위치값이 웹브라우저창의 높이만큼 내려갔을때 (스크롤다운하여 웹브라우저의 맨밑까지 내렸을 경우) 
			// 즉 스크롤탑의 위치값이 (보여주는 문서의 높이값 - 웹브라우저의 높이값) 과 같을때
			if( ($(window).scrollTop() + 1) == ($(document).height() - $(window).height()) ){
				viewRateMovies(currentShowPageNo++);
			}
			
			if($(window).scrollTop() == 0){ // 맨위로 스크롤업 했을 경우 ==> 다시 처음부터 시작하도록 한다.
				$("div#div_rateMovies").empty();
				currentShowPageNo = 1;
				viewRateMovies(currentShowPageNo);
			}
		}); // end of $(window).scroll(function(){})
		
		
	}); // end of $(document).ready(function(){})

	// 평가한 영화 전체 보여주기
	function viewRateMovies(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/viewRateMovies.action",
			data:{"currentShowPageNo":currentShowPageNo},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 평가한 영화가 존재하는 경우
					
					<%-- 평가한 영화(Ajax로 페이징 처리) --%>
					$.each(json, function(index, item){
						html += '<div style="width: 19%; margin: 3px; display: inline-block;" class="my-3">'
					          +   '<div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 260px; border: solid 1px #e6e6e6; border-radius: 2%;">'
                        	  +     '<img class="img-thumnail w-100" src="https://image.tmdb.org/t/p/w780/'+item.poster_path+'">'
				        	  +   '</div>'
			              	  +   '<div class="p-0 m-0 mt-2 px-2 text-center">';
			            if(item.movie_title.length > 11){ // 영화제목이 11글자보다 큰 경우
			            	html += '<p class="h6 card-title my-2"><span style="display:none;">'+item.movie_id+'</span>'+item.movie_title.substring(0, 12)+'...</p>';
			            }
			            else {
			            	html += '<p class="h6 card-title my-2"><span style="display:none;">'+item.movie_id+'</span>'+item.movie_title+'</p>';
			            }
			            html += '</div>'
			              	  +   '<div class="card-text text-center">'
						      +     '<span style="color: #FDD346; padding: 0 10px;">'+item.rating+'</span>';
			        	if(item.rating %1 != 0){ // 별점에 소수점 포함 (예: 3.5)
			        		let starCount = Math.floor(item.rating);
			        		for(let i=0; i<starCount; i++){
			        			html += '<i class="fa-solid fa-star" style="color: #FDD346;"></i>';
			        		}
							html += '<i class="fa-solid fa-star-half" style="color: #FDD346;"></i>';
			        	}
			        	else {
			        		for(let i=0; i<item.rating; i++){
			        			html += '<i class="fa-solid fa-star" style="color: #FDD346;"></i>';
			        		}
			        	}
			        	html +=   '</div>'
			        		  + '</div>';
					}); // end of $.each(json, function(index, item){})
				}
				if(currentShowPageNo == 1){
					$("div#div_rateMovies").html(html);
				}
				else {
					$("div#div_rateMovies").append(html);
				}
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function viewRateMovies(currentShowPageNo)
	
</script>

  <div class="container-fluid">
	<div id="div_container" class="container-fluid">
	  <div id="div_content" class="mx-auto">
	  
  		<h2 style="text-align: left; padding: 10px; font-weight: 800; margin: 15px;">평가한 영화<span id="count_rating">${requestScope.userInfo.count_rating}</span></h2>
	  	<div id="div_nav_content" class="container py-3" style="margin-bottom: 30px;"> 

 		  <%-- 평가한 영화(Ajax로 페이징 처리) --%>
	      <div id="div_rateMovies" class="p-1"></div>
	      
        </div>
      </div>
    </div>
  </div>  
  
