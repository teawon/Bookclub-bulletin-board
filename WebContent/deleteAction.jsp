<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="bbs.BbsDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
 <jsp:setProperty name="bbs" property="bbsTitle"/>
 <jsp:setProperty name="bbs" property="bbsContent"/>
  
 
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

int bbsID=0;
if (request.getParameter("bbsID")!=null) { bbsID=Integer.parseInt(request.getParameter("bbsID")); }
if(userID == null)
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('로그인을 하세요.')");
	 script.println("location.href = 'login.jsp'");
	 script.println("</script>");
} 
else {
	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.delete(bbsID);
			 if(result == -1){
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("alert('삭제에 실패했습니다.')");
				 script.println("history.back()");
				;
				 script.println("</script>");
			 } 
			 else {
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("history.go(-2)");
				 script.println("</script>");
			 }
}
    
	
	
 



%>

	
</body>
</html>