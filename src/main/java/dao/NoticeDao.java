package dao;

import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.Notice;


public class NoticeDao {
	
	// SELECT : updateNoticeForm.jsp 공지 정보 조회
	public Notice selectNotice(Notice notice)throws Exception{
		Notice n = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate, createdate"
					+ " FROM notice"
					+ " WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return n;
	}
	
	
	
	// deleteNoticeAction.jsp
	public int deleteNotice(Notice notice) throws Exception {
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return 0;
		
	}
	
	
	
	// updateNoticeAction.jsp
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return  0;
	}
	
	//insertNoticeAtion.jsp
	public int insertNotice(Notice notice) throws Exception {
		
		int row = 0;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);	
		return 0;
	}
	
	
	
	
	// loginForm. jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT  member_name memberName, notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Notice n = new Notice();
			n.setMemberName(rs.getString("memberName"));
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	

	
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoticeCount() throws Exception {
		int cnt = 0;
		
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "select COUNT(*) cnt FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		
		dbUtil.close(rs, stmt, conn);
		return cnt;
	}
		

}
