<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="bbs.BbsDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <%@page import="rec_bbs.rec_bbsDAO" %>
 <%@page import="likey.LikeyDAO" %> 
<%!
	public static String getClientIP(HttpServletRequest request) {
	String ip = request.getHeader("X-FORWARDED-FOR");
	if (ip == null || ip.length() == 0) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0) {
		ip = request.getRemoteAddr();
	}
	return ip;
}
%>
  
 
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
		LikeyDAO likey = new LikeyDAO();
		int result = likey.like(userID, rec_bbsID, getClientIP(request));
		if(result == 1){
				result=rec.like(rec_bbsID);
				if(result ==1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('추천이 완료되었습니다.')");
					script.println("location.href = 'bbs_rec.jsp'");
					script.println("</script>");
					script.close();
					return;
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제가 완료되었습니다.')");
					script.println("location.href = 'bbs_rec.jsp'");
					script.println("</script>");
				}
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('오류코드 : rec_like')");
				script.println("location.href = 'bbs_rec.jsp'");
				script.println("</script>");
			} //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
			 else {
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("alert('이미 추천하셨습니다.')");
				 script.println("location.href = 'bbs_rec.jsp'");
				 script.println("</script>");
			 }
	}
	
	



    
	
	
 



%>

	
</body>
</html>