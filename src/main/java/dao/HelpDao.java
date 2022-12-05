package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Help;

public class HelpDao {
	
	// 관리자 
	// selectHelpList 오버로딩 (이름이똑같아도 매게변수가 다르면 상관없다.)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+ "		, h.member_id memberId"
					+ "		, h.updatedate helpUpdatedate"
					+"		, h.createdate helpCreatedate"
					+ "		, c.comment_no commentNo"
					+"		, c.comment_memo commentMemo"
					+ "		, c.member_id commentMemberId"
					+ "		, c.updatedate dommentUpdatedate"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+ " LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpMemberId", rs.getString("helpMemberId"));
			m.put("helpUpdatedate", rs.getString("helpUpdatedate"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentMemberId", rs.getInt("commentMemberId"));
			m.put("commentUpdatedate", rs.getString("commentUpdatedate"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	
	// help 리스트 helpList.jsp
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
				+ "			, h.help_memo helpMemo"
				+ "			, h.member_id helpMemberId"
				+ "			, h.updatedate helpUpdatedate"
				+ "			, h.createdate helpCreatedate"
				+ "			, c.comment_no commentNo"
				+ "			, c.comment_memo commentMemo"
				+ "			, c.member_id commentMemberId"
				+ "			, c.updatedate commentUpdatedate"
				+ "			, c.createdate commentCreatedate"
				+ " FROM help h LEFT JOIN COMMENT c" //" FROM HELP h LEFT OUTER JOIN COMMENT c"
				+ " ON h.help_no = c.help_no"
				+ " WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		// db자원 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpMemberId", rs.getString("helpMemberId"));
			m.put("helpUpdatedate", rs.getString("helpUpdatedate"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentMemberId", rs.getString("commentMemberId"));
			m.put("commentUpdatedate", rs.getString("commentUpdatedate"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		// db자원반납
		dbUtil.close(rs, stmt, conn);
		return list;
		
	}
	
	// insertHelpAction.jsp
	public int insertHelp(Help help) throws Exception { 
		int row = 0;
		String sql = "INSERT INTO help (help_memo, member_id, updatedate, createdate)"
				+ "VALUES(?, ?, NOW(),NOW())";
		DBUtil dbUtil = new DBUtil();
		// db자원 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		row = stmt.executeUpdate();
		
		// db자원반납
		dbUtil.close(null, stmt, conn);
		return row;

	}
	// SELECT : updateHelpForm.jsp
	public Help selectHelp(Help help)throws Exception{
		Help h = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT help_no helpNo, help_memo helpMemo, member_id memberId, updatedate, createdate"
					+ " FROM help"
					+ " WHERE help_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, help.getHelpNo());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			h = new Help();
			h.setHelpNo(rs.getInt("helpNo"));
			h.setHelpMemo(rs.getString("helpMemo"));
			h.setMemberId(rs.getString("memberId"));
			h.setUpdatedate(rs.getString("updatedate"));
			h.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return h;
	}
	
	// UPDATE : updateHelpAction.jsp
	public int updateHelp(Help help) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "UPDATE help SET help_memo = ? WHERE help_no= ? ";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// DELETE : deleteHelpAction.jsp
		public int deleteHelp(Help help) throws Exception{
			int row = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = null;
			PreparedStatement stmt = null;
			sql = "DELETE FROM help WHERE help_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			row = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			return row;
		}
	
}