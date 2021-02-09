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

  <!--  <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
 <jsp:setProperty name="bbs" property="bbsTitle"/>
 <jsp:setProperty name="bbs" property="bbsContent"/>
   
  이걸로 받으면 안된다. 
  넘겨받은 값을 가져오기 위해서는 MultipartRequest 객체를 통해서 가져와야 한다.
   MultipartRequest 객체를 생성할 시 생성자의 인자로 request를 넘겨받았기 때문이다.
-->
 
  

 
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


		int result = bbsDAO.write_free(multipartRequest.getParameter("bbsTitle"), userID, multipartRequest.getParameter("bbsContent"));
		
		if(result == -1){
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('글쓰기에 실패했을까요.')");
			 script.println("history.back()");
			 script.println("</script>");
		} //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
		else {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("location.href = 'bbs_free.jsp'");
			 script.println("</script>");
		}
	Enumeration fileNames = multipartRequest.getFileNames();
	
	while(fileNames.hasMoreElements()) {
		  String parameter = (String) fileNames.nextElement(); //각각의 파일들을 parameter안에 넣는다.
		 
		  
		  
		  String fileName=multipartRequest.getOriginalFileName(parameter);
		  String fileRealName=multipartRequest.getFilesystemName(parameter);
		  
		  if(fileName == null) continue;
		  
		  new FileDAO().upload(fileName,fileRealName,bbsDAO.getbbsID());
		  
		
		  
	  }
	
}
    






	
 



%>

	
</body>
</html>