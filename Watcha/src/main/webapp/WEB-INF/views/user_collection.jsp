<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<%
    String ctxPath = request.getContextPath();
%>     
    
<!DOCTYPE html>
<html>

<head>

<style type="text/css">

	body {
		border: solid 0px gray;
		word-break: break-all; 
		padding: 0;           
	}	

	div#container{
		border: solid 0px purple;
		width: 70%;
		margin: 20px auto; 
	}

	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    
	}
			
	/*버튼 시작*/		
	.btnP{
	  background: white;
	  color: black;
	  border:none;
	  position:relative;
	  height:50px;
	  font-size: 15px;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none;
	}
	.btnP:hover{
	  background:#fff;
	  color: #ff0558;
	}
	.btnP:before,.btnP:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #ff0558;
	  transition:400ms ease all;
	}
	.btnP:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	.btnP:hover:before,.btnP:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}
	/*버튼 끝*/		
		
	.commentP {
	  width: 700px;
	  height: 35px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 15px;
	  outline: none;   
	  background-color: #e6e6e6;    
	  
	}	
	
	/* 출연,제작 시작 */ 
	@media (max-width: 768px) {
	    .carousel-inner .carousel-item > div {
	        display: none;
	    }
	    .carousel-inner .carousel-item > div:first-child {
	        display: block;
	    }
	}
	
	.carousel-inner .carousel-item.active,
	.carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	    display: flex;
	}
	
	/* display 3 */
	@media (min-width: 768px) {
	    
	    .carousel-inner .carousel-item-right.active,
	    .carousel-inner .carousel-item-next {
	      transform: translateX(33.333%);
	    }
	    
	    .carousel-inner .carousel-item-left.active, 
	    .carousel-inner .carousel-item-prev {
	      transform: translateX(-33.333%);
	    }
	}
	
	.carousel-inner .carousel-item-right,
	.carousel-inner .carousel-item-left{ 
	  transform: translateX(0);
	}
	/* 출연,제작 끝 */
	
	input[type="checkbox"] { 
	   opacity: 0;
	}
	
	.btn:active, .btn:focus {
		outline:none !important;
		box-shadow:none !important;
	}
	
	#commentBack{
	  width: 700px;
	  font-size: 15px;
	  margin: -25px 0 0 140px;      
	  border-radius: 15px; 
	  background-color: #ebebeb;  
	} 
	
	img#lastest {
		 background-position: center center; 
		 height: 280px; 
  	     width: 40%;  
  	     border-radius: 15px;
  	     margin: 0 0 0px 20px;  
	} 
	
	#chart{
	  width: 58%;   
	  height: 340px;  
	  border: solid 1px #eee;
	  border-radius: 15px;
	  float: left;
	  margin: 10px 0 10px 0;   
	}
	
	 
	
	/* 차트 1 시작 */
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	/* 차트 1 끝 */	
	
	/* 차트2 시작 */
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	input[type="number"] {
	    min-width: 50px;
	}
	/* 차트 2 끝 */
	
	
	.mycollection{
		width: 300px; 
		height: 100px;  
		margin: 50px 0 0 380px;    
	}
		
	#infoinfo {
		width: 100%; 
	}	
	
	#infoinfo > div:nth-child(2) {
		margin: 0 0 20px 480px; 
	}  
	
	#commentpi{
		padding: 7px 0 7px 80px; 
	}
	
	#commentuic{
		padding: 7px 0 7px 10px;   
	} 
	
	#commentucc{
		padding: 7px 0 7px 50px;    
		font-weight: bold; 
	}
	
	#commentuct{  
		padding: 7px 0 7px 150px;    
		font-size: 12px;    
	}
		
</style>

