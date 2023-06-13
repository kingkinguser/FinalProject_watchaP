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
					
		$("span#totalMovieCount").hide();
		$("span#countMovie").hide();
		
		displayMovie(1);
		
		
		$("button#btnMoreMovie").click(function() {
			
			if($(this).text() == "처음으로") { // $(this) 는 여기서 button 을 말함 
				
				$("ul#displayMovie").empty();  // 비운다.
				$("span#end").empty();    // 비운다 	
				displayMovie(1);            // 처음부터 다시 가기 위해 비운 후 함수 다시 실행 
				$(this).text("더보기");
				
			}
			else {
				displayMovie($(this).val());  // 함수 호출 this로 가져와 val() 내용을 가져온다. 

			}
		
		});
	
	});
		
	let lastSearchWord = "${lastSearchWord}";
	
	let lenShow = 10;	// 영화 10개씩 보기 위해 
	let novalue = "1"
	
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

				var responseData = JSON.parse(json.jsonResponse);
				var count = responseData.movie_list.length;				
				
				var total_count = responseData.total_count; 
				$("span#totalMovieCount").text(total_count);
				$("span#total_mv_count").text(total_count);
				
				
				let html = "";
				
				if(start == "1" && count == 0) {  // 배열이기 때문에 json == null 로 하면 절대로 안된다. 
					// 처음부터 데이터가 존재하지 않는 경우 				
					html += "<div style='text-align: center;' class='h2'>영화 정보가 없습니다.<div>";
				

					$("ul#displayMovie").html(html);
					$("button#btnMoreMovie").hide();
				} 
				
				else if (count > 0) {
					// 데이터가 존재하는 경우 
					responseData.movie_list.forEach(function(item, index, array) {
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
					
					$("span#countMovie").text( Number($("span#countMovie").text()) + count );    /// val() 대신 text 를 사용해야 한다.				
					

					if( Number($("span#totalMovieCount").text()) <= Number($("span#countMovie").text()) )  {  // number 는 빼도 그만 안빼도 그만 
						
						$("span#end").html("더이상 조회할 영화가 없습니다.");		// id 가 end 인 span 태그에 추가하겠다.
						$("button#btnMoreMovie").text("처음으로");
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
			<span class="h5" style="margin: 0;">"  <c:out value="${lastSearchWord.replace('<', ' ').replace('>', ' ')}" />  "의 검색결과</span>  <!-- 스크립트 공격 방어 -->
			<span>[ 영화 검색결과 숫자 : <span id="total_mv_count"></span> 개 ]</span>
		</div>
	</div>
		
		
	<div class="container clearfloat">
		<h4 class="h4" style="font-weight: bold;">영화</h4>
		
		
		<div>
			<ul style="padding: 0; margin: 0;" id="displayMovie">
			
			</ul>
		</div>		

	</div>
	
	<div id="odd_number">
         <p class="text-center">
            <span id="end" style="display:block; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <button type="button" class="btn btn-secondary btn-lg" id="btnMoreMovie" value="" style="margin-top : 20px;">더보기</button>   <%-- value 값이 초기에는 없었는데 값을 집어넣어주면  --%>
            <span style=" position: relative; top: 11px;">
	            <span id="countMovie"></span>
	            <span id="totalMovieCount"></span>    
            </span>        
         </p>
    </div>
	
	
</body>
</html>