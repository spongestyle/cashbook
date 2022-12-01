<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.*" %>

<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	System.out.println(loginMember.getMemberId()+"<--중간확인");
	System.out.println(loginMember.getMemberLevel()+"<--중간확인");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		String msg = URLEncoder.encode("관리자만 접속가능한 페이지입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
		return;
	}
	 
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	
	// 공지 5개, 멤버 5명 (최신업데이트)
	ArrayList<Notice> NoticeList = noticeDao.selectNoticeListByPage(0,5);
	ArrayList<Member> MemberList = memberDao.selectMemberListByPage(0,5);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin main</title>
</head>
<body>
	<div>
		<jsp:include page = "/inc/adminUrl.jsp" ></jsp:include>
	
	</div>
	<div>
		<!--  최근공지목록 -->
		<h1>최근공지목록</h1>
		<table border= "1">
			<tr>
				<th>번호</th>
				<th>공지내용</th>
				<th>공지날짜</th>
			</tr>
			<%
				for(Notice n : NoticeList ) {
			%>
			<tr>	
				<td><%=n.getNoticeNo() %></td>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getCreatedate() %></td>
				
			</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<div>
		<!--  최근회원가입목록 -->
		<h1>신규회원가입멤버</h1>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>회원등급</th>
				<th>최신수정일자</th>
				<th>가입날자</th>
			</tr>
			<%
				for(Member m : MemberList) {
			
			%>
			<tr>
				<td><%=m.getMemberNo() %></td>
				<td><%=m.getMemberId()%></td>
				<td><%=m.getMemberName()%></td>
				<td><%=m.getMemberLevel()%></td>
				<td><%=m.getUpdatedate() %></td>
				<td><%=m.getCreatedate() %></td>
			
			</tr>
			
			<%
				}
			%>
		
		</table>
	<a href = "<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
</body>
</html>