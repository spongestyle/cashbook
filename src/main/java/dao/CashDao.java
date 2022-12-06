package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class CashDao {
	
	// cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.cash_memo cashMemo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ?"
				+ " AND YEAR(c.cash_date) = ?"
				+ " AND MONTH(c.cash_date) = ?"
				+ " AND DAY(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
		
		// 해당 월의 CASH정보를 넣어주기
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getLong("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m); //리스트에넣기
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.category_no categoryNo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	
	// insertCashList
	public int insertCashList(String loginMemberId, int categoryNo, long cashPrice, String cashDate, String cashMemo) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(member_id, category_no, cash_price, cash_date, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginMemberId);
		stmt.setInt(2, categoryNo);
		stmt.setLong(3, cashPrice);
		stmt.setString(4, cashDate);
		stmt.setString(5, cashMemo);
		
		int row = stmt.executeUpdate();
		// 성공하면 1 실패하면 0
		if(row == 1) {
			return 1;
		}else {
			return 0;
		}
			
	}
		
}