<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="bbs.BbsDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <% request.setCharacterEncoding("UTF-8");  %> <!-- 건너오는 데이터의 형식 지정 -->
 <%@page import="file.FileDAO" %>
  <%@page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.util.Enumeration"%>

 
 
  

 
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
	BbsDAO bbsDAO = new BbsDAO();
	
	String directory = request.getSession().getServletContext().getRealPath("upload");
	int maxSize= 1024 * 1024 * 100;
	String encoding = "UTF-8";
  
MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());


		int result = bbsDAO.update(bbsID,multipartRequest.getParameter("bbsTitle"),multipartRequest.getParameter("bbsContent"));
		
		if(result == -1){
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('수정에 실패했습니다.')");
			 script.println("history.go(-3)");
			 script.println("</script>");
		} //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
		else {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("history.go(-3)");
			 script.println("</script>");
		}
	Enumeration fileNames = multipartRequest.getFileNames();
	
	int delete_file = 0;
	while(fileNames.hasMoreElements()) {
		
		  
		  String parameter = (String) fileNames.nextElement(); //각각의 파일들을 parameter안에 넣는다.
		 
		  
		  
		  String fileName=multipartRequest.getOriginalFileName(parameter);
		  String fileRealName=multipartRequest.getFilesystemName(parameter);
		  
		  if(fileName == null) continue;
		  if(delete_file == 0) {delete_file=new FileDAO().delete(bbsID);} //만약 1개라도 파일이 있다면 다 삭제.
		  new FileDAO().upload(fileName,fileRealName,bbsID);
		  
		
		  
	  }
	
}
    






	
 



%>

	
</body>
</html>