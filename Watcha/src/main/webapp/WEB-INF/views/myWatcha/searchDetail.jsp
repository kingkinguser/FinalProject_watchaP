<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>    
    
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
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
img#img_wallPaper {position: relative; z-index:1; object-fit:cover; width: 100%; border-radius: 3% / 4%; opacity: 0.8;}
img#img_movie {position: relative; z-index:2; border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}
span#collectionCount {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}

select#collection{border: none; font-size: 11pt;}
select#collection:focus{outline: none;}

input[type="checkbox"] {opacity: 0;}

<%-- 별점 --%>
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

<%-- 한줄평수정 모달 --%>
div#editComment{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus,
.modal-body input:focus {outline: none;}
.fa-face-meh:hover{color: #ff0558; cursor: pointer;}

<%-- 한줄평 상세모달 --%>
div.replyOfComment{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus {outline: none;}
img#img_profile {width: 40px; height: 40px; box-sizing: inherit; border:solid 1px #e6e6e6; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; margin: 0 6px;}
p.movieRate{height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px 15px; background-color: #ffffff;}

</style>

<script>

	$(document).ready(function(){
		
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
	
		$('.carousel').carousel({
			interval: 10000
		});
		
 		$("input#checkSpoiler").change(function(){
 			if($(this).prop("checked")){
 				$(this).prev().css("color","#ff0558");
 				$(this).parent().next().text("한줄평에 스포일러가 포함되었습니다.");
 			}
 			else{
 				$(this).prev().css("color","#cccccc");
 				$(this).parent().next().text("스포일러가 포함된 한줄평을 가려보세요.");
 			}
 		}); 		
 		
	}); // end of $(document).ready(function(){})

</script>
</head>
<body>
  <div class="container-fluid" style="background-color: #f8f8f8;">
	<div id="div_container" class="container">
	  <div id="div_myContent">
	  	<div style="overflow: hidden; height: 300px;">
	  	  <img id="img_wallPaper" src="<%= ctxPath%>/resources/images/배경이미지.jpg" />
	  	</div>
  		
  		<div style="height: 250px; padding: 0 50px; margin-bottom: 20px;">
  		  <div style="position: relative; top: -2rem;">
			<div style="display: flex; margin: 0px; padding: 0px; text-align: center; font-weight: 500;" class="row">
              <div class="col-md-4">
                <img id="img_movie" class="img-thumnail" src="<%= ctxPath%>/resources/images/포스터.jpg">
              </div>
  			  <div class="col-md-8" style="position: relative; top: 3rem;">
	  			<h4 style="text-align: left; padding: 0 5px; font-size: 20pt; font-weight: 900; margin-top: 10px;">영화제목</h4>
			    <div style="display: flex; margin: 5px;">
			      <p class="h5 my-2 mr-2">영화장르</p>
			      <p class="h5 my-2 mr-2">개봉일자</p>
			    </div>
     		  	<div class="h5 pl-2 my-1 p-2" style="padding: 5px;">
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
			    <div style="display: flex; margin: 5px auto; padding: 5px; border-top: solid 1px #e6e6e6;">
                 <label for="check_wantsee" style="cursor: pointer; width: 28%;" class="my-2 mx-2">
                   <i class="seechange1 fas fa-plus wantseei" style="color: gray; width: 14px;"></i>
                   <i class="seechange2 fas fa-bookmark" style="color: gray; width: 14px;"></i>
                   <span class="wantseei">&nbsp;&nbsp;보고싶어요</span>
                   <input type="checkbox" id="check_wantsee" name="check_wantsee"/>
                 </label>
                 <label for="check_seeing" style="cursor: pointer; width: 20%;" class="my-2 mx-2">
                   <i class="far fa-eye seeingi" style="color: gray;"></i>
                   <span class="seeingi">&nbsp;&nbsp;보는중</span>
                   <input type="checkbox" id="check_seeing" name="check_seeing"/>
                 </label>
			      <p class="my-2 mx-2" style="width: 50%;">관람일자<span class="ml-1">2023.05.13</span></p>
			    </div>
  			  </div>
		    </div>
  		  </div>
  		</div>
  		
	  	<div id="div_nav_content" class="container py-3" style="position: relative; top: 0rem;"> 
	  	  
		  <div class="row mx-auto my-2" style="padding: 0 50px;">
	  	    <div id="comment" class="col-md-12 mx-auto p-1">
	 	      <h5 style="padding-left: 5px; font-weight: 600;">이 영화에 대한 한줄평</h5>
	          <div class="mx-auto mt-2 mb-3 p-1">
       		    <div class="mx-auto my-auto p-2" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
     		  	  <p style="padding: 10px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <div style="display: flex; width:70%;">
    		  	      <p class="m-2">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
    		  	      <p class="m-2">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i><span class="pl-2">345</span></p>
    		  	      <p class="m-2">
    		  	        <button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;
    		  	          <i class="fa-solid fa-comments" style="color: #e6e6e6;"></i>
    		  	          <span class="pl-2">27</span>
    		  	        </button>
    		  	      </p>
    		  	    </div>
    		  	    <div style="width: 30%; text-align: right;">
					  <button type="button" class="btn btn-sm btn-secondary p-2 m-1" data-toggle="modal" data-target="#editComment">한줄평 수정하기</button>
    		  	    </div>
    		  	  </div>
       		   </div>	
		      </div>
		    </div>
	      </div>
		  
		  <div class="row mx-auto my-2" style="padding: 0 50px;">
	  	    <div id="collection" class="col-md-4 mx-auto p-1">
	 	      <h5 style="padding-left: 10px; font-weight: 600;">이 영화가 담긴 컬렉션<span id="collectionCount">5</span></h5>
	 	      <select id="collection" style="margin: 5px 10px; width: 90%;">
	 	        <option>컬렉션1</option>
	 	        <option>컬렉션2</option>
	 	        <option>컬렉션3</option>
	 	      </select>
	          <div class="mx-auto mt-2 mb-3 p-1 w-100" style="padding: 0 50px;">
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
	          </div>
	        </div>

	  	    <div class="col-md-8 mx-auto p-1">
 	    	  <h5 style="padding-left: 10px; font-weight: 600;">이 영화의 포토티켓</h5>
			  <div id="photoTicket" class="mx-auto mt-1 mb-3 p-1">
			    <div class="p-0">
				  <div style="display: flex;">
				    <p style="padding: 0 0 0 10px; margin: 0px;">2023.05.13</p>
				    <button type="button" class="btn btn-sm btn-light p-1 mb-1 px-2 mx-2" onclick="">
				      <span>포토티켓 다운로드</span><i class="fa-regular fa-circle-down fa-lg ml-2" style="color: gray;"></i>
				    </button>
				  </div>
				  <div style="display: flex;">
			        <div class="card m-1 w-50">
                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
	    	        </div>
			        <div class="card m-1 w-50">
                      <img class="img-thumnail rounded img-fluid" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
	    	        </div>
				  </div>
			    </div>
		      </div>
	  	    </div>
		  </div>
		</div>
	  </div>
	</div>

		<%-- 포토티켓 모달창 --%>
		<div class="modal fade" id="makePhotoTicket">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-body text-center" style="height: 580px; margin: 10px;">
		        <h5 class="modal-title" style="font-weight: bold;">포토티켓 만들기<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
			    <div class="row mx-auto mt-3" style="display: flex; padding: 10px 0; height: 380px;">
			      <div id="photoTicketFront" class="col p-0 mx-1" style="width:95%; border: solid 1px #e6e6e6; border-radius: 1%;">
                    <img class="img-thumnail rounded" style="width: 100%;" src="<%= ctxPath%>/resources/images/포스터.jpg">
				    <input type="text" style="text-align: center; border: none; font-size: 10pt; margin: 5px;" placeholder="포토티켓에 문구를 넣어보세요."/>
	    	      </div>
			      <div id="photoTicketBack" class="col p-0 py-3 mx-1" style="width:95%; border: solid 1px #e6e6e6; border-radius: 1%;">
			      	<div>
			      	  <p class="h4 my-3">가디언즈 오브 갤럭시: Volume 3</p>
			      	  <div>
			      	    <p class="h5 my-3">관람일자</p>
			      	    <p class="my-3">영화장르</p>
			      	    <p class="my-3 p-2" style="font-size: 11pt;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
			      	    <div>별점</div>
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
		
		<%-- 한줄평 수정 모달창 --%>
		<div class="modal fade" id="editComment">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-body">
		        <h5 class="modal-title" style="font-weight: bold;">영화제목<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
	      		<div class="my-2">
	      		  <textarea style="width: 100%; height: 450px; resize: none; border: none;" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요."></textarea>
	      		</div>
	      		<div style="display: inline-block; width: 100%;">
	      		  <div style="display: inline-block; width: 83%;">
	      		    <label for="checkSpoiler">
		  		      <i class="fa-solid fa-face-meh fa-2xl" style="color: #cccccc;"></i>
		              <input type="checkbox" id="checkSpoiler" style="display: none;" />
	      		    </label>
		            <span style="color: #666666;">스포일러가 포함된 한줄평을 가려보세요.</span>
	      		  </div>
	      		  <div style="display: inline-block; width: 16%; text-align: right;">
		            <button type="button" class="btn" style="color: #ffffff; background-color: #ff0558;">등록</button>
	      		  </div>
	      		</div>
		      </div>
		    </div>
		  </div>
		</div>
	
		<%-- 한줄평 댓글 보여주기 모달창 --%>
		<div class="modal fade replyOfComment" id="replyOfComment1">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-body">
		        <h5 class="modal-title mb-2 ml-4"><span>작성자</span>님의 한줄평<button type="button" class="close" data-dismiss="modal">&times;</button></h5>
       		  	  <%-- 한줄평 --%>
	       		  <div class="mx-auto my-2 p-1" style="background-color: #fdfdfd; border: solid 1px #e6e6e6; border-radius: 2%; width: 95%;">
	      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
	  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
	  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
	      		    </div>
	       		    <div class="mx-auto my-auto p-2" style="border-bottom: solid 1px #e6e6e6;">
	     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
	     		  	  <div style="display: flex; font-size: 11pt; color: gray;" class="mb-1">
	    		  	    <p class="m-2">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
	    		  	    <p class="m-2">좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #ff0558;"></i><span class="pl-2">345</span></p>
	    		  	    <p class="m-2">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #e6e6e6;"></i><span class="pl-2">27</span></p>
	  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
	     		  	  </div>
	       		    </div>
	       		    
	      		    <%-- 한줄평에 대한 댓글 --%>
	      		    <h5 class="modal-title my-2 ml-4">전체댓글&nbsp;<span style="font-size: 11pt; color: gray;">27개</span></h5>
	       		    <div class="mx-auto my-2 p-1" style="background-color: #fdfdfd; width: 100%;">
	      		      <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
	  			        <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
	  			        <div>
	  			          <p style="text-align: left; padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">서수경</p>
	     		  	      <p style="text-align: left; padding: 0 5px; margin: 0px; font-size: 10pt;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
	    		  	      <p style="text-align: left; padding: 0 5px; margin: 3px 0px 0px 0px; font-size: 10pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
	  			        </div>
	      		      </div>
	      		      <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
	  			        <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
	  			        <div>
	  			          <p style="text-align: left; padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">서수경</p>
	     		  	      <p style="text-align: left; padding: 0 5px; margin: 0px; font-size: 10pt;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
	    		  	      <p style="text-align: left; padding: 0 5px; margin: 3px 0px 0px 0px; font-size: 10pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
	  			        </div>
	      		      </div>
	      		      <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">
	  			        <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
	  			        <div>
	  			          <p style="text-align: left; padding: 0 5px; margin: 0px 0px 5px 0px; font-weight: 600;">서수경</p>
	     		  	      <p style="text-align: left; padding: 0 5px; margin: 0px; font-size: 10pt;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
	    		  	      <p style="text-align: left; padding: 0 5px; margin: 3px 0px 0px 0px; font-size: 10pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
	  			        </div>
	      		      </div>
	      		    </div>
	      		  </div>
	      		    
      		      <%-- 댓글쓰기 --%>
       		      <div class="mx-auto my-2 p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 3%; width: 95%;">
      		        <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; display: flex;">
  			          <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			          <div style="width: 100%;">
  			            <div style="display: flex;">
  			              <p style="text-align: left; padding: 0 5px; margin: 0px 10px 5px 0px; font-weight: 600;">작성자이름</p>
  			            </div>
      		  		    <textarea style="width: 100%; height: 70px; resize: none; border: solid 1px #e6e6e6; border-radius: 1%; font-size: 10pt;" placeholder="이 한줄평에 대한 댓글을 적어주세요."></textarea>
  			            <div style="display: flex;">
					      <button type="button" class="btn btn-sm btn-secondary m-1">등록</button>
					      <button type="button" class="btn btn-sm btn-light m-1" style="border: solid 1px #e6e6e6;">취소</button>
  			            </div>
  			          </div>
      		        </div>
      		      </div>
	      		    

		      </div>
		    </div>
		  </div>
		</div>  	
	
	
  </div>
  
  

</body>
</html>    