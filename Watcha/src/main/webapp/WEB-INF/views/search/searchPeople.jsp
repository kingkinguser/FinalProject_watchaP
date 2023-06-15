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
		height: 150px;
  		padding: 0;
  		display: flex; 		
	}
	
	.SMD > img {	
  		height: 150px;
  		width: 150px;
  		margin: 0 10px 0 0;
  
	}
	
	.clearfloat:after {
		content: "";
		display: table;
		clear: both;
	}
	
	.MvTitle {
		padding-top: 2%;
		color: black;
	}
	
	.TitleM {
		font-weight: bold;
	}
	
	.colorChange {
		color: #8c8c8c;
	}
	
	
	@media (min-width: 860px) {
		.SMDLi {
			width: 50%;
			float: left;
			box-sizing: border-box;
			padding: 8px 5px;
		}
	}

	@media (max-width: 860px) {
		.SMDLi {
			width: 100%;
			padding: 8px 5px;
		}
	}

</style>


<script type="text/javascript">

	$(document).ready(function() {
					
		$("#people").css({'border-bottom': 'solid 1px black'});
		
		$("span#totalPeopleCount").hide();
		$("span#countPeople").hide();
		
		displayPeople(1);
		
		
		$("button#btnMorePeople").click(function() {
			
			if($(this).text() == "처음으로") { // $(this) 는 여기서 button 을 말함 
				
				$("ul#displayPeople").empty();  // 비운다.
				$("span#end").empty();    // 비운다 				
				displayPeople(1);            // 처음부터 다시 가기 위해 비운 후 함수 다시 실행 
				$(this).text("더보기");
				
			}
			else {
				displayPeople($(this).val());  // 함수 호출 this로 가져와 val() 내용을 가져온다. 

			}
		
		});
		
		/*영화 눌렀을때 */
		$("button#contants").click(function(){
			SearchContants();
		});
		
		/* 인물 눌렀을때  */
		$("button#people").click(function(){
			SearchPeople();
		});
		
		/* 컬렉션 눌렀을때 */
		$("button#collection").click(function(){
			SearchCollection();
		});
		
		/* 유저 눌렀을때 */
		$("button#user").click(function(){
			SearchUser();
		});
		
		$("button#excel").click(function(){
			excel();
		});
	
	});
		
	let lastSearchWord = "${lastSearchWord}";
	
	let lenShow = 10;	// 인물 10개씩 보기 위해 
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayPeople(start) {     
		
		$.ajax({
			url:"<%= ctxPath%>/goSearchPeople.action",
			type:"post",
			data:{"start":start		
				 ,"lenShow":lenShow
				 ,"lastSearchWord": lastSearchWord},
			dataType:"json",
			async:true,			
			success:function(json) {

				var responseData = JSON.parse(json.jsonResponse);
				var count = responseData.People_list.length;				
				
				var total_count = responseData.totalPeopleCount; 
				$("span#totalPeopleCount").text(total_count);
				$("span#total_mv_count").text(total_count);
				
				
				let html = "";
				
				if(start == "1" && count == 0) {  // 배열이기 때문에 json == null 로 하면 절대로 안된다. 
					// 처음부터 데이터가 존재하지 않는 경우 				
					html += "<div style='text-align: center; padding: 100px 0;' class='h4'>" + 
					           "<p style='margin-bottom: 40px;'><i class='fa-solid fa-question fa-2xl' style='color: #9a9da2;'></i></p>" + 
					           "<p>인물 정보가 없습니다.</p>" + 
					           "<p>(한글로 검색하셨다면 영문으로 검색하세요)</p>" + 
					        "<div>";
				

					$("ul#displayPeople").html(html);
					$("button#btnMorePeople").hide();
					$("h4#title_people").hide();
				} 
				
				else if (count > 0) {
					// 데이터가 존재하는 경우 
					responseData.People_list.forEach(function(item, index, array) {
						html +=  '<li class = "SMDLi">'+ 
			                        '<div class="SMD">'+
			                        '<img src="' + (item.profile_image_path ? "https://image.tmdb.org/t/p/w500/" + item.profile_image_path : "<%= ctxPath%>/resources/images/업데이트중입니다.jpg") + '" class="card-img-top" alt="...">'+
			                          '<div class = "MvTitle">'+
			                             '<p class="TitleM">' + item.actor_name + '</p>'+
			                             '<p class="colorChange">성별 : ' + item.gender + '</p>'+
			                             '<p class="colorChange">생년월일 : ' + item.date_of_birth + '</p>'+
			                          '</div>' +
									'</div>'  +
								'</li>' 
						});

						
							
					$("ul#displayPeople").append(html);		 // append 를 쓰면 기존거 + 새로운거 html 을 쓰면 기존꺼는 없애고 새로운것만 나타남
					
	
					$("button#btnMorePeople").val( Number(start) + lenShow );					
					
					$("span#countPeople").text( Number($("span#countPeople").text()) + count );    /// val() 대신 text 를 사용해야 한다.				
					

					if( Number($("span#totalPeopleCount").text()) <= Number($("span#countPeople").text()) )  {  // number 는 빼도 그만 안빼도 그만 
						if(!(start == "1" && count < 11)) {
							$("span#end").html("더이상 조회할 인물이 없습니다.");		// id 가 end 인 span 태그에 추가하겠다.
							$("button#btnMorePeople").text("처음으로");
							$("span#countPeople").text(0);
						}
						else{
							$("button#btnMorePeople").hide();
						}
					}
	
				} // end of else if 				
			
			},
			// 에러 일때 실행된다.
	         error: function(request, status, error){
	             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
			
		});
		
		
		
			
		
	}// end of function displayPeople() 

	
	// 영화 버튼을 눌렀을때 
	function SearchContants() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchMovie = document.FrmMovieSearchDetail;
		FrmMovieSearchMovie.action="<%=ctxPath%>/goSearch.action";    
		FrmMovieSearchMovie.method="get";
		FrmMovieSearchMovie.submit();	
	}
	
	
	// 인물 버튼을 눌렀을때 
	function SearchPeople() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchPeople = document.FrmMovieSearchDetail;
		FrmMovieSearchPeople.action="<%=ctxPath%>/goSearchPeople.action";   
		FrmMovieSearchPeople.method="get";
		FrmMovieSearchPeople.submit();	
	}
	
	// 컬렉션 버튼을 눌렀을때 
	function SearchCollection() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchCollection = document.FrmMovieSearchDetail;
		FrmMovieSearchCollection.action="<%=ctxPath%>/goSearchCollection.action";    
		FrmMovieSearchCollection.method="get";
		FrmMovieSearchCollection.submit();	
		
	}
	
	// 유저 버튼을 눌렀을때 
	function SearchUser() {
		
		const searchText = $('input#lastSearchWord').val();
		
		const FrmMovieSearchUser = document.FrmMovieSearchDetail;
		FrmMovieSearchUser.action="<%=ctxPath%>/goSearchUser.action";    
		FrmMovieSearchUser.method="get";
		FrmMovieSearchUser.submit();	
		
	}
	// 인물 엑셀로 저장 
	function excel() {
		
		const FrmActorExcel = document.FrmMovieSearchDetail;
		FrmActorExcel.action="<%=ctxPath%>/actor/excel/download.action";    
		FrmActorExcel.method="post";
		FrmActorExcel.submit();	
	}
	

