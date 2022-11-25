package dao;

import java.sql.*;
import java.util.ArrayList;

import util.*;
import vo.*;



public class MemberDao {
	
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		
		/*
		 * ORDER BY createdate DESC
		 * 
		 * 
		 */
	
		
		return null;
	}
	
	// 관리자 : 멤버 강퇴
	public int deleteMemberByAdmin(Member member) {
		return 0;
	}
	
	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		// 반환할 Member 변수
		Member resultMember = null;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		--> DB를 연결하는 코드(명령들)가 Dao 메서드들 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		// 로그인sql
		String loginSql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		
		PreparedStatement loginStmt = conn.prepareStatement(loginSql);
		loginStmt.setString(1, paramMember.getMemberId());
		loginStmt.setString(2, paramMember.getMemberPw());
		
		ResultSet loginRs = loginStmt.executeQuery();
		if(loginRs.next()) {
			// select 한값을 resultMember에 저장
			resultMember = new Member();
			resultMember.setMemberId(loginRs.getString("memberId"));
			resultMember.setMemberName(loginRs.getString("memberName"));
		
		
			loginRs.close();
			loginStmt.close();
			conn.close();
			return resultMember;
		}
		
		loginRs.close();
		loginStmt.close();
		conn.close();
		return null;
		}	
	
	
	// 회원가입 메서드 (하나의 메서드에 2개의 쿼리 넣기는 나중에 시도)
	
	// boolean 참과 거짓만을 사용. 반환값 true : 이미id존재, false : 사용가능 --> 코드짜기가 편하다.
	
	public boolean selectMemberIdCk(String memberId) throws Exception  {
		boolean result = false;
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// id중복 sql
		String ovlSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement ovlStmt = conn.prepareStatement(ovlSql);
		ovlStmt.setString(1, memberId);;
		ResultSet ovlRs = ovlStmt.executeQuery();
		
		if(ovlRs.next()) {
			result = true;
		}
		dbUtil.close(ovlRs, ovlStmt, conn);
		return result;
	}
	
	// 
	public int insertMember(Member member) throws Exception	{
		int row = 0;
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 회원가입 sql
		String insertSql = "INSERT INTO member (member_id, member_pw, member_name,updatedate, createdate) "
				+ "VALUES(?,PASSWORD(?),?,CURDATE(),CURDATE())";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, member.getMemberId());
		insertStmt.setString(2, member.getMemberPw());
		insertStmt.setString(3, member.getMemberName());
		row = insertStmt.executeUpdate();
		
		dbUtil.close(null, insertStmt, conn);
		return row; //결과값을 리턴
	}	

	/*
	public Member insert(Member paramMeber) throws Exception {
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		Member insertMember = null;
		// 1) id 중복검사 sql
		
		String ovlSql = "SELECT member_id FROM member WHERE member_id=?";
		PreparedStatement ovlStmt = conn.prepareStatement(ovlSql);
		ovlStmt.setString(1, paramMeber.getMemberId());
		ResultSet ovlRs = ovlStmt.executeQuery();
		if(ovlRs.next()) {
			System.out.println("중복된ID");
			return insertMember;
		}
		// 2) 회원가입 sql
	
		String insertSql = "INSERT INTO member (member_id, member_pw, member_name,updatedate, createdate) VALUES(?,PASSWORD(?),?,CURDATE(),CURDATE())";
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, paramMeber.getMemberId());
		insertStmt.setString(2, paramMeber.getMemberPw());
		insertStmt.setString(3, paramMeber.getMemberName());
		int row = insertStmt.executeUpdate();
		if (row == 1) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		insertStmt.close();
		conn.close();
		return insertMember;

	}
	*/
	// 비밀번호 확인 메서드
	
	public int selectMemberPw(String memberId, String memberPw) throws Exception {
		int row = 0;
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 비밀번호 일치 확인 sql
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) { //비밀번호가 일치한다면
			row = 1;
		}
		
		dbUtil.close(rs, stmt, conn);
		return row; //결과값을 리턴	
	}
	
	// 비밀번호 수정 메서드
	public int updateMemberPw(String updatePw, String memberId)  throws Exception{
		int row = 0;
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 비밀번호 수정 sql
		String sql = "UPDATE member SET member_pw = PASSWORD (?) WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, updatePw);
		stmt.setString(2, memberId);
		
		// 성공하면 row==1
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row; //결과값을 리턴	
		
	}
	
	
	
	
		

		
	// 회원탈퇴 메서드
		
	public Boolean deleteMember(Member paramMember) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 탈퇴 sql
		String deleteSql = "DELETE FROM member WHERE member_id = ? member_pw = PASSWORD(?)";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setString(1, paramMember.getMemberId());
		deleteStmt.setString(2, paramMember.getMemberPw());
		
		int row = deleteStmt.executeUpdate();
		
		boolean result = false;
		if(row == 1) {
		   result = true;
		}
		deleteStmt.close();
		conn.close();
		return result;
		
	}
	
	// 입력한 두 비밀번호가 일치하는 지 확인하는 메서드
	public Boolean passwordCheck(String pw, String pwCheck) {
		if(pw.equals(pwCheck)) {
			return true;
		} else {
			return false;
		}
	
	}
}