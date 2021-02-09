<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="file.FileDAO" %>

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
} 
		
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

if(!userID.equals(bbs.getUserID()))
{
	 PrintWriter script = response.getWriter();
	 script.println("<script>");
	 script.println("alert('권한이 없습니다.')");
	 script.println("location.href = 'main.jsp'");
	 script.println("</script>");
}

%>
 <script src="http://code.jquery.com/jquery-3.4.1.js"></script>
 <script src="js/bootstrap.js"></script>


 <div class="container">
  	<div class="row">
  	<% if(bbs.getBbs_freeID() != 0)  { %>
  	
  	
  	
  	 <form method="post" action="updateAction.jsp?bbsID=<%=bbsID %>" enctype="multipart/form-data">
  
  	<% 
  	} else {
  	%>
  	<form method="post" action="updateAction_book.jsp?bbsID=<%=bbsID %>" enctype="multipart/form-data">
  	<% 
  	} 
  	%>	
  	<table id="insertTable" class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
  			<thead>
  				<tr>
  					<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 수정 양식</th>
  				</tr>
  			</thead>
  			<tbody>
  				<tr>
  					<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="30" value="<%=bbs.getBbsTitle() %>" required></td>
  				</tr>
  				<tr>
  					<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;" required><%=bbs.getBbsContent() %></textarea></td>
  				</tr>
  				
     		 	 <tr>
	  				  <td>
	  				  
	  				  	 
	  				  	<input type='file' name='filename1'>
	  				 
	  				 </td>
	  				
	      			  
     		 	 </tr>
  			</tbody>
  			
  		</table>
  		
		<input type="button" class="btn btn-success" value="파일 추가" onClick="addFile()" >
  		<input type="submit" style="margin:7px;" class="btn btn-primary pull-right" value="글수정">
  		<input type="button" style="margin:7px;" class="btn btn-primary pull-right" value="취소" onClick="history.go(-1)">
  	</form>
  	</div>
 </div>
  <script>
 var rowIndex = 1;
 function addFile(){
     if(rowIndex > (10)) return false;
     var oCurrentRow,oCurrentCell;
     var sAddingHtml;
     oCurrentRow = insertTable.insertRow();
     rowIndex = oCurrentRow.rowIndex;
     oCurrentCell = oCurrentRow.insertCell();
     rowIndex++;
     oCurrentCell.innerHTML = "<tr><td><input  TYPE=FILE NAME='filename" +rowIndex + "' ></td></tr>";
     form.rowCount.value = rowIndex;
     
     if(rowIndex == 6)
    	 {
    	 document.getElementById('insertTable').deleteRow(5);

    	
    	 }
 }



</script>
</body>	
</html>