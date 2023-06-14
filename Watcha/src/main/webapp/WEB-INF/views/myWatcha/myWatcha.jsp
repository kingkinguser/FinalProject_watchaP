<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

  <%-- 풀캘린더(무비다이어리) --%>
  <link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />
  <script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
  <script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

  <%-- 하이차트(선호장르) --%>
  <script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
  <script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/wordcloud.js"></script>
  <script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
  <script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
  <script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

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
span#rating_count, span#reviewCount, span#collectionCount {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
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
input#fromDate:focus, input#toDate:focus{outline: none;}

div#div_rating label {min-width: 30px; padding: 4px; margin: 0px 10px; border-radius: 10%; box-shadow: 1px 1px 1px #e6e6e6; cursor: pointer;}
div#div_rating input {display: none;}

div#searchResult td {padding: 4px; margin: 0px; text-align: center;}

<%-- 한줄평등록/수정 모달 --%>
div#registerReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
div#editReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus,
.modal-body input:focus {outline: none;}
.fa-face-meh:hover{cursor: pointer;}

<%-- 무비다이어리 모달 --%>
div#makeMovieDiary{font-family: 'Noto Sans KR', sans-serif;}
select#watching_date :focus{outline: none;}

/* ========== full calendar css 시작 ========== */
.fc-header-toolbar {height: 30px;}
a, a:hover, .fc-daygrid {color: #000; text-decoration: none; background-color: transparent; cursor: pointer;} 
.fc-sat { color: #0000FF; }    /* 토요일 */
.fc-sun { color: #FF0000; }    /* 일요일 */
.fc-col-header {width: 100% !important;}
.fc-scrollgrid-sync-table {width: 100% !important; height: 600px !important;}
.fc-daygrid-body {width: 100% !important;}
.fc-view-harness-active {height: 635px !important;}
/* ========== full calendar css 끝 ========== */

.highcharts-container {font-family: 'Noto Sans KR', sans-serif; cursor: default;}

</style>

<script>

	$(document).ready(function(){
		
		$("div#mycontent").css('padding-top','20px');
		$("div#mycontent").css('background-color','#f8f8f8');
		
 		myReviewPaging(1); // 회원의 전체 한줄평 보여주기
 		showPreference(); // 회원의 선호장르(하이차트) 보여주기
 		
		$('.carousel').carousel({
			interval: 10000
		});

 		$('.carousel .carousel-item').each(function(){
 		    var minPerSlide = 2;
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
 		
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 		
		// 포토티켓 다운로드 
 		$(".photoTitle").next().hide();

 		$(".photoTitle").hover(function(){
 				$(this).next().slideDown('fast');
	 		}, function(){
	 			$(this).next().slideUp('fast');
 		});

 		// 무비다이어리 - 풀캘린더
 		var calendarEl = document.getElementById('movieCalendar');
 		
 	    var calendar = new FullCalendar.Calendar(calendarEl, {
 	        initialView: 'dayGridMonth',
 	        locale: 'ko',
 	        selectable: true,
 		    editable: false,
 		    headerToolbar: {
 		    	  left: 'prev',
 		          center: 'title',
 		          right: 'today next'
 		    },
 		    dayMaxEventRows: true, // for all non-TimeGrid views
 		    views: {
 		      timeGrid: {
 		        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
 		      }
 		    },
 			
 		    // ===================== DB 와 연동하는 법 시작 ===================== //
			events:function(info, successCallback, failureCallback) {
 		
 		    	$.ajax({
 	                url: "<%= ctxPath%>/myWatcha/showMovieDiary.action",
 	                dataType: "json",
 	                success:function(json) {
						var events = [];
 	                    if(json.length > 0){
 	                        
 	                    	var diaryExists = []; // 관람일자가 이미 등록된 영화의 movie_id를 담을 배열
                        	$.each(json, function(index, item) {
	                        	var watching_date = moment(item.watching_date).format('YYYY-MM-DD');
	                              
                         		events.push({
                              		id: item.diary_id,
                                    title: item.movie_title,
                                    start: watching_date,
                                    color: item.color,
                                    url: "<%= ctxPath%>/myWatcha/searchDetail.action?movie_id="+item.movie_id
                         		}); // end of events.push({})
                                
                         		diaryExists.push(item.movie_id); // 관람일자가 이미 등록된 영화의 movie_id 를 push
	                     	}); // end of $.each(json, function(index, item) {})
	                     	$("input.movie_id").val(diaryExists);
 	                    } // end of if                         
 	                    successCallback(events);                               
 	                },
 					error: function(request, status, error){
 				    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 				    }	
 	                                            
 	          }); // end of $.ajax({})
 	        
 	        }, // end of events:function(info, successCallback, failureCallback) {}
 	        // ===================== DB 와 연동하는 법 끝 ===================== //
 	        
 			// 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(관람일자 등록하는 모달창으로 넘어간다)
 	        dateClick: function(info) {
 	      	 // alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
 	      	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
 	      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
 	      	 	movieDiaryModal(info.dateStr);
 	      	},
 	    	eventDidMount: function(arg) {
            	arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
            }
 	    });
 	    
		calendar.render();  // 풀캘린더 보여주기
		calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.

		// 무비다이어리 등록 모달창에서 "등록할 영화" 를 선택한 경우
		$("select#movie_id").change(function(){
			
			let movie_id = $(this).val();
			let html = "";

			if(movie_id == "0"){ // "영화를 선택하세요." 일 경우
				$("div#div_movie_poster").html('');
				$("div#div_rating").html('');
			}
			else {
				let poster_path;
				$("input.poster_path").each(function(index, item){
					if($(item).attr('name') == movie_id){
						poster_path = $(item).val();
						return;
					}
				});

				$("div#div_movie_poster").html('<img class="img-thumnail" style="width: 90%; border-radius: 3%; border: solid 1px gray;" src="https://image.tmdb.org/t/p/w780/'+poster_path+'">');
				
				let rating;
				$("input.rating").each(function(index, item){
					if($(item).attr('name') == movie_id){
						rating = $(item).val();
						return;
					}
				});
				
				html += '<p class="h5 py-2">${sessionScope.loginuser.name}님의 별점평가</p>';
				
				if(rating %1 != 0){ // 별점에 소수점 포함 (예: 3.5)
	        		let starCount = Math.floor(rating);
	        		for(let i=0; i<starCount; i++){
	        			html += '<i class="fa-solid fa-star fa-2xl" style="color: #fdd346;"></i>';
	        		}
					html += '<i class="fa-solid fa-star-half fa-2xl" style="color: #fdd346;"></i>';
	        	}
	        	else {
	        		for(let i=0; i<rating; i++){
	        			html += '<i class="fa-solid fa-star fa-2xl" style="color: #fdd346;"></i>';
	        		}
	        	}
				$("div#div_rating").html(html);
			}
		}); // end of $("select#movie_id").change(function(){})
		
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 		
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
 				$(this).parent().parent().css({'background-color':'#ff0558', 'color':'#fff'}); // 배경색, 글씨색 변경
 			}
 			else { // 체크박스 체크해제
 				$(this).parent().parent().css({'background-color':'#fff0f5', 'color':'gray'}); // 배경색, 글씨색 변경
 			}
 		}); // end of $("input:checkbox[name='genre_id']").click(function(){})

 		// 검색하기 - 별점 체크박스 클릭할 때
 		$("input:checkbox[name='rating']").click(function(){
 			if($(this).prop("checked")){ // 체크박스 체크
 				$(this).parent().find('i').css('color','#fdd346'); // 별 아이콘 색깔 노란색으로 변경
 			}
 			else { // 체크박스 체크해제
 				$(this).parent().find('i').css('color','#cccccc'); // 별 아이콘 색깔 회색으로 변경
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
 		
 		// 모달 창에서 입력된 값 초기화 시키기
    	$(".modal").each(function(index, item){
    	    $("button.close").on("click", function(){
   	    		let frm = $(item).find('form').get(0);
   	    		if(frm != null){
   		    		frm.reset();
   	    		}
				$("div#div_movie_poster").html('');
				$("div#div_rating").html('');
   	    	});
    	}); // end of $(".modal").each(function(index, item){})
   	
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
							  + 	  '<p style="font-size: 11pt; padding: 3px; margin: 3px; height: 80px; overflow: auto;">'+item.review_content+'</p>';
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
					
					$("div#div_review").html(html);
					showReviewPageBar(Number(currentShowPageNo));
				} // end of if (작성한 한줄평이 있는 경우)
				else {
			          html = '<p class="h5 text-center">작성한 한줄평이 없어요.</p>';
					  $("div#review").html(html);
				}
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
	
	// 포토티켓 다운로드(앞면)
	function downloadPhoto1(movie_id){
		$("input#photo_movie_id").val(movie_id);

		const frm = document.downloadPhotoFrm;
		frm.action = "<%= ctxPath %>/myWatcha/downloadPhoto.action";
		frm.photo_side.value = "front";
		frm.method = "post";
		frm.submit();
		
		setTimeout(downloadPhoto2, 5000);
	} // end of function downloadPhoto1(movie_id)
	
	// 포토티켓 다운로드(뒷면)
	function downloadPhoto2(){
		const frm = document.downloadPhotoFrm;
		frm.action = "<%= ctxPath %>/myWatcha/downloadPhoto.action";
		frm.photo_movie_id.value = $("input#photo_movie_id").val();
		frm.photo_side.value = "back";
		frm.method = "post";
		frm.submit();
	} // end of function downloadPhoto2()
	
	// 무비다이어리 모달창 보여주기
	function movieDiaryModal(watching_date){
		$("input#watching_date").val(watching_date);
 	    $("input#watching_date").datepicker();
 	    
 	    // 관람일자가 이미 등록된 영화는 무비다이어리 등록에서 제외하도록 한다.
		let diaryExists_arr = $("input.movie_id").val().split(",");
		
		$("option#movie_id").each(function(index, item){
			for(let i=0; i<diaryExists_arr.length; i++){
				if($(item).val() == diaryExists_arr[i]){
					$(item).remove();
				}
			} // end of for
		}); // end of $("option#movie_id").each(function(index, item){})

		$("div#makeMovieDiary").modal('show');
 	    
	} // end of function movieDiaryModal(watching_date)
	
	// 무비다이어리 등록하기
	function registerDiary(){
		const queryString = $("form[name='movieDiaryFrm']").serialize();
		$.ajax({
			url:"<%= ctxPath%>/myWatcha/registerDiary.action",
			data:queryString,
			type:"post",
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				location.href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id="+$('select#movie_id').val();
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function registerDiary()
	
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
					html += "<p class='h5 text-center'>검색조건에 해당하는 검색결과가 없어요.</p>";
				}
				
				$("div#searchResult").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function searchResult()
	
	// 하이차트 - 선호하는 장르(wordcloud)
	function showPreference(){
		// 로그인한 회원이 평가한 영화 중 선호하는 장르에 대한 DB 데이터 가져오기
		// 전체 평가한 영화 중 별점 3점 이상인 영화들의 장르(드라마,액션,SF,...)를 알아오고 별점별로 장르에 점수를 매겨서 가장 점수가 높은 장르를 가져온다.
		// [예제] 별점3인 영화(드라마,액션)이면 드라마3, 액션3 && 별점5인 영화(드라마,로맨스)이면 드라마5, 로맨스5 ==> 합산 드라마8 액션3 로맨스5
		// 차트에서 장르 데이터(word)를 클릭하면 장르별 추천영화를 보여주는 페이지로 이동
		
		$.ajax({ 
			url:"<%= ctxPath%>/myWatcha/showPreferenceChart.action",
			dataType:"json",
			success:function(json){
			//	console.log(JSON.stringify(json));
			
				let genreArr = [];
				for(let i=0; i<json.length; i++){
					let obj = {name : json[i].genre_name
							 , weight : Number(json[i].rating_genre)}; 
					genreArr.push(obj);
				} // end of for
				
				///////////////////////////////////////////////////////////////////////////////////
				Highcharts.chart('preference',{
				    accessibility: {
				        screenReaderSection: {
				            beforeChartFormat: '<h5>{chartTitle}</h5>' +
				                '<div>{chartSubtitle}</div>' +
				                '<div>{chartLongdesc}</div>' +
				                '<div>{viewTableButton}</div>'
				        }
				    },
				    series: [{
				        type: 'wordcloud',
				        data: genreArr,
				        name: '장르별 선호도'
				    }],
				    title: {
				        text: 'Wordcloud of Alice\'s Adventures in Wonderland'
				    },
				    subtitle: {
				        text: 'An excerpt from chapter 1: Down the Rabbit-Hole  '
				    },
				    tooltip: {
				    	pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
				    }
				});
				///////////////////////////////////////////////////////////////////////////////////
				$("div.highcharts-data-table").hide();
			},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }				
		});
	} // end of function showPreference()
	
</script>

  <div class="container-fluid">
	<div id="div_container" class="container">
	  <div id="div_myContent">
	  	<div style="overflow: hidden; height: 200px;">
	  	  <div class="row">
			<div class="col-md-12 text-right">
			  <%-- 마이페이지로 이동 --%>
			  <a id="goMyPage" href="<%= ctxPath %>/modifyMyInfo.action"><i class="fa-solid fa-gear fa-2xl" style="color: #cccccc;"></i></a>
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
	        <img class="p-0 m-0" src="<%= ctxPath%>/resources/images/팝콘아이콘.png" style="height: 220px;">
	  	   </c:if>
	  	  </div>
	  	</div>
  		
  		<div style="padding: 0 50px; margin: 0px;">
  		  <div id="div_myProfile">
  		    <%-- 회원의 프로필  --%>
			<div style="display: flex; margin: 0px; position: relative; top: -2rem;" class="row">
			  <c:if test="${not empty sessionScope.loginuser.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/${sessionScope.loginuser.profile_image}"/>
			  </c:if>
			  <c:if test="${empty sessionScope.loginuser.profile_image}">
  			    <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
			  </c:if>
		    </div>
			<div style="position: relative; top: -2rem;" class="p-0 m-0">
  			  <h5 style="text-align: left; padding: 0 5px; font-size: 20pt; font-weight: 900; margin: 10px 0px;">${sessionScope.loginuser.name}</h5>
		      <c:if test="${not empty sessionScope.loginuser.profile_message}">
  			    <p style="text-align: left; padding: 0 5px; font-weight: 600; margin-top: 5px;">${sessionScope.loginuser.profile_message}</p>
		      </c:if>
  			
	  		  <ul class="nav nav-pills row" style="padding: 5px 0px 15px 15px; border-bottom: solid 1px #e6e6e6;">
			    <li class="nav-item">
			      <a class="active" data-toggle="pill" href="#ratingMovies">평균별점<span style="padding-left: 5px;">${requestScope.userInfo.rating_avg}점</span></a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#review">한줄평<span style="padding-left: 5px;">${requestScope.reviewCount}개</span></a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#movieDiary">무비다이어리</a>
			    </li>
			    <li class="nav-item">
			      <a data-toggle="pill" href="#searchInfo">검색하기</a>
			    </li>
			    <li class="nav-item">
			      <a href="<%= ctxPath%>/view/user_collection.action">내 컬렉션</a>
			    </li>
			  </ul>
  			</div>
  		  </div>
  		</div>
  		
	  	<div id="div_nav_content" class="tab-content pt-4 pb-3 my-3"> <%-- 평가한 영화 / 한줄평 / 무비다이어리 --%>
	  	  <div id="ratingMovies" class="tab-pane container active">
	        <c:if test="${not empty requestScope.ratingMoviesList}">
	  	    <div style="display: flex; padding: 0 50px;">
	 	      <h5 style="padding-left: 5px; font-weight: 600;"><span>${sessionScope.loginuser.name}</span>&nbsp;님이 선호하는 장르</h5>
	 	      <p style="padding-left: 5px;">선호 장르의 다양한 영화를 추천받으시려면 장르를 클릭해보세요.</p>
	        </div>
	        <div class="row mx-auto my-1 mb-5" style="padding: 0 50px;">
	          <div id="preference" style="width: 100%; height: 400px; border: solid 1px #e6e6e6; border-radius: 2%;"></div>
		    </div>

	        <div style="display: flex; padding: 0 50px;" class="row mx-auto">
	 	      <h5 class="col-md-9" style="padding-left: 5px; font-weight: 600;">평가한 영화<span id="rating_count">${requestScope.userInfo.rating_count}</span></h5>
	 	      <a class="col-md-3 text-right" href="<%= ctxPath%>/myWatcha/rateMovies.action" style="color: black; text-decoration: none;">전체보기</a>
	        </div>
	        <div id="div_rateMovies" class="row mx-auto my-1 mb-3" style="padding: 0 50px;">
			<c:if test="${requestScope.userInfo.rating_count > 4}">
	          <div id="movieCarousel" class="carousel slide w-100" data-ride="carousel">
	            <div class="carousel-inner w-100" role="listbox">
	             <c:forEach var="movie" items="${requestScope.ratingMoviesList}" varStatus="status">
	              <c:if test="${status.index == 0}">
					<div class="carousel-item active">
					  <div class="col-md-3 p-1">
						<div class="card">
				          <div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 240px;">
                            <img class="img card-img-top" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
				          </div>
	                      <div class="card-body text-center px-0">
	                        <div style="overflow: hidden; height: 40px;" class="p-0 m-0 px-3">
						      <a href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id=${movie.movie_id}" style="text-decoration: none; color: black;">
						        <h6 class="card-title"><span style="display:none;">${movie.movie_id}</span>${movie.movie_title}</h6>
		                      </a>
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
				    	</div>
					  </div>
					</div>
	              </c:if>
	              <c:if test="${status.index != 0}">
					<div class="carousel-item">
					  <div class="col-md-3 p-1">
						<div class="card">
				          <div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 240px;">
                            <img class="img card-img-top" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
				          </div>
	                      <div class="card-body text-center px-0">
	                        <div style="overflow: hidden; height: 40px;" class="p-0 m-0 px-3">
						      <a href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id=${movie.movie_id}" style="text-decoration: none; color: black;">
						        <h6 class="card-title"><span style="display:none;">${movie.movie_id}</span>${movie.movie_title}</h6>
		                      </a>
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
			</c:if>
			<c:if test="${requestScope.userInfo.rating_count <= 4}">
	          <div class="w-100">
	            <div class="w-100" role="listbox">
	             <c:forEach var="movie" items="${requestScope.ratingMoviesList}" varStatus="status">
					<div class="row mx-auto">
					  <div class="col-md-3 p-1">
						<div class="card">
				          <div class="p-0 m-0 mx-auto" style="overflow: hidden; height: 240px;">
                            <img class="img card-img-top" src="https://image.tmdb.org/t/p/w780/${movie.poster_path}">
				          </div>
	                      <div class="card-body text-center px-0">
	                        <div style="overflow: hidden; height: 40px;" class="p-0 m-0 px-3">
						      <a href="<%= ctxPath %>/myWatcha/searchDetail.action?movie_id=${movie.movie_id}" style="text-decoration: none; color: black;">
						        <h6 class="card-title"><span style="display:none;">${movie.movie_id}</span>${movie.movie_title}</h6>
		                      </a>
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
				    	</div>
					  </div>
					</div>
	              </c:forEach>
				</div>
			  </div>
			  </c:if>
		    </div>
	        </c:if>
	        <c:if test="${empty requestScope.ratingMoviesList}">
	          <p class="h5 text-center">평가한 영화가 없어요.</p>
	        </c:if>
		  </div>
	  	
		  <div id="review" class="tab-pane container fade">
	  	    <div style="display: flex; padding: 0 50px;" class="row mx-auto">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">내 한줄평<span id="reviewCount">${requestScope.reviewCount}</span></h5>
	        </div>
	        
    		<%-- 한줄평(Ajax로 페이징 처리) --%>
	        <div id="div_review" style="padding: 0 50px; display: inline-block;" class="my-1 mb-3 mx-auto"></div>
		    <div id="div_reviewPageBar">${requestScope.pageBar}</div>
		  </div>
	  	
		  <div id="movieDiary" class="tab-pane container fade">
	  	    <div style="display: flex; padding: 0 50px;">
	 	      <h5 style="padding-left: 5px; font-weight: 600; margin: 4px 0 0 0;">포토티켓</h5>
	        </div>
	        
	        <form name="downloadPhotoFrm">
	          <input type="hidden" id="photo_movie_id" name="movie_id" value="" />
	          <input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}" />
	          <input type="hidden" name="photo_side" value="" />
	        </form>
	        
	        <c:if test="${not empty requestScope.userPhotoTicketList}">
			<c:if test="${requestScope.photoTicketCount > 4}">
	        <div id="photoTicket" class="row mx-auto my-1 carousel slide w-100" data-ride="carousel" style="padding: 0 50px;">
	          <div class="carousel-inner w-100">
	          <c:forEach var="photoTicket" items="${requestScope.userPhotoTicketList}" varStatus="status">
	          <c:if test="${status.index == 0}">
	            <div class="carousel-item active">
		          <div class="col-md-3 p-1">
		            <div class="flip-card" style="height: 280px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_front}">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_back}">
			    	    </div>
		              </div>
				    </div>
                    <div style="height: 80px;" class="p-0 my-2 text-center">
			          <h6 class="photoTitle card-title p-0 m-0" style="cursor: pointer; overflow: hidden; max-height: 50px;" onclick="downloadPhoto1(${photoTicket.movie_id})">${photoTicket.movie_title}</h6>
			          <i class="download fa-regular fa-circle-down" style="color: gray; background-color:#fff; width: 100%;">&nbsp;<span style="font-size: 10pt;">다운로드</span></i>
                    </div>
		          </div>
			    </div>
			  </c:if>
	          <c:if test="${status.index != 0}">
	            <div class="carousel-item">
		          <div class="col-md-3 p-1">
		            <div class="flip-card" style="height: 280px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_front}">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_back}">
			    	    </div>
		              </div>
				    </div>
                    <div style="height: 80px;" class="p-0 my-2 text-center">
			          <h6 class="photoTitle card-title p-0 m-0" style="cursor: pointer; overflow: hidden; max-height: 50px;" onclick="downloadPhoto1(${photoTicket.movie_id})">${photoTicket.movie_title}</h6>
			          <i class="download fa-regular fa-circle-down" style="color: gray; background-color:#fff; width: 100%;">&nbsp;<span style="font-size: 10pt;">다운로드</span></i>
                    </div>
		          </div>
			    </div>
			  </c:if>
			  </c:forEach>
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
	        </c:if>
	        
			<c:if test="${requestScope.photoTicketCount <= 4}">
	        <div id="photoTicket" class="mx-auto my-1 w-100" style="padding: 0 50px;">
	          <div class="row w-100">
	          <c:forEach var="photoTicket" items="${requestScope.userPhotoTicketList}" varStatus="status">
		          <div class="col-md-3 p-1">
		            <div class="flip-card" style="height: 280px;">
		              <div class="flip-card-inner">
					    <div class="flip-card-front m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_front}">
			    	    </div>
					    <div class="flip-card-back m-1">
	                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${photoTicket.photo_back}">
			    	    </div>
		              </div>
				    </div>
                    <div style="height: 80px;" class="p-0 my-2 text-center">
			          <h6 class="photoTitle card-title p-0 m-0" style="cursor: pointer; overflow: hidden; max-height: 50px;" onclick="downloadPhoto1(${photoTicket.movie_id})">${photoTicket.movie_title}</h6>
			          <i class="download fa-regular fa-circle-down" style="color: gray; background-color:#fff; width: 100%;">&nbsp;<span style="font-size: 10pt;">다운로드</span></i>
                    </div>
		          </div>
			  </c:forEach>
			  </div>
	        </div>
	        </c:if>
	        </c:if>
	        <c:if test="${empty requestScope.userPhotoTicketList}">
	          <p class="h5 text-center my-1">등록한 포토티켓이 없어요.</p>
	        </c:if>
	        
	  	    <div style="display: flex; padding: 0 50px;" class="mt-3">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">무비다이어리</h5>
	        </div>
	        <div class="mx-auto my-1 mb-3" style="padding: 0 50px;">
	          <div id="movieCalendar" style="width: 100%; padding: 10px 0px;"></div>
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
				<input type="text" id="fromDate" readonly="readonly" placeholder="&nbsp;&nbsp;&nbsp;시작일자" style="width: 15%; border: none; cursor: pointer; color: gray;">
	            <span>&nbsp;~&nbsp;</span> 
	            <input type="text" id="toDate" readonly="readonly" placeholder="&nbsp;&nbsp;&nbsp;종료일자" style="width: 15%; border: none; cursor: pointer; color: gray;">
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

		<%-- 관람일자 등록 모달창 --%>
		<div class="modal fade" id="makeMovieDiary" data-keyboard="false">
		<form name="movieDiaryFrm">
		  <div class="modal-dialog modal-dialog-centered mx-auto">
		    <div class="modal-content mx-auto" style="width: 85%;">
		      <div class="modal-body text-center" style="margin: 10px;">
		        <h5 class="modal-title" style="font-weight: bold;">무비다이어리 - 관람일자 등록하기<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
		        <p style="color: gray;">별점평가를 한 영화에 한해서만 관람일자 등록이 가능해요.</p>
			    <div class="row mx-auto mt-3 mb-2" style="display: flex; padding: 10px 0;">
			      <div class="col-md-6">
	      	        <p class="h5 my-3 p-1">등록할 영화를 선택해주세요.</p>
      	            <select id="movie_id" name="movie_id" style="width: 200px;" class="my-2">
      	              <option value="0">영화를 선택하세요.</option>
            		  <c:forEach var="movie" items="${requestScope.ratingMoviesList}" varStatus="status">
    	                <option id="movie_id" value="${movie.movie_id}">${movie.movie_title}</option>
      	              </c:forEach>
      	            </select>
      	            <input type="hidden" name="diaryExists" class="movie_id" value="" />
            	    <c:forEach var="movie" items="${requestScope.ratingMoviesList}">
      	              <input type="hidden" name="${movie.movie_id}" class="poster_path" value="${movie.poster_path}" />
      	              <input type="hidden" name="${movie.movie_id}" class="rating" value="${movie.rating}" />
      	            </c:forEach>
      	            <div style="display: flex;" class="my-3">
	      	          <p class="h5 py-2 m-0 mx-3">관람일자</p>
			          <input type="text" id="watching_date" name="watching_date" readonly="readonly" style="width: 130px; border: none; cursor: pointer; color: gray;" />
      	            </div>
	      	        <div id="div_rating" class="my-3"></div>
			      </div>
			      <div class="col-md-6">
		            <div id="div_movie_poster" class="p-1 pt-3 mx-1 text-center" style="width: 98%;"></div>
			      </div>
			    </div>
		        <button type="button" class="btn" onclick="registerDiary()" style="padding: 10px 30px; color: #ffffff; background-color: #ff0558;">등록하기</button>
		        <button type="reset" class="btn btn-secondary" style="padding: 10px 30px;">취소하기</button>
    	      </div>
		    </div>
		  </div>
		</form>
		</div>

  </div>