</script>



</head>
<body>
	<div class="searchWord_header">
		<div class="container">
			<span class="h5" style="margin: 0;">"  <c:out value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />  "의 검색결과</span>  <!-- 스크립트 공격 방어 -->
			<span>[ 인물 검색결과 숫자 : <span id="total_mv_count"></span> 개 ]</span>
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
			      <button type="button" class="nav-link" data-status="1" id="people">인물</button>			      
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="2" id="collection">컬렉션</button>	
			    </li>
			    <li class="nav-item">
			      <button type="button" class="nav-link" data-status="3" id="user">유저</button>	
			    </li>
			  </ul>
			</nav>
		</div>
		
		<form id="FrmMovieSearchDetail" name="FrmMovieSearchDetail">
			<input type="hidden" id="novalue" name="novalue" value="0"/>
			<input type="hidden" id="lastSearchWord" name="lastSearchWord" value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />
		</form>
		
		<span class="h4" style="font-weight: bold;" id="title_people">인물<button type="button" style="float: right" class="btn btn-success" id="excel">excel 저장</button></span>
		
		<div>
			<ul style="padding: 0; margin: 0;" id="displayPeople">
			
			</ul>
		</div>
	</div>
	
	<div>
         <p class="text-center">
            <span id="end" style="display:block; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <button type="button" class="btn btn-secondary btn-lg" id="btnMorePeople" value="" style="margin-top : 20px;">더보기</button>   <%-- value 값이 초기에는 없었는데 값을 집어넣어주면  --%>
            <span style=" position: relative; top: 11px;">
	            <span id="countPeople"></span>
	            <span id="totalPeopleCount"></span>    
            </span>        
         </p>
       </div>
	
</body>
</html>