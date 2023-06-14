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
div#div_container {width: 100%; display: flex; z-index: 4; position: relative; top: 0rem; background-color: #ffffff; cursor: default;
				 /*font-family: 'IBM Plex Sans KR', sans-serif;*/
				  font-family: 'Noto Sans KR', sans-serif;}
div#div_content {width: 90%; margin: 0px 30px auto; padding-bottom: 30px;}
img#img_wallPaper {position: relative; z-index:1; object-fit:cover; width: 100%; opacity: 0.8;}
img#img_movie {z-index:5; border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}
span#collectionCount, span#reviewCount {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
img#img_profile {width: 40px; height: 40px; box-sizing: inherit; border:solid 1px #e6e6e6; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; margin: 0 6px;}
p.movieRate{width: 25%; height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px; background-color: #ffffff;}
input.like_review{display:none;}

div#div_reviewPageBar {text-align: center; margin: 10px;}
div#div_reviewPageBar li {display:inline-block; padding: 0px 5px;}
div#div_reviewPageBar button {background-color: #ffffff; border: none;}

select#collection{border: none; font-size: 11pt;}
select#collection:focus{outline: none;}

div#commentRegister textarea:focus {outline: none;}
div#review_modal{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
div#commentRegister textarea:focus, div#commentEdit textarea:focus, div#review_modal textarea:focus, div#review_modal input:focus {outline: none;}
</style>

<script>

	$(document).ready(function(){

		$("div#mycontent").css('padding-top','0px');
		$("div#mycontent").css('background-color','#ffffff');
		
 		userReviewPaging(1); // 영화별 유저들 한줄평 (페이지바 페이징, Ajax) 보여주기
 		
		// "좋아요" 클릭 시
		$(document).on("click", "input.like_review", function(){
			$("input.like_review").each(function(index, item){
				
				let review_id = $(item).attr('id'); // 예) like_review1
				review_id = review_id.substring(11, review_id.length);
				
				let b_like_review = false;
				let number_of_likes = $(item).parent().find("#number_of_likes").text();
				
				if($(item).prop("checked")){ // 좋아요 체크
					$(item).next().find('i').css('color','#ff0558');
					b_like_review = true;
					updateLikeReview(b_like_review, review_id);
					$(item).parent().find("#number_of_likes").text(Number(number_of_likes)+1);
	 			}
	 			else { // 좋아요 체크해제
					$(item).next().find('i').css('color','#cccccc');
					b_like_review = false;
					updateLikeReview(b_like_review, review_id);
					$(item).parent().find("#number_of_likes").text(Number(number_of_likes)-1);
	 			}
			});
 		}); // end of $(document).on("click", "input#like_review", function(){})
 		
		// 스포일러가 포함된 한줄평에서 "한줄평 보기" 버튼 클릭 시
		$(document).on("click", "button.showContent", function(){
			$(this).parent().css('display', 'none');
			$(this).parent().next().fadeIn('slow').css('display', '');
 		}); // end of $(document).on("click", "button.showContent", function(){})

 		// 한줄평 수정 모달에서 checkbox 를 체크했을 때
 		$(document).on("change", "input#spoiler_status", function(){
 			
 			if($(this).prop("checked")){ // 체크박스 체크 ==> 스포일러 포함
 				$("i.fa-face-meh").css("color","#ff0558");
 				$("span#spoiler_status").text("한줄평에 스포일러가 포함되었어요.");
 				$("input#spoiler_status").val("1");
 			}
 			else { // 체크박스 체크해제 ==> 스포일러 미포함
 	 			$("i.fa-face-meh").css("color","#cccccc");
 	 			$("span#spoiler_status").text("스포일러가 포함된 한줄평을 가려보세요.");
 	 			$("input#spoiler_status").val("0");
 			}
 		}); // end of $(document).on("change", "input#spoiler_status", function(){})
 		
 		// 댓글창이 change 될 때
 		$(document).on("change", "textarea#content", function(){
			$("span.addError").empty();
 		});
 		
	}); // end of $(document).ready(function(){})

	// 영화별 유저들 한줄평 (페이지바 페이징) 보여주기(Ajax)
	function userReviewPaging(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/movieReview.action",
			data:{"movie_id":"${requestScope.movieInfo.movie_id}",
				  "currentShowPageNo":currentShowPageNo},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 영화에 대한 유저들의 한줄평이 존재하는 경우

					html += '<h4 style="text-align: left; padding: 5px; font-weight: 600; margin: 10px;">이 영화에 대한 한줄평<span id="reviewCount" class="ml-2">'+json.length+'</span></h4>';
					
					<%-- 유저들의 한줄평 보여주기 시작 --%>
					$.each(json, function(index, item){
						html += '<div id="'+item.review_id+'" style="width: 32%; margin: 3px; display: inline-block;" class="my-2">'
				       		  +   '<div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">'
				       		  +     '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">';
				        if(item.profile_image == null){ // 유저의 프로필이미지가 없는 경우
					       	html +=   '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
				        }
				        else {
					       	html +=   '<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
				        }
				        
				        html +=       '<h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">'+item.name+'</h5>'

				        if(item.user_id == "${sessionScope.loginuser.user_id}"){ // 로그인한 회원이 작성한 한줄평일 경우
					       	html +=   '<h6 style="padding: 0px; margin: 12px 0px; color: gray; font-size: 10pt;">내가 쓴 한줄평</h6>';
				        }

				        html +=	    '</div>'
				       		  +     '<div class="mx-auto my-auto p-2">';
			       		  
				       	if(item.spoiler_status == 0 || item.user_id == "${sessionScope.loginuser.user_id}"){ // 한줄평에 스포일러가 없거나, 로그인한 회원이 작성한 한줄평일 경우
					       	html +=   '<div class="m-0 p-0 my-2" style="height: 100px; overflow: auto;">'
					       		  +     '<p style="padding: 10px; margin: 0px;">'+item.review_content+'</p>'
					       		  +	  '</div>';
				       	}
			       		else if(item.spoiler_status == 1){ // 해당 한줄평에 스포일러가 포함된 경우
					       	html +=	  '<div class="text-center m-0 p-0 my-2" style="height: 100px; overflow: auto;">'
					       		  +	    '<p style="padding: 10px; margin: 0px;">스포일러가 포함되어 있어요.</p>'
					       		  +     '<button type="button" class="showContent" style="border: none; color: #ff0558; background-color: transparent; font-weight: bold;">한줄평 보기</button>'
					       		  +	  '</div>'
					       		  +   '<div class="text-center m-0 p-0 my-2" style="display: none; height: 100px; overflow: auto;">'
					       		  +     '<p style="padding: 10px; margin: 0px;">'+item.review_content+'</p>'
					       		  +	  '</div>';
				       	}
				       	html +=	  	  '<div class="m-0 p-0 my-2" style="height: 20px;">';

				       	if(item.spoiler_status == 1 && item.user_id == "${sessionScope.loginuser.user_id}"){ // 한줄평에 스포일러가 있고, 로그인한 회원이 작성한 한줄평일 경우
					       	html +=	    '<p style="padding: 0px 10px; margin: 0px; color: #ff0558; font-size: 11pt; font-weight: bold;">스포일러가 포함되어 있어요.</p>';
				        }
				       	html +=	  	  '</div>';
				       	
				       	html +=       '<div style="display: flex;">'
				       		  +         '<p style="width: 70%; padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="ml-2">'+item.review_date+'</span></p>';
				       		  
				        if(item.rating == 0){ // 별점평가를 하지 않은 경우
					       	html +=   	'<p class="movieRate text-center">평가안함</p>'
					       		  +	  '</div>';
				        }
				        else {
					       	html +=   	'<p class="movieRate text-center">★&nbsp;<span>'+item.rating+'</span></p>'
				       		  	  +	  '</div>';
				        }
				        
				       	html +=   	  '<div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">'
				      	  	  +         '<label for="like_review'+item.review_id+'" class="m-1" style="cursor: pointer;">'
				      	
				       	if(item.like_review == 1){ // 로그인한 회원이 해당 한줄평에 좋아요를 한 경우
				       		html +=       '<input type="checkbox" id="like_review'+item.review_id+'" class="like_review" checked/>'
				      	  	  	  +       '<span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i></span>';
				       	}
				       	else if(item.user_id == "${sessionScope.loginuser.user_id}" || "${empty sessionScope.loginuser}"){ // 로그인한 회원이 자신의 한줄평에 좋아요를 클릭한 경우
				       		html +=       '<span onclick="func_likeAlert()">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>';
				       	}
				       	else {
				       		html +=       '<input type="checkbox" id="like_review'+item.review_id+'" class="like_review"/>'
			      	  	  	  	  +       '<span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>';
				       	}
				      	  	  
				      	html +=           '<span class="pl-1" id="number_of_likes" style="cursor: default;">'+item.number_of_likes+'</span>'
				      	  	  +          '</label>'
				      	  	  +          '<p class="m-1">'
				      	  	  +            '<span>댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i></span>'
				      	  	  +            '<span class="pl-2">'+item.number_of_comments+'</span>'
				      	  	  +          '</p>'
				      		  +          "<span><button onclick='reviewDetail("+JSON.stringify(item)+")' type='button' class='btn btn-sm btn-secondary ml-2'>자세히 보기</button></span>"
				      	  	  +        '</div>'
				      	  	  +      '</div>'
				      	  	  +    '</div>'
				      	  	  +  '</div>';

					}); // end of $.each(json, function(index, item){})
					<%-- 유저들의 한줄평 보여주기 끝 --%>
				} // end of if (영화에 대한 유저들의 한줄평이 존재하는 경우)
				else {
					html += '<h4 style="text-align: left; padding: 5px; font-weight: 600;">이 영화에 대한 한줄평이 존재하지 않아요.</h4>';
				}
		    	$("div#userReview").hide();
		    	$("div#userReview").html(html);
		    	$("div#userReview").fadeIn('30');
		    	userReviewPageBar(Number(currentShowPageNo));
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function userReviewPaging(currentShowPageNo)

	// 한줄평 페이지바 보여주기
	function userReviewPageBar(currentShowPageNo){
		$.ajax({
			url:"<%= ctxPath%>/userReviewCount.action",
			data:{"movie_id":"${requestScope.movieInfo.movie_id}"},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));

				if(Number(json.totalCount) > 0){
					
					if(typeof currentShowPageNo == "string"){ // currentShowPageNo 가 string 타입이면 사칙연산을 위해 형변환해준다.
						currentShowPageNo = Number(currentShowPageNo);
					}
					let sizePerPage = 6;
					
					let totalCount = Number(json.totalCount);
					let totalPage = Math.ceil(totalCount/sizePerPage);
			
					let blockSize = 5; 
					let loop = 1; 
					let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
					// 공식 pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1 을 이용하여 구한다.
					
					let pageBar = "<ul style='list-style: none;'>";
					  
					// === [맨처음][이전] 만들기 === //
					if(pageNo != 1) {
						pageBar += "<li><button type='button' onclick='userReviewPaging(1)'>[처음]</button></li>";
						pageBar += "<li><button type='button' onclick='userReviewPaging("+(pageNo-1)+")'>"+(pageNo-1)+"</button></li>";
					}
					  
					while(!(loop > blockSize || pageNo > totalPage)) {
					   if(pageNo == currentShowPageNo) {
					      pageBar += "<li style='color: #ff0558;'><button type='button' onclick='userReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
					   }
					   else {
						  pageBar += "<li><button type='button' onclick='userReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
					   }
					   loop++;
					   pageNo++;
					} // end of while
					  
					// === [다음][마지막] 만들기 === //
					if( pageNo <= totalPage ) {
					  pageBar += "<li><button type='button' onclick='userReviewPaging("+(pageNo+1)+")'>next</button></li>";
					  pageBar += "<li><button type='button' onclick='userReviewPaging("+totalPage+")'>[마지막]</button></li>"; 
					}
					pageBar += "</ul>";
				
					$("div#div_reviewPageBar").html(pageBar);
				}
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function showReviewPageBar(currentShowPageNo)
	
	// 한줄평 한개 자세히 보여주기(댓글 제외)
	function reviewDetail(reviewObj){
 		
		$("div#div_reviewPageBar").empty();
		
		let html = "";
		
		html += '<div style="display: flex;">'
	    	  +   '<h4 style="text-align: left; padding: 5px; font-weight: 600; margin: 10px;">'+reviewObj.name+'님의 한줄평</h4>'
		  	  +   '<button onclick="userReviewPaging(1)" type="button" style="color: gray; border: none; background-color: transparent;">한줄평 전체보기</button>'
		  	  + '</div>'
		  	  + '<div id="reviewDetail'+reviewObj.review_id+'" class="my-2 p-2" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">';
		
		<%-- 한줄평 내용 한개 보여주기 시작 --%>
		html +=   '<div id="reivew'+reviewObj.review_id+'" class="mx-auto my-auto p-1" style="margin: 3px;">'
     		  +     '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex; border-bottom: solid 1px #e6e6e6;">';
      	if(reviewObj.profile_image == null){ // 유저의 프로필이미지가 없는 경우
	    	html +=   '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
      	}
      	else {
	       	html +=   '<img id="img_profile" src="<%= ctxPath%>/resources/images/'+reviewObj.profile_image+'"/>';
      	}
      	html +=       '<h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">'+reviewObj.name+'</h5>'
      	
        if(reviewObj.user_id == "${sessionScope.loginuser.user_id}"){ // 로그인한 회원이 작성한 한줄평일 경우
	       	html +=   '<p class="pr-2" style="color: gray; font-size: 10pt; padding: 0px; margin: 10px 0 0 0;">내가 쓴 한줄평</p>'
	       		  +	  '<button type="button" data-toggle="modal" data-backdrop="static" data-target="#editReview" style="font-weight: bold; color: #ff0558; border: none; background-color: transparent;">수정</button>'
	       		  +	  "<button type='button' onclick='delReview("+reviewObj.review_id+")' style='font-weight: bold; color: #ff0558; border: none; background-color: transparent;'>삭제</button>"
				  + '</div>';
        } // end of if(로그인한 회원이 작성한 한줄평일 경우)
      	
        else { // 로그인한 회원이 작성한 한줄평이 아닐 경우
        	html += '</div>';
        }     
        html +=     '<div class="mx-auto my-auto p-2">';
 		  
       	if(reviewObj.spoiler_status == 0 || reviewObj.user_id == "${sessionScope.loginuser.user_id}"){ // 한줄평에 스포일러가 없거나, 로그인한 회원이 작성한 한줄평일 경우
	       	html +=   '<div class="m-0 p-0 my-2">'
	       		  +     '<p style="padding: 0px 10px; margin: 0px;">'+reviewObj.review_content+'</p>'
	       		  +	  '</div>';
       	}
        else if(reviewObj.spoiler_status == 1){ // 해당 한줄평에 스포일러가 포함된 경우
	       	html +=	  '<div class="text-center m-0 p-0 my-2">'
	       		  +	    '<p style="padding: 0px 10px; margin: 0px;">스포일러가 포함되어 있어요.</p>'
	       		  +     '<button type="button" class="showContent" style="border: none; color: #ff0558; background-color: transparent; font-weight: bold;">한줄평 보기</button>'
	       		  +	  '</div>'
	       		  +   '<div class="m-0 p-0 my-2" style="display: none;">'
	       		  +     '<p style="padding: 0px 10px; margin: 0px;">'+reviewObj.review_content+'</p>'
	       		  +	  '</div>';
       	}
        if(reviewObj.spoiler_status == 1 && reviewObj.user_id == "${sessionScope.loginuser.user_id}"){ // 한줄평에 스포일러가 있고, 로그인한 회원이 작성한 한줄평일 경우
	       	html +=	  '<div class="m-0 p-0 my-2">'
	       		  +	    '<p style="padding: 0px 10px; margin: 0px; color: #ff0558; font-size: 11pt; font-weight: bold;">스포일러가 포함되어 있어요.</p>'
	       		  +	  '</div>';
        }
     	
     	html +=       '<div style="display: flex;">'
     		  +         '<p style="width: 20%; padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="ml-2">'+reviewObj.review_date+'</span></p>';
     		  
      	if(reviewObj.rating == 0){ // 별점평가를 하지 않은 경우
	       	html +=   	'<p class="movieRate text-center ml-1" style="width: 8%;">평가안함</p>';
      	}
      	else {
	       	html +=   	'<p class="movieRate text-center ml-1" style="width: 8%;">★&nbsp;<span>'+reviewObj.rating+'</span></p>';
      	}
      	
     	html +=   	 '</div>'
    	  	  +      '<div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">'
    	  	  +        '<label for="like_review'+reviewObj.review_id+'" class="m-2" style="cursor: pointer;">'
    	  	  
    	if(reviewObj.like_review == 1){ // 로그인한 회원이 해당 한줄평에 좋아요를 한 경우
     		html +=     '<input type="checkbox" id="like_review'+reviewObj.review_id+'" class="like_review" checked/>'
     			  +		'<span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i></span>';
     	}	  
       	else if("${empty sessionScope.loginuser}" || (reviewObj.like_review == 0 && reviewObj.user_id == "${sessionScope.loginuser.user_id}")){ // 로그인한 회원이 자신의 한줄평에 좋아요를 클릭한 경우
       		html +=     '<span onclick="func_likeAlert()">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>';
       	}
     	else {
     		html +=     '<input type="checkbox" id="like_review'+reviewObj.review_id+'" class="like_review"/>'
     			  +		'<span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>';
     	}
    	html +=         '<span class="pl-1" id="number_of_likes" style="cursor: default;">'+reviewObj.number_of_likes+'</span>'
    	  	  +        '</label>'
    	  	  +        '<p class="m-2">'
    	  	  +          '<span>댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i></span>'
    	  	  +          '<span id="number_of_comments" class="pl-2">'+reviewObj.number_of_comments+'</span>'
    	  	  +        '</p>'
    	  	  +      '</div>'
    	  	  +    '</div>'
    	  	  +  '</div>'
  			  +  '<div id="reviewComment" class="mx-auto my-auto p-1 mb-3" style="margin: 3px;"></div>'
    	  	  +'</div>'
    	  	  +'<div id="commentRegister" class="mb-3" style="background-color: #f2f2f2; border: solid 1px #e6e6e6; border-radius: 2%;"></div>';

    	$("div#userReview").hide();
    	$("div#userReview").html(html);
    	$("div#userReview").fadeIn('30');
		<%-- 한줄평 내용 한개 보여주기 끝 --%>
		
		reviewComment(reviewObj);

  	  	<%-- 한줄평 수정 모달창 --%>
    	if(reviewObj.user_id == "${sessionScope.loginuser.user_id}"){
    		let html = "";
	       	html += '<div class="modal fade" id="editReview">'
			  	  +   '<div class="modal-dialog modal-dialog-centered">'
			  	  +     '<div class="modal-content">'
			  	  +       '<div class="modal-body">'
			  	  +         '<h5 class="modal-title" style="font-weight: bold;">'+"${requestScope.movieInfo.movie_title}"+'<button type="button" class="close" data-dismiss="modal">&times;</button></h5>'
			  	  +         '<div class="my-2">'
			  	  +           '<textarea id="review_content" name="review_content" style="width: 100%; height: 450px; resize: none; border: none;">'+reviewObj.review_content+'</textarea>'
			  	  +         '</div>'
			  	  +         '<div style="display: inline-block; width: 100%;">'
			  	  +           '<div style="display: inline-block; width: 83%;">'
			  	  +             '<label for="spoiler_status">';
			
			if(reviewObj.spoiler_status == 0){ // 원래의  한줄평에 스포일러가 포함되지 않은 경우
				html +=           '<i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #cccccc;"></i>'
				  	  +           '<input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="0" />'
				  	  +           '<span id="spoiler_status" style="color: #666666; cursor: pointer;">스포일러가 포함된 한줄평을 가려보세요.</span>'
				  	  +         '</label>';
			}
			else { // 원래의 한줄평에 스포일러가 포함된 경우
				html +=           '<i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #ff0558;"></i>'
				  	  +           '<input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="1" checked />'
				  	  +           '<span id="spoiler_status" style="color: #666666; cursor: pointer;">한줄평에 스포일러가 포함되었어요.</span>'
				  	  +         '</label>';
			}
			  	  
			html +=           '</div>'
			  	  +           '<div style="display: inline-block; width: 16%; text-align: right;">'
			  	  +             "<button type='button' class='btn' onclick='updateReview("+JSON.stringify(reviewObj)+")' style='color: #ffffff; background-color: #ff0558;'>수정</button>"
			  	  +           '</div>'
			  	  +         '</div>'
			  	  +       '</div>'
			  	  +     '</div>'
			  	  +   '</div>'
			  	  + '</div>';
			  	  
	    	$("div#review_modal").html(html);
	    	<%-- 한줄평 수정 모달창 끝 --%>
	  	}
	} // end of function reviewDetail(reviewObj)
		
	// 한줄평 한개의 댓글 보여주기
	function reviewComment(reviewObj){
		
		$.ajax({
			url:"<%= ctxPath%>/reviewComment.action",
			data:{"review_id":reviewObj.review_id},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				<%-- 한줄평 댓글 보여주기 Ajax --%>
				let html = "";
				if(json.length > 0){ // 댓글이 존재하는 경우
					
					html +=     '<h5 class="my-2 ml-4">전체댓글&nbsp;<span style="font-size: 11pt; color: gray;">'+json.length+'</span></h5>'
						  +	    '<div id="viewAllComment">';

					<%-- 한줄평 댓글 보여주기 시작 --%>
					$.each(json, function(index, item){
						html +=   '<div id="'+item.comment_id+'" class="mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';

						if(item.profile_image == null){ // 유저의 프로필이미지가 없는 경우
					    	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
				      	}
				      	else {
					       	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
				      	}

						html +=     '<div style="text-align: left;">'
							  
						if(item.user_id == reviewObj.user_id){ // 한줄평 작성자가 자신의 한줄평에 댓글을 단 경우
							html +=   '<p style="padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">'+item.name+'<span class="pl-2" style="color: #ff0558; font-size: 10pt;">작성자</span></p>'
						}
						else {
							html +=   '<p style="padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">'+item.name+'</p>'
						}

						html += 	  '<p style="padding: 0 5px; margin: 0px;">'+item.content+'</p>'
							  + 	  '<p style="display: inline-block; margin: 10px 0px 0px 0px; font-size: 10pt; color: gray;">작성일자&nbsp;<span class="pl-2">'+item.comment_date+'</span></p>'

						if(item.user_id == "${sessionScope.loginuser.user_id}"){ // 로그인한 회원이 달았던 댓글인 경우
							html +=   '<div style="display: inline-block;">'
				       		  	  +	    "<button type='button' class='p-0 m-0 mx-1 ml-2' onclick='updateComment1("+JSON.stringify(item)+","+JSON.stringify(reviewObj)+")' style='font-weight: bold; color: #ff0558; border: none; background-color: transparent; font-size: 10pt;'>수정</button>"
				       		  	  +	    "<button type='button' class='p-0 m-0 mx-1' onclick='delComment("+item.comment_id+","+JSON.stringify(reviewObj)+")' style='font-weight: bold; color: #ff0558; border: none; background-color: transparent; font-size: 10pt;'>삭제</button>"
								  +	  '</div>';
						}
						html +=     '</div>'
							  +	  '</div>';
					}); // end of $.each(json, function(index, item){})
					html +=   '</div>';
					<%-- 한줄평 댓글 보여주기 끝--%>
					
				} // end of if(댓글이 존재하는 경우)
				else {
					html += '<h5 style="text-align: center; padding: 5px; font-weight: 500; margin-bottom: 50px;">이 한줄평에 대한 댓글이 존재하지 않아요.</h5>';
				}
				$("div#reviewComment").html(html);

			    <%-- 댓글쓰기 --%>
			    if(${not empty sessionScope.loginuser}){ // 로그인한 경우
				    html  =     '<form name="commentFrm">'
				    	  + 	'<div class="mx-auto my-2 p-1">'
				    	  + 	  '<input type="hidden" name="review_id" value="'+reviewObj.review_id+'" />'
				    	  + 	  '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';

				    if(${empty sessionScope.loginuser.profile_image}){ // 유저의 프로필이미지가 없는 경우
				    	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
			      	}
			      	else {
				       	html += 	'<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
			      	}
			    	
					html += 		'<div style="width: 100%;">'
				    	  + 		  '<div style="display: flex;" class="mb-2">'
				    	  + 		    '<p style="text-align: left; padding: 0 5px; margin: 0px 10px 5px 0px; font-weight: 600;">'+${sessionScope.loginuser.name}+'</p>'
				    	  + 		    '<input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}" />'
				    	  + 		  '</div>'
				    	  + 		  '<textarea id="content" name="content" style="width: 100%; height: 70px; resize: none; border: solid 1px #e6e6e6; border-radius: 1%; font-size: 11pt;" placeholder="이 한줄평에 대한 댓글을 적어주세요."></textarea>'
				    	  + 		  '<div style="display: flex; position: relative; float: right;">'
				    	  +				'<span class="addError" style="color: #ff0558;"></span>'
				    	  + 		    "<button type='button' onclick='addComment("+JSON.stringify(reviewObj)+")' class='btn btn-sm btn-secondary m-1 ml-3'>등록</button>"
				    	  + 		    "<button type='button' onclick='reviewDetail("+JSON.stringify(reviewObj)+")' class='btn btn-sm btn-light m-1'>취소</button>"
				     	  + 		  '</div>'
				     	  + 		'</div>'
				     	  + 	  '</div>'
				    	  + 	'</div>'
				    	  +		'</form>';
			    }
			    else { // 로그인하지 않았을 경우
			    	html = '<div class="mx-auto my-2 p-1">'
						 +   '<h5 style="text-align: center; padding: 5px; margin: 20px; font-weight: 600;">회원만 댓글을 달 수 있어요!</h5>';
				    	 + '</div>';
			    }
				$("div#commentRegister").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});						
	} // end of function reviewComment(reviewObj)
	
	// 한줄평 삭제
	function delReview(review_id){
		if(confirm("한줄평을 삭제하시겠습니까?")){
			$.ajax({
				url:"<%= ctxPath%>/deleteReview.action",
				data:{"review_id":review_id}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
					userReviewPaging(1);
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delReview(review_id)
	
	// 한줄평 수정
	function updateReview(reviewObj){
		if($("textarea#review_content").val().trim() == ""){
			alert("한줄평 내용을 적어주세요.");
		}
		else {
			$.ajax({
				url:"<%= ctxPath%>/updateReview.action",
				data:{"review_id":reviewObj.review_id,
					  "review_content":$("textarea#review_content").val(),
					  "spoiler_status":$("input#spoiler_status").val()}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
					$("div#editReview").modal('hide');
					$(".modal-backdrop").remove();
					reviewObj.review_content = $("textarea#review_content").val();
					reviewObj.spoiler_status = $("input#spoiler_status").val();
					reviewDetail(reviewObj);
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delReview(review_id)
	
	function func_likeAlert(){
		if(${empty sessionScope.loginuser}){
			alert("회원만 좋아요를 할 수 있어요!");
		}
		else { // 로그인한 회원이 본인의 한줄평에 좋아요를 클릭한 경우
			alert("내 한줄평에 좋아요를 할 수는 없어요.");
		}
	} // end of function func_likeAlert()
	
	// 한줄평에 좋아요 체크 또는 체크해제
	function updateLikeReview(b_like_review, review_id){
		$.ajax({
			url:"<%= ctxPath%>/reviewLike.action",
			data:{"review_id":review_id,
				  "like_review":b_like_review}, 
			type:"post",
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }			
		});
	} // end of function updateLikeReview(b_like_review)
	
	// 한줄평에 댓글 추가
	function addComment(reviewObj){
		if($("textarea#content").val().trim() == ""){
			$("span.addError").html("댓글내용을 적어주세요.");
		}
		else {
			const queryString = $("form[name='commentFrm']").serialize();
			
			$.ajax({
				url:"<%= ctxPath%>/addComment.action",
				data:queryString, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
					reviewObj.number_of_comments = Number(reviewObj.number_of_comments)+1;
					reviewDetail(reviewObj);
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function addComment(reviewObj)
		
	// 한줄평에 달린 댓글 수정(수정 form 태그)
	function updateComment1(commentObj, reviewObj){
		
		let html = "";
	    <%-- 댓글 수정 --%>
	    html +=     '<div id="commentEdit" class="mx-auto my-2 p-1">'
	    	  + 	  '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';
	    <%--	  
		if(${empty sessionScope.profile_image}){ // 유저의 프로필이미지가 없는 경우
	    	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
      	}
      	else {
	       	html += 	'<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
      	}
      	--%>
    	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
    	
		html += 		'<div style="width: 100%;">'
	    	  + 		  '<div style="display: flex;" class="mb-2">'
	    	  + 		    '<p style="text-align: left; padding: 0 5px; margin: 0px 10px 5px 5px; font-weight: 600; color: #ff0558;">댓글 수정하기</p>'
	    	  + 		    '<input type="hidden" name="review_id" value="'+reviewObj.review_id+'" />'
	    	  + 		    '<input type="hidden" name="comment_id" value="'+commentObj.comment_id+'" />'
	    	  + 		  '</div>'
	    	  + 		  '<textarea id="content" name="content" style="width: 100%; height: 70px; resize: none; border: solid 1px #e6e6e6; border-radius: 1%; font-size: 11pt;">'+commentObj.content+'</textarea>'
	    	  + 		  '<div style="display: flex; position: relative; float: right;">'
	    	  +				'<span class="addError" style="color: #ff0558;"></span>'
	    	  + 		    "<button type='button' onclick='updateComment2("+JSON.stringify(commentObj)+","+JSON.stringify(reviewObj)+")' class='btn btn-sm btn-secondary m-1'>수정</button>"
	    	  + 		    "<button type='button' onclick='reviewDetail("+JSON.stringify(reviewObj)+")' class='btn btn-sm btn-light m-1'>취소</button>"
	     	  + 		  '</div>'
	     	  + 		'</div>'
	    	  + 	  '</div>'
	    	  + 	'</div>';
	    	  
	  	$("form[name='commentFrm']").hide();
	  	$("form[name='commentFrm']").html(html);
	  	$("form[name='commentFrm']").fadeIn('30');
	} // end of function updateComment1(commentObj, reviewObj)
	
	// 한줄평에 달린 댓글 수정
 	function updateComment2(commentObj, reviewObj){
  		const queryString = $("form[name='commentFrm']").serialize();

		$.ajax({
			url:"<%= ctxPath%>/updateComment.action",
			data:queryString, 
			type:"post",
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				reviewDetail(reviewObj);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }			
		});
	} // end of function updateComment2(commentObj, reviewObj)
	
	// 한줄평에 달린 댓글 삭제
	function delComment(comment_id, reviewObj){
		if(confirm("댓글을 삭제하시겠습니까?")){
			$.ajax({
				url:"<%= ctxPath%>/deleteComment.action",
				data:{"comment_id":comment_id,
					  "review_id":reviewObj.review_id}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
					reviewObj.number_of_comments = Number(reviewObj.number_of_comments)-1;
					reviewDetail(reviewObj);
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delComment(comment_id, reviewObj)
	
	
</script>

  <div class="container-fluid">
    <div style="background-color: #333333; overflow: hidden; height: 350px;" class="row container mx-auto">
      <div style="width: 10%; box-shadow: 50px 10px 20px #333333; z-index: 3;"></div>
      <div style="width: 80%;">
	    <a href="<%= ctxPath %>/view/project_detail.action?movie_id=${requestScope.movieInfo.movie_id}" style="text-decoration: none; color: black;">
	      <img id="img_wallPaper" src="https://image.tmdb.org/t/p/w1280/${requestScope.movieInfo.backdrop_path}" />
        </a>
      </div>
      <div style="width: 10%; box-shadow:-50px -10px 20px #333333; z-index: 2;"></div>
    </div>
	<div id="div_container" class="container">
	  <div id="div_content" class="mx-auto">
  		<div style="height: 150px; padding: 0 15px;">
		  <div style="display: flex; margin: 0px; padding: 0px; text-align: center; font-weight: 500; height: 150px;" class="row">
 			<div class="col-md-9" style="position: relative; top: 1rem; height: 150px;">
  			  <h2 style="text-align: left; padding: 10px; font-weight: 900; margin: 15px 0px;">${requestScope.movieInfo.movie_title}</h2>
  			  <div style="display: flex; margin: 10px 0px;">
  			    <h5 class="mx-2">평균별점<span class="ml-2">${requestScope.movieInfo.rating_avg}</span></h5>
  			    <h5 class="mx-2">별점평가 총<span class="ml-2">${requestScope.movieInfo.rating_count}</span>개</h5>
  			  </div>
 			</div>
            <div class="col-md-3" style="position: relative; z-index:5; top: -8rem;">
              <img id="img_movie" class="img-thumnail" src="https://image.tmdb.org/t/p/w780/${requestScope.movieInfo.poster_path}">
            </div>
	      </div>
  		</div>
	  	
	  	<div id="div_nav_content" class="container py-3" style="margin-bottom: 30px;"> 
		  <div id="userReview" style="padding: 0 30px;"></div>
		  <div id="div_reviewPageBar"></div>
		</div>
		
	  </div>
	</div>
  </div>
  
  <div id="review_modal"></div>
  
