package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberDTO;

public class BoardDAO {
	// 클래스 => 멤버변수, 메서드
	// 주제 게시판관련 DB작업
	
	// DB연결 메서드
	public Connection getConnection() throws Exception{
		// throws Exception : 예외처리(에러처리) 메서드 호출한 곳에서 처리하겠다
		// 1단계 JDBC 프로그램 불러오기
		// Class.forName("com.mysql.cj.jdbc.Driver");

		// 2단계 JDBC 프로그램 이용해서 DB서버에 접속 => 연결정보 저장
		// DB서버에 접근할 DB주소
		// String dbUrl = "jdbc:mysql://localhost:3306/jspdb1?serverTimezone=UTC";
		// DB에 접근할 아이디
		// String dbId = "root";
		// DB에 접근할 비밀번호
		// String dbPass = "1234";
		// DB연결 정보를 Connection형 con변수에 저장
		// Connection con = DriverManager.getConnection(dbUrl, dbId, dbPass);
		// return con;
		
		// Data Base Connection Pool  => DBCP
		// 서버에서 미리 DB연결 => 이름정의 => 이름을 불러서 DB연결정보 사용
		// 1. DB연결 속도 향상, 2. DB연결코드 수정 최소화  장점
		// webapp - META-INF - context.xml (디비연결)
		// MemberDAO DB연결 이름을 불러서 사용
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}
	
	// 리턴할형 List   getBoardList() 메서드 정의
	public List getBoardList(int startRow,int pageSize) {
		
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1, 2 DB연결 메서드 호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// String sql = "select * from board";
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순 정렬
			// String sql = "select * from board order by num desc";
			// 시작하는 행부터 10개(Mysql  limit 시작행-1,몇개)
		    String sql = "select * from board order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();
			
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
			// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//첨부파일
				boardDTO.setFile(rs.getString("file"));
				
				//배열한칸에 글 정보 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardList;		
	}
	
	public List getBoardSearch(int startRow,int pageSize,String searchField,String searchText) {
		// 여러명을 저장할 변수 => 자바API 배열 변수
		List boardList=new ArrayList();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1, 2 DB연결 메서드 호출
			con=getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
//			String sql="select * from board";
			// 최근글이 위로 올라오게 정렬 num 기준값을 내림차순 정렬
//			String sql="select * from board order by num desc";
			//시작하는 행부터 10개(Mysql  limit 시작행-1,몇개)
		    String sql="select * from board where "+searchField+" like ? order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+searchText+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			//=> sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
			// rs.next() 결과에서 다음행 이동하고 데이터 있으면 true/없으면 false 
			// while(rs.next()){
				// 데이터 있으면 true => 열접근
			while(rs.next()) {
				BoardDTO boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//배열한칸에 글 정보 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardList;		
	}
	
//	BoardDTO boardDTO=boardDAO.getBoard(num);
	public BoardDTO getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO boardDTO = null;
		try {
			// 1, 2 DB연결 메서드 호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행결과 저장
			rs = pstmt.executeQuery();
			// 5단계 다음행 => 열접근=> boardDTO객체생성 set값을 저장
			if(rs.next()) {
				boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				//첨부파일
				boardDTO.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return boardDTO;
	}
	
	// 리턴값없음 insertBoard(BoardDTO boardDTO) 메서드 정의 
	public void insertBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 단계 DB연결 메서드 호출 
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			// 4단계 sql구문을 실행 (insert, update, delete)
			rs = pstmt.executeQuery();
			// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)  
			int num = 0;
			if(rs.next()) {
				num = rs.getInt("max(num)")+1;
			}
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			// 날짜 now()
			sql = "insert into board(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getName());
			pstmt.setString(3, boardDTO.getPass());
			pstmt.setString(4, boardDTO.getSubject());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getReadcount());
			//파일
			pstmt.setString(7, boardDTO.getFile());
			
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	// 리턴할형없음 updateBoard(BoardDTO boardDTO)
	public void updateBoard(BoardDTO boardDTO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1, 2 DB연결 메서드 호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "update board set subject=?, content=?, file=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			//파일
			pstmt.setString(3, boardDTO.getFile());
			pstmt.setInt(4, boardDTO.getNum());
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	// 리턴값없음 deleteBoard(int num) 메서드 정의
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1, 2 DB연결 메서드 호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
//	int count=boardDAO.getBoardCount();
	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			// 1,2 DB연결 메서드호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
			// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
			rs = pstmt.executeQuery();
			// 5단계 다음행으로 이동 데이터 있으면 열 접근
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
		return count;
	}
	
//	boardDAO.updateReadcount(num);
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1,2 DB연결 메서드 호출
			con = getConnection();
			// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
			String sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 sql구문을 실행 (insert, update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try { rs.close(); }catch(SQLException ex){}
			if(pstmt!=null)try { pstmt.close(); }catch(SQLException ex){}
			if(con!=null)try { con.close(); }catch(SQLException ex){}
		}
	}
	
	
	
}//클래스
