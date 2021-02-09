<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@page import="file.FileDAO" %>
<%@page import="file.FileDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="./css/bootstrap.css">
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
int pageNumber=1;

if(request.getParameter("pageNumber") != null)
{
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
		 			<li class="active"><a href="bbs_free.jsp">자유게시판</a></li>
		 			
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
		 			<li class="active"><a href="bbs_free.jsp">자유게시판</a></li>
		 			
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
  		<table class="table table-striped" style="text-align: center; font-size:25px; border: 1px solid #dddddd">
  			<thead>
  				<tr>
  					<th style="background-color: #eeeeee; text-align: center;">번호</th>
  					<th style="background-color: #eeeeee; text-align: center;">제목</th>
  					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
  					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
  					<th style="background-color: #eeeeee; text-align: center;">조회수</th>
  				</tr>
  			</thead>
  			<tbody>
  			<% 
  			Date nowTime = new Date();
  			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd"); //현재의 년도와 날짜를 가져온다. if문으로 비교하여 같으면 분만 표기.
  		
  			BbsDAO bbsDAO = new BbsDAO();
  			ArrayList<Bbs> list = bbsDAO.getList_free(pageNumber);
  			
  			for(int i = 0; i < list.size(); i++) {
  				if(i==11) break;
  			%>
  			
  				<tr> 
  				    
  					<td><%= list.get(i).getBbs_freeID() %></td>
  					<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
  					<td><%= list.get(i).getUserID() %></td>
  					
  					<% 
  					if(sf.format(nowTime).equals((list.get(i).getBbsDate().substring(0,4) + list.get(i).getBbsDate().substring(5,7) + list.get(i).getBbsDate().substring(8,10))))
  					{
  					%> 
  					
  					 <td><%= list.get(i).getBbsDate().substring(11,16) %> </td>
  					 
  					
  					
  					
  					<%
  					}else { 
  					
  					%>
  					<td> <%= list.get(i).getBbsDate().substring(0,4) + "-" +list.get(i).getBbsDate().substring(5,7) + "-" +list.get(i).getBbsDate().substring(8,10) %> </td>
  					<% 
  					}
  					%>
  					
  					
  				<td><%= list.get(i).getSeeCount() %></td>	
  				</tr>
  			
  			
  			<%
  			}
  			%>
  				
  			</tbody>
  		</table>
  		<ul class="pager">
  	<li class="page-item">
  <% 
  	if(pageNumber <= 1) {
  %>	
  		<a class="page-link disabled">이전</a>
  <% 
  	} else {
  %>
   <a class="page-link" href="./bbs_free.jsp?pageNumber=<%=pageNumber -1 %>">이전</a>
  <% 
   }
  %>
  </li>
  <li class="page-item">
  <% 
  	if(list.size() <11 ) {
  %>	
  		<a class="page-link disabled">다음</a>
  <% 
  	} else {
  %>
   <a class="page-link" href="./bbs_free.jsp?pageNumber=<%=pageNumber +1 %>">다음</a>
  <% 
   }
  %>
  
  </li>
 
 </ul>
  		<%if(userID!=null) {%><a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> <%} %>
  	</div>
 </div>
 
</body>
</html>