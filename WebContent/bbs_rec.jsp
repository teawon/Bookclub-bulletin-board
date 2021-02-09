<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="rec_bbs.rec_bbsDAO" %>
<%@ page import="rec_bbs.rec_bbsDTO" %>



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
    
    .starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}


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
		 			<li><a href="bbs_free.jsp">자유게시판</a></li>
		 			
		 			<li class="active"><a href="bbs_rec.jsp">책 소개</a></li>
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
		 			
		 			<li class="active"><a href="bbs_rec.jsp">책 소개</a></li>
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
 

  <section class="container">
  	<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
  	<br>
  	
  	<%
  		rec_bbsDAO rec= new rec_bbsDAO();
		ArrayList<rec_bbsDTO> list = rec.getList(pageNumber);
		for(int i = 0; i < list.size(); i++) {
			  	if(i==5) break;
			  	
  	%>
  	 <div class="panel panel-info"> 
		  	<div class="panel-heading">
		  		<div class="row">
		  			<div class="col-xs-8 text-left panel-title" ><%=list.get(i).getRec_bookName() %>&nbsp;<small><%=list.get(i).getRec_author() %></small></div>
		  			<div class="col-xs-4 text-right">(<%=list.get(i).getRec_type() %>)</div>
		  		</div>
		  	</div>
	  		<div class="panel-body">
		    	
		    	<p class="panel-text"> <%=list.get(i).getRec_content() %></p>
			</div>
		     <div class="panel-footer">
		     	<div class="row">
		     		<div class="col-xs-8 text-left">
		     			<span>평가 : (<%=list.get(i).getRec_score() %>/10)</span> <span style="color:green">(추천 :<%=list.get(i).getRec_likeCount() %>)</span>
		     		</div>
		     	
	                <div class="col-xs-4 text-right">
	   					<a onclick="return confirm('추천하시겠습니까?')" href="./rec_likeAction.jsp?rec_bbsID=<%=list.get(i).getRec_bbsID() %>">추천</a>
	   					<a onclick="return confirm('삭제하시겠습니까?')" href="./rec_deleteAction.jsp?rec_bbsID=<%=list.get(i).getRec_bbsID() %>">삭제</a>
					</div>
	              
	   			</div>
	        </div>
	    </div>
	   
	<%   
 	}
 	%>
 
  </section>
  <ul class="pager">
  	<li class="page-item">
  <% 
  	if(pageNumber <= 1) {
  %>	
  		<a class="page-link disabled">이전</a>
  <% 
  	} else {
  %>
   <a class="page-link" href="./bbs_rec.jsp?pageNumber=<%=pageNumber -1 %>">이전</a>
  <% 
   }
  %>
  </li>
  <li class="page-item">
  <% 
  	if(list.size() <6 ) {
  %>	
  		<a class="page-link disabled">다음</a>
  <% 
  	} else {
  %>
   <a class="page-link" href="./bbs_rec.jsp?pageNumber=<%=pageNumber +1 %>">다음</a>
  <% 
   }
  %>
  
  </li>
  </ul>
   
 <div class="panel">
  <div class="panel-body">
    
  </div>
</div>

  
  <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true"> <!-- tabindex는 레이아웃 느낌 , modal은 새로 창 띄우는거 -->
   	<div class="modal-dialog"> <!-- 전반적으로 모달 창 임을 알려줌. -->
   		<div class="modal-content"> <!-- 모달 내용이 들어감 -->
   			<div class="modal-header"> <!-- 모달 내용의 맨 윗부분 -->
	   			<h5 class="modal-title" id="modal">책 등록</h5>
	   			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	   				<span aria-hidden="true">&times;</span> <!-- x기호 -->
	   			</button>
	   		</div>
	   		<div class="modal-body">
		   			<form action="./rec_writeAction.jsp" method="post">
		   				<div class="form-row"> <!-- 한개의 행은 12열인데 6과 6으로 나눔 -->
		   					<div class="form-group col-sm-6">
			   					<label>책 제목</label>
			   					<input type="text" name="rec_bookName" class="form-control" maxlength="20" required>
		   					</div>	   					
		   				    <div class="form-group col-sm-3">
			   					<label>저자</label>
			   					<input type="text" name="rec_author" class="form-control" maxlength="10" required>
		   				   </div>
		   				   <div class="form-group col-sm-3">
			   					<label>장르</label>
			   					<select name="rec_type" class="form-control">
			   						<option value="--">--</option>
			   						<option value="수필">수필</option>
			   						<option value="소설">소설</option>
			   						<option value="과학">과학</option>
			   						<option value="심리학">심리학</option>
			   						<option value="경제/사회">경제/사회</option>
			   						<option value="자기개발">자기개발</option>
			   					</select>
		   				   </div>
		   		        </div>
		   		        <div class="form-group">
		   		        	<label>책 소개 및 추천 내용</label>
		   		        	<textarea name="rec_content" class="form-control" maxlength="2048" style="height:180px" required></textarea>
		   		        </div>
		   		        <div class="form-group">
		   		        	<label>총평</label>
			   				<div class="starRev">
								  <span class="starR on">1</span>
								  <span class="starR">2</span>
								  <span class="starR">3</span>
								  <span class="starR">4</span>
								  <span class="starR">5</span>
								  <span class="starR">6</span>
								  <span class="starR">7</span>
								  <span class="starR">8</span>
								  <span class="starR">9</span>
								  <span class="starR">10</span>
							</div> 
							     
							<input id="score" type="hidden" name="rec_score" value="1">
			   					
		   		        </div>
		   		        <div class="modal-footer">
		   		        	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		   		        	<button type="submit" class="btn btn-primary" >등록하기</button>
		   		        </div>
		   			</form>
		   			
	   		</div>
	   	</div>
   	</div>
  </div>
  
  <script>
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		 
		  $('#score').attr("value",$(this).text());
		  return false;
		});
</script>

</body>
</html>