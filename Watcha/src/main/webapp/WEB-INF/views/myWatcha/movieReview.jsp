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
p.movieRate{width: 40%; height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px; background-color: #ffffff;}

<%-- 한줄평등록/수정 모달 --%>
div#registerReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
div#editReview{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus,
.modal-body input:focus {outline: none;}
.fa-face-meh:hover{cursor: pointer;}	
</style>

<script>

	$(document).ready(function(){
		
		userReview(); // 영화별 유저들 한줄평 (카드 캐러셀, Ajax) 보여주는 함수 호출
		
		// 스포일러가 포함된 한줄평에서 "한줄평 보기" 버튼 클릭 시
		$(document).on("click", "button.showContent", function(){
			$(this).parent().css('display', 'none');
			$(this).parent().next().fadeIn('slow').css('display', '');
 		}); // end of $(document).on("click", "button.showContent", function(){})

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
		
		 // 모달 창에서 입력된 값 초기화 시키기
	 	 $(".modal").each(function(index, item){
	 	 	$("button.close").on("click", function(){
		    	let frm = $(item).find('form').get(0);
		    	if(frm != null){
			    	frm.reset();
		    	}
			});
		 }); // end of $(".modal").each(function(index, item){})

	     // 특정 영화에 대하여 회원이 매긴 별점 (원래 값)
	     $("input:radio[name='rating']").each(function(index, item){
	        if(Number($(item).val())/2 == "${requestScope.reviewInfo.rating}"){
	           $(item).prop("checked", true);
	           return false;
	        }
	     }); // end of $("input:radio[name='rating']").each(function(index, item){})

	     // 영화에 대한 별점 등록 또는 수정 하는 경우
	     $("input:radio[name='rating']").change(function(){
	        if("${requestScope.reviewInfo.rating}" == ""){ // 별점 등록하는 경우
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

	}); // end of $(document).ready(function(){})

	// 영화별 유저들 한줄평 (카드 캐러셀) 보여주기(Ajax)
	function userReview(){
		$.ajax({
			url:"<%= ctxPath%>/movieReview.action",
			data:{"movie_id":"${requestScope.movieDetail.movie_id}"},
			dataType:"json",
			success:function(json){
			//	console.log("확인용 : "+JSON.stringify(json));
				
				let html = "";
				if(json.length > 0){ // 영화에 대한 유저들의 한줄평이 존재하는 경우
					
					html += '<div id="userReview" class="container" style="padding: 0px;">'
					      +   '<div style="position: relative; float: right; z-index: 2;">'
					      +     '<a style="padding: 0px 15px; color: black; text-decoration: none;" href="<%= request.getContextPath()%>/allReview.action?movie_id='+${requestScope.movieDetail.movie_id}+'">전체보기</a>'
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
				        html +=       '<h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">'+item.name+'</h5>'
				       		  +     '</div>'
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
				       		  +         '<p style="width: 60%; padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">'+item.review_date+'</p>';
				       		  
				        if(item.rating == 0){ // 별점평가를 하지 않은 경우
					       	html +=   	'<p class="movieRate text-center">평가안함</p>';
				        }
				        else {
					       	html +=   	'<p class="movieRate text-center">★&nbsp;<span>'+item.rating+'</span></p>';
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
					      +	    '<a class="carousel-control-prev" href="#review" role="button" data-slide="prev">'
					      +	      '<span class="carousel-control-prev-icon" aria-hidden="true"><i class="fa-solid fa-angle-left fa-2xl" style="color: #cccccc;"></i></span>'
					      +	      '<span class="sr-only">Previous</span>'
					      +	    '</a>'
					      +	    '<a class="carousel-control-next" href="#review" role="button" data-slide="next">'
					      +	      '<span class="carousel-control-next-icon" aria-hidden="true"><i class="fa-solid fa-angle-right fa-2xl" style="color: #cccccc;"></i></span>'
					      +	      '<span class="sr-only">Next</span>'
					      +	    '</a>'
					      +	  '</div>'
					      +	'</div>';
				}
				else {
					html += '<h5 style="text-align: center; padding: 5px; margin: 50px; font-weight: 600;">이 영화에 대한 한줄평이 존재하지 않아요.</h5>';
				}
				$("div#div_comment").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});		
	} // end of function userReview()
	
</script>

<div class="container" style="padding: 0px;">
	<div id="div_comment"></div>
</div>

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
