<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	alert("${requestScope.message}"); 		// 메시지 출력해주기
	location.href = "${requestScope.goBackURL}"; 	// 페이지 이동
	
	opener.location.reload(true); // 부모창 새로 고침
	self.close(); // 팝업창 닫기
	
</script>