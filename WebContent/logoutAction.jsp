<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  

 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>로그인</title>
</head>

<body>
	
<%
 	session.invalidate();
%>
 <script>
 	location.href = 'main.jsp';
 	alert('로그아웃 되셨습니다.');
 </script>
	
</body>
</html>