<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<% String ctxPath = request.getContextPath(); %>    



<head>


<%-- <link rel="icon" href="<%=ctxPath%>/images/파비콘.ico"> --%>


<style type="text/css">

	.footer {
		background-color: black;
	}
	
	div.footer-container {
		color: white;
		background-color: black;
		padding: 0;
	}
	.footer-up {
		text-align: center;
		margin-bottom: 50px;
	}
	.footer-row {
		color : #bfbfbf;
	}
	.footer-up > h2 > span {
		color: red;
	}
	
	div.footer-nav > nav  a{
		color: #bfbfbf;
		text-decoration: none;
	}
	
	.footer-line {
		margin: 0 5px ;
	}
	.footer-icon {
		position: relative;
		top: 50px; 
	}
	
	.footer-icon > a {
		color: white;
	}
	.footer-row > li {
		list-style:none;
	}
	.footer-link-text {
		position: relative;
		font-size: 10pt;
	}
	.footer-row > li > a {
		color: gray;
	}
	
	.footer-model-header > button {
		color: red;
		background-color: white;
		border: none;	
  		font-size: 50px;
  		padding: 0;
	}
	
	.card-header > button{
		background-color: white;
		border: none;	
		width: 100%;
		text-align: left;
	}

	.footer-icon-css {
		position: relative;
		bottom: 5px;
	}
	
	.footer-icon-css2 {
		position: relative;
		top: 10px;
	}
	
	@media (min-width: 768px) {
	  .modal-dialog {
	    max-width: 720px;
	  }
	}

	@media (max-width: 767px) {
	  .modal-dialog {
	    max-width: 100%;
	    margin: 0	   
	  }
	}
	
	.footer-icon1:hover {
		color: #4d4dff;
	}
	
	.footer-icon2:hover {
		color: #4da6ff;
	}
	.footer-icon3:hover {
		color: #ff1a1a;
	}

	
</style>


<script type="text/javascript">

 	$(document).ready(function(){
	
 		$('#footer-modal-main').hide;
 		$('#footer-modal-main-2').hide;
 		
 		$('.footer-accordion-button').click(function() {
   		    const icon = $(this).find('i');
   		    if (icon.hasClass('fa-sort-up')) {
   		      icon.removeClass('fa-sort-up').addClass('fa-sort-down').addClass('footer-icon-css').removeClass('footer-icon-css2');
   		    } else {
   		      icon.removeClass('fa-sort-down').addClass('fa-sort-up').addClass('footer-icon-css2').removeClass('footer-icon-css');
   		    }
   		});
 		
 		$.ajax({
 			url:"<%= ctxPath%>/footer/showEvaluationNumber.action",
 			type:"get",
 			success: function(data){
 				//console.log("n : " + data);	
 				 $("span#footer-count").text(data);
 				
 			},
	 		error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }	
 		});
 		
 		
	});
 	
 	
 	

	
</script>

