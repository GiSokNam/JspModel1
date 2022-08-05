<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project/board/update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%

String id = (String)session.getAttribute("id");

if(id == null){
	response.sendRedirect("../inc/login.jsp");
}

int num = Integer.parseInt(request.getParameter("num"));
BoardDAO boardDAO = new BoardDAO();

BoardDTO boardDTO = boardDAO.getBoard(num);
%>
 <div id="wrap">
<!-- 헤더들어가는 곳 -->
<!-- 헤더들어가는 곳 -->
<!-- 본문들어가는 곳 -->
<!-- 본문 메인 이미지 -->
 <div ></div>
<!-- 본문 메인 이미지 -->
<!-- 왼쪽메뉴 -->
 <nav></nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
 <form action="updatePro.jsp" id="board" method="post">
 <input type="hidden" name="num" value="<%=boardDTO.getNum()%>">
<!--  <input type="hidden" name="pass" value="1234"> -->
 <h1>Board Update</h1>
  <table>
   <tr>
	<th>글쓴이</th>
	<td><input type="text" name="name" value="<%=id %>" readonly></td>
	</tr>
    <tr>
     <th>제목</th>
     <td><input type="text" name="subject" value="<%=boardDTO.getSubject()%>"></td>
    </tr>
    <tr>
     <th>내용</th>
     <td><textarea rows="30" cols="50" name="content"><%=boardDTO.getContent()%></textarea></td>
    </tr>
    <tr>
     <td colspan="2">
      <div id="table_btn">
       <input type="button" value="목록으로"  class="btn" onclick="location.href='board.jsp'" style="float: right;">
       <input type="submit" value="수정하기" class="btn" style="float: right;">
      </div>
     </td>
    </tr>
 </table>
</form>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->
<!-- 푸터틀어가는 곳 -->
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>