<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="user.UserDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID"/>
 <jsp:setProperty name="user" property="userPassword"/>
  <jsp:setProperty name="user" property="userName"/>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>로그인</title>
</head>

<body>
	
<%
String userID = null;
if(session.getAttribute("userID") != null)
{
	userID = (String) session.getAttribute("userID");	
} //만약 세션이 있다면 null인 변수 값에 집어 넣어서 확인을 목적으로 사용.

if(userID != null)
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('이미 로그인이 되어있습니다.')");
	 script.println("location.href = 'main.jsp'");
	 script.println("</script>");
} 

     session.setAttribute("userID",user.getUserID());
	 UserDAO userDAO = new UserDAO();
	 int result = userDAO.join(user);
	 if(result == -1){
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('이미 존재하는 아이디 입니다.')");
		 script.println("history.back()");
		 script.println("</script>");
	 } //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
	 else {
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('회원가입이 정상 처리되었습니다.')");
		 script.println("location.href = 'main.jsp'");
		 script.println("</script>");
	 }
 



%>

	
</body>
</html>