<script type="text/javascript">

	$(document).ready(function(){
			
		/* 좋아요 값 유지 */
		if($('#likeMaintain').val() == 1) {  
			$(".goodi").css({"color":"#ff0558"}); 	  
		}
		
		if($('#likeMaintain').val() == 0) { 
			$(".goodi").css({"background-color":"","color":""}); 
		}  
		
			/* 검색 엔터누를시  */ 
			$('input#user_collection_content').on('keyup', function(event){
				
		    	if( event.keyCode == 13 ){
		    		
					if("${requestScope.collection_viewA}")	{ 
						goAddUserWriteA()
					}
					else if("${requestScope.collection_viewB}") {
						goAddUserWriteB()
					}
		    		 
		    	}
		    	
		    });
			
			if("${requestScope.collection_viewA}")	{ 
				goUserViewCommentA(1)
			}
			else if("${requestScope.collection_viewB}") {
				goUserViewCommentB(1)
			}
				
			/* 카드 더보기 시작 */
			$("span#totalHITCount").hide(); 
			$("span#countHIT").hide();
			
			if("${requestScope.collection_viewA}")	{ 
				displayHITA("1"); 
			}
			else if("${requestScope.collection_viewB}") {
				displayHITB("1"); 
			}
			
			
			
			$("button#btnMoreHIT").click(function(){
				
				if($(this).text() == "처음으로"){
					
					$("div#displayHITA").empty();
					$("div#displayHITB").empty();
					$("span#end").empty();
					displayHITA("1");
					displayHITB("1"); 
					$(this).text("더보기");
					 
				}
				else{
					displayHITA($(this).val());
					displayHITB($(this).val()); 
				}
				
			});
			/* 카드 더보기 끝 */
				
			/* 출연, 제작 시작*/	
			$('#recipeCarousel').carousel({ 
				  interval: 10000
			});
			
			$('.carousel .carousel-item').each(function(){
				
			    var minPerSlide = 5;
			    var next = $(this).next();
			    
			    if (!next.length) {
			        next = $(this).siblings(':first');
			    }

			    next.children(':first-child').clone().appendTo($(this));
			    
			    for (var i=0;i<minPerSlide;i++) {
			    	
			        next=next.next();
			        
			        if (!next.length) {
			        	next = $(this).siblings(':first');
			      	}
			        
			        next.children(':first-child').clone().appendTo($(this));
			   }
			});
			/* 출연, 제작 끝*/	
			
			/*좋아요 시작*/		
			$("input:checkbox[name='check_good']").click(function(){
				  
				if($('input:checkbox[name="check_good"]').is(":checked")) {
					 
				 	$(".goodi").css({"color":"#ff0558"}); 
				 	
				}
				else if(!$('input:checkbox[name="check_good"]').is(":checked")) {
		
					$(".goodi").css({"background-color":"","color":""}); 
				}
				
					goLikeCollection();
				
				$("input:checkbox[name='check_good']").toggle();
				
				location.reload(true);  
				
			});
			/*좋아요 끝*/	
				
			
	/* 좋아요 총수 */	
	goLikeTotal() 
	
	/* 차트 2 */
	pieBasic()
	
	});//end of $(document).ready(function()) ----------------------------------------------------------------------------

	// Function Declaration

	/* ==== 더보기 시작  ==== */
	let lenHIT = 5;
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHITA(start){
		 
		    const Data = { "start":start,  
				    	   "len"  :lenHIT,
				    	   "user_id_collection" : '${requestScope.collection_viewA[0].user_id}' 
			}
	    	
		$.ajax({
			url:"<%= ctxPath %>/cardSeeMore.action",
		    data: Data,
		    dataType:"json",
		    success:function(json){
		    	
		    	 let html = "";
		    	 
		    	 if(start == "1" && json.length == 0){
			    	
		    		 html += "<div class='mycollection'>나만의 컨렉션을 만들어 보세요!!</div>";
		    	  
		    	 	 $("div#displayHITA").html(html);
		    		 
		    	 }
		    	 else if(json.length > 0){
		    		 // 데이터가 존재하는 경우
		    		 
		    		 $.each(json, function(index, item){  
					    			    
				        html +=    "<div class='card mb-3' style='width: 10rem; display: inline-block; margin: 20px 0 0 30px;'>" +
									  "<img src='https://image.tmdb.org/t/p/w780"+item.poster_path+"' class='card-img-top' style='width: 100%; height: 220px;'/>" +
									  "<div class='card-body'>" +
									    "<h6 class='card-title' style='font-size: 14px; font-weight: bold; text-align: center; height: 20px;'>"+item.movie_title+"</h6>"+
									    "<p class='card-text'></p>" +
									    "<a href='project_detail.action?movie_id="+item.movie_id+"' class='stretched-link'></a>" +
									  "</div>" +
									"</div>"			 
								    		 
		    		 }); // end of $.each(json, function(index, item) -------------------------------------------
		    		
		    		 // 상품결과 출력하기		 
		    		 $("div#displayHITA").append(html);	
		    		 
	    			// >>> !!! 중요 !!! 더보기 버튼의 value 속성에 값을 지정하기 <<< //
	    			$("button#btnMoreHIT").val(Number(start) + lenHIT); 
	    			
	    			// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	    			$("span#countHIT").text(Number($("span#countHIT").text()) + json.length);
	    			
	    			// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
	    			if( Number($("span#totalHITCount").text()) == Number($("span#countHIT").text()) ){
	    				$("span#end").html("더이상 조회할 제품이 없습니다.");
	    				$("button#btnMoreHIT").text("처음으로");
	    				$("span#countHIT").text("0");
	    			} 
		    		 
		    	 } // end of else if(json.length > 0){} --------------------------------------
		    	
		    },
	        error: function(request, status, error){ // 페이지없으면 404 에러
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	
		});					        
	}
	function displayHITB(start){
		
		    const Data = { "start":start,  
				    	   "len"  :lenHIT,
				    	   "user_id_collection" : '${requestScope.collection_viewB[0].user_id}' 
			}
 	    	
		$.ajax({
			url:"<%= ctxPath %>/cardSeeMore.action",
		    data: Data,
		    dataType:"json",
		    success:function(json){
		    	
		    	 let html = "";
		    	 
		    	 if(start == "1" && json.length == 0){
			    	
		    		 html += "<div class='mycollection'>나만의 컨렉션을 만들어 보세요!!</div>";
		    	 
		    	 	 $("div#displayHITB").html(html);
		    		 
		    	 }
		    	 else if(json.length > 0){
		    		 // 데이터가 존재하는 경우
		    		 
		    		 $.each(json, function(index, item){  
					    			    
				        html +=    "<div class='card mb-3' style='width: 10rem; display: inline-block; margin: 20px 0 0 30px;'>" +
									  "<img src='https://image.tmdb.org/t/p/w780"+item.poster_path+"' class='card-img-top' style='width: 100%; height: 220px;'/>" +
									  "<div class='card-body'>" +
									    "<h6 class='card-title' style='font-size: 14px; font-weight: bold; text-align: center; height: 20px;'>"+item.movie_title+"</h6>"+
									    "<p class='card-text'></p>" +
									    "<a href='project_detail.action?movie_id="+item.movie_id+"' class='stretched-link'></a>" +
									  "</div>" +
									"</div>"			 
								    		 
		    		 }); // end of $.each(json, function(index, item) -------------------------------------------
		    		
		    		 // 상품결과 출력하기		 
		    		 $("div#displayHITB").append(html);	
		    		 
	    			// >>> !!! 중요 !!! 더보기 버튼의 value 속성에 값을 지정하기 <<< //
	    			$("button#btnMoreHIT").val(Number(start) + lenHIT); 
	    			
	    			// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	    			$("span#countHIT").text(Number($("span#countHIT").text()) + json.length);
	    			
	    			// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
	    			if( Number($("span#totalHITCount").text()) == Number($("span#countHIT").text()) ){
	    				$("span#end").html("더이상 조회할 제품이 없습니다.");
	    				$("button#btnMoreHIT").text("처음으로");
	    				$("span#countHIT").text("0");
	    			} 
		    		 
		    	 } // end of else if(json.length > 0){} --------------------------------------
		    	
		    },
	        error: function(request, status, error){ // 페이지없으면 404 에러
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	
		});					        
	}
	/* ==== 더보기 끝 ==== */

	/* ==== 댓글쓰기 시작 ==== */
	function goAddUserWriteA() {
	  
	  const user_collection_content = $("input#user_collection_content").val().trim(); 
	  
	  if(user_collection_content == "") {
		  alert("댓글 내용을 입력하세요!!");
		  return;  // 종료 
	  }
	  
	  goAddUserWrite_noAttachA();
	  
    }
	function goAddUserWriteB() {
		  
		  const user_collection_content = $("input#user_collection_content").val().trim(); 
		  
		  if(user_collection_content == "") {
			  alert("댓글 내용을 입력하세요!!");
			  return;  // 종료 
		  }
		  
		  goAddUserWrite_noAttachB(); 
		  
	    }
	
	/* ==== 댓글쓰기 끝 ==== */
	 
    /* ==== 댓글쓰기 시작 ==== */ 
    function goAddUserWrite_noAttachA() {
		 
	  const commentData = { user_id_collection : '${requestScope.collection_viewA[0].user_id}',
					        user_id_comment : '${sessionScope.loginuser.user_id}',
		    				user_collection_content : $("input#user_collection_content").val() }
		
      $.ajax({
  		 url:"<%= request.getContextPath()%>/addUserComment.action",
  		 data: commentData,
  		 type:"post",
  		 dataType:"json",
  		 success:function(json){
  		
  			 if(json.n == '1') {
  				goUserViewCommentA(1); // 페이징 처리 한 댓글 읽어오기	 
  			 } else {
  				 alert("댓글 입력 실패");
  			 } 
  			 
  			 $("input#user_collection_content").val("");
  			 
  		 },
  		 error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }
      });
    }
	
    function goAddUserWrite_noAttachB() { 
		 
  	  const commentData = { user_id_collection : '${requestScope.collection_viewB[0].user_id}',
  					        user_id_comment : '${sessionScope.loginuser.user_id}',
  		    				user_collection_content : $("input#user_collection_content").val() }
  		
        $.ajax({
    		 url:"<%= request.getContextPath()%>/addUserComment.action",
    		 data: commentData,
    		 type:"post",
    		 dataType:"json",
    		 success:function(json){
    		
    			 if(json.n == '1') {
    				goUserViewCommentB(1); // 페이징 처리 한 댓글 읽어오기	 
    			 } else {
    				 alert("댓글 입력 실패");
    			 } 
    			 
    			 $("input#user_collection_content").val("");
    			 
    		 },
    		 error: function(request, status, error){
  			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	     }
        });
      }
    /* ==== 파일첨부가 없는 댓글쓰기 끝 ==== */
  
    // === Ajax로 불러온 댓글내용을  페이징 처리 하기 시작  === //
    function goUserViewCommentA(currentShowPageNo) {
	  $.ajax({
		  url:"<%= request.getContextPath()%>/user_collection_commentList.action",
		  data:{"user_id_collection":'${requestScope.collection_viewA[0].user_id}',
			    "currentShowPageNo":currentShowPageNo}, 
		  dataType:"json",
		  success:function(json){
			  // console.log("~~ 확인용 : " + JSON.stringify(json));
			  
			  let html = "";
			  if(json.length > 0) {
				 $.each(json, function(index, item){
					    
					 html += "<tr>";    
					 html += '<td id="commentpi">'+item.profile_image+"</td>";
					 html += '<td id="commentuic">'+item.user_id_comment+"</td>"; 
					 html += '<td id="commentucc">'+item.user_collection_content+"</td>";
		             html += '<td id="commentuct">'+item.user_collection_time+"</td>";  
		             html += "</tr>"; 
 				 });  
			  }   
			  else {
				    html += "<tr>" +
				                "<td colspan='6' class='comment'>댓글이 없습니다</td>" +
				            "</tr>"; 
			  }
			  
			  $("tbody#commentDisplay").html(html);
			  
			  // === 페이지바 함수 호출 === //
			  makeUserCommentPageBarA(currentShowPageNo);
			  	
			// == 차트 시작 == //
			let htmlchart = ""; 
			
			 $.each(json, function(index, item){
					 
				 	htmlchart += item.user_collection_content + " ";
				 	
 				 });  
			
			const text = htmlchart,
		    lines = text.replace(/[():'?0-9]+/g, '').split(/[,\. ]+/g),
		    data = lines.reduce((arr, word) => {
		        let obj = Highcharts.find(arr, obj => obj.name === word);
		        if (obj) {
		            obj.weight += 1;
		        } else { 
		            obj = {
		                name: word,
		                weight: 1
		            };
		            arr.push(obj);
		        }
		        return arr;
		    }, []); 

			Highcharts.chart('chart_container', {
			    accessibility: {
			        screenReaderSection: {
			            beforeChartFormat:  '<h5>{chartTitle}</h5>' +
							                '<div>{chartSubtitle}</div>' +
							                '<div>{chartLongdesc}</div>' +
							                '<div>{viewTableButton}</div>'
			        }
			    },
			    series: [{
			        type: 'wordcloud',
			        data,
			        name: 'Occurrences'
			    }],
			    title: {
			        text: '댓글 중 가장 많은 단어' 
			    },
			    tooltip: {
			        headerFormat: '<span style="font-size: 16px"><b>{point.key}</b></span><br>'
			    }
		});				
			// == 차트 끝 == //  
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
    }
    
    function goUserViewCommentB(currentShowPageNo) {
  	  $.ajax({
  		  url:"<%= request.getContextPath()%>/user_collection_commentList.action",
  		  data:{"user_id_collection":'${requestScope.collection_viewB[0].user_id}',
  			    "currentShowPageNo":currentShowPageNo}, 
  		  dataType:"json",
  		  success:function(json){
  			  // console.log("~~ 확인용 : " + JSON.stringify(json));
  			  
  			  let html = "";
  			  if(json.length > 0) {
  				 $.each(json, function(index, item){
  					    
  					 html += "<tr>";    
  					 html += '<td id="commentpi">'+item.profile_image+"</td>";
  					 html += '<td id="commentuic">'+item.user_id_comment+"</td>"; 
  					 html += '<td id="commentucc">'+item.user_collection_content+"</td>";
  		             html += '<td id="commentuct">'+item.user_collection_time+"</td>";  
  		             html += "</tr>"; 
   				 });  
  			  }   
  			  else {
  				    html += "<tr>" +
  				                "<td colspan='6' class='comment'>댓글이 없습니다</td>" +
  				            "</tr>"; 
  			  }
  			  
  			  $("tbody#commentDisplay").html(html);
  			  
  			  // === 페이지바 함수 호출 === //
  			  makeUserCommentPageBarB(currentShowPageNo);
  			  	
  			  
  		  },
  		  error: function(request, status, error){
  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  		  }
  	  });
  	  
      }
    //=== Ajax로 불러온 댓글내용을  페이징 처리 하기 끝  === // 
  
    // ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
    function makeUserCommentPageBarA(currentShowPageNo) {
	  
	  <%-- === 원글에 대한 totalPage 수를 알아오려고 한다. 시작 === --%>
	  $.ajax({
		  url:"<%= request.getContextPath()%>/getUserCommentTotalPage.action",
		  data:{"user_id_collection":'${requestScope.collection_viewA[0].user_id}',
			    "sizePerPage":"5"}, 
		  type:"get",  
		  dataType:"json",
		  success:function(json){

			  // console.log("~~ 확인용 : " + JSON.stringify(json));
			  
			  if(json.totalPage > 0) {
				  // 댓글이 있는 경우 
				  
				  const totalPage = json.totalPage; 
				  
				  const blockSize = 4;
				  
				  let loop = 1;
				  /*
				      loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				  */
				  
				  if(typeof currentShowPageNo == "string") {
					  currentShowPageNo = Number(currentShowPageNo);
				  }
				  
				// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
				let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
				
				let pageBarHTML = "<ul style='list-style: none;'>";
				
				// === [맨처음][이전] 만들기 === //
				if(pageNo != 1) {
					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewCommentA(\"1\")'>[맨처음]</a></li>";
					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewCommentA(\""+(pageNo-1)+"\")'>[이전]</a></li>";
				}
				
				while( !(loop > blockSize || pageNo > totalPage) ) {
					
					if(pageNo == currentShowPageNo) {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
					}
					else {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goUserViewCommentA(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
					}
					
					loop++;
					pageNo++;
					
				}// end of while-----------------------
				
				
				// === [다음][마지막] 만들기 === //
				if( pageNo <= totalPage ) {
					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewCommentA(\""+pageNo+"\")'>[다음]</a></li>";
					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewCommentA(\""+totalPage+"\")'>[마지막]</a></li>"; 
				}
				 
				pageBarHTML += "</ul>";
				 
				$("div#pageBar").html(pageBarHTML);
				  
			  }// end of if(json.totalPage > 0)------------------
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }
    
    function makeUserCommentPageBarB(currentShowPageNo) {
  	  
  	  <%-- === 원글에 대한 totalPage 수를 알아오려고 한다. 시작 === --%>
  	  $.ajax({
  		  url:"<%= request.getContextPath()%>/getUserCommentTotalPage.action",
  		  data:{"user_id_collection":'${requestScope.collection_viewB[0].user_id}',
  			    "sizePerPage":"5"}, 
  		  type:"get",  
  		  dataType:"json",
  		  success:function(json){

  			  // console.log("~~ 확인용 : " + JSON.stringify(json));
  			  
  			  if(json.totalPage > 0) {
  				  // 댓글이 있는 경우 
  				  
  				  const totalPage = json.totalPage; 
  				  
  				  const blockSize = 4;
  				  
  				  let loop = 1;
  				  /*
  				      loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
  				  */
  				  
  				  if(typeof currentShowPageNo == "string") {
  					  currentShowPageNo = Number(currentShowPageNo);
  				  }
  				  
  				// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
  				let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
  				
  				let pageBarHTML = "<ul style='list-style: none;'>";
  				
  				// === [맨처음][이전] 만들기 === //
  				if(pageNo != 1) {
  					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewCommentB(\"1\")'>[맨처음]</a></li>";
  					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewCommentB(\""+(pageNo-1)+"\")'>[이전]</a></li>";
  				}
  				
  				while( !(loop > blockSize || pageNo > totalPage) ) {
  					
  					if(pageNo == currentShowPageNo) {
  						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
  					}
  					else {
  						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goUserViewCommentB(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
  					}
  					
  					loop++;
  					pageNo++;
  					
  				}// end of while-----------------------
  				
  				 
  				// === [다음][마지막] 만들기 === //
  				if( pageNo <= totalPage ) {
  					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewCommentB(\""+pageNo+"\")'>[다음]</a></li>";
  					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewCommentB(\""+totalPage+"\")'>[마지막]</a></li>"; 
  				}
  				 
  				pageBarHTML += "</ul>";
  				 
  				$("div#pageBar").html(pageBarHTML);
  				  
  			  }// end of if(json.totalPage > 0)------------------
  			  
  		  },
  		  error: function(request, status, error){
  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  		  }
  	  });
    }  
  <%-- === 원글에 대한 totalPage 수를 알아오려고 한다. 끝 === --%>
    
  // === 좋아요 시작  === //
  function goLikeCollection() { 
	  
	 const commentData = { user_id_collection : '${requestScope.collection_viewA[0].user_id}',
	   		   			   user_id_like : '${sessionScope.loginuser.user_id}'
     }
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/likeCollection.action",
		  data: commentData , 
		  type:"post", 	      
		  dataType:"json",
		  success:function(json){
			  // console.log("~~ 확인용 : " + JSON.stringify(json));
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }
  //=== 좋아요 끝  === //
  
  
  //== 좋아요 총수 시작 ==//
  function goLikeTotal() { 
	  
	 const commentData = { user_id_collection : '${requestScope.collection_viewA[0].user_id}',
	   		   			   user_id_like : '${sessionScope.loginuser.user_id}'
     }
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/likeTotal.action",
		  data: commentData , 
		  type:"post", 	      
		  dataType:"json",
		  success:function(json){
			   // console.log("~~ 확인용 : " + JSON.stringify(json));
			   
			   let html = "<span>"+json.likeTotal+"</span>";   
				           
				  $("#likeTotal").html(html); 
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }  
  //== 좋아요 총수 끝 ==//  
  
  //== 차트 2 시작 ==//
  function pieBasic() { 
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/pieBasic.action",
		  data: {user_id : '${requestScope.collection_viewB[0].user_id}'} , 
		  type:"post", 	      
		  dataType:"json",
		  success:function(json){
			   // console.log("~~ 확인용 : " + JSON.stringify(json));
			   
				Highcharts.chart('chart_container2', {
				       chart: {
					        plotBackgroundColor: null,
					        plotBorderWidth: null,
					        plotShadow: false,
					        type: 'pie'
					    },
					    title: {
					        text: '내가 담은 컬렉션 영화 장르 퍼센티지(%)'
					    },
					    tooltip: {
					        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
					    },
					    accessibility: {
					        point: {
					            valueSuffix: '%'
					        }
					    },
					    plotOptions: {
					        pie: {
					            allowPointSelect: true,
					            cursor: 'pointer',
					            dataLabels: {
					                enabled: true,
					                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
					            }
					        }
					    },
					    series: [{
					        name: 'Brands',
					        colorByPoint: true,
					        data: [{
					            name: 'Chrome',
					            y: 70.67,
					            sliced: true,
					            selected: true
					        }, {
					            name: 'Edge',
					            y: 14.77
					        },  {
					            name: 'Firefox',
					            y: 4.86
					        }, {
					            name: 'Safari',
					            y: 2.63
					        }, {
					            name: 'Internet Explorer',
					            y: 1.53
					        },  {
					            name: 'Opera',
					            y: 1.40
					        }, {
					            name: 'Sogou Explorer',
					            y: 0.84
					        }, {
					            name: 'QQ',
					            y: 0.51
					        }, {
					            name: 'Other',
					            y: 2.6
					        }]
					    }]
					}); 
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }  
  //== 차트 2 끝 ==//   
</script>

<script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/wordcloud.js"></script>
<script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath %>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>


<meta charset="UTF-8">
<title></title>
</head>


<c:if test="${not empty requestScope.collection_viewA}"> 
	<body>
		<div id="container">
		 
			<div class="card">
			    <div class="card-body"> 
				   
			   <div id="infoinfo">               
			      	  
			      	<div style="font-size: 30px; margin: 0 0 5px 370px; font-weight: bold;"><span style="color:#ff0558">"</span>${requestScope.collection_viewA[0].name}<span style="color:#ff0558">"</span>님의 <span style="color:#ff0558">컬렉션</span></div>   
		             
					  <div style="margin: 0 0 0 460px; font-weight: bold;">좋아요 총수: <span id="likeTotal" style="color:#ff0558"></span></div>
						 
					  <label for="check_good" style="cursor: pointer; margin: 0 0 15px 470px;">   
					    <i class="far fa-thumbs-up goodi"></i><span class="goodi" style="font-weight: bolder">&nbsp;&nbsp;좋아요 </span> 
					  </label>
 
					  <input type="checkbox" id="check_good" name="check_good"/>
					
					  <input type="hidden" name="likeMaintain" id="likeMaintain" value="${requestScope.likeMaintain}" /> 
			    	  	  
			   </div> 
			     
					<div id="chart">   
						<figure class="highcharts-figure">
						    <div id="chart_container" style="height: 300px;"></div>
						    <p class="highcharts-description"></p> 
						</figure>
					</div> 
		        	     
		        	<div style="font-size: 20px; font-weight: bolder; margin: 0 0 10px 665px;"><span style="color:#ff0558">"</span>${requestScope.collection_viewA[0].name}<span style="color:#ff0558">"</span>님이 가장 최근에 담은 <span style="color:#ff0558">영화</span></div>
	
		         	<c:if test="${requestScope.collection_viewA[0].movie_title != null}">
			        	<a href='project_detail.action?movie_id=${requestScope.collection_viewA[0].movie_id}'>
			        		<img id="lastest" src="https://image.tmdb.org/t/p/w1280${requestScope.collection_viewA[0].backdrop_path}" />
			        	</a>   		
		        	</c:if>
		         	
		         	<c:if test="${requestScope.collection_viewA[0].movie_title == null}">
			        	<a>   
			        		<img id="lastest" src="<%= ctxPath%>/resources/images/왓챠피디아NULL.png" /> 
			        	</a> 
		        	</c:if> 
		        	  
		        	<c:if test="${requestScope.collection_viewA[0].movie_title == null}"> 
		        		<div style="font-size: 15px; margin: 15px 0 30px 730px; ">컬렉션을 담아 보세요!!</div> 
		         	</c:if>   	        	  
		        	<c:if test="${requestScope.collection_viewA[0].movie_title != null}">    
		        		<div style="font-size: 22px; font-weight: bold; text-align: center; margin-bottom: 25px;">${requestScope.collection_viewA[0].movie_title}</div>
		         	</c:if>     
 			          
			      	<hr style="margin: 0 30px 0 30px;">  	     
			      	
			    	<div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px;">나의 컬렉션</div>	
	 
					  <div class="row" id="displayHITA" style="margin-left: 20px;"></div>
					  
	   					  <c:if test="${requestScope.totalCount.COUNT > 5}">   
						      <div>  
						         <p class="text-center">
						            <span id="end" style="display:block; margin:20px 0px 0 0; font-weight:bold; font-size: 12pt;"></span> 
						            <button type="button" class="btn" id="btnMoreHIT" style="font-weight:bold; color:#ff0558;">더보기</button>
						            <span id="totalHITCount">${requestScope.totalCount.COUNT}</span>
						            <span id="countHIT">0</span>
						         </p> 
						      </div>
				      	  </c:if>
				      	  
				    <hr style="margin: 0 30px 0 30px;">  
				    		
				    <div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px; display: inline-block;">댓글</div>			
				    		
				         <input type="hidden" name="user_id" id="user_id" value="${requestScope.collection_viewA[0].user_id}" />
				         <input type="hidden" name="collection_id" id="collection_id" value="${requestScope.collection_viewA[0].collection_id}" /> 
			    	 
			    	<%-- === 댓글 내용 보여주기 === --%>
			    	<div id="commentBack">
				    	<table style="">
							<tbody id="commentDisplay"></tbody>
						</table>
			    	</div>
			    	
		    	   	<div style="display: flex;">  
			    	   <div id="pageBar" style="margin: 10px 0 0 400px; text-align: center;"></div>
			    	</div>	
			    	
			    	<input style="margin-left: 140px;" class="commentP" type="text" name="user_collection_content" id="user_collection_content">
			    	<button style="margin-left: 20px;" class="btnP" onclick="goAddUserWriteA()"><i class="far fa-comment"></i>제출</button>
			    		
			    </div>
			</div>
		</div> 
	</body>
</c:if> 

<c:if test="${not empty requestScope.collection_viewB}"> 
	<body> 
		<div id="container">
		 
			<div class="card">
			    <div class="card-body">    
				     
			   <div id="infoinfo">                  
			      	       
			        <div style="font-size: 30px;  margin: 0 0 5px 430px; font-weight: bold;">나만의 <span style="color:#ff0558">컬렉션 </span></div>   
		            
		            <div style="margin: 0 0 15px 435px; font-weight: bold;">내가 받은 좋아요 총수: <span id="likeTotal" style="color:#ff0558"></span></div>
		            
			   </div>    
				
				<div id="chart">   
					<figure class="highcharts-figure">
					    <div id="chart_container2" style="height: 300px;"></div>
					    <p class="highcharts-description"></p> 
					</figure>
				</div> 
				         
		        <div id="">     
		        	     
		        	<div style="font-size: 20px; font-weight: bolder; margin: 0 0 10px 665px;">가장 최근에 컬렉션에 담은 <span style="color:#ff0558">영화</span></div>
	
		         	<c:if test="${requestScope.collection_viewB[0].movie_title != null}">
			        	<a href='project_detail.action?movie_id=${requestScope.collection_viewB[0].movie_id}'>
			        		<img id="lastest" src="https://image.tmdb.org/t/p/w1280${requestScope.collection_viewB[0].backdrop_path}" />
			        	</a>   		
		        	</c:if>
		         	
		         	<c:if test="${requestScope.collection_viewB[0].movie_title == null}">
			        	<a>   
			        		<img id="lastest" src="<%= ctxPath%>/resources/images/왓챠피디아NULL.png" /> 
			        	</a> 
		        	</c:if> 
		        	  
		        	<c:if test="${requestScope.collection_viewB[0].movie_title == null}"> 
		        		<div style="font-size: 15px; margin: 15px 0 30px 730px; ">컬렉션을 담아 보세요!!</div> 
		         	</c:if>   	        	   
		        	<c:if test="${requestScope.collection_viewB[0].movie_title != null}">      
		        		<div style="font-size: 22px; font-weight: bold; text-align: center; margin-bottom: 25px;">${requestScope.collection_viewB[0].movie_title}</div>
		         	</c:if>      
		        </div> 	     
			          
			      	<hr style="margin: 0 30px 0 30px;">  	     
			      	
			    	<div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px;">나의 컬렉션</div>	
	 
					  <div class="row" id="displayHITB" style="margin-left: 20px;"></div>  
					   
	   					  <c:if test="${requestScope.totalCount.COUNT > 5}">   
						      <div>  
						         <p class="text-center">
						            <span id="end" style="display:block; margin:20px 0px 0 0; font-weight:bold; font-size: 12pt;"></span> 
						            <button type="button" class="btn" id="btnMoreHIT" style="font-weight:bold; color:#ff0558;">더보기</button>
						            <span id="totalHITCount">${requestScope.totalCount.COUNT}</span>
						            <span id="countHIT">0</span>
						         </p> 
						      </div>
				      	  </c:if>
				      	  
				    <hr style="margin: 0 30px 0 30px;">  
				    		
				    <div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px; display: inline-block;">댓글</div>			
				    		
				         <input type="hidden" name="user_id" id="user_id" value="${requestScope.collection_viewB[0].user_id}" />
				         <input type="hidden" name="collection_id" id="collection_id" value="${requestScope.collection_viewB[0].collection_id}" /> 
			    	 
			    	<%-- === 댓글 내용 보여주기 === --%>
			    	<div id="commentBack">
				    	<table>
							<tbody id="commentDisplay"></tbody>
						</table>
			    	</div>
			    	
		    	   	<div style="display: flex;">  
			    	   <div id="pageBar" style="margin: 10px 0 0 400px; text-align: center;"></div>
			    	</div>	
			    	
			    	<input style="margin-left: 140px;" class="commentP" type="text" name="user_collection_content" id="user_collection_content">
			    	<button style="margin-left: 20px;" class="btnP" onclick="goAddUserWriteB()"><i class="far fa-comment"></i>제출</button>
			    		
			    </div>
			</div>
		</div> 
	</body>
</c:if>

</html>