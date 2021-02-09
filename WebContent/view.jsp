<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="file.FileDAO" %>
<%@page import="file.FileDTO" %>
<%@page import="java.util.ArrayList" %>
<%@page import="comment.CommentDAO" %>
<%@page import="comment.CommentDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>종이숲</title>
</head>


<style>
	.plus {
       
       margin-right:20px;
     	float: left;
  		height: 50px;
  		width: 120px;
        text-indent: -9999px;
        overflow: hidden;
        background: url(img/h1_img.png);
        background-size:cover;
    }
</style>


<body>
<% 

String userID = null;
if(session.getAttribute("userID") != null)
{
	userID = (String) session.getAttribute("userID");	
}
int bbsID=0;
if(request.getParameter("bbsID") !=null ) {
	bbsID = Integer.parseInt(request.getParameter("bbsID")); //문자열을 10진수 정수로 변환
} //Get방식의 방법입니다. 주소뒤에 ? 를 붙인뒤 변수명=변수값 을 같이 써주면 그 정보가 해당 주소에 실려 가게 되므로 form 으로 정보를 넣는 것 처럼 숫자가 전달.
		
if(bbsID == 0)
{
	PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('유효하지 않은 접근 입니다.')");
	 script.println("location.href = 'main.jsp'");
	 script.println("</script>");
}
Bbs bbs = new BbsDAO().getBbs(bbsID);