</head>
<body>

	<!-- Modal -->
									
	<div id="footer-modal-main">
		<!-- Modal -->
		<div class="modal fade" id="footer-model">

		   <div class="modal-dialog modal-dialog-scrollable" style="color:black">    <!-- modal-dialog-scrollable 는 띈 창에 대해서만 스크롤을 할 수 있다.  없다면 페이지 전체가 스크롤이 되어진다. -->

		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header footer-model-header" style="display: block">									  
					<button type="button" data-dismiss="modal">&times;</button>									        
		        	<h5 class="h5" style="font-size:22pt; font-weight: bold;">서비스 이용약관</h5>									  
		      </div>

		      <!-- Modal body -->
		      <div class="modal-body">
		        <div class="accordion" id="accordionExample" style="overflow-anchor: none;">		<!-- 아이디 값이 중요하다. -->
				 <div class="card" style="border: none;">
				    <div class="card-header" id="headingsix" style="background-color: white; padding: 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapsesix" aria-expanded="true" aria-controls="collapsesix" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 6</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-up"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapsesix" class="collapse show" aria-labelledby="headingsix" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2021년 10월 29일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingfive" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapsefive" aria-expanded="true" aria-controls="collapsefive" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 5</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapsefive" class="collapse hide" aria-labelledby="headingfive" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2018년 05월 02일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingfour" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapsefour" aria-expanded="true" aria-controls="collapsefour" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 4</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapsefour" class="collapse hide" aria-labelledby="headingfour" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2016년 12월 02일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingthree" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapsethree" aria-expanded="true" aria-controls="collapsethree" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 3</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapsethree" class="collapse hide" aria-labelledby="headingthree" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2015년 09월 26일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingTwo" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 2</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseTwo" class="collapse hide" aria-labelledby="headingTwo" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2012년 01월 02일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingone" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseone" aria-expanded="true" aria-controls="collapseone" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 1</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseone" class="collapse hide" aria-labelledby="headingone" data-parent="#accordionExample">
				       <div class="card-body footer-modal-font">
				         <p>왓챠피디아 이용약관<br><br>본 약관은 2011년 08월 15일부터 적용됩니다.<br><br>제 1 조 목적<br>이 약관은 주식회사 왓챠(이하 "회사")에서 제공하는 왓챠피디아 및 왓챠피디아에서 제공하는 제반 서비스(이하 "서비스")에 접속과 사용자에 의해서 업로드 및 다운로드 되어 표시되는 모든 정보, 텍스트, 이미지 및 기타 자료를 이용하는 이용자(이하 "회원")와 서비스 이용에 관한 권리 및 의무와 책임사항, 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>제2조 약관의 게시와 효력, 개정<br>① 회사는 서비스의 가입 과정에 본 약관을 게시합니다.<br>② 회사는 관련법에 위배되지 않는 범위에서 본 약관을 변경할 수 있으며, 개정 전 약관과 함께 적용일자 7일 전부터 웹사이트에서 확인할 수 있도록 게시합니다. 다만, 이용자에게 불리하게 약관을 변경하는 경우에는 적용일자 30일 전에 개정내용을 이용자가 확인할 수 있도록 게시합니다.<br>③ 회원은 회사가 전항에 따라 변경하는 약관에 동의하지 않을 권리가 있으며, 이 경우 회원은 회사에서 제공하는 서비스 이용 중단 및 탈퇴 의사를 표시하고 서비스 이용 종료를 요청할 수 있습니다. 다만, 회사가 회원에게 변경된 약관의 내용을 통보하면서 회원에게 "7일 이내 의사 표시를 하지 않을 경우 의사 표시가 표명된 것으로 본다는 뜻"을 명확히 통지하였음에도 불구하고, 거부의 의사표시를 하지 아니한 경우 회원이 변경된 약관에 동의하는 것으로 봅니다.<br><br>제3조 약관의 해석과 예외 준칙<br>① 회사는 제공하는 개별 서비스에 대해서 별도의 이용약관 및 정책을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우 개별 서비스의 이용약관을 우선하여 적용합니다.<br>② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
				       </div>
				     </div>
				     
				 </div>
				</div>
   
		    </div>
		  </div>
		</div>
		</div>
	</div>
	
	
	
	<div id="footer-modal-main-2">
		<!-- Modal -->
		<div class="modal fade" id="footer-model-2">

		   <div class="modal-dialog modal-dialog-scrollable" style="color:black">    <!-- modal-dialog-scrollable 는 띈 창에 대해서만 스크롤을 할 수 있다.  없다면 페이지 전체가 스크롤이 되어진다. -->

		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header footer-model-header" style="display: block">									  
					<button type="button" data-dismiss="modal">&times;</button>									        
		        	<h5 class="h5" style="font-size:22pt; font-weight: bold;">개인정보 처리방침</h5>									  
		      </div>

		      <!-- Modal body -->
		      <div class="modal-body">
		        <div class="accordion" id="accordionExample2" style="overflow-anchor: none;">		<!-- 아이디 값이 중요하다. -->
				 <div class="card" style="border: none;">
				    <div class="card-header" id="headingVsix" style="background-color: white; padding: 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVsix" aria-expanded="true" aria-controls="collapseVsix" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 15</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-up"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVsix" class="collapse show" aria-labelledby="headingVsix" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2023년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingVfive" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVfive" aria-expanded="true" aria-controls="collapsefive" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 14</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVfive" class="collapse hide" aria-labelledby="headingVfive" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2021년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingVfour" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVfour" aria-expanded="true" aria-controls="collapseVfour" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 13</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVfour" class="collapse hide" aria-labelledby="headingVfour" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2019년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingVthree" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVthree" aria-expanded="true" aria-controls="collapseVthree" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 12</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVthree" class="collapse hide" aria-labelledby="headingVthree" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2017년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingVTwo" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVTwo" aria-expanded="true" aria-controls="collapseVTwo" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 11</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVTwo" class="collapse hide" aria-labelledby="headingVTwo" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2015년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				     
				     <div class="card-header" id="headingVone" style="background-color: white; padding: 30px 0 0 0;">
				      <button type="button" data-toggle="collapse" data-target="#collapseVone" aria-expanded="true" aria-controls="collapseVone" class="footer-accordion-button" style="padding: 0;">
				      <h4 class="mb-0">											        
				          <span>버전 10</span>		
				          <span style="float: right; bottom: 5px; position: relative;"><i class="fa-solid fa-sort-down"></i></span>									
				      </h4>
				      
				      </button>
				    </div>
				
				    <div id="collapseVone" class="collapse hide" aria-labelledby="headingVone" data-parent="#accordionExample2">
				       <div class="card-body footer-modal-font">
				         <p>개인정보처리방침<br><br>본 방침은 2013년 2월 24일부터 적용됩니다.<br><br><br><br><br><br>1. 총칙<br><br>제 1조 목적<br><br>주식회사 왓챠는(이하 ‘회사’라고 합니다)는 왓챠피디아(WATCHA PEDIA), 왓챠(WATCHA) 및 왓챠피디아 관련 제반 서비스(이하 “서비스”라고 합니다)를 이용하는 회원의 개인정보 보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.<br><br>회사는 개인정보 보호 관련 주요 법률인 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다)을 비롯한 모든 개인정보 보호에 관련 법률 규정 및 국가기관 등이 제정한 고시, 훈령, 지침 등을 준수합니다.<br><br>본 개인정보처리방침은 회사의 서비스를 이용하는 회원에 대하여 적용되며, 회원이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보 보호를 위하여 회사가 어떠한 조치를 취하고 있는지 알립니다. 또한 개인정보와 관련하여 회사와 회원간의 권리 및 의무 관계를 규정하여 회원의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br><br><br><br>2. 개인정보의 처리<br><br>제 2조 개인정보의 수집·이용에 대한 동의<br><br>회사는 적법하고 공정한 방법에 의하여 서비스 이용계약의 성립 및 이행에 필요한 최소한의 개인정보를 수집하며 이용자의 개인 식별이 가능한 개인정보를 수집하기 위하여 회원가입시 개인정보수집·이용 동의에 대한 내용을 제공하고 회원이 '동의' 버튼을 클릭하면 개인정보 수집·이용에 대해 동의한 것으로 봅니다.<br><br><br>제 3조 수집하는 개인정보의 항목범위 및 수집 방법<br><br>1항. 회원가입, 상담, 서비스 신청 등 서비스 제공 및 계약이행을 위해 회원가입 시점에 회사가 회원으로부터 수집하는 개인정보는 아래와 같습니다.<br>1) 아이디(이메일 주소), 비밀번호, sns를 통한 가입 시 이메일, 이름, 생년월일, 연령, 성별, 프로필 사진, 식별token, 회원번호(sns 연동 또는 제휴요금제 이용 회원에 한함)를 수집하며 만약 회원의 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.</p>
				       </div>
				     </div>
				     
				 </div>
				</div>
   
		    </div>
		  </div>
		</div>
		</div>
	</div>
	
	
	
	
	<div class="footer d-none d-md-block">
		<div class="container footer-container">
			<div class="footer-up">
				<h2 class="footer_h2 pt-2">지금까지<span id="">★ <span id="footer-count"></span> 개의 평가가</span> 쌓였어요.</h2>
			</div>
			
			 <%-- md 사이즈보다 크면 실행한다. --%>
			<nav class="navbar navbar-expand-md navbar-dark">
			  <div class="collapse navbar-collapse" id="collapsibleNavbar">
			    <ul class="navbar-nav" style="display: block; width: 100%;">
			       <li>
			       	<div class="row footer-row">
						<div class="footer col-md-11" style="padding-left: 0;">
							<div class="footer-nav">
								<nav>
									<a href="javascript:void(0)" data-toggle="modal" data-target="#footer-model" class="footer-modal-go">서비스 이용약관</a>								
									<span class="footer-line">|</span>
									<a href="javascript:void(0)" data-toggle="modal" data-target="#footer-model-2" class="footer-modal-go-2">개인정보 처리방침</a>
									<span class="footer-line">|</span>
									<a href="https://watcha.team">회사 안내</a>
								</nav>
							</div>
							
							<div class="footer-nav">
								<nav>
									<div><span>고객센터</span><span class="footer-line">|</span><a target="_blank" href="mailto:cs@warchpedia.co.kr"><span>cs@warchpedia.co.kr, 02-515-9985</span></a></div>									
									<div><span>광고 문의</span>
									
										<span class="footer-line">|</span>		
										<a target="_blank" href="mailto:ad_sales@watcha.com"><span>ad_sales@watcha.com</span></a>						
										<span class="footer-line">·</span>							
										<a href="https://an2-ast.amz.wtchn.net/Watchapedia_AD.pdf">최신 광고 소개서 <i class="fa-solid fa-download"></i></a>						
										<%-- 임의로 파일 다운로드 되게 함 ( but DB에서 연결을 해서 파일을 가져와야 할 듯함 --%>
									
									</div>
									<div><span>제휴 및 대외 협력</span><span class="footer-line">|</span><a target="_blank" href="mailto:cs@warchpedia.co.kr"><span>cs@warchpedia.co.kr, 02-515-9985</span></a></div>
								</nav>
							</div>
							
							<div class="footer-bottom">
								<div>
									<span>주식회사 왓챠</span><span class="footer-line">|</span>
									<span>서울특별시 마포구 월드컵북로 21 풍성빌딩</span>
								</div>
								<div>
									<span>조원 강성은 민동현 장주형 신준하 서수경</span>
								</div>
								<div>
									<span>사업자 등록 번호 211-88-66013</span>
								</div>
								<div>
									<p><img src="<%= ctxPath%>/resources/images/와차피디아_로고.png" /><span style="position: relative; top: 2px;">&copy; 2022 by WATCHA, Inc. ALL rights reserved.</span></p>
								</div>
								
							</div>
						</div>	
						<div class="col-md-1">
							
							
							<div class="footer-icon" style="width:117px; right: 40px; top: 160px;">
								<a href="https://www.facebook.com/watchaKR/"><i class="fa-brands fa-facebook fa-2xl footer-icon1" style="margin-right: 5px;" ></i></a>
								<a href="https://twitter.com/watcha_kr?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor"><i class="fa-brands fa-square-twitter fa-2xl footer-icon2" style="margin-right: 5px;"></i></a>
								<a href="https://watcha.team"><i class="fa-solid fa-w fa-xl footer-icon3"></i></a>
							</div>
						</div>
					</div>	
			       </li>    
			    </ul>
			  </div>		
			</nav>	
		</div>
	</div>
		
	<div class="d-block d-md-none" style="margin-top: 90px;">
		<div class="fixed-bottom" style="border-top: solid 1px black; background-color: white;">
			<div class="container">			
							
				 <ul class="row footer-row" style="margin-bottom: 0; ">
				       <li class="col-2">
				           <a class="nav-link-1" href="#">
							  <i class="fa-solid fa-house fa-xl"></i><br>
							  <span class="footer-link-text" style="left: 7px;">홈</span>
						   </a>
	
				       </li>
				       
				       <li class="col-2 offset-1">
				           <a class="nav-link-2" href="#">
				              <i class="fa-solid fa-magnifying-glass fa-xl"></i><br>
				              <span class="footer-link-text">검색</span>
				           </a>
				       </li>
				       
				       <li class="col-2 offset-1">
				          <a class="nav-link-3" href="#">
				              <i class="fa-solid fa-star fa-xl"></i><br>
				              <span class="footer-link-text" style="left: 1px;">평가</span>
				          </a>
				       </li>
				       
				       <li class="col-2 offset-1">
				          <a class="nav-link-4" href="#">
				              <i class="fa-solid fa-user fa-xl"></i><br>
				              <span class="footer-link-text" style="right: 16px; display: block; width: 100px; top: 3px;">나의 왓챠</span>
				          </a>
				       </li>
			 	  </ul>
			</div>
		</div>	
	</div>	

</body>
</html>