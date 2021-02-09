<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="comment.CommentDAO" %> 
  <%@page import="comment.CommentDTO" %> 
  <%@page import="bbs.Bbs" %> 
  <%@page import="bbs.BbsDAO" %> 
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
  <% request.setCharacterEncoding("UTF-8");  %>
 

 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>종이숲</title>
</head>

<body>
	
<%

String userID = null;
if(session.getAttribute("userID") != null)
{
	userID = (String) session.getAttribute("userID");	
} //만약 세션이 있다면 null인 변수 값에 집어 넣어서 확인을 목적으로 사용.

int bbsID=0;
if(request.getParameter("bbsID") !=null ) {
	bbsID = Integer.parseInt(request.getParameter("bbsID")); //문자열을 10진수 정수로 변환
} 

if(userID == null)
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('로그인을 하세요.')");
	 script.println("location.href = 'login.jsp'");
	 script.println("</script>");
} 

else {


String content = null;



     if(request.getParameter("content") != null) {
    	 content=request.getParameter("content");
     }
     
    
     
	CommentDAO comet = new CommentDAO();
	 int result = comet.upload(bbsID, userID, content);
	 if(result == -1){
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('오류가 발생하였습니다 . CODE:comment_upload')");
		 script.println("history.back()");
		 script.println("</script>");
	 } //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
	 else {
			 int result1 = new BbsDAO().commentCountAdd(bbsID);
			 if(result1==-1)
			 {
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("alert('오류가 발생하였습니다 . CODE-commendAdd')");
				 script.println("history.back()");
				 script.println("</script>");
			 }
			 else{
			 PrintWriter script = response.getWriter();
		
		
			String str= "<script> location.href = 'view.jsp?bbsID=";
		    str+= bbsID;
			str+= " ' </script> ";
			//script.println("<script>");
			//script.println("location.href = 'view.jsp?bbsID=1'");
			//script.println("</script>");  옛날 그냥 전 페이지로 로드 하는데 새로고침 안되서 history를 직접 게시글 번호 받고 이동하게 바꿈
			script.println(str);
		 }
 

}
}
%>

	
</body>
</html>