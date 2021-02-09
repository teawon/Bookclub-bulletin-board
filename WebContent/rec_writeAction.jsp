<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="rec_bbs.rec_bbsDAO" %> 
  <%@page import="rec_bbs.rec_bbsDTO" %> 
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
  <% request.setCharacterEncoding("UTF-8");  %>
 

 
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

if(userID == null)
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('회원만 등록할 수 있습니다.')");
	 script.println("location.href = 'main.jsp'");
	 script.println("</script>");
} 


String rec_bookName = null;
String rec_author = null;
String rec_content = null;
String rec_score = null;
String rec_type = null;
	


     if(request.getParameter("rec_bookName") != null) {
    	 rec_bookName=request.getParameter("rec_bookName");
     }
     
     if(request.getParameter("rec_author") != null) {
    	 rec_author=request.getParameter("rec_author");
     }
     
     if(request.getParameter("rec_content") != null) {
    	 rec_content=request.getParameter("rec_content");
     }
     
     if(request.getParameter("rec_score") != null) {
    	 rec_score=request.getParameter("rec_score");
     }
     
     if(request.getParameter("rec_type") != null) {
    	 rec_type=request.getParameter("rec_type");
     }
     
    	 
     
	 rec_bbsDAO bbs = new rec_bbsDAO();
	 int result = bbs.write_rec(userID, rec_bookName, rec_author, rec_content, rec_score, rec_type);
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
		 script.println("alert('등록완료')");
		 script.println("location.href = 'bbs_rec.jsp'");
		 script.println("</script>");
	 }
 



%>

	
</body>
</html>