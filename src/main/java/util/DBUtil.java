package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		return conn;
	}
	
	// close 모듈화 (rs가 있든 없든 입력하게끔 만듬)
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		if (rs != null) { 
			rs.close();
		} 
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
		
	}
	
	
}