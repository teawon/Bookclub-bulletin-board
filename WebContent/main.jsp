<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
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
    
    .stripes {
    background : url(img/main_image.png);
    background-attachment: fixed;
    background-position: center center;
    background-repeat: no-repeat;
    background-size: cover;
    min-height: 100vh;
}
	.navbar {
	margin:0;
	position: fixed;
	width:100%;
  top: 0;}
  
  .emty {
  margin:0;
  width:100%;
  height:50px;
  }
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
	 			<li class="active"><a href="main.jsp">메인</a></li>
	 			
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
		 			<li class="active"><a href="main.jsp">메인</a></li>
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
 
 <div class="emty">""</div>
 
<div class="jumbotron-fluid">
  
 
  <div class="jumbotron-fluid">
    <div class="container-fluid special stripes">
      <div class="container">
        <h1 class="jumbotron-heading text-white text-center">종이숲 홈페이지 입니다 <br><br></h1>
        <p class="lead text-white text-center mx-auto"> 독서 토론의 활동 내역 및 게시판을 둘러보세요.<br><br><br><br><br><br><br></p>
        <div class="row">
        	<div class="col-sm-4">
        		<p style="text-align: center"><a class="btn btn-info btn-pull" href="bbs_book.jsp" role="button" >토론 활동 내역</a></p>
        	</div>
        	<div class="col-sm-4">
        		<p style="text-align: center"><a class="btn btn-info btn-pull" href="bbs_free.jsp" role="button" >자유 게시판</a></p>
        	</div>
        	<div class="col-sm-4">
        		<p style="text-align: center"><a class="btn btn-info btn-pull" href="bbs_rec.jsp" role="button" >책 소개</a></p>
        	</div>
        </div>  
      </div>
    </div>
   </div>
  

 </div>



</body>
</html>