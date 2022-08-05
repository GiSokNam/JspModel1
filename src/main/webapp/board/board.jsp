<%@page import="board.BoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
BoardDAO boardDAO = new BoardDAO();
// 한페이지 보여줄(가져올) 글개수 설정
int pageSize = 10;
// 페이지 번호 가져오기
// http://localhost:8080/FunWeb/center/notice.jsp
// http://localhost:8080/FunWeb/center/notice.jsp?pageNum=2
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum = "1";
}
// 페이지 번호 => 정수형 변경
int currentPage = Integer.parseInt(pageNum);
// 시작하는 행부터 10개(Mysql 구문 -> limit 1, 10), 시작하는 행 ~ 끝행 (Oracle 11~20)
// pageNum(currentPage) pageSize   			=> 		  startRow  endRow
//    1                    10   (1-1)*10+1 	   0*10+1    1		  10
//    2                    10   (2-1)*10+1     1*10+1   11		  20
//    3                    10   (3-1)*10+1     2*10+1   21        30
int startRow = (currentPage-1)*pageSize+1;

// 끝나는 행
// startRow pageSize => 	   endRow
//     1        10   1+10-1      10
//     11       10   11+10-1     20
//     21       10   21+10-1     30
int endRow = startRow+pageSize-1;
// 시작하는 행부터 10개 (mysql limit 1,10)
//String sql = "select * from board order by desc limit 1,10";

List boardList = boardDAO.getBoardList(startRow, pageSize);
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
  <h1>커뮤니티</h1>
   <table id="notice">
    <tr>
     <th class="tno">번호</th>
     <th class="twrite">글쓴이</th>
     <th class="ttitle">제목</th>
     <th class="tdate">등록일</th>
     <th class="tread">조회</th>
    </tr>
    <%
 // 날짜 => 문자열 모양변경
 	 SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY.MM.dd");
 	  for(int i = 0; i < boardList.size(); i++) {
 		BoardDTO boardDTO = (BoardDTO)boardList.get(i);
 	    %> 
 	  	<tr>
  	     <td><%=boardDTO.getNum() %></td>
  	     <td><%=boardDTO.getName() %></td>
  	     <td class="left"><a href="content.jsp?num=<%=boardDTO.getNum() %>"> <%=boardDTO.getSubject() %></a></td>
  	     <td><%=dateFormat.format(boardDTO.getDate()) %></td>
  	     <td><%=boardDTO.getReadcount() %></td>
 	 	</tr>
 		<%
 	  }
    %>
   </table>
   <div>
    <form action="search.jsp" name="search" method="post">
     <div>
      <select name="searchField">
       <option value="0">선택</option>
       <option value="subject">제목</option>
       <option value="name">작성자</option>
      </select>
      <input type="text" name="searchText" placeholder="검색">
      <input type="submit" value="검색" class="btn">
     </div>
    </form>
   </div>
   <div id="table_btn">
    <%
    String id = (String)session.getAttribute("id");
    if(id != null) {
    	%>
    	<a href="write.jsp"><input type="button" value="글쓰기" class="btn"></a>
    	<%
    }
    %>
   </div>
   <br>
   <div id="page_control">
	 <%
	 // 한페이지에 보여줄 페이지 개수 설정
	 int pageBlock = 10;
	 // 시작하는 페이지 번호 구하기
	 // currentPage , pageBlock =>          				  startPage
	 //   1 ~ 10         10    (0~9)/10*10+1  =>(0)*10+1      1
	 //   11 ~ 20        10    (1~19)/10*10+1 =>(1)*10+1      11
	 //   21 ~ 30        10    (2~29)/10*10+1 =>(2)*10+1      21
	 int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
	 // 끝나는 페이지 번호 구하기
	 //  startPage , pageBlock =>          				  endPage
	 //     1            10                                   10
	 //     11           10                                   20
	 //     21           10                                   30
	 int endPage = startPage + pageBlock - 1;
	 // 전체 글 개수 count
	 int count = boardDAO.getBoardCount();
	 
	 // 전체페이지 개수 구하기
	 // int pageCount = 전체글개수 / 한화면에 보여줄 글개수
	 //						50/10 => 5페이지 + 0페이지
	 //						55/10 => 5페이지 + 1페이지
	 int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	 // 페이지가 10페이지 안될경우
	 if (endPage > pageCount) {
		 endPage = pageCount;
	 }
	 %>

	 <%
	 if (startPage > pageBlock) {
	 	%>
	 	<a href="board.jsp?pageNum=<%=startPage - pageBlock%>">이전</a>
	 	<%
	 }
	 for (int i = startPage; i <= endPage; i++) {
	 	%>
	 	<a href="board.jsp?pageNum=<%=i%>"><%=i%></a>
	 	<%
	 }

	 if (endPage < pageCount) {
		 %>
	 	<a href="board.jsp?pageNum=<%=startPage + pageBlock%>">다음</a>
	 	<%
	 }
	 %>
  </div>
 </article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->
<!-- 푸터틀어가는 곳 -->
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>