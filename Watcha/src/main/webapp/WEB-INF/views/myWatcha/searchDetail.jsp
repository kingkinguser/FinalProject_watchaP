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

  <%-- html2canvas --%>
  <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap');
</style>

<style type="text/css">
div#div_container {width: 80%; display: flex; cursor: default;
				 /*font-family: 'IBM Plex Sans KR', sans-serif;*/
				  font-family: 'Noto Sans KR', sans-serif;}
div#div_myContent {width: 80%; margin: 30px auto; border-radius: 3%; border: solid 1px #cccccc; background-color: #ffffff;}
img#img_wallPaper {position: relative; z-index:1; object-fit:cover; width: 100%; border-radius: 3% / 4%; opacity: 0.8;}
img#img_movie {position: relative; z-index:2; border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}

select#collection{border: none; font-size: 11pt;}
select#collection:focus{outline: none;}

input[type="checkbox"] {opacity: 0;}
input#watching_date:focus{outline: none;}

<%-- 별점 --%>
.rate { display: inline-block;border: 0;margin-right: 15px;}
.rate > input {display: none;}
.rate > label {float: right;color: #ddd}
.rate > label:before {display: inline-block;font-size: 2.5rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
.rate input:checked ~ label, 
.rate label:hover,.rate label:hover ~ label { color: #FDD346} 
.rate input:checked + .rate label:hover,
.rate input input:checked ~ label:hover,
.rate input:checked ~ .rate label:hover ~ label,  
.rate label:hover ~ input:checked ~ label { color: #FDD346} 

<%-- 한줄평 등록/수정 모달 --%>
div#registerReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
div#editReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus,
.modal-body input:focus {outline: none;}
.fa-face-meh:hover{cursor: pointer;}

<%-- 한줄평 상세모달 --%>
div.reviewDetail{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus {outline: none;}
img#img_profile {width: 40px; height: 40px; box-sizing: inherit; border:solid 1px #e6e6e6; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; margin: 0 6px;}
p.movieRate{height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px 15px; background-color: #ffffff;}

<%-- 포토티켓 모달 --%>
div#makePhotoTicket{font-family: 'Noto Sans KR', sans-serif;}

</style>

<script>

	$(document).ready(function(){

		$("div#mycontent").css('padding-top','20px');
		$("div#mycontent").css('background-color','#f8f8f8');

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		   /*보고싶어요 시작*/   
		   $(".seechange2").hide(); 
		   
		   $("input:checkbox[name='check_wantsee']").click(function(){
		       
		      if($('input:checkbox[name="check_wantsee"]').is(":checked")) {
		            $(".seechange1").hide(); 
		            $(".seechange2").show(); 
		            $(".seechange2").css({"color":"#ff0558"}); 
		             $(".wantseei").css({"color":"#ff0558"}); 
		         }
		         else if(!$('input:checkbox[name="check_wantsee"]').is(":checked")) {
		            $(".seechange1").show(); 
		            $(".seechange2").hide(); 
		            $(".wantseei").css({"color":""}); 
		         }
		         
		      //   $("input:checkbox[name='check_wantsee']").toggle();
		      
		     });
		   /*보고싶어요 끝*/      

		   /*보는중 시작*/      
		   $("input:checkbox[name='check_seeing']").click(function(){
		        
		      if($('input:checkbox[name="check_seeing"]').is(":checked")) {
		          $(".seeingi").css({"color":"#ff0558"}); 
		      }
		      else if(!$('input:checkbox[name="check_seeing"]').is(":checked")) {
		         $(".seeingi").css({"background-color":"","color":""}); 
		      }
		      
		    //  $("input:checkbox[name='check_seeing']").toggle();
		      
		     });
		   /*보는중 끝*/		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		viewReviewDetail(); // 모달에 한줄평 보여주기
		   
		$('.carousel').carousel({
			interval: 10000
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
 		
 		// 특정 영화에 대하여 회원이 매긴 별점 (원래 값)
 		$("input:radio[name='rating']").each(function(index, item){
 			if(Number($(item).val())/2 == "${requestScope.searchDetail.rating}"){
 				$(item).prop("checked", true);
 				return false;
 			}
 		}); // end of $("input:radio[name='rating']").each(function(index, item){})
<%--
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
 					//	console.log("확인용 : "+JSON.stringify(json));
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
 					//	console.log("확인용 : "+JSON.stringify(json));
 					},
 					error: function(request, status, error){
 			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 			        }			
 	 			});
 			}
 		}); // end of $("input:radio[name='rating']").change(function(){})
--%> 		
 		// 영화에 대한 별점을 수정하는 경우
 		$("input:radio[name='rating']").change(function(){
 			$.ajax({
				url:"<%= ctxPath%>/myWatcha/updateRating.action",
				data:{"movie_id":"${requestScope.searchDetail.movie_id}",
					  "user_id":"${sessionScope.loginuser.user_id}",
					  "rating":Number($(this).val())/2}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
 			});
 		}); // end of $("input:radio[name='rating']").change(function(){})

 		// 관람일자 등록 또는 수정  datepicker
 	    $.datepicker.setDefaults({
 	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
 	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
 	        ,showMonthAfterYear:true // 연도 먼저 나오고, 뒤에 월 표시
 	        ,changeYear: true        // 콤보박스에서 연 선택 가능
 	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
 	        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 달력의 월 부분 텍스트
        	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
 	    });
 	    $("input#watching_date").datepicker();

 	    // 관람일자 등록 또는 수정하기
 	    $("input#watching_date").change(function(){
			const queryString = $("form[name='movieDiaryFrm']").serialize();
			
 	    	if(${empty requestScope.searchDetail.watching_date}){ // 관람일자 등록하는 경우
 	    		$.ajax({
 					url:"<%= ctxPath%>/myWatcha/registerDiary.action",
					data:queryString, 
 					type:"post",
 					dataType:"json",
 					success:function(json){
 					//	console.log("확인용 : "+JSON.stringify(json));
 					    history.go(0); // 새로고침
 					},
 					error: function(request, status, error){
 			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 			        }			
 				});
 	    	}
 	    	else { // 관람일자 수정하는 경우
 	    		$.ajax({
 					url:"<%= ctxPath%>/myWatcha/updateDiary.action",
					data:queryString, 
 					type:"post",
 					dataType:"json",
 					success:function(json){
 					//	console.log("확인용 : "+JSON.stringify(json));
 					},
 					error: function(request, status, error){
 			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 			        }			
 				});
 	    	}
 	    	
 	    }); // end of $("input#watching_date").change(function(){})
 	    
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
 					//	console.log("확인용 : "+JSON.stringify(json));
 					    history.go(0); // 새로고침
 					},
 					error: function(request, status, error){
 			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 			        }			
 				});
 			}
 		}); // end of $("button#btnAdd").click(function(){})
	
 		// 모달 창에서 입력된 값 초기화 시키기
    	$(".modal").each(function(index, item){
    	    $("button.close").on("click", function(){
   	    		let frm = $(item).find('form').get(0);
   	    		if(frm != null){
   		    		frm.reset();
   	    		}
   	    	});
    	}); // end of $(".modal").each(function(index, item){})
    	
    	// 포스터(포토티켓 앞면) 사진 변경하기
    	$("input#changePhotoFront").change(function(){

			const img_photo_front = $(this).get(0);
			console.log(img_photo_front.files);
			
	  		const fileReader = new FileReader();
			fileReader.readAsDataURL(img_photo_front.files[0]); 
			
			fileReader.onload = function() { // 변경한 사진 img 태그에 꽂아주기
			    document.getElementById("img_photo_front").src = fileReader.result;
			};

    	}); // end of $("input#changePhotoFront").change(function(){})
    	
	}); // end of $(document).ready(function(){})
	
	// 한줄평 삭제
	function delReview(review_id){
		if(confirm("한줄평을 삭제하시겠습니까?")){
			$.ajax({
				url:"<%= ctxPath%>/deleteReview.action",
				data:{"review_id":"${requestScope.searchReview.review_id}"}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
				    history.go(0); // 새로고침
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delReview(review_id)
	
	// 한줄평 자세히 보기 모달 창에서 한줄평 수정 모달을 열려고 할 때
	function reviewEditModal(){
		$("div#reviewDetail").modal('hide');
		$("div#editReview").modal('show');
	} // end of function reviewEditModal()
	
	// 한줄평 수정
	function updateReview(review_id){
		
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
				//	console.log("확인용 : "+JSON.stringify(json));
				    history.go(0); // 새로고침
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delReview(review_id)

	// 한줄평에 달린 댓글 보여주기(ajax)
	function viewReviewDetail(){
		
		$.ajax({
			url:"<%= ctxPath%>/reviewComment.action",
			data:{"review_id":"${requestScope.searchReview.review_id}"}, 
			type:"get",
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
			
				let html = "";
				
       			  	<%-- 한줄평에 달린 댓글 --%>
       				if(json.length > 0){ // 한줄평에 달린 댓글이 있는 경우
						html +=   '<h5 class="my-2 ml-4">전체댓글&nbsp;<span style="font-size: 11pt; color: gray;">${requestScope.searchReview.number_of_comments}</span></h5>'
					  		  +   '<div id="viewAllComment">';
					
					  	$.each(json, function(index, item){
					  		html += '<div class="mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';
						  
					        if(item.profile_image == null){ // 유저의 프로필이미지가 없는 경우
						       	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
					        }
					        else {
						       	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
					        }
							
						  	html += '<div style="text-align: left;">';
						  	if(item.user_id == "${sessionScope.loginuser.user_id}"){ // 로그인한 회원이 작성한 한줄평일 경우
						       	html += '<p style="padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">'+item.name+'<span class="pl-2" style="color: #ff0558; font-size: 10pt;">작성자</span></p>';
					        }
						  	else {
						       	html += '<p style="padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">'+item.name+'</p>';
						  	}
						    html += 	'<p style="padding: 0 5px; margin: 0px;">'+item.content+'</p>'
						    	  + 	'<p style="display: inline-block; margin: 10px 0px 0px 0px; font-size: 10pt; color: gray;">작성일자&nbsp;<span class="pl-2">'+item.comment_date+'</span></p>';
						  	if(item.user_id == "${sessionScope.loginuser.user_id}"){ // 로그인한 회원이 작성한 한줄평일 경우
						       	html += '<div style="display: inline-block;">'
						       		  +	  "<button type='button' class='p-0 m-0 mx-1 ml-2' onclick='updateComment1("+JSON.stringify(item)+")' style='font-weight: bold; color: #ff0558; border: none; background-color: transparent; font-size: 10pt;'>수정</button>"
						       		  +   '<button type="button" class="p-0 m-0 mx-1" onclick="delComment('+item.comment_id+')" style="font-weight: bold; color: #ff0558; border: none; background-color: transparent; font-size: 10pt;">삭제</button>'
									  +	'</div>';

					        }
						    html +=   '</div>'
						  		  + '</div>';
					  	}); // end of $.each(json, function(index, item){})
					    html += '</div>';
       			  }
       			  else { // 한줄평에 달린 댓글이 없는 경우
				      html += '<h5 style="text-align: center; padding: 5px; font-weight: 500; margin-bottom: 50px;">이 한줄평에 대한 댓글이 존재하지 않아요.</h5>';
       			  }
       			  
  				$("div#reviewComment").html(html);
       			  
       			<%-- 댓글 등록 --%>
				html  = '<form name="commentFrm">'
			    	  + '<div class="mx-auto">'
			    	  +   '<input type="hidden" name="review_id" value="${requestScope.searchReview.review_id}" />'
			    	  +   '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';

						  <%-- 로그인한 회원의 프로필 이미지 없는경우 --%>
						  <%-- 세션으로 수정예정 
					        if("${sessionScope.loginuser.profile_image}" == null){ // 유저의 프로필이미지가 없는 경우
						       	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
					        }
					        else {
						       	html += '<img id="img_profile" src="<%= ctxPath%>/resources/images/'+item.profile_image+'"/>';
					        }
						  --%>
			  	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';

			  	html += 	'<div style="width: 100%;">'
					  +		  '<div style="display: flex;" class="mb-2">'
					  +		    '<p style="text-align: left; padding: 0 5px; margin: 0px 10px 5px 0px; font-weight: 600;">작성자이름</p>'
					  +		    '<input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}" />'
					  +		  '</div>'
					  +		  '<textarea id="content" name="content" style="width: 100%; height: 70px; resize: none; border: solid 1px #e6e6e6; border-radius: 1%; font-size: 11pt;" placeholder="이 한줄평에 대한 댓글을 적어주세요."></textarea>'
					  +		  '<div style="display: flex; position: relative; float: right;">'
					  +		    '<span class="addError" style="color: #ff0558;"></span>'
					  +		      '<button type="button" onclick="addComment(${requestScope.searchReview.review_id})" class="btn btn-sm btn-secondary m-1 ml-3">등록</button>'
					  +		      '<button type="button" onclick="reviewDetail(${requestScope.searchReview.review_id})" class="btn btn-sm btn-light m-1">취소</button>'
					  +		  '</div>'
					  +		'</div>'
					  +	  '</div>'
					  +	'</div>'
					  +	'</form>';
    	  	  	  
  				$("div#commentRegister").html(html);
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }			
		});
	} // end of function viewReviewDetail()
	
	// 한줄평에 댓글 추가
	function addComment(review_id){
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
					viewReviewDetail();				
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function addComment(review_id)
		
	// 한줄평에 달린 댓글 수정(수정 form 태그)
	function updateComment1(commentObj){
		let html = "";
	    <%-- 댓글 수정 --%>
	    html +=     '<div id="commentEdit" class="mx-auto my-2 p-1">'
	    	  + 	  '<div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">';
	    <%--	  
		if(${empty sessionScope.profile_image}){ // 유저의 프로필이미지가 없는 경우
	    	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
      	}
      	else {
	       	html += 	'<img id="img_profile" src="<%= ctxPath%>/resources/images/'+${sessionScope.profile_image}+'"/>';
      	}
      	--%>
    	html +=     '<img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>';
    	
		html += 		'<div style="width: 100%;">'
	    	  + 		  '<div style="display: flex;" class="mb-2">'
	    	  + 		    '<p style="text-align: left; padding: 0 5px; margin: 0px 10px 5px 5px; font-weight: 600; color: #ff0558;">댓글 수정하기</p>'
	    	  + 		    '<input type="hidden" name="comment_id" value="'+commentObj.comment_id+'" />'
	    	  + 		  '</div>'
	    	  + 		  '<textarea id="content" name="content" style="width: 100%; height: 70px; resize: none; border: solid 1px #e6e6e6; border-radius: 1%; font-size: 11pt;">'+commentObj.content+'</textarea>'
	    	  + 		  '<div style="display: flex; position: relative; float: right;">'
	    	  +				'<span class="addError" style="color: #ff0558;"></span>'
	    	  + 		    "<button type='button' onclick='updateComment2()' class='btn btn-sm btn-secondary m-1'>수정</button>"
	    	  + 		    "<button type='button' onclick='viewReviewDetail()' class='btn btn-sm btn-light m-1'>취소</button>"
	     	  + 		  '</div>'
	     	  + 		'</div>'
	    	  + 	  '</div>'
	    	  + 	'</div>';
	    	  
	  	$("form[name='commentFrm']").hide();
	  	$("form[name='commentFrm']").html(html);
	  	$("form[name='commentFrm']").fadeIn('30');
	} // end of function updateComment1(commentObj)
	
	// 한줄평에 달린 댓글 수정
 	function updateComment2(){
  		const queryString = $("form[name='commentFrm']").serialize();

		$.ajax({
			url:"<%= ctxPath%>/updateComment.action",
			data:queryString, 
			type:"post",
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				viewReviewDetail();				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }			
		});
	} // end of function updateComment2()
	
	// 한줄평에 달린 댓글 삭제
	function delComment(comment_id){
		if(confirm("댓글을 삭제하시겠습니까?")){
			$.ajax({
				url:"<%= ctxPath%>/deleteComment.action",
				data:{"comment_id":comment_id,
					  "review_id":"${requestScope.searchReview.review_id}"}, 
				type:"post",
				dataType:"json",
				success:function(json){
				//	console.log("확인용 : "+JSON.stringify(json));
					viewReviewDetail();				
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }			
			});
		}
	} // end of function delComment(comment_id)

	// 포토티켓 등록 - canvas 객체 변환
	function registerPhoto1(){
		
		// 포토티켓 내 text를 입력하는 input 태그 유효성 검사하기
		if($("input#photoText").val() == ""){
			$("input#photoText").val(" ");
		}
		if($("textarea#photoContent").val() == ""){
			$("textarea#photoContent").val(" ");
		}
		
		// 포토티켓을 등록할때(canvas 로 저장 시) textarea 줄바꿈이 안되어서 div 에 .text() 로 꽂아주었음
		$("textarea#photoContent").css('display','none');
		$("div#div_photoContent").text($("textarea#photoContent").val());
		
		var formData = new FormData();
		formData.append("diary_id", "${requestScope.searchDetail.diary_id}");

		// 포토티켓 앞면, 뒷면 html 객체를 canvas 로 변환하여 input 태그(file 타입)에 꽂아주기
		html2canvas(document.querySelector("#div_photo_front")).then(function(canvas){
			let imgBase64 = canvas.toDataURL("image/jpeg", 1.0); // Base64 로 변환
			// data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQ ... (이하 생략)
			let file_front = canvasToFile(imgBase64, "file_front");
		    formData.append("file_front", file_front);

		    // file 로 변환하는 데 시간이 오래 걸려서 순차적으로 진행하도록 함
		    html2canvas(document.querySelector("#div_photo_back")).then(function(canvas){
				let imgBase64 = canvas.toDataURL("image/jpeg", 1.0); // Base64 로 변환
				let file_back = canvasToFile(imgBase64, "file_back");
			    formData.append("file_back", file_back);
				
				registerPhoto2(formData); // ajax
			});
		});
	} // end of function registerPhoto1()
	
	// 포토티켓 등록 - ajax
	function registerPhoto2(formData){
		$.ajax({
			url:"<%= ctxPath %>/myWatcha/registerPhoto.action",
            data: formData,
			type:"post",
            processData:false,  // 파일 전송시 설정 
            contentType:false,  // 파일 전송시 설정 
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
			    history.go(0); // 새로고침
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }			
		});
	} // end of function registerPhoto2(formData)

	// Base64 로 변환된 canvas 객체를 file 객체로 변환하기
	function canvasToFile(imgBase64, fileName){
		const decodImg = atob(imgBase64.split(",")[1]); // , 를 기준으로 뒷부분만 잘라내기

	  	let imgArr = [];
	  	for(let i=0; i<decodImg.length; i++){
	  		imgArr.push(decodImg.charCodeAt(i)); // imgArr 배열에 넣기
	  	}

	  	return new File([new Uint8Array(imgArr)], fileName, {type: 'image/jpeg'});
	} // end of function canvasToFile(imgBase64)

	// 포토티켓 다운로드
	function downloadPhoto(){
		
	}
	
</script>

  <div class="container-fluid">
	<div id="div_container" class="container">
	  <div id="div_myContent">
	  	<div style="overflow: hidden; height: 300px;">
	      <a href="<%= ctxPath %>/view/project_detail.action?movie_id=${requestScope.movieInfo.movie_id}" style="text-decoration: none; color: black;">
	  	    <img id="img_wallPaper" src="https://image.tmdb.org/t/p/w1280/${requestScope.searchDetail.backdrop_path}" />
	  	  </a>
	  	</div>
  		
  		<div style="height: 280px; padding: 0 50px; margin-bottom: 20px;">
  		  <div style="position: relative; top: -2rem;">
			<div style="display: flex; margin: 0px; padding: 0px; text-align: center; font-weight: 500;" class="row">
              <div class="col-md-4">
                <img id="img_movie" class="img-thumnail" src="https://image.tmdb.org/t/p/w780/${requestScope.searchDetail.poster_path}">
              </div>
  			  <div class="col-md-8" style="text-align: left; position: relative; top: 3rem;">
	  			<h4 style="padding: 0 5px; font-weight: 700; margin: 10px;">${requestScope.searchDetail.movie_title}</h4>
	            <h5 class="pt-3 pl-4" style="color: #ff0558; font-weight: 500;">${requestScope.searchDetail.genre_name}</h5>
   		  	  	<div class="mx-2 text-center" style="padding: 5px; border-bottom: solid 1px #e6e6e6;">
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
			    <div class="py-2 pl-3 text-center" style="display: flex;">
		         <p class="h6 py-2 mx-2" style="width: 45%;">개봉일자&nbsp;${requestScope.searchDetail.release_date}</p>
                 <form name="movieDiaryFrm" style="width: 55%;">
				 <c:if test="${not empty requestScope.searchDetail.watching_date}">
			       <p class="h6 py-2 mx-2" data-toggle="tooltip" title="관람일자를 수정하려면 클릭하세요.">관람일자
    			     <input type="text" id="watching_date" name="watching_date" value="${requestScope.searchDetail.watching_date}" readonly="readonly" style="width: 110px; border: none; cursor: pointer; color: gray;" />
			       </p>
			       <input type="hidden" name="diary_id" value="${requestScope.searchDetail.diary_id}" />
				 </c:if>
				 <c:if test="${empty requestScope.searchDetail.watching_date}">
			       <p class="h6 py-2 mx-2">관람일자
    			     <input type="text" id="watching_date" name="watching_date" value="" readonly="readonly" placeholder="등록하기" style="width: 110px; border: none; cursor: pointer; color: gray;" />
			       </p>
			       <input type="hidden" name="movie_id" value="${requestScope.searchDetail.movie_id}" />
				 </c:if>
                 </form>
			    </div>
  			  </div>
		    </div>
  		  </div>
  		</div>
  		
	  	<div id="div_nav_content" class="container my-3 pt-5"> 
	  	  
		  <div class="row mx-auto my-2" style="padding: 0 50px;">
		  
	  	    <div id="comment" class="mx-auto p-1 m-2" style="width: 45%;">
	 	      <h5 style="padding-left: 10px; font-weight: 600;">이 영화에 대한 한줄평</h5>
	          <div class="mx-auto my-3 p-1">
       		    <div class="mx-auto my-auto p-2" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
     		  	  
    		  	<c:if test="${not empty requestScope.searchReview}">
     		  	  <p id="review_content" style="padding: 10px;">${requestScope.searchReview.review_content}</p>
     		  	  <c:if test="${requestScope.searchReview.spoiler_status eq 1}">
	       		    <p style="padding: 0px 10px; margin: 0px; color: #ff0558; font-size: 11pt; font-weight: bold;">스포일러가 포함되어 있어요.</p>
     		  	  </c:if>
    		  	  <p class="m-2 pl-2" style="font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">${requestScope.searchReview.review_date}</span></p>
    		  	  <div style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <div style="display: flex;">
    		  	      <p class="m-2">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i><span class="pl-2">${requestScope.searchReview.number_of_likes}</span></p>
    		  	      <p class="m-2">
    		  	        <span>댓글&nbsp;<i class="fa-solid fa-comments" style="color: #e6e6e6;"></i></span>
    		  	        <span class="pl-2">${requestScope.searchReview.number_of_comments}</span>
    		  	      </p>
    		  	    </div>
    		  	  </div>
   		  	      <div style="padding-left: 25px; display: flex; font-size: 11pt;">
   		  	        <button type="button" data-target="#reviewDetail" data-toggle="modal" data-backdrop="static" style="background-color: transparent; border: none; font-weight: bold; color: #ff0558; margin: 5px;">자세히 보기</button>
				    <button type="button" data-target="#editReview" data-toggle="modal" data-backdrop="static" style="background-color: transparent; border: none; font-weight: bold; color: gray; margin: 5px;">한줄평 수정하기</button>
   		  	      </div>
    		  	</c:if>
    		  	  
    		  	<c:if test="${empty requestScope.searchReview}">
		          <div class="m-1 w-100 text-center my-3">
     		  	    <p style="padding: 10px;" class="h6">등록된 한줄평이 없어요.</p>
				    <button type="button" class="btn btn-md btn-secondary m-1" data-toggle="modal" data-backdrop="static" data-target="#registerReview">한줄평 등록하기</button>
    	          </div>
    		  	</c:if>

       		   </div>	
		      </div>
		    </div>
		  
	  	    <div class="mx-auto p-1 m-2" style="width: 55%;">
	  	    <div style="display: flex;">
 	    	  <h5 style="padding-left: 10px; font-weight: 600;">이 영화의 포토티켓</h5>
			  <c:if test="${not empty requestScope.searchDetail.photo_front}">
		       <button type="button" class="btn btn-sm btn-light p-1 px-2 ml-4" onclick="downloadPhoto()">
		        <span>포토티켓 다운로드</span><i class="fa-regular fa-circle-down fa-lg ml-2" style="color: gray;"></i>
		       </button>
			  </c:if>
	  	    </div>
			  <div id="photoTicket" class="mx-auto mt-1 mb-3 p-1">
			    <div class="p-0 text-center">
				  <c:if test="${not empty requestScope.searchDetail.photo_front}">
				  <div style="display: flex;">
			        <div class="card m-1 w-50">
                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${requestScope.searchDetail.photo_front}">
	    	        </div>
			        <div class="card m-1 w-50">
                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/photoTicket/${requestScope.searchDetail.photo_back}">
	    	        </div>
				  </div>
				  <p style="color: gray;">포토티켓을 다시 만들 수도 있어요!<button type="button" data-toggle="modal" data-backdrop="static" data-target="#makePhotoTicket" style="border:none; background-color: transparent; font-weight: bold; color: #ff0558;">포토티켓 만들기</button></p>
				  </c:if>
				  
				  <c:if test="${empty requestScope.searchDetail.photo_front}">
		          <div class="m-1 w-100 text-center my-3 pt-1">
   		  	        <p style="padding: 10px;" class="h6">등록된 포토티켓이 없어요.</p>
   		  	        <c:if test="${not empty requestScope.searchDetail.watching_date}">
	                  <button type="button" class="btn btn-md btn-secondary p-2 m-2" data-toggle="modal" data-backdrop="static" data-target="#makePhotoTicket">포토티켓 만들기</button>
   		  	        </c:if>
   		  	        <c:if test="${empty requestScope.searchDetail.watching_date}">
   		  	          <p style="padding: 10px; color: gray;" class="h6"><span style="color: #ff0558;">관람일자</span>를 먼저 등록해주세요.</p>
   		  	        </c:if>
    	          </div>
	 			  </c:if>
				  
				</div>
			  </div>
		    </div>
	      </div>
		      
	  	</div>
	  </div>
	</div>
  </div>

		<%-- 포토티켓 모달창 --%>
		<div class="modal fade" id="makePhotoTicket" data-keyboard="false">
		<form name="photoTicketFrm" enctype="multipart/form-data">
		  <div class="modal-dialog modal-dialog-centered mx-auto">
		    <div class="modal-content mx-auto" style="width: 85%;">
		      <div class="modal-body text-center" style="height: 620px; margin: 10px;">
		        <h5 class="modal-title" style="font-weight: bold;">포토티켓 만들기<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
			    <div class="row mx-auto mt-3 mb-2" style="display: flex; padding: 10px 0; height: 450px;">
		          <div id="div_photo_front" class="col p-1 pt-3 mx-1 text-center" style="width: 98%; height: 420px; border: solid 1px #e6e6e6; border-radius: 2%;">
                    <img id="img_photo_front" class="img-thumnail" style="width: 90%; border-radius: 3%;" src="<%= ctxPath %>/resources/images/photoTicket/${requestScope.searchDetail.poster_path}">
			        <input type="text" id="photoText" style="width: 98%; text-align: center; border: none; font-size: 10pt; margin: 8px;" placeholder="포토티켓에 문구를 넣어보세요." autocomplete="off" />
    	          </div>
		          <div id="div_photo_back" class="col p-1 py-3 mx-1" style="width: 98%; height: 420px; border: solid 1px #e6e6e6; border-radius: 2%;">
		      	    <div>
		      	      <p class="h4 my-3 p-2">${requestScope.searchDetail.movie_title}</p>
		      	      <p class="h5 py-2" style="color: #ff0558;">${requestScope.searchDetail.genre_name}</p>
		      	      <p class="h6 py-2">관람일자&nbsp;${requestScope.searchDetail.watching_date}</p>
			          <div class="py-4">
			            <c:if test="${requestScope.searchDetail.rating %1 ne 0}"> <%-- 별점에 소수점 포함 (예: 3.5) --%>
			            <fmt:parseNumber var="rating" value="${requestScope.searchDetail.rating}" integerOnly="true" />
			            <c:forEach begin="1" end="${rating}">
		                  <i class="fa-solid fa-star fa-2xl" style="color: #fdd346;"></i>
			            </c:forEach>
					      <i class="fa-solid fa-star-half fa-2xl" style="color: #fdd346;"></i>						       
			            </c:if>
			            <c:if test="${requestScope.searchDetail.rating %1 eq 0}"> <%-- 별점에 소수점 포함X (예: 4) --%>
			            <c:forEach begin="1" end="${requestScope.searchDetail.rating}">
		                  <i class="fa-solid fa-star fa-2xl" style="color: #fdd346;"></i>
			            </c:forEach>
			            </c:if>
			          </div>
		      	      <div class="my-2 px-2" style="font-size: 11pt; width: 100%; height: 120px;">
		      	        <div id="div_photoContent" style="width: 99%; text-align: left;"></div>
   	        		    <c:if test="${not empty requestScope.searchReview}">
      		  		      <textarea id="photoContent" style="width: 100%; height: 120px; overflow: hidden; font-size: 11pt; resize: none; border: none;">${searchReview.review_content}</textarea>
					    </c:if>
   	        		    <c:if test="${empty requestScope.searchReview}">
      		  		      <textarea id="photoContent" style="width: 100%; height: 120px; overflow: hidden; font-size: 11pt; resize: none; border: none;" placeholder="등록된 한줄평이 없어요."></textarea>
					    </c:if>
		      	      </div>
		      	    </div>
    	          </div>
			    </div>
			    <label class="btn btn-secondary m-0" style="padding: 10px 30px;">포스터 사진 변경하기
                  <input type="file" name="changePhotoFront" id="changePhotoFront" accept="image/*" style="display: none;"/>
			    </label>
		        <button type="button" class="btn" onclick="registerPhoto1()" style="padding: 10px 30px; color: #ffffff; background-color: #ff0558;">포토티켓 등록하기</button>
		      </div>
		    </div>
		  </div>
		</form>
		</div>
		
	  <%-- 한줄평 등록 모달창 --%>
      <c:if test="${empty requestScope.searchReview}">
		<div class="modal fade registerReview" id="registerReview" data-keyboard="false">
		<form name="registerReviewFrm">
		  <input type="hidden" name="user_id" value="${sessionScope.loginuser.user_id}" />
		  <input type="hidden" name="movie_id" value="${requestScope.searchDetail.movie_id}" />
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-body">
		        <h5 class="modal-title" style="font-weight: bold;">${requestScope.searchDetail.movie_title}<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
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
      <c:if test="${not empty requestScope.searchReview}">
       	<div class="modal fade editReview" id="editReview" data-keyboard="false">
		<form name="editReviewFrm">
		  <input type="hidden" name="review_id" value="${requestScope.searchReview.review_id}" />
		  <div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			  <div class="modal-body">
			  	<h5 class="modal-title" style="font-weight: bold;">${requestScope.searchDetail.movie_title}<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
			  	<div class="my-2">
			  	  <textarea id="review_content" name="review_content" style="width: 100%; height: 450px; resize: none; border: none;">${requestScope.searchReview.review_content}</textarea>
			  	</div>
			  	<div style="display: inline-block; width: 100%;">
			  	  <div style="display: inline-block; width: 83%;">
			  	
			  	    <label for="spoiler_status">
					<c:if test="${requestScope.searchReview.spoiler_status eq 0}">
					  <i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #cccccc;"></i>
				  	  <input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="0" />
				  	  <span id="spoiler_status" style="color: #666666; cursor: pointer;">스포일러가 포함된 한줄평을 가려보세요.</span>
					</c:if>
					<c:if test="${requestScope.searchReview.spoiler_status eq 1}">
					  <i class="fa-solid fa-face-meh fa-2xl mr-1" style="color: #ff0558;"></i>
				  	  <input type="checkbox" id="spoiler_status" name="spoiler_status" style="display: none;" value="1" checked />
				  	  <span id="spoiler_status" style="color: #666666; cursor: pointer;">한줄평에 스포일러가 포함되었어요.</span>
					</c:if>
				  	</label>
			  	  
				  </div>
				  <div style="display: inline-block; width: 16%; text-align: right;">
		            <button type="button" class="btn" onclick="updateReview(${requestScope.searchReview.review_id})" style="color: #ffffff; background-color: #ff0558;">수정</button>
			  	  </div>
			  	</div>
			  </div>
			</div>
		  </div>
		</form>
		</div>
	  </c:if>
      <%-- 한줄평 수정 모달창 끝 --%>
	
		<%-- 한줄평 자세히 보여주기 모달창 --%>
		<div class="modal fade reviewDetail" id="reviewDetail" data-keyboard="false">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-body">
		        <h5 class="modal-title mb-2 ml-4"><span>${requestScope.searchDetail.movie_title}에 대한 한줄평</span><button type="button" class="close" data-dismiss="modal">&times;</button></h5>
       			
       			  <%-- 한줄평 --%>
	       		  <div class="mx-auto my-2 p-2" style="background-color: #fdfdfd; border: solid 1px #e6e6e6; border-radius: 2%; width: 95%;">
	      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
					
					<%-- 로그인한 회원의 프로필 이미지 없는경우 --%>
					<%-- 세션으로 수정예정 
					<c:if test="${not empty requestScope.userInfo.profile_image}">
		  			  <img id="img_profile" src="<%= ctxPath%>/resources/images/${requestScope.userInfo.profile_image}"/>
					</c:if>
					<c:if test="${empty requestScope.userInfo.profile_image}">
		  			  <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
					</c:if>
					--%>

	  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>

	  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">로그인한 회원</h5>
	       			  <p class="pr-2" style="color: gray; font-size: 10pt; padding: 0px; margin: 10px 0 0 0;">내가 쓴 한줄평</p>
	       		  	  <button type="button" onclick="reviewEditModal()" style="font-weight: bold; color: #ff0558; border: none; background-color: transparent;">수정</button>
	       		  	  <button type="button" onclick="delReview(${requestScope.searchReview.review_id})" style="font-weight: bold; color: #ff0558; border: none; background-color: transparent;">삭제</button>
	      		    </div>
	      		    
	      		    <div class="mx-auto my-auto p-2">
	       			  <div class="m-0 p-0 my-2">
	       		        <p id="review_content" style="padding: 0px 10px; margin: 0px;">${requestScope.searchReview.review_content}</p>
	       		  	  </div>
	       		  	  <c:if test="${requestScope.searchReview.spoiler_status eq 1}">
	       			  <div class="m-0 p-0 my-2">
	       		  		<p style="padding: 0px 10px; margin: 0px; color: #ff0558; font-size: 11pt; font-weight: bold;">스포일러가 포함되어 있어요.</p>
	       		  	  </div>
	       		  	  </c:if>
     				  <div style="display: flex;">
     		  			<p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="ml-2">${requestScope.searchReview.review_date}</span></p>
	       				<p class="movieRate">★&nbsp;<span>${requestScope.searchDetail.rating}</span></p>
     				  </div>
     				  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
					    <label for="like_review" class="m-2" style="cursor: pointer;">
     			  		  <span onclick="alert('내 한줄평에 좋아요를 할수는 없어요.');">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i></span>
     			  		  <span class="pl-1" id="number_of_likes" style="cursor: default;">${requestScope.searchReview.number_of_likes}</span>
    	  	  			</label>
    	  	  			<p class="m-2">
    	  	  			  <span>댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i></span>
    	  	  			  <span id="number_of_comments" class="pl-2">${requestScope.searchReview.number_of_comments}</span>
    	  	  			</p>
    	  	  		  </div>
    	  	  		</div>
       			  
       			    <%-- 한줄평에 달린 댓글 --%>
  			  	    <div id="reviewComment" class="mx-auto my-auto p-1 mb-3" style="margin: 3px;"></div>
  			  	  </div>
  			  	  
       			  <%-- 댓글 등록 --%>
    	  	  	  <div id="commentRegister" class="mx-auto mt-2 p-1 mb-3" style="background-color: #f2f2f2; border: solid 1px #e6e6e6; border-radius: 2%; width: 95%;"></div>

		      </div>
		    </div>
		  </div>
		</div>  	
