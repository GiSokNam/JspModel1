<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project/Board/deletePro.jsp</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
// String pass = request.getParameter("pass");

BoardDAO boardDAO = new BoardDAO();

BoardDTO boardDTO = boardDAO.getBoard(num);

if(boardDTO != null) {
// 	boardDAO.deleteBoard(num, pass); 
	boardDAO.deleteBoard(num);

	response.sendRedirect("board.jsp");
	
}
%>
</body>
</html>