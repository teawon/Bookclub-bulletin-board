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

<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.RenderingHints"%>


<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.IOException"%>


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


		int result = bbsDAO.write_book(multipartRequest.getParameter("bbsTitle"), userID, multipartRequest.getParameter("bbsContent"));
		
		if(result == -1){
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('글쓰기에 실패했습니다.')");
			 script.println("history.back()");
			 script.println("</script>");
		} //-1이 반환되었다는 것은 PRIMARY KEY인 userID가 중복되었을 때.
		else {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("location.href = 'bbs_book.jsp'");
			 script.println("</script>");
		}
	Enumeration fileNames = multipartRequest.getFileNames();
	int ck=0;
	while(fileNames.hasMoreElements()) {
		  String parameter = (String) fileNames.nextElement(); //각각의 파일들을 parameter안에 넣는다.
		  
		    
			  String fileName=multipartRequest.getOriginalFileName(parameter);
			  String fileRealName=multipartRequest.getFilesystemName(parameter);
			  if(fileName == null) continue;
			  
			  
			  
		  if(fileName.contains("png") && ck==0)
		  {   
			 BufferedImage bi = ImageIO.read(new File(directory+"/"+fileRealName));
			 int width=240;
			 int height=400;
			 
			 BufferedImage thumbnail = new BufferedImage (width,height,BufferedImage.TYPE_INT_RGB);
			 Graphics2D g2= thumbnail.createGraphics();
			 g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
			 g2.drawImage(bi,0,0,width,height,null);
			 g2.dispose();
					 
			 ImageIO.write(thumbnail, "gif", new File(directory+"/"+"thumnail"+bbsDAO.getbbs_bookID()+".gif"));
			
			 
			 ck=1;
			File temp = new File(directory+"/"+fileRealName);
			temp.delete();
			
		
		  }
		   if(ck==1) continue;
		   new FileDAO().upload(fileName,fileRealName,bbsDAO.getbbsID());
		  
		  //png파일만됨..이유는 모름 ㅠ

		
		  
	  }
	
	  if(ck==0)
	  {
		  
		  
		  String oriFilePath =  "img/noimg.gif";
	        //복사될 파일경로
	       String copyFilePath = directory+"/"+directory+"/"+"thumnail"+bbsDAO.getbbs_bookID()+".gif";
	        //파일객체생성
	       File oriFile = new File(oriFilePath);
	        //복사파일객체생성
	       File copyFile = new File(copyFilePath);
	        
	        try {
	            
	            FileInputStream fis = new FileInputStream(oriFile); //읽을파일
	            FileOutputStream fos = new FileOutputStream(copyFile); //복사할파일
	            
	            int fileByte = 0; 
	            // fis.read()가 -1 이면 파일을 다 읽은것
	            while((fileByte = fis.read()) != -1) {
	                fos.write(fileByte);
	            }
	            //자원사용종료
	            fis.close();
	            fos.close();
	            
	        } catch (FileNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	  }
	
}
    






	
 



%>

	
</body>
</html>