<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="user.UserDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID"/>
 <jsp:setProperty name="user" property="userPassword"/>
 
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

UserDAO userDAO = new UserDAO();
int result = userDAO.login(user.getUserID(), user.getUserPassword());
if(result ==1){
	
 session.setAttribute("userID",user.getUserID());
 PrintWriter script = response.getWriter();
 script.println("<script>");
 script.println("location.href = 'main.jsp'");
 script.println("</script>");  
}
if(result ==0){
 PrintWriter script = response.getWriter();
 script.println("<script>");
 script.println("alert('비밀번호가 틀립니다')");
 script.println("history.back()"); //이전 페이지로 돌려보냄
 script.println("</script>");  
}
if(result == -1){
 PrintWriter script = response.getWriter();
 script.println("<script>");
 script.println("alert('존재하지 않는 아이디 입니다.')");
 script.println("history.back()");
 script.println("</script>");  
}

if(result == -2){
 PrintWriter script = response.getWriter();
 script.println("<script>");
 script.println("alert('데이터 베이스 오류가 발생하였습니다. ')");
 script.println("history.back()");
 script.println("</script>");  
}

%>

	
</body>
</html>