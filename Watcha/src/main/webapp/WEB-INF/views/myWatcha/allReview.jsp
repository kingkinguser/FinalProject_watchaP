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
div#div_container {width: 100%; display: flex; z-index: 4; position: relative; top: 0rem; background-color: #ffffff; cursor: default;
				 /*font-family: 'IBM Plex Sans KR', sans-serif;*/
				  font-family: 'Noto Sans KR', sans-serif;}
div#div_content {width: 80%; margin: 0px 30px auto; padding-bottom: 30px;}
img#img_wallPaper {position: relative; z-index:1; object-fit:cover; width: 100%; opacity: 0.8;}
img#img_movie {z-index:5; border: solid 1px #f8f8f8; border-radius: 2%; box-shadow: 1px 1px 1px #cccccc; width: 100%;}
span#collectionCount {padding-left: 10px; font-weight: 400; color: #666666; font-size: 14px;}
img#img_profile {width: 40px; height: 40px; box-sizing: inherit; border:solid 1px #e6e6e6; border-radius: 50%; box-shadow: 1px 1px 1px #cccccc; margin: 0 6px;}
p.movieRate{height: 30px; border: solid 1px #e6e6e6; border-radius: 20%/40%; padding: 0 10px; margin: 5px 15px; background-color: #ffffff;}
input#like_comment{display:none;}

select#collection{border: none; font-size: 11pt;}
select#collection:focus{outline: none;}

<%-- 한줄평 상세모달 --%>
div.replyOfComment{font-family: 'Noto Sans KR', sans-serif; cursor: default;}
.modal-body textarea:focus {outline: none;}
</style>

<script>

	$(document).ready(function(){

		// "좋아요" 클릭 시
 		$("input#like_comment").click(function(){
 			if($(this).prop("checked")){ // 좋아요 체크
				$(this).next().find('i').css('color','#ff0558');			
 			}
 			else { // 좋아요 체크해제
				$(this).next().find('i').css('color','#cccccc');
 			}
 		});
 		
 		
	}); // end of $(document).ready(function(){})

</script>
</head>
<body>
  <div class="container-fluid" style="padding: 0px;">
    <div style="position: relative; top: 0rem; width: 100%; height: 25px; z-index: 6; background-color: #ffffff;"></div>
    <div style="background-color: #333333; overflow: hidden; height: 350px;" class="row mx-auto">
      <div style="width: 15%; box-shadow: 50px 0px 20px #333333; z-index: 3;"></div>
      <div style="width: 70%;">
	    <img id="img_wallPaper" src="<%= ctxPath%>/resources/images/배경이미지.jpg" />
      </div>
      <div style="width: 15%; box-shadow:-50px 0px 20px #333333; z-index: 2;"></div>
    </div>
	<div id="div_container" class="container-fluid">
	  <div id="div_content" class="mx-auto">
  		<div style="height: 150px; padding: 0 50px;">
		  <div style="display: flex; margin: 0px; padding: 0px; text-align: center; font-weight: 500; height: 150px;" class="row">
 			<div class="col-md-9" style="position: relative; top: 1rem; height: 150px;">
  			  <h2 style="text-align: left; padding: 10px; font-weight: 900; margin: 15px;">영화제목</h2>
 	          <h4 style="text-align: left; padding: 5px; font-weight: 600; margin: 30px 10px;">이 영화에 대한 한줄평</h4>
 			</div>
            <div class="col-md-3" style="position: relative; z-index:5; top: -8rem;">
              <img id="img_movie" class="img-thumnail" src="<%= ctxPath%>/resources/images/포스터.jpg">
            </div>
	      </div>
  		</div>
	  	
	  	<div id="div_nav_content" class="container py-3" style="position: relative; top: 1rem; margin-bottom: 30px;"> 
		  <div class="row mx-auto my-1" style="padding: 0 50px;">
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2">
    		  	      <button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;
    		  	        <i class="fa-solid fa-comments" style="color: #cccccc;"></i>
    		  	        <span class="pl-2">27</span>
    		  	      </button>
    		  	    </p>
   		  	      </div>
       		    </div>
      		  </div>
       	    </div>
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2"><button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i><span class="pl-2">27</span></button></p>
   		  	      </div>
       		    </div>
      		  </div>
       	    </div>
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2"><button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i><span class="pl-2">27</span></button></p>
   		  	      </div>
       		    </div>
      		  </div>
       	    </div>
       	  </div>
		  <div class="row mx-auto my-1" style="padding: 0 50px;">
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2"><button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i><span class="pl-2">27</span></button></p>
   		  	      </div>
       		    </div>
      		  </div>
       	    </div>
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2"><button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i><span class="pl-2">27</span></button></p>
   		  	      </div>
       		    </div>
      		  </div>
       	    </div>
       	    <div class="col-md-4 p-1">
       		  <div class="mx-auto my-auto p-1" style="background-color: #f8f8f8; border: solid 1px #e6e6e6; border-radius: 2%;">
      		    <div class="flex-container mx-auto my-auto p-2 text-center" style="padding-left: 10px; border-bottom: solid 1px #e6e6e6; display: flex;">
  			      <img id="img_profile" src="<%= ctxPath%>/resources/images/프로필없음.jpg"/>
  			      <h5 style="text-align: left; padding: 0 5px; font-weight: 600; margin: 8px 10px;">서수경</h5>
      		    </div>
       		    <div class="mx-auto my-auto p-2">
     		  	  <p style="padding: 10px; margin: 0px;">픽사의 뛰어난 작품들에서나 발견할 수 있을 것 같은 애절한 순정을 마블에서 만나게 되다니.</p>
     		  	  <div style="display: flex;">
    		  	    <p style="padding-left: 10px; margin: 10px 0px; font-size: 11pt; color: gray;">작성일자&nbsp;<span class="pl-2">2023.05.13</span></p>
  			        <p class="movieRate">★&nbsp;<span>3.5</span></p>
     		  	  </div>
    		  	  <div class="pl-2" style="border-top: solid 1px #e6e6e6; display:flex; padding: 5px; font-size: 11pt; color: gray;">
    		  	    <label for="like_comment" class="m-2" style="cursor: pointer;">
    		  	      <input type="checkbox" id="like_comment" />
    		  	      <span>좋아요&nbsp;<i class="fa-solid fa-heart" style="color: #cccccc;"></i></span>
    		  	      <span class="pl-1" style="cursor: default;">345</span>
    		  	    </label>
    		  	    <p class="m-2"><button type="button" data-target="#replyOfComment1" data-toggle="modal" style="color: gray; border: none; background-color: #f8f8f8;">댓글&nbsp;<i class="fa-solid fa-comments" style="color: #cccccc;"></i><span class="pl-2">27</span></button></p>
   		  	      </div>
       		    </div>
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