<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project/Board/content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO boardDAO = new BoardDAO();
boardDAO.updateReadcount(num);
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
 <article>
  <h1>Board Content</h1>
   <table id="notice">
	<tr>
	 <th>글번호</th>
	 <td><%=boardDTO.getNum() %></td>
     <th>등록일</th>
     <td><%=boardDTO.getDate() %></td>
    </tr>
    <tr>
	 <th>글쓴이</th>
	 <td><%=boardDTO.getName() %></td>
     <th>조회수</th>
     <td><%=boardDTO.getReadcount() %></td>
    </tr>
    <tr>
     <th>제목</th>
     <td colspan="3"><%=boardDTO.getSubject() %></td>
    </tr>
    <tr>
     <th>내용</th>
     <td colspan="3"><%=boardDTO.getContent() %></td>
    </tr>
    <tr>
     <td colspan="4">
      <div id="table_btn">
		<input type="button" value="목록으로" class="btn" onclick="location.href='board.jsp'" style="float: right;">
		<%
		String id = (String)session.getAttribute("id");

		if(id!=null){
			if(id.equals(boardDTO.getName())){
		%>
		<input type="button" value="삭제하기" class="btn" style="float: right;" 
       	onclick="location.href='delete.jsp?num=<%=boardDTO.getNum()%>'">
       	<input type="button" value="수정하기" class="btn" style="float: right;" 
       	onclick="location.href='update.jsp?num=<%=boardDTO.getNum()%>'">
		<%
			}
		}
		%> 
	  </div>
     </td>
    </tr>
  </table>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->
<!-- 푸터틀어가는 곳 -->
<!-- 푸터들어가는 곳 -->
</div>

</body>
</html>