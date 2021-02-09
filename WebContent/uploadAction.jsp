<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="file.FileDAO" %> <!-- 방금 만든 클래스를 가져옴 -->
 <%@page import="java.io.File" %>
  
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
 <%@page import="java.io.PrintWriter" %> <!-- 자바 스크립트 문장의 작성을 위해 사용-->
 <%@page import="java.util.Enumeration"%>

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
  //String directory = request.getSession().getServletContext().getRealPath("file");
String directory = getServletContext().getRealPath("file");

//request.getServletContext().getRealPath("upload");//application.getRealPath("/upload/"); //최상위 기본 클래스의 메서드 이용
  int maxSize= 1024 * 1024 * 100;
  String encoding = "UTF-8";
  
  MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
 // MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
  Enumeration fileNames = multipartRequest.getFileNames();
  
	
	while(fileNames.hasMoreElements()) {
		  String parameter = (String) fileNames.nextElement(); //각각의 파일들을 parameter안에 넣는다.
		 
		  
		  
		  String fileName=multipartRequest.getOriginalFileName(parameter);
		  String fileRealName=multipartRequest.getFilesystemName(parameter);
		  
		  if(fileName == null) continue;
		  
		  out.write("파일명:" + fileName + "<br>");
		  out.write("실제 파일명:" + fileRealName + "<br>");
		  
		
		  
	  }
	
  
  
%>

	
</body>
</html>