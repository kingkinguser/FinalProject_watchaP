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
		padding-top: 5%;
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
					
		$("span#totalMovieCount").hide();
		$("span#countMovie").hide();
		
		displayMovie(1);
		
		
		$("button#btnMoreMovie").click(function() {
			
			if($(this).text() == "처음으로") { // $(this) 는 여기서 button 을 말함 
				
				$("div#displayMovie").empty();  // 비운다.
				$("span#end").empty();    // 비운다 				
				displayMovie(1);            // 처음부터 다시 가기 위해 비운 후 함수 다시 실행 
				$(this).text("더보기");
				
			}
			else {
				displayMovie($(this).val());  // 함수 호출 this로 가져와 val() 내용을 가져온다. 

			}
		
		});
	
	});
		
	var lastSearchWord = "${lastSearchWord}";
	
	let lenShow = 10;	// 영화 10개씩 보기 위해 
	var novalue = "1"
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayMovie(start) {     
		
		$.ajax({
			url:"<%= ctxPath%>/goSearchDetail.action",
			type:"get",
			data:{"start":start		
				 ,"lenShow":lenShow
				 ,"lastSearchWord": lastSearchWord
				 ,"novalue" : novalue},
			dataType:"json",
			async:true,			
			success:function(json) {
				
				console.log(JSON.stringify(json));
				console.log(start);
				console.log(json.jsonResponse);
				
				var responseData = JSON.parse(json.jsonResponse);
				var count = responseData.length;
			    console.log(count);  // Number of movies in the array
				
				
				let html = "";
				
				if(start == "1" && count == 0) {  // 배열이기 때문에 json == null 로 하면 절대로 안된다. 
					// 처음부터 데이터가 존재하지 않는 경우 				
					html += "<div style='text-align: center;' class='h2'>영화 정보가 없습니다.<div>";
				
					// HIT 상품 결과물 출력하기 
					$("ul#displayMovie").html(html);
					$("button#btnMoreMovie").hide();
				} 
				
				else if (count > 0) {
					// 데이터가 존재하는 경우 
					responseData.forEach(function(item, index, array) {
						html +=  '<li class = "SMDLi">'+ 
				                    '<a href = "<%= ctxPath%>/view/project_detail.action?movie_id=' + item.movie_id + '" title="' + item.movie_title + '" style="text-decoration: none;">'+
				                        '<div class="SMD">'+
				                        '<img src="https://image.tmdb.org/t/p/w500/' + item.poster_path + '" class="card-img-top" alt="...">'+
				                          '<div class = "MvTitle">'+
				                             '<p class="TitleM">' + item.movie_title + '</p>'+
				                             '<p class="colorChange">개봉연도 : ' + item.release_date + '</p>'+
				                             '<p class="colorChange">★ ' + item.rating_avg + '</p>'+
				                          '</div>' +
										'</div>'  +
									'</a>' +
								'</li>' 
						});

						
							
					$("ul#displayMovie").append(html);		 // append 를 쓰면 기존거 + 새로운거 html 을 쓰면 기존꺼는 없애고 새로운것만 나타남
					
	
					$("button#btnMoreMovie").val( Number(start) + lenShow );					
					
					$("span#countMovie").text( Number($("span#countMovie").text()) + json.length );    /// val() 대신 text 를 사용해야 한다.				
					
					
					if( Number($("span#totalHITCount").text()) <= Number($("span#countMovie").text()) )  {  // number 는 빼도 그만 안빼도 그만 
						
						$("span#end").html("더이상 조회할 영화가 없습니다.");		// id 가 end 인 span 태그에 추가하겠다.
						$("button#btnMoreHIT").text("처음으로");
						$("span#countMovie").text(0);
					}
	
				} // end of else if 				
			
			},
			// 에러 일때 실행된다.
	         error: function(request, status, error){
	             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
			
		});
		
		
		
			
		
	}// end of function displayMovie() 


</script>



</head>
<body>
	<div class="searchWord_header">
		<div class="container">
			<h5 class="h5" style="margin: 0;">"  <c:out value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />  "의 검색결과</h5>  <!-- 스크립트 공격 방어 -->
		</div>
	</div>
		
		
	<div class="container clearfloat">
		<h4 class="h4" style="font-weight: bold;">영화</h4>
		
		
		<div>
			<ul style="padding: 0; margin: 0;" id="displayMovie">
			
			</ul>
		</div>
		
		<%-- <div>
			<ul style="padding: 0; margin: 0;">
				<c:forEach var="showMovie" items="${requestScope.showMovie}" varStatus="status">
					<li class = "SMDLi">
						<a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${showMovie.movie_id}" title="${showMovie.movie_title}" style="text-decoration: none;">
						
							<div class="SMD">
								<img src="https://image.tmdb.org/t/p/w500/${showMovie.poster_path}" class="card-img-top" alt="...">
								<div class = "MvTitle">
									<p class="TitleM">${showMovie.movie_title}</p>
									<p class="colorChange">${showMovie.release_date} ● ${showMovie.original_language}</p>
									<p class="colorChange">★ ${showMovie.rating_avg}</p>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div> --%>
		
		
		<div>
         <p class="text-center">
            <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <button type="button" class="btn btn-secondary btn-lg" id="btnMoreMovie" value="">더보기</button>   <%-- value 값이 초기에는 없었는데 값을 집어넣어주면  --%>
            <span id="totalMovieCount">${requestScope.totalHITCount}</span>
            <span id="countMovie">0</span>
         </p>
        </div>
		
		
		
	</div>
</body>
</html>