if(bbs.getBbsAvailable() == 0)
{
	PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('이미 삭제된 게시판 입니다.')");
	 script.println("location.href = 'main.jsp'");
	 script.println("</script>");
}
%>
 <script src="http://code.jquery.com/jquery-3.4.1.js"></script>
 <script src="js/bootstrap.js"></script>
  <nav class="navbar navbar-default">
 	<div class="navbar-header">
 		<button type="button" class="navbar-toggle collapsed"
	 		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
	 		aria-expanded="false">
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
	 		<span class="icon-bar"></span>
 		</button>
 		<a class="plus" href="main.jsp">종이숲</a> <!-- .navbar-brand클래스 임의 변경 -> plus -->
 	</div>
 	
 	<% 
 	if(userID == null) {
 	%>
	 	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 		<ul class="nav navbar-nav">
	 			<li><a href="main.jsp">메인</a></li>
	 			
		 			<li><a href="bbs_book.jsp">독서토론 활동 내역</a></li>
		 			<li><a href="bbs_free.jsp">자유게시판</a></li>
		 			
		 			<li><a href="bbs_rec.jsp">책 소개</a></li>
	 		</ul>
	 		<ul class="nav navbar-nav navbar-right">
	 			<li class="dropdown">
	 			 <a href="#" class="dropdown-toggle"
	 			 	data-toggle="dropdown" role="button" aria-haspopup="true"
	 			 	aria-expanded="false">접속하기<span class="caret"></span></a>
	 			 	<ul class="dropdown-menu">
	 			 		<li><a href="login.jsp">로그인</a></li>
	 			 		<li><a href="join.jsp">회원가입</a></li>
	 			 	</ul>
	 			</li>
	 		</ul>
	 	</div>
 	<% 
 	} else {
 	%>
	 		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		 		<ul class="nav navbar-nav">
		 			<li><a href="main.jsp">메인</a></li>
		 			<li><a href="bbs_book.jsp">독서토론 활동 내역</a></li>
		 			<li><a href="bbs_free.jsp">자유게시판</a></li>
		 			
		 			<li><a href="bbs_rec.jsp">책 소개</a></li>
		 		</ul>
		 		<ul class="nav navbar-nav navbar-right">
		 			<li class="dropdown">
		 			 <a href="#" class="dropdown-toggle"
		 			 	data-toggle="dropdown" role="button" aria-haspopup="true"
		 			 	aria-expanded="false">회원관리<span class="caret"></span></a>
		 			 	<ul class="dropdown-menu">
		 			 		<li>  회원정보(미구현)</li>
		 			 		<li><a href="logoutAction.jsp">로그아웃</a></li>
		 			 	</ul>
		 			</li>
		 		</ul>
	 		</div>
 	<%
 	}
 	%>
 	
 </nav>

  <div class="container">
  	<div class="row">
  	
  		<table class="table" style="text-align: center; border: 1px solid #dddddd">
  			<thead>
  				<tr>
  					<th  rowspan="2" style=" text-align: center; font-size:40px;"><%= bbs.getBbsTitle()  %>
	  					<br> 
	  					<div class="row">
		  					 <div class="col-sm-6 text-left" style="font-size:20px;">
			  					 작성자 : <%= bbs.getUserID()  %> | <%= bbs.getBbsDate()  %>
			  				 </div>
		  				
		  					 <div class="col-sm-6 text-right" style="font-size:20px;" >
		  				        조회수 : <%=bbs.getSeeCount() %>
		  					 </div>
  				   	   	</div>
  				   	</th>
  				     
  				</tr>
  				</thead>
  				<% 
  
  			FileDAO fileDAO = new FileDAO();
  			ArrayList<FileDTO> list = fileDAO.getFiles(bbsID);
  			
  			for(int i = 0; i < list.size(); i++) {
  			%>
  	
           <tr>  
           <td style="text-align:left;"> <a href="downloadAction?file=<%=list.get(i).getFileRealName()%>"><%=list.get(i).getFileName()%>(<%=list.get(i).getDownloadCount() %>)</a></td>
  		  </tr>
  			
  				
  			<% 
  			}
  		    %>
  		    
  			<tbody>
  				
  				<tr>
  					<td style="height:500px; font-size:30px; text-align: left;"><%= bbs.getBbsContent() %></td>
  				</tr>
  			</tbody>
  			
  		</table>
  		
  		<div class="container" style="font-size:30px;">댓글 :<%=bbs.getCommentCount() %>개</div>
  		
  		<div class="container" style="border-top:2px solid #dddddd;">
	  	
	  		<% 
	  		CommentDAO commentDAO = new CommentDAO();
	  		ArrayList<CommentDTO> comList = commentDAO.getComments(bbsID); 
	  			
	  		  for(int o = 0; o<comList.size(); o++) {
	  		%>
	  		<div class="row" style="border-bottom: 1px solid #dddddd; font-size:30px;">
	  			<div class="col-sm-2">
	  			<%=comList.get(o).getUserID() %>
	  			</div>
	  			<div class="col-sm-7">
	  			<%=comList.get(o).getContent() %>
	  			</div>
	  			<div class="col-sm-3">
	  			 <span><%=comList.get(o).getCommentDate().substring(2,10) %> <a href="commentDeleteAction.jsp?comID=<%= comList.get(o).getComID() %>&bbsID=<%=bbsID%>">
	  			 <span class="glyphicon glyphicon-remove" aria-hidden="true" style="font-size: 20px;"></span>
	  			 </a></span>
	  			</div>
	  			<!-- 댓글 삭제시 해당 게시글 번호 및 삭제할 댓글고유번호 2개를 인자값으로 보낸다. -->
	  		</div>
	  		<% 
	  		}
	  		%>
	  		
	  		</div>
	  		<form action="./commentAction.jsp?bbsID=<%=bbsID %>" method="post">
		  		<div class="form-group" style="margin-top:20px;">
				   	<textarea name="content" class="form-control" maxlength="2048" style="height:60px" required></textarea>
				   	<input type="submit" class="btn btn-light pull-right" value="댓글 입력">
			    </div>
	  		</form>
  		</div>
  		
  		
  		
  		
  	    <%	int temp = new BbsDAO().seeCountAdd(bbsID);%>
  	    <input type="button" class="btn btn-primary" value="목록" onClick="history.go(-1)"> 
  	     
  	    <% if(userID != null && userID.equals(bbs.getUserID())) 
  	    { 
  	     %>
  	        <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
  	    	<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
  	    	
  	    <%
  	    }
  	    %>
  	</div>
 </div>
 
</body>	
</html>