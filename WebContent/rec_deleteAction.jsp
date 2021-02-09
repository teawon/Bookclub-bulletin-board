<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="bbs.BbsDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <%@page import="rec_bbs.rec_bbsDAO" %>
 <%@page import="likey.LikeyDAO" %> 

  
 
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

int rec_bbsID=0;

if (request.getParameter("rec_bbsID")!=null) { rec_bbsID=Integer.parseInt(request.getParameter("rec_bbsID")); }

if(userID == null)
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('로그인을 하세요.')");
	 script.println("location.href = 'login.jsp'");
	 script.println("</script>");
} 
else {
	
	rec_bbsDAO rec = new rec_bbsDAO();
	if(userID.equals(rec.getUserID(rec_bbsID)))  //문자열 비교는 equls! 
	{
		int result = rec.delete(rec_bbsID);
		 if(result == 1){
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('삭제가 완료되었습니다.')");
			 script.println("location.href = 'bbs_rec.jsp'");
			 script.println("</script>");
		 } //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
		 else {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('문제가 발생하였습니다. 오류코드 : rec_del1')");
			 script.println("location.href = 'bbs_rec.jsp'");
			 script.println("</script>");
		 }
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('자신이 쓴 글만 삭제가 가능합니다.')");
		script.println("location.href = 'bbs_rec.jsp'");
		script.println("</script>");
	}
	
}


    
	
	
 



%>

	
</body>
</html>