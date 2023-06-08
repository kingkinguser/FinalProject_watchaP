<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
div#div_container {width: 80%; display: flex; cursor: default;
				 /*font-family: 'IBM Plex Sans KR', sans-serif;*/
				  font-family: 'Noto Sans KR', sans-serif;}
div#div_myContent {width: 80%; margin: 30px auto; border-radius: 3%; border: solid 1px #cccccc; background-color: #ffffff;}
a#goMyPage {position: absolute; z-index:3; top: 1rem; right: 1.8rem; text-shadow: 1px 1px 1px #ffffff; opacity: 0.8;}
div#div_myBackground {position: relative; z-index:1; width: 100%; border-radius: 2% / 10%; opacity: 0.95; text-align: center; background-color: #666666;}
div#div_myBackground > img {position: relative; z-index:0; opacity: 0.15; width: 20%; margin: 0 -2.1px !important;}
img#img_wallPaper {position: relative; z-index:1; object-fit:cover; width: 100%; border-radius: 3% / 4%; opacity: 0.8;}
img#img_profile {position: relative; z-index:2; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; width: 10%;}
div#div_myProfile > div {margin: 15px auto; padding: 0px; text-align: center; font-weight: 500;}
div#div_myProfile > div.row > div > span {padding: 0px 5px;}
span#count_rating, span#reviewCount, span#collectionCount {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
.nav-pills a {display: block; padding: 0.5rem 0.5rem; color: black; font-weight: 500; background-color: white; text-decoration: none;}
.nav-pills .active {font-weight: 600; color: #ff0558; cursor: pointer;}
div#div_nav_content {position: relative; top:-2rem;}

div#div_review > div {background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;}
div#div_reviewPageBar {text-align: center; margin: 10px;}
div#div_reviewPageBar li {display:inline-block; padding: 0px 5px;}
div#div_reviewPageBar button {background-color: #ffffff; border: none;}

<%-- 캐러셀 --%>
.carousel-inner .carousel-item.active,
.carousel-inner .carousel-item-next,
.carousel-inner .carousel-item-prev {display: flex;}

.carousel-inner .carousel-item-right.active,
.carousel-inner .carousel-item-next {transform: translateX(25%);}
    
.carousel-inner .carousel-item-left.active, 
.carousel-inner .carousel-item-prev {transform: translateX(-25%);}

.carousel-inner .carousel-item-right,
.carousel-inner .carousel-item-left {transform: translateX(0);}

<%-- 포토티켓 카드 --%>
.flip-card {background-color: transparent; perspective: 2000px;}
.flip-card-inner {position: relative; width: 100%; text-align: center; transition: transform 0.6s; transform-style: preserve-3d; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);}
.flip-card:hover .flip-card-inner {transform: rotateY(180deg);}
.flip-card-front, .flip-card-back {position: absolute; width: 100%; backface-visibility: hidden;}
.flip-card-front {z-index: 2;}
.flip-card-back {transform: rotateY(180deg); z-index: 1;}

<%-- 검색바 --%>
input#searchWord{width: 100%; border: none; font-size: 11pt;}
input#searchWord:focus{outline: none;}
select {border: none; font-size: 11pt;}
select :focus{outline: none;}

div#div_rating label {min-width: 30px; padding: 4px; margin: 0px 10px; border-radius: 10%; box-shadow: 1px 1px 1px #e6e6e6; cursor: pointer;}
div#div_rating input {display: none;}

div#searchResult td {padding: 4px; margin: 0px; text-align: center;}

<%-- 한줄평등록 모달 --%>
div#registerReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
div#editReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus,
.modal-body input:focus {outline: none;}

<%-- 포토티켓 모달 --%>
div#makePhotoTicket{font-family: 'Noto Sans KR', sans-serif;}
</style>

