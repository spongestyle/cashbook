<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.*" %>

<%
	// Controller
	// 로긴메서드에서 회원불러오기
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember ==null || loginMember.getMemberLevel() <1 ) {
		
		String msg = URLEncoder.encode("관리자만 접속가능한 페이지입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage (0,0);
	int noticeCount = noticeDao.selectNoticeCount(); // -> last page
	
	
	
	// 최근공지 5개, 최근멤버 5명
	
	
	// View



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin main</title>
</head>
<body>
	<ul>
		<li><a href = "<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href = "<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href = "<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>

	</ul>
	<div>
		<!--  category list -->
		<h1>공지</h1>
		<table>
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
			<tr>	
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				}
			%>
		
		
		</table>
	</div>
</body>
</html>