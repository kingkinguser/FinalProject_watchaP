<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>     

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
	
	/* header 부분 동일 */
	.searchWord_div_nav {
		margin-bottom: 10px; 
		position: relative;
		bottom: 20px;
		border-bottom: solid 1px #cccccc;
	}
	.searchWord_nav {
		padding-bottom: 0;
		background-color: white;
	}
	
	nav.navbar > ul.navbar-nav > li.nav-item > button.nav-link {
		border: none;
		background-color: white;
		margin-right: 10px;
	}
	
	
	
	.searchWord_header {
		border-bottom: solid 1px  #f2f2f2;
		background-color: #f8f9fa!important;
		padding: 12px 0 ;
		position: relative;
		bottom: 20px;
	}
	
	.SMDLi {
		list-style:none;
		margin: 0;
		border-bottom: solid 1px #d9d9d9;
		
	}
	
	.SMD {
		margin-top: 10px;
		height: 90px;
  		padding: 0;
  		display: flex; 		
	}
	
	.SMD > img {	
  		height: 80px;
  		width: 80px;
  		margin: 0 10px 0 0;
  		border-radius: 50%;
  
	}
	
	.clearfloat:after {
		content: "";
		display: table;
		clear: both;
	}
	
	.MvTitle {
		margin-top: 32px;
		color: black;
	}
	
	.TitleM {
		font-weight: bold;
	}
	
	.colorChange {
		color: #8c8c8c;
	}
	
	
	@media (min-width: 760px) {
		.SMDLi {
			width: 50%;
			float: left;
			box-sizing: border-box;
			padding: 8px 5px;
		}
	}

	@media (max-width: 760px) {
		.SMDLi {
			width: 100%;
			padding: 8px 5px;
		}
	}
	
	
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	
	#poster_part{
	    position: relative;
	    background-color : black;   
	    border-radius: 8px;
	    overflow: hidden;
	}
	
	

</style>


