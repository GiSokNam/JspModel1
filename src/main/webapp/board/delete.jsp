<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project/notice/delete.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
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
 <script type="text/javascript">
	function fun1() {
		history.back();
	}
</script>
<form action="deletePro.jsp" id="board" method="post">
<input type="hidden" name="num" value="<%=num%>">
<h1>Content Delete</h1>
 <table>
<!-- 	<tr> -->
<!--      <th>Pass</th> -->
<!--      <td><input type="password" name="pass"></td> -->
<!--     </tr> -->
  <tr>
   <th colspan="2">글 삭제 or 취소?</th>
  </tr>
  <tr>
   <td colspan="2">
    <div id="table_btn">
     <input type="submit" value="삭제" class="btn" style="float: right;">
     <input type="button" value="취소" class="btn" style="float: right;" onclick="fun1()">
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