<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>로그인</title>
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
	 			 		<li class="active"><a href="login.jsp">로그인</a></li>
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
 	<div class="col-lg-4"></div>
 	<div class="col-lg-4">
 		<div class="jumbotron" style="padding-top:20px;">
 			<form method="post" action="LoginAction.jsp">
 				<h3 style="text-align:center;">로그인화면</h3> 
 				<div class="form-gruop">
 					<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
 					
 				</div>
 				<div class="form-gruop">
 					<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
 				</div>
 				<input type="submit" class="btn btn-primary form-control" value="로그인">
 			</form>
 			
 	</div>
 </div>
 </div>
 
 
</body>
</html>