<script type="text/javascript">

	$(document).ready(function() {
				
		$("#Collection").css({'border-bottom': 'solid 1px black'});
		
		$("span#totalCollectionCount").hide();
		$("span#countCollection").hide();
		
		displayCollection(1);
		
		$("button#btnMoreCollection").click(function() {
			
			if($(this).text() == "처음으로") { // $(this) 는 여기서 button 을 말함 
				
				$("ul#displayCollection").empty();  // 비운다.
				$("span#end").empty();    // 비운다 				
				displayCollection(1);            // 처음부터 다시 가기 위해 비운 후 함수 다시 실행 
				$(this).text("더보기");
				
			}
			else {
				displayCollection($(this).val());  // 함수 호출 this로 가져와 val() 내용을 가져온다. 

			}
		
		});
		
		/*영화 눌렀을때 */
		$("button#contants").click(function(){
			SearchContants();
		});
		
		/* 인물 눌렀을때  */
		$("button#People").click(function(){
			SearchPeople();
		});
		
		/* 컬렉션 눌렀을때 */
		$("button#collection").click(function(){
			SearchCollection();
		});
		
		/* 유저 눌렀을때 */
		$("button#User").click(function(){
			SearchUser();
		});
	
	});
		
	let lastSearchWord = "${lastSearchWord}";
	
	let lenShow = 10;	// 영화 10개씩 보기 위해 
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayCollection(start) {     
		
		$.ajax({
			url:"<%= ctxPath%>/goSearchCollection.action",
			type:"post",
			data:{"start":start		
				 ,"lenShow":lenShow
				 ,"lastSearchWord": lastSearchWord},
			dataType:"json",
			async:true,			
			success:function(json) {

				
				var responseData = JSON.parse(json.jsonResponse);
				var count = responseData.Collection_list.length;				
				
				var total_count = responseData.totalCollectionCount; 
				$("span#totalCollectionCount").text(total_count);
				$("span#total_mv_count").text(total_count);
				
				
				let html = '';
								
				if(start == "1" && count == 0) {  // 배열이기 때문에 json == null 로 하면 절대로 안된다. 
					// 처음부터 데이터가 존재하지 않는 경우 				
					html += "<div style='text-align: center; padding: 100px 0;' class='h4'>" + 
					           "<p style='margin-bottom: 40px;'><i class='fa-solid fa-question fa-2xl' style='color: #9a9da2;'></i></p>" + 
					           "<p>컬렉션 정보가 없습니다.</p>" + 					            
					        "<div>";
				

					$("ul#displayCollection").html(html);
					$("button#btnMoreCollection").hide();
					$("h4#title_Collection").hide();
				} 
				
				else if (count > 0) {
					// 데이터가 존재하는 경우 
					responseData.Collection_list.forEach(function(item, index, array) {
					    var user_id = item.user_id;

						
						html += '<li class="SMDLi">' +
						'<a href="#" title="" class="Main-a" onclick="event.preventDefault(); document.getElementById(\'form' + index + '\').submit()">' +
							           			 '<div id="poster_part">' +
				                         			 '<div style="display: flex;">'; 
				                          	
				             /* 포스터 부분 반복  */  
                  			responseData.poster[index].slice(0, 3).forEach(function(posterUrl) {
                  			    var resultCount = responseData.poster[index].length;
                  			    var widthStyle = '';

                  			    if (resultCount === 3) {
                  			        widthStyle = 'width: 33.33%;';
                  			    } else if (resultCount === 2) {
                  			        widthStyle = 'width: 50%;';
                  			    } else if (resultCount === 1) {
                  			        widthStyle = 'width: 100%; padding: 0px 116px';
                  			    }

                  			    html += '<div class="poster-item" style="display: flex; ' + widthStyle + '">' +
                  			                '<div style="height: 300px; width:100%;">' +
                  			                    '<img src="https://image.tmdb.org/t/p/w500' + posterUrl + '" alt="포스터 이미지" style="height: 100%; width: 100%;"/>' +
                  			                '</div>' +
                  			            '</div>';
                  			});

						html +=  		'</div>' + 
	                       	 		  '</div>' + 
							
							 '<div class="SMD">' +
						            '<img src="' + (item.profile_image ? "<%= ctxPath %>/resources/images/" + item.profile_image : "<%= ctxPath %>/resources/images/프로필없음.jpg") + '" class="card-img-top" alt="..." style="border: solid 1px black;"/>' +
						            '<div class="MvTitle">' +
						              '<p class="TitleM"><span> " </span>' + item.name + '<span> " 님의 컬렉션</span></p>' +
						            '</div>' +
						          '</div>' +
						        '</a>' +
						      '</li>' +
						      '<form id="form' + index + '" action="<%= ctxPath %>/view/user_collection.action" method="post">' +
						        '<input type="hidden" name="user_id" value="' + user_id + '">' +
						    '</form>';
						});
						
							
					$("ul#displayCollection").append(html);		 // append 를 쓰면 기존거 + 새로운거 html 을 쓰면 기존꺼는 없애고 새로운것만 나타남
					
	
					$("button#btnMoreCollection").val( Number(start) + lenShow );					
					
					$("span#countCollection").text( Number($("span#countCollection").text()) + count );    /// val() 대신 text 를 사용해야 한다.				
					

					if( Number($("span#totalCollectionCount").text()) <= Number($("span#countCollection").text()) )  {  // number 는 빼도 그만 안빼도 그만 
						if(!(start == "1" && count < 11)) {
							$("span#end").html("더이상 조회할 유저가 없습니다.");		// id 가 end 인 span 태그에 추가하겠다.
							$("button#btnMoreCollection").text("처음으로");
							$("span#countCollection").text(0);
						}
						else{
							$("button#btnMoreCollection").hide();
						}
					}
	
				} // end of else if 				
			
			},
			// 에러 일때 실행된다.
	         error: function(request, status, error){
	             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
			
		});
		
		
		
			
		
	}// end of function displayCollection() 

	
	// 영화 버튼을 눌렀을때 
	function SearchContants() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchMovie = document.FrmMovieSearchDetail;
		FrmMovieSearchMovie.action="<%=ctxPath%>/goSearch.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchMovie.method="get";
		FrmMovieSearchMovie.submit();	
	}
	
	
	// 인물 버튼을 눌렀을때 
	function SearchPeople() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchPeople = document.FrmMovieSearchDetail;
		FrmMovieSearchPeople.action="<%=ctxPath%>/goSearchPeople.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchPeople.method="get";
		FrmMovieSearchPeople.submit();	
	}
	
	// 컬렉션 버튼을 눌렀을때 
	function SearchCollection() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchCollection = document.FrmMovieSearchDetail;
		FrmMovieSearchCollection.action="<%=ctxPath%>/goSearchCollection.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchCollection.method="get";
		FrmMovieSearchCollection.submit();	
		
	}
	
	// 유저 버튼을 눌렀을때 
	function SearchUser() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchUser = document.FrmMovieSearchDetail;
		FrmMovieSearchUser.action="<%=ctxPath%>/goSearchUser.action";     /* // action 인것 바꾸기 */ 
		FrmMovieSearchUser.method="get";
		FrmMovieSearchUser.submit();	
		
	}
	

</script>



</head>
<body>
	<div class="searchWord_header">
		<div class="container">
			<span class="h5" style="margin: 0;">"  <c:out value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />  "의 검색결과</span>  <!-- 스크립트 공격 방어 -->
			<span>[ 컬렉션 검색결과 숫자 : <span id="total_mv_count"></span> 개 ]</span>
		</div>
	</div>
		
		
	<div class="container clearfloat">
	
		<div class="searchWord_div_nav">
			<nav class="navbar  navbar-expand  navbar-light searchWord_nav">
		
			  <ul class="navbar-nav">
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="0" id="contants">영화</button>
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="1" id="People">인물</button>			      
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="2" id="collection">컬렉션</button>	
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="3" id="User">유저</button>	
			    </li>
			  </ul>
			</nav>
		</div>
		
		<form id="FrmMovieSearchDetail" name="FrmMovieSearchDetail">
			<input type="hidden" id="novalue" name="novalue" value="0"/>
			<input type="hidden" id="lastSearchWord" name="lastSearchWord" value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />
		</form>
		
		<h4 class="h4" style="font-weight: bold;" id="title_Collection">컬렉션</h4>
		
		
		<div>
			<ul style="padding: 0; margin: 0;" id="displayCollection">
			
			</ul>
		</div>
	</div>
	
	<div>
         <p class="text-center">
            <span id="end" style="display:block; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <button type="button" class="btn btn-secondary btn-lg" id="btnMoreCollection" value="" style="margin-top : 20px;">더보기</button>   <%-- value 값이 초기에는 없었는데 값을 집어넣어주면  --%>
            <span style=" position: relative; top: 11px;">
	            <span id="countCollection"></span>
	            <span id="totalCollectionCount"></span>    
            </span>        
         </p>
    </div>	
	
	
	
</body>
</html>