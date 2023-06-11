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
	}
	
	.SMD {
		height: 150px;
  		padding: 0;
  		display: flex;
	}
	
	.SMD > img {	
  		height: 150px;
  		width: 150px;
  
	}
	
	.clearfloat:after {
		content: "";
		display: table;
		clear: both;
	}
	
	
	@media (min-width: 860px) {
		.SMDLi {
			width: 50%;
			float: left;
			box-sizing: border-box;
			padding: 0 5px;
		}
	}

	@media (max-width: 860px) {
		.SMDLi {
			width: 100%;
		}
	}

</style>


<script type="text/javascript">




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
			<ul style="padding: 0; margin: 0;">
				<c:forEach var="showMovie" items="${requestScope.showMovie}" varStatus="status">
					<li class = "SMDLi">
						<a href = "<%= ctxPath%>/view/project_detail.action?movie_id=${showMovie.movie_id}" title="${showMovie.movie_title}" class="Main-a">
						
							<div class="SMD">
								<img src="https://image.tmdb.org/t/p/w500/${showMovie.poster_path}" class="card-img-top" alt="...">
								<div>
									<p>${showMovie.movie_title}</p>
									<p>${showMovie.release_date} * ${showMovie.original_language}</p>
									<p>★ ${showMovie.rating_avg}</p>
								</div>
							</div>
							<div class="">
								
							<div>
						
						</a>
					
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</body>
</html>