<script>

	$(document).ready(function(){
		
		$("div#mycontent").css('padding-top','20px');
		$("div#mycontent").css('background-color','#f8f8f8');
		
 		myReviewPaging(1); // 회원의 전체 한줄평 보여주기

		$('.carousel').carousel({
			interval: 10000
		});

 		$('.carousel .carousel-item').each(function(){
 		    var minPerSlide = 4;
 		    var next = $(this).next();
 		    if (!next.length) {
 		        next = $(this).siblings(':first');
 		    }
 		    next.children(':first-child').clone().appendTo($(this));
 		    
 		    for (var i=0; i<minPerSlide; i++) {
 		        next = next.next();
 		        if (!next.length) {
 		        	next = $(this).siblings(':first');
 		      	}
 		        next.children(':first-child').clone().appendTo($(this));
			}
 		});		
 		
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
 		
 		$(".photoTitle").find('.download').hide();

 		$(".photoTitle").hover(function(){
 				$(this).find('.download').slideDown('fast');
	 		}, function(){
	 			$(this).find('.download').slideUp('fast');
 		});
 		
 		// 검색하기 - 관람일자 datepicker
 	    $.datepicker.setDefaults({
 	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
 	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
 	        ,showMonthAfterYear:true // 연도 먼저 나오고, 뒤에 월 표시
 	        ,changeYear: true        // 콤보박스에서 연 선택 가능
 	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
 	        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 달력의 월 부분 텍스트
        	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
 	    });
 		
 	    // input 을 datepicker로 선언
 	    $("input#fromDate").datepicker({
 	    	onClose:function(selectedDate){
 	    		$("input#toDate").datepicker("option", "minDate", selectedDate);
 	    	}
 	    });
 	    $("input#toDate").datepicker({
 	    	onClose:function(selectedDate){
 	    		$("input#fromDate").datepicker("option", "maxDate", selectedDate);
 	    	}
 	    });
 	    
 		// 검색하기 - 검색어를 입력후 엔터할 때
 		$("input#searchWord").keyup(function(e){
 			if(e.keyCode == 13){
 	 			searchResult();
 			}
 		}); // end of $("input#searchWord").keyup(function(){})
 		
 		// 검색하기 - 장르 체크박스 클릭할 때
 		$("input:checkbox[name='genre_id']").click(function(){
 			if($(this).prop("checked")){ // 체크박스 체크
 				$(this).parent().parent().css({'background-color':'#ff0558', 'color':'#fff'}).fadeIn('fast'); // 배경색, 글씨색 변경
 			}
 			else { // 체크박스 체크해제
 				$(this).parent().parent().css({'background-color':'#fff0f5', 'color':'gray'}).fadeIn('fast'); // 배경색, 글씨색 변경
 			}
 		}); // end of $("input:checkbox[name='genre_id']").click(function(){})

 		// 검색하기 - 별점 체크박스 클릭할 때
 		$("input:checkbox[name='rating']").click(function(){
 			if($(this).prop("checked")){ // 체크박스 체크
 				$(this).parent().find('i').css('color','#fdd346').fadeIn('fast'); // 별 아이콘 색깔 노란색으로 변경
 			}
 			else { // 체크박스 체크해제
 				$(this).parent().find('i').css('color','#cccccc').fadeIn('fast'); // 별 아이콘 색깔 회색으로 변경
 			}
 		}); // end of $("input:checkbox[name='rating']").click(function(){})

 	    // 검색하기 - 날짜지우기 버튼을 클릭할 때
 	    $("button#btnDateReset").click(function(){
 	    	$("input#fromDate").val("");
 	    	$("input#toDate").val("");
 	    });
 	    
 	    // 검색하기 - 초기화 버튼을 클릭할 때
 	    $("button#btnSearchReset").click(function(){
 	    	// 검색어 삭제
 	    	$("input#searchWord").val("");
 	    	
 	    	// 장르종류 삭제
 	    	$("input:checkbox[name='genre_id']").prop("checked", false);
			$("ul#ul_genre").find('li').css({'background-color':'#fff0f5', 'color':'gray'}).fadeIn('fast'); // 배경색, 글씨색 변경
 	    	
			// 별점 삭제
			$("input:checkbox[name='rating']").prop("checked", false);
			$("div#div_rating").find('label').find('i').css('color','#cccccc').fadeIn('fast'); // 별 아이콘 색깔 회색으로 변경
			
			// 관람일자 삭제
			$("input#fromDate").val("");
 	    	$("input#toDate").val("");
 	    	
 	    	// 검색결과 비우기
 	    	$("div#searchResult").empty();
 	    }); // end of $("button#btnSearchReset").click(function(){})
 		
 		// 한줄평 "등록" 버튼 클릭 시
 		$("button#btnAdd").click(function(){
 			if($("textarea#review_content").val().trim() == ""){
 				alert("한줄평 내용을 적어주세요.");
 			}
 			else {
 				$.ajax({
 					url:"<%= ctxPath%>/addReview.action",
					data:{"movie_id":"290859",
						  "user_id":"${sessionScope.loginuser.user_id}",
						  "review_content":$("textarea#review_content").val(),
						  "spoiler_status":$("input#spoiler_status").val()}, 
 					type:"post",
 					dataType:"json",
 					success:function(json){
 					//	console.log("확인용 : "+JSON.stringify(json));
						location.href="<%= request.getContextPath()%>/allReview.action?movie_id="+"290859";
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
 			if($("textarea#review_content").val().trim() == ""){
 				alert("한줄평 내용을 적어주세요.");
 			}
 			else {
	 			$.ajax({
	 				url:"<%= ctxPath%>/updateReview.action",
					data:{"review_id":"${requestScope.reviewInfo.review_id}",
						  "review_content":$("textarea#review_content").val(),
						  "spoiler_status":$("input#spoiler_status").val()}, 
	 				type:"post",
	 				dataType:"json",
	 				success:function(json){
	 				//	console.log("확인용 : "+JSON.stringify(json));
						location.href="<%= request.getContextPath()%>/allReview.action?movie_id="+"290859";
						// 추후 수정예정
	 				},
	 				error: function(request, status, error){
	 		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 		        }			
	 			});
 			}
 		}); // end of $("button#btnEdit").click(function(){})
 		
	}); // end of $(document).ready(function(){})
	
	
	// 내 한줄평 보여주기(8개씩 페이징처리)
	function myReviewPaging(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/myReviewPaging.action",
			data:{"currentShowPageNo":currentShowPageNo},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 작성한 한줄평이 존재하는 경우
					
					<%-- 한줄평(Ajax로 페이징 처리) --%>
					$.each(json, function(index, item){
						html += '<div id="'+item.review_id+'" class="p-1 m-1" style="width: 48%; display: inline-block;">'
							  +   '<div class="row col-md-12 mx-auto my-auto p-1">'
							  +     '<div class="col-md-4 p-1" style="display: inline-block;">'
							  + 	  '<img class="img-thumnail rounded" style="width: 100%; margin: 5px auto; border: solid 1px #e6e6e6;" src="https://image.tmdb.org/t/p/w780/'+item.poster_path+'">'
							  + 	'</div>'
							  +     '<div class="col-md-8 p-1" style="display: inline-block;">'
							  + 	  '<p class="h6 pl-2 my-2" style="border-bottom: solid 1px #e6e6e6; padding: 5px;"><span style="display: none;">'+item.movie_id+'</span>'+item.movie_title+'</p>'
							  + 	  '<p style="font-size: 11pt; padding: 3px; margin: 3px; height: 50px; overflow: auto;">'+item.review_content+'</p>';
						if(item.spoiler_status == 0){ // 스포일러 포함X
							html +=   '<p class="m-1 text-center" style="font-size: 11pt; color: gray;"><i class="fa-solid fa-face-meh" style="color: #e6e6e6;"></i><span class="pl-1">스포일러 미포함</span></p>';
						}
						else { // 스포일러 포함O
							html +=   '<p class="m-1 text-center" style="font-size: 11pt; color: gray;"><i class="fa-solid fa-face-meh" style="color: #ff0558;"></i><span class="pl-1">스포일러 포함</span></p>';
						}
						html += 	  '<div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 10.5pt; color: gray;">'
							  + 	    '<p class="mx-2 m-0">'+item.review_date+'</p>'
							  + 	    '<p class="mx-2 m-0"><i class="fa-solid fa-heart" style="color: #ff0558;"></i><span class="pl-1">'+item.number_of_likes+'</span></p>'
							  + 	    '<p class="mx-2 m-0"><i class="fa-solid fa-comments" style="color: #e6e6e6;"></i><span class="pl-1">'+item.number_of_comments+'</span></p>'
						  	  +       '</div>';
						html += 	'</div>'
						  	  +   '</div>'
						  	  + '</div>';
					}); // end of $.each(json, function(index, item){})
				}
				$("div#div_review").html(html);
				showReviewPageBar(Number(currentShowPageNo));
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function myReviewPaging(currentShowPageNo)
	
	// 한줄평 페이지바 보여주기
	function showReviewPageBar(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/showReviewPageBar.action",
			data:{"currentShowPageNo":currentShowPageNo},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				$("div#div_reviewPageBar").html(json.pageBar);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function showReviewPageBar(currentShowPageNo)
	
	// 검색하기 - 검색결과
	function searchResult(){
		
		// 장르종류로 검색
		let arr_genre_id = [];
		$("input:checkbox[name='genre_id']:checked").each(function(index, item){
			arr_genre_id.push($(item).val());
		});
		let str_genre_id = arr_genre_id.join();
		
		// 별점으로 검색
		let arr_rating = [];
		$("input:checkbox[name='rating']:checked").each(function(index, item){
			arr_rating.push($(item).val());
		});
		let str_rating = arr_rating.join();
		
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/searchResult.action",
			data:{"searchWord":$("input#searchWord").val(),
				  "str_genre_id":str_genre_id,
				  "str_rating":str_rating,
				  "from_watching_date":$("input#fromDate").val(),
				  "to_watching_date":$("input#toDate").val()},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){
					html += '<h5 style="padding-left: 5px; font-weight: 600;">검색결과</h5>';
					
					$.each(json, function(index, item){
				        html += '<div style="width: 32%; display: inline-block;" class="m-1">'
					          +   '<div class="mx-auto my-auto p-2" style="border: solid 1px #e6e6e6; border-radius: 2%;">'
					          +     '<table style="width: 100%; height: 220px; overflow: auto;">'
					          +       '<tbody>'
					          +         '<tr>'
					          +           '<td><h6>'+item.movie_title+'</h6></td>'
					          +         '</tr>'
					          +         '<tr style="border-top: solid 1px #e6e6e6;">'
					          +           '<td>'+item.genre_name+'</td>'
					          +         '</tr>'
					          +         '<tr>'
					          +           '<td>'
					          +			    '<span class="mr-2">'+item.rating+'</span><span>';
			        	if(item.rating %1 != 0){ // 별점에 소수점 포함 (예: 3.5)
			        		let starCount = Math.floor(item.rating);
			        		for(let i=0; i<starCount; i++){
			        			html += '<i class="fa-solid fa-star" style="color: #fdd346;"></i>';
			        		}
							html += '<i class="fa-solid fa-star-half" style="color: #fdd346;"></i>';
			        	}
			        	else {
			        		for(let i=0; i<item.rating; i++){
			        			html += '<i class="fa-solid fa-star" style="color: #fdd346;"></i>';
			        		}
			        	}
					    html +=			  '</span></td>'
					          +         '</tr>'
					          +         '<tr>';
					    if(item.watching_date != null){
					    	html +=	      '<td>'+item.watching_date+'</td>';
					    }
					    else {
					    	html +=		  '<td>등록된 관람일자가 없어요</td>';
					    }
					    html +=         '</tr>'
					          +         '<tr>'
					          +           '<td colspan="2" class="text-center"><a class="btn btn-sm btn-secondary" href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id='+item.movie_id+'">자세히 보기</a></td>'
					          +         '</tr>'
					          +       '</tbody>'
					          +     '</table>'
					          +   '</div>'	
					          + '</div>';
						
					}); // end of $.each(json, function(index, item){})
				}
				else {
					html += "<p>검색조건에 해당하는 검색결과가 없어요.</p>";
				}
				
				$("div#searchResult").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	}
	
</script>

  <div class="container-fluid">
	<div id="div_container" class="container">
	  <div id="div_myContent">
	  	<div style="overflow: hidden; height: 200px;">
	  	  <div class="row">
			<div class="col-md-12 text-right">
			  <%-- 마이페이지로 이동 --%>
			  <a id="goMyPage" href="#"><i class="fa-solid fa-gear fa-2xl" style="color: #cccccc;"></i></a>
			</div>
	  	  </div>
	  	  <%-- 배경이미지(회원이 평가한 영화 중 최근 5개) --%>
	  	  <div id="div_myBackground">
	  	   <c:if test="${not empty requestScope.ratingFiveList}">
	  	    <c:forEach var="movie" items="${requestScope.ratingFiveList}">
	          <img class="p-0 m-0" style="border-radius: 8%;" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
	  	    </c:forEach>
	  	   </c:if>
	  	   <c:if test="${empty requestScope.ratingFiveList}">
	        <img class="p-0 m-0" src="<%= ctxPath%>/resources/images/팝콘아이콘.png">
	  	   </c:if>
	  	  </div>
	  	</div>
  		
  		<div style="padding: 0 50px; margin: 0px;">
  		  <div id="div_myProfile">
  		    <%-- 회원의 프로필  --%>
			<div style="display: flex; margin: 0px; position: relative; top: -2rem;" class="row">
			  <c:if test="${not empty requestScope.userInfo.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/${requestScope.userInfo.profile_image}"/>
			  </c:if>
			  <c:if test="${empty requestScope.userInfo.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
			  </c:if>
		    </div>
			<div style="position: relative; top: -2rem;" class="p-0 m-0">
  			  <h5 style="text-align: left; padding: 0 5px; font-size: 20pt; font-weight: 900; margin: 10px 0px;">${requestScope.userInfo.nickname}</h5>
		      <c:if test="${not empty requestScope.userInfo.profile_message}">
  			    <p style="text-align: left; padding: 0 5px; font-weight: 600; margin-top: 5px;">${requestScope.userInfo.profile_message}</p>
		      </c:if>
  			
	  		  <ul class="nav nav-pills row" style="padding: 5px 0px 15px 15px; border-bottom: solid 1px #e6e6e6;">
			    <li class="nav-item">
			      <a class="active" data-toggle="pill" href="#ratingMovies">평균별점<span style="padding-left: 5px;">${requestScope.userInfo.avg_rating}</span></a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#review">한줄평<span style="padding-left: 5px;">${requestScope.userInfo.reviewCount}개</span></a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#collection">컬렉션<span style="padding-left: 5px;">${requestScope.userInfo.collectionCount}개</span></a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#movieDiary">무비다이어리</a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#searchInfo">검색하기</a>
			    </li>
			  </ul>
  			</div>
  		  </div>
  		</div>
  		
	  	<div id="div_nav_content" class="tab-content pt-4 pb-3 my-3"> <%-- 평가한 영화 / 한줄평 / 컬렉션 / 무비다이어리 --%>
	  	  <div id="ratingMovies" class="tab-pane container active">
	  	    <div style="display: flex; padding: 0 50px;">
	 	      <h5 style="padding-left: 5px; font-weight: 600;"><span>${requestScope.userInfo.nickname}</span>&nbsp;님이 선호하는 장르</h5>
	        </div>
	        <div class="row mx-auto my-1 mb-5" style="padding: 0 50px;">
	          <div id="preference" style="width: 100%; height: 400px; border: solid 1px #e6e6e6; border-radius: 2%;">
	          </div>
		    </div>

	        <div style="display: flex; padding: 0 50px;" class="row mx-auto">
	 	      <h5 class="col-md-9" style="padding-left: 5px; font-weight: 600;">평가한 영화<span id="count_rating">${requestScope.userInfo.count_rating}</span></h5>
	 	      <a class="col-md-3 text-right" href="<%= ctxPath%>/rateMovies.action" style="color: black; text-decoration: none;">전체보기</a>
	        </div>
	        <div id="div_rateMovies" class="row mx-auto my-1 mb-3" style="padding: 0 50px;">
	          <div id="movieCarousel" class="carousel slide w-100" data-ride="carousel">
	            <div class="carousel-inner w-100" role="listbox">
	             <c:forEach var="movie" items="${requestScope.ratingMoviesList}" varStatus="status">
	              <c:if test="${status.index == 0}">
					<div class="carousel-item active">
					  <div class="col-md-3 p-1">
						<div class="card">
						  <a href="#" style="text-decoration: none; color: black;">
					        <div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 220px;">
	                          <img class="img-thumnail w-100" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
					        </div>
		                    <div class="card-body text-center px-0">
		                      <div style="overflow: hidden; height: 40px;" class="p-0 m-0 px-3">
						        <h6 class="card-title"><span style="display:none;">${movie.movie_id}</span>${movie.movie_title}</h6>
		                      </div>
						      <div class="card-text px-1">
						       <span style="color: #FDD346;">${movie.rating}</span>
						       <c:if test="${movie.rating %1 ne 0}"> <%-- 별점에 소수점 포함 (예: 3.5) --%>
						        <fmt:parseNumber var="rating" value="${movie.rating}" integerOnly="true" />
						        <c:forEach begin="1" end="${rating}">
					             <i class="fa-solid fa-star" style="color: #FDD346;"></i>
						        </c:forEach>
								 <i class="fa-solid fa-star-half" style="color: #FDD346;"></i>						       
						       </c:if>
						       <c:if test="${movie.rating %1 eq 0}"> <%-- 별점에 소수점 포함X (예: 4) --%>
						        <c:forEach begin="1" end="${movie.rating}">
					             <i class="fa-solid fa-star" style="color: #FDD346;"></i>
						        </c:forEach>
						       </c:if>
						      </div>
					  	    </div>
						  </a>
				    	</div>
					  </div>
					</div>
	              </c:if>
	              <c:if test="${status.index != 0}">
					<div class="carousel-item">
					  <div class="col-md-3 p-1">
						<div class="card">
						  <a href="#" style="text-decoration: none; color: black;">
					        <div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 220px;">
	                          <img class="img card-img-top" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
					        </div>
		                    <div class="card-body text-center px-0">
		                      <div style="overflow: hidden; height: 40px;" class="p-0 m-0 px-3">
						        <h6 class="card-title"><span style="display:none;">${movie.movie_id}</span>${movie.movie_title}</h6>
		                      </div>
						      <div class="card-text px-1">
						       <span style="color: #FDD346;">${movie.rating}</span>
						       <c:if test="${movie.rating %1 ne 0}"> <%-- 별점에 소수점 포함 (예: 3.5) --%>
						        <fmt:parseNumber var="rating" value="${movie.rating}" integerOnly="true" />
						        <c:forEach begin="1" end="${rating}">
					             <i class="fa-solid fa-star" style="color: #FDD346;"></i>
						        </c:forEach>
								 <i class="fa-solid fa-star-half" style="color: #FDD346;"></i>						       
						       </c:if>
						       <c:if test="${movie.rating %1 eq 0}"> <%-- 별점에 소수점 포함X (예: 4) --%>
						        <c:forEach begin="1" end="${movie.rating}">
					             <i class="fa-solid fa-star" style="color: #FDD346;"></i>
						        </c:forEach>
						       </c:if>
						      </div>
					  	    </div>
						  </a>
				    	</div>
					  </div>
					</div>
	              </c:if>
	             </c:forEach>
	
	            </div>
	            <a class="carousel-control-prev w-auto" href="#movieCarousel" role="button" data-slide="prev">
	                <span aria-hidden="true"><i class="fa-solid fa-angle-left fa-2xl" style="color: #cccccc;"></i></span>
	                <span class="sr-only">Previous</span>
	            </a>
	            <a class="carousel-control-next w-auto" href="#movieCarousel" role="button" data-slide="next">
	                <span aria-hidden="true"><i class="fa-solid fa-angle-right fa-2xl" style="color: #cccccc;"></i></span>
	                <span class="sr-only">Next</span>
	            </a>
	      	  </div>
		    </div>
		  </div>
	  	
		  <div id="review" class="tab-pane container fade">
	  	    <div style="display: flex; padding: 0 50px;" class="row mx-auto">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">내 한줄평<span id="reviewCount">${requestScope.userInfo.reviewCount}</span></h5>
	        </div>
	        
    		<%-- 한줄평(Ajax로 페이징 처리) --%>
	        <div id="div_review" style="padding: 0 50px; display: inline-block;" class="my-1 mb-3 mx-auto"></div>
		    <div id="div_reviewPageBar">${requestScope.pageBar}</div>
		  </div>
	  	
		  <div id="collection" class="tab-pane container fade">
	  	    <div style="display: flex; padding: 0 50px;" class="row mx-auto">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">내 컬렉션<span id="collectionCount">${requestScope.userInfo.collectionCount}</span></h5>
	        </div>
	        <div class="row mx-auto my-1 mb-3" style="padding: 0 50px;">
			  <div class="col-md-4 p-0">
				<div class="card m-1">
				  <div style="display:inline-block; text-align: center;">
				    <a href="#" style="text-decoration: none; color: black;">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
				    </a>
				  </div>
		    	</div>
			    <h5 class="card-title m-2">컬렉션제목</h5>
			  </div>
			  <div class="col-md-4 p-0">
				<div class="card m-1">
				  <div style="display:inline-block; text-align: center;">
				    <a href="#" style="text-decoration: none; color: black;">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
				    </a>
				  </div>
		    	</div>
			    <h5 class="card-title m-2">컬렉션제목</h5>
			  </div>
			  <div class="col-md-4 p-0">
				<div class="card m-1">
				  <div style="display:inline-block; text-align: center;">
				    <a href="#" style="text-decoration: none; color: black;">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
                      <img class="img-thumnail" style="width: 48%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
				    </a>
				  </div>
		    	</div>
			    <h5 class="card-title m-2">컬렉션제목</h5>
			  </div>
		    </div>
		  </div>
		  
		  <div id="movieDiary" class="tab-pane container fade">
	  	    <div style="display: flex; padding: 0 50px;">
	 	      <h5 style="padding-left: 5px; font-weight: 600; margin: 4px 0 0 0;">포토티켓</h5>
			  <button type="button" class="btn btn-sm btn-light mx-4 mb-1" data-toggle="modal" data-target="#makePhotoTicket">포토티켓 만들기</button>
	        </div>
	        <div id="photoTicket" class="row mx-auto my-1 mb-5 carousel slide w-100" data-ride="carousel" style="padding: 0 50px;">
	          <div class="carousel-inner w-100">
	            <div class="carousel-item active">
		          <div class="col-md-3 p-0">
		            <div class="flip-card" style="height: 250px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
		              </div>
				    </div>
			        <h5 class="photoTitle card-title p-2" style="position: relative; top: 0.5rem; cursor: pointer;">영화제목<i class="download fa-regular fa-circle-down ml-2" style="color: gray;" onclick=""></i></h5>
		          </div>
		          <div class="col-md-3 p-0">
		            <div class="flip-card" style="height: 250px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
		              </div>
				    </div>
			        <h5 class="photoTitle card-title p-2" style="position: relative; top: 0.5rem; cursor: pointer;">영화제목<i class="download fa-regular fa-circle-down ml-2" style="color: gray;" onclick=""></i></h5>
		          </div>
		          <div class="col-md-3 p-0">
		            <div class="flip-card" style="height: 250px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
		              </div>
				    </div>
			        <h5 class="photoTitle card-title p-2" style="position: relative; top: 0.5rem; cursor: pointer;">영화제목<i class="download fa-regular fa-circle-down ml-2" style="color: gray;" onclick=""></i></h5>
		          </div>
		          <div class="col-md-3 p-0">
		            <div class="flip-card" style="height: 250px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
		              </div>
				    </div>
			        <h5 class="photoTitle card-title p-2" style="position: relative; top: 0.5rem; cursor: pointer;">영화제목<i class="download fa-regular fa-circle-down ml-2" style="color: gray;" onclick=""></i></h5>
		          </div>
		        </div>
	            <div class="carousel-item">
		          <div class="col-md-3 p-0">
		            <div class="flip-card" style="height: 250px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
			    	    </div>
		              </div>
				    </div>
			        <h5 class="photoTitle card-title p-2" style="position: relative; top: 0.5rem; cursor: pointer;">영화제목<i class="download fa-regular fa-circle-down ml-2" style="color: gray;" onclick=""></i></h5>
		          </div>
			    </div>
	          </div>
		      <a class="carousel-control-prev" href="#photoTicket" role="button" data-slide="prev">
		        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		        <span class="sr-only">Previous</span>
		      </a>
		      <a class="carousel-control-next" href="#photoTicket" role="button" data-slide="next">
		        <span class="carousel-control-next-icon" aria-hidden="true"></span>
		        <span class="sr-only">Next</span>
		      </a>
	        </div>
	        
	  	    <div style="display: flex; padding: 0 50px;">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">무비다이어리</h5>
	        </div>
	        <div class="row mx-auto my-1 mb-3" style="padding: 0 50px;">
	          <div id="movieCalendar" style="width: 100%; height: 400px; border: solid 1px #e6e6e6; border-radius: 2%;">
	          </div>
		    </div>
		  </div>
  	    
  	      <div id="searchInfo" class="tab-pane container fade">
            <div id="div_searchBar" class="m-0 mb-3 mx-auto" style="padding: 0 40px;">
              <%-- 영화제목으로 검색하기 --%>
              <div class="mx-2 mb-3" style="display: flex;">
                <div id="movie_title" style="width: 55%; display: flex; border: solid 1px #e6e6e6; padding: 10px 20px; border-radius: 10%/60%;">
                  <input type="text" id="searchWord" name="searchWord" placeholder="영화제목으로 검색하기" autocomplete="off" />
                  <i class="fa-solid fa-magnifying-glass fa-lg" onclick="searchResult()" style="color: gray; cursor: pointer; padding: 10px 0px 8px 0px;"></i>
                </div>
                <p style="display: flex; color: gray; font-size: 11pt;" class="ml-3 mt-2">별점평가를 한 영화에 한해서만 검색 가능해요.</p>
              </div>
              
              <%-- 장르종류로 검색하기 --%>
              <div class="m-2 my-2" style="width: 100%; display: flex;">
			    <span class="pr-2 h6 py-2" style="width: 20%;">장르종류</span>
			    <ul id="ul_genre" style="list-style-type: none;" class="m-0 p-0">
			      <c:forEach var="genre" items="${requestScope.genreList}" varStatus="status">
			        <li style="display: inline-block; border-radius: 15%; background-color: #fff0f5; box-shadow: 1px 1px 1px #e6e6e6; color: gray;" class="p-1 m-1">
			          <label for="genre_id${status.index}" class="m-0 p-0 px-1" style="cursor: pointer;">
			            <span style="font-size: 10pt;">${genre.genre_name}</span>
			            <input type="checkbox" id="genre_id${status.index}" name="genre_id" value="${genre.genre_id}" style="display:none;"/>
			          </label>
			        </li>
			      </c:forEach>
			    </ul>              
              </div>
              
              <%-- 별점으로 검색하기 --%>
              <div class="m-2 my-2" style="width: 85%; display: flex;">
			    <span class="pr-2 h6 py-2" style="width: 18%;">별점</span>
			    <div id="div_rating" style="display: inline-block;" class="p-1 m-1">
	              <label for="rating0.5">
	                <i class="fa-solid fa-star-half" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating0.5" name="rating" value="0.5" />
	              </label>
	              <label for="rating1">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating1" name="rating" value="1" />
	              </label>
	              <label for="rating1.5">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                <i class="fa-solid fa-star-half" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating1.5" name="rating" value="1.5" />
	              </label>
	              <label for="rating2">
			        <c:forEach begin="1" end="2">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <input type="checkbox" id="rating2" name="rating" value="2" />
	              </label>
	              <label for="rating2.5">
			        <c:forEach begin="1" end="2">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <i class="fa-solid fa-star-half" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating2.5" name="rating" value="2.5" />
	              </label>
	              <label for="rating3">
			        <c:forEach begin="1" end="3">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <input type="checkbox" id="rating3" name="rating" value="3" />
	              </label>
	              <label for="rating3.5">
			        <c:forEach begin="1" end="3">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <i class="fa-solid fa-star-half" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating3.5" name="rating" value="3.5" />
	              </label>
	              <label for="rating4">
			        <c:forEach begin="1" end="4">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <input type="checkbox" id="rating4" name="rating" value="4" />
	              </label>
	              <label for="rating4.5">
			        <c:forEach begin="1" end="4">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <i class="fa-solid fa-star-half" style="color: #cccccc;"></i>
	                <input type="checkbox" id="rating4.5" name="rating" value="4.5" />
	              </label>
	              <label for="rating5">
			        <c:forEach begin="1" end="5">
	                <i class="fa-solid fa-star" style="color: #cccccc;"></i>
	                </c:forEach>
	                <input type="checkbox" id="rating5" name="rating" value="5" />
	              </label>
	            </div>
              </div>

              <%-- 관람일자로 검색하기 --%>
              <div class="m-2 my-2" style="width: 100%; display: inline-block;">
			    <span class="pr-3 h6">관람일자</span>
				<input type="text" id="fromDate" readonly="readonly" style="width: 15%; border: none; cursor: pointer; color: gray;">
	            <span>&nbsp;~&nbsp;</span> 
	            <input type="text" id="toDate" readonly="readonly" style="width: 15%; border: none; cursor: pointer; color: gray;">
                <button type="button" id="btnDateReset" class="btn btn-sm btn-secondary m-1">날짜 지우기</button>
                <button type="button" class="btn btn-md m-1" onclick="searchResult()" style="position: relative; float: right; background-color: #ff0558; color: #fff;">검색하기</button>
                <button type="button" id="btnSearchReset" class="btn btn-md m-1" style="position: relative; float: right; background-color: #ff80aa; color: #fff;">초기화</button>
              </div>
              
      	    </div>
      	    
	  	    <div style="padding: 0 50px;" class="mt-3 mx-auto">
 	          <div id="searchResult" class="my-3" style="width: 100%;"></div>
 	        </div>
 	        
	  	  </div>
	  	  
	    </div>
	  </div>
    </div>

		<%-- 포토티켓 모달창 --%>
		<div class="modal fade" id="makePhotoTicket">
		  <div class="modal-dialog modal-dialog-centered mx-auto">
		    <div class="modal-content mx-auto" style="width: 75%;">
		      <div class="modal-body text-center" style="height: 580px; margin: 10px;">
		        <h5 class="modal-title" style="font-weight: bold;">포토티켓 만들기<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
			    <div class="row mx-auto mt-3" style="display: flex; padding: 10px 0; height: 400px;">
			      <div id="photoTicketFront" class="col-md-6 p-0 m-0" style="width: 100%; border: solid 1px #e6e6e6; border-radius: 1%;">
                    <img class="img-thumnail rounded" style="width: 100%;" src="<%= ctxPath %>/resources/images/포스터.jpg" />
				    <input type="text" style="text-align: center; border: none; font-size: 10pt; margin: 5px;" placeholder="포토티켓에 문구를 넣어보세요."/>
	    	      </div>
			      <div id="photoTicketBack" class="col-md-6 p-0 py-3 m-0" style="width: 100%; border: solid 1px #e6e6e6; border-radius: 1%;">
			      	<div>
			      	  <p class="h4 my-3">가디언즈 오브 갤럭시: Volume 3</p>
			      	  <div class="mx-auto">
			      	    <p class="h5 my-3">관람일자</p>
			      	    <p class="my-3">영화장르</p>
			      	    <p class="my-3 p-3 text-left" style="font-size: 11pt;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
				        <div class="text-center">
			              <i class="fa-solid fa-star fa-2xl" style="color: #FDD346;"></i>
			              <i class="fa-solid fa-star fa-2xl" style="color: #FDD346;"></i>
			              <i class="fa-solid fa-star fa-2xl" style="color: #FDD346;"></i>
			              <i class="fa-solid fa-star fa-2xl" style="color: #FDD346;"></i>
			              <i class="fa-solid fa-star fa-2xl" style="color: #FDD346;"></i>
				        </div>
			      	  </div>
			      	</div>
	    	      </div>
			    </div>
				<div class="mb-4">
				  <button type="button" class="btn btn-sm" style="background-color: #e6e6e6;">포스터 사진 변경하기</button>
				  <button type="button" class="btn btn-sm" style="background-color: #e6e6e6;">포토티켓에 텍스트 문구 없애기</button>
				</div>
		        <button type="button" class="btn btn-secondary" style="padding: 10px 30px;">포토티켓 다운로드</button>
		        <button type="button" class="btn" style="padding: 10px 30px; color: #ffffff; background-color: #ff0558;">포토티켓 등록하기</button>
		      </div>
		    </div>
		  </div>
		</div>

	
		<%-- 한줄평 등록하기 --%>
        <div style="position: relative; left: 150px; bottom: 33px; width: 150px;">
          <label for="check_comment" style="cursor: pointer;">
             <span class="commenti">
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
             </span>
          </label>
        </div> 
  </div>

	  <%-- 한줄평 등록 모달창 --%>
      <c:if test="${empty requestScope.reviewInfo}">
		<div class="modal fade" id="registerReview">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-body">
		        <h5 class="modal-title" style="font-weight: bold;">영화제목<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
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
		</div>
	  </c:if>
      <%-- 한줄평 등록 모달창 끝 --%>
		
 	  <%-- 한줄평 수정 모달창 --%>
      <c:if test="${not empty requestScope.reviewInfo}">
       	<div class="modal fade" id="editReview">
		  <div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			  <div class="modal-body">
			  	<h5 class="modal-title" style="font-weight: bold;">영화제목<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
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
		</div>
	  </c:if>
      <%-- 한줄평 수정 모달창 끝 --%>
		