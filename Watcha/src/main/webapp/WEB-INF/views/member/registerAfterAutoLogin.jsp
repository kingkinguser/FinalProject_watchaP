<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	window.onload = function(){
		
		alert("회원가입에 감사드립니다.!!");
		
		const frm = document.loginFrm;
		frm.action = "<%= request.getContextPath()%>/loginEnd.action";
		frm.method = "post";
		frm.submit();
		
	}// end of window.onload = function(){}-----------------------------

</script>

</head>
<body>
	
	<form name="loginFrm">
		<input type="hidden" name="user_id" value="${requestScope.user_id}" />
		<input type="hidden" name="password" value="${requestScope.password}" />
	</form>

</body>
</html>