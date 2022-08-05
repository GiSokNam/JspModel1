<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/insertPro.jsp</title>
</head>
<body>
<%
// 회원가입 시 한글이 사용되므로 한글 사용시 글자 깨짐을 방지하기위해
// post request 한글처리
request.setCharacterEncoding("utf-8");

// request id pass name 파라미터 값 가져오기 => 변수 저장
// 파라미터 값을 가져오기 위한 코드 : request.getParameter("input태그의 name값을 입력");
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");

// JDBC를 사용하여 DB에 접근하는 일반적인 순서
// 1. Driver 클래스 로드
// 2. DB 연결을 위한 Connection 객체 생성
// 3. SQL을 담는 Statement 또는 PreparedStatement 객체 생성
// 4. SQL 실행
// 5. 리소스 정리

// JspModel1의 경우
// JDBC Driver 로드와 JDBC 프로그램 이용해서 DB서버에 접속 및 연결정보 저장
// => META-INF의 context.xml 파일에서 처리한다.
// 또한, DB연결을 위한 Connection 객체 생성
//		SQL을 담는 Statement 또는 PreparedStatement 객체 생성
//		SQL 실행
//		리소스 정리
// 등 DB작업을 java파일(자바의 메서드 형태)로 분리하는 방식 

// 자바파일 : 데이터를 담아서 전달
// 패키지 member 파일이름 MemberDTO
// 멤버변수 정의, 멤버변수 접근 메서드 정의
// 객체생성 => 기억장소 할당
MemberDTO memberDTO = new MemberDTO();
// 멤버변수에 값을 저장하는 메서드 호출
memberDTO.setId(id);
memberDTO.setPass(pass);
memberDTO.setName(name);

// 자바파일 메서드정의(DB) 메서드 호출
// 패키지 member 파일이름 MemberDAO
// insertMember() 메서드 정의 

// MemberDAO 객체생성
// 객체생성 => 클래스 기억장소 할당
MemberDAO memberDAO = new MemberDAO();

// 메서드 호출
// memberDAO.insertMember(id,pass,name);
memberDAO.insertMember(memberDTO);

%>
<script type="text/javascript">
	alert("회원가입 성공");
	location.href="loginForm.jsp";
</script>
<body>
</html>





