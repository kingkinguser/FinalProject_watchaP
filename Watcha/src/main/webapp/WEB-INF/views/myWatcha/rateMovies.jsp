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
div#div_content {width: 100%; margin: 0px 30px auto; padding-bottom: 30px;}
span#count_rating {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
img#img_movie {border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}
label {cursor: pointer; margin: 0px 8px;}
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
			if( (Math.floor($(window).scrollTop() + 1)) == ($(document).height() - $(window).height()) ){
				viewRateMovies(currentShowPageNo++);
			}
			if($(window).scrollTop() == 0){ // 맨위로 스크롤업 했을 경우 ==> 다시 처음부터 시작하도록 한다.
				$("div#div_rateMovies").empty();
				currentShowPageNo = 1;
				viewRateMovies(currentShowPageNo);
			}
		}); // end of $(window).scroll(function(){})
		
		// 정렬순서 변경하기
		$("input:radio[name='order']").click(function(){
			$("input:radio[name='order']").each(function(index, item){
				let check_icon = $(item).next();

				if($(this).prop("checked")){ // 라디오박스 체크
	 				check_icon.css({'color':'#ff0558'});
	 			}
				else {
					check_icon.css({'color':'#cccccc'});
				}
			});
			currentShowPageNo = 1;
			viewRateMovies(currentShowPageNo);

		}); // end of $("input:radio[name='order']").click(function(){})
		
		
	}); // end of $(document).ready(function(){})

	// 평가한 영화 전체 보여주기
	function viewRateMovies(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/viewRateMovies.action",
			data:{"currentShowPageNo":currentShowPageNo,
				  "order":$("input:radio[name='order']:checked").val()},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 평가한 영화가 존재하는 경우
					
					<%-- 평가한 영화(Ajax로 페이징 처리) --%>
					$.each(json, function(index, item){
						html += '<div style="width: 19%; margin: 3px; display: inline-block;" class="my-3">'
					          +   '<div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 280px; border: solid 1px #e6e6e6; border-radius: 2%;">'
                        	  +     '<img class="img-thumnail w-100" src="https://image.tmdb.org/t/p/w780/'+item.poster_path+'">'
				        	  +   '</div>'
			              	  +   '<div class="p-0 m-0 mt-2 px-2 text-center">'
				        	  +     '<a href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id='+item.movie_id+'" style="text-decoration: none; color: black;">';
			            if(item.movie_title.length > 11){ // 영화제목이 11글자보다 큰 경우
			            	html +=   '<p class="h6 card-title my-2"><span style="display:none;">'+item.movie_id+'</span>'+item.movie_title.substring(0, 12)+'...</p>';
			            }
			            else {
			            	html +=   '<p class="h6 card-title my-2"><span style="display:none;">'+item.movie_id+'</span>'+item.movie_title+'</p>';
			            }
			            html +=     '</a>'
			            	  +   '</div>'
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

					if(currentShowPageNo == 1){
						$("div#div_rateMovies").hide();
						$("div#div_rateMovies").html(html);
						$("div#div_rateMovies").fadeIn('30');
					}
					else {
						$("div#div_rateMovies").hide();
						$("div#div_rateMovies").append(html);
						$("div#div_rateMovies").fadeIn('30');
					}
				} // end of if(평가한 영화가 존재하는 경우)
				else {
					if(currentShowPageNo == 1){
			        	html = '<p class="h5 text-center my-3">평가한 영화가 없어요.</p>';
			        	$("div#div_nav_content").html(html);
					}
					else {
			        	html = '<button type="button" onclick="noMoreMovies()" class="h5 text-center my-3" style="text-decoration: none; color: #ff0558; border: none; background-color: transparent;">평가한 영화 전체를 다 조회하였어요. 맨 위로 이동할까요?</button>';
			        	$("div#div_noMoreMovies").html(html);
					}
				}
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function viewRateMovies(currentShowPageNo)
	
	// 더 이상 조회할 영화가 없을때
	function noMoreMovies(){
		$("div#div_noMoreMovies").empty();
		window.scrollTo(0,0);
	} // end of function noMoreMovies()
	
</script>

  <div class="container-fluid">
	<div id="div_container" class="container">
	  <div id="div_content" class="mx-auto">
	  
  		<h2 style="text-align: left; padding: 10px; font-weight: 800; margin: 15px;">평가한 영화<span id="count_rating">${requestScope.userInfo.count_rating}</span></h2>
	  	<div id="div_nav_content" class="container py-3" style="margin-bottom: 30px;"> 
		  
		  <%-- 정렬순서 선택하기 --%>
		  <div style="display: flex;">
		    <h5 class="mx-3">정렬순서를 바꿀 수 있어요.</h5>
		    <div style="font-weight: 500; margin-left: 15px;">
		      <label for="orderbyDateDesc">
		        <input type="radio" id="orderbyDateDesc" name="order" value="rating_date desc" style="display: none;" checked/>
			    <i class="fa-solid fa-check fa-lg" style="color: #ff0558;"></i><span class="px-2">별점평가 최신순</span>
		      </label>
		      <label for="orderbyDateAsc">
		        <input type="radio" id="orderbyDateAsc" name="order" value="rating_date asc" style="display: none;"/>
			    <i class="fa-solid fa-check fa-lg" style="color: #cccccc;"></i><span class="px-2">별점평가 오래된순</span>
		      </label>
		      <label for="orderbyRatingDesc">
		        <input type="radio" id="orderbyRatingDesc" name="order" value="rating desc" style="display: none;"/>
			    <i class="fa-solid fa-check fa-lg" style="color: #cccccc;"></i><span class="px-2">별점평가 높은순</span>
		      </label>
		      <label for="orderbyRatingAsc">
		        <input type="radio" id="orderbyRatingAsc" name="order" value="rating asc" style="display: none;"/>
			    <i class="fa-solid fa-check fa-lg" style="color: #cccccc;"></i><span class="px-2">별점평가 낮은순</span>
		      </label>
		    </div>
		  </div>

 		  <%-- 평가한 영화(Ajax로 페이징 처리) --%>
	      <div id="div_rateMovies" class="p-1"></div>
	      <%-- 영화가 더이상 없을 경우 --%>
	      <div id="div_noMoreMovies" class="p-1 text-center"></div>
	      
        </div>
      </div>
    </div>
  </div>  
  
