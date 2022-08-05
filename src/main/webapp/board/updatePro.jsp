<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project/board/updatePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

int num=Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
// String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

BoardDAO boardDAO = new BoardDAO();

BoardDTO boardDTO = boardDAO.getBoard(num);

if(boardDTO != null) {
	BoardDTO updateDTO = new BoardDTO();
	updateDTO.setSubject(subject);
	updateDTO.setContent(content);
	updateDTO.setNum(num);
// 	updateDTO.setPass(pass); 
	
	boardDAO.updateBoard(updateDTO);
	
	response.sendRedirect("board.jsp");

} 
%>
</body>
</html>