package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class HelpDao {
	
	// 관리자 
	// selectHelpList 오브로딩 (이름이똑같아도 매게변수가 다르면 상관없다.)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+ "		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
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
		stmt.setInt(1, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	
	// help 리스트
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
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
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}