<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/bootstrap.min.css">

<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<script>
	//location.href='main.jsp'; 1.파일 업로드 부분 디자인 , view보이는거 디자인 , 수정
	</script>
	<script src="./js/jquery.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/pooper.js"></script>
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
		파일 : <input type="file" name="file"><br>
		<input type="submit" value="업로드">
	</form>
	<div class="card">
  <div class="card-header">Header</div>
  <div class="card-body">Content</div>
  <div class="card-footer">Footer</div>
  
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
 	if(1 == 1) {
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
</div>
</body>
</html>