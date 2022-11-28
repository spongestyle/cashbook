<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.*" %>



<%
	// Controller
	// 로긴메서드에서 회원불러오기

	
	//페이징
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	NoticeDao noticeDao = new NoticeDao();
	count = noticeDao.selectNoticeCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 공지사항 목록 출력
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);

	

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버 관리</a></li><!-- 레벨 수정, 멤버 목록, 강제 회원탈퇴 -->
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">back</a></li>
	</ul>
	<!-- 공지목록 페이징 (상세보기 없음 타이틀만 보이게, 댓글 기능) -->
	<div>
		<h3><strong>★공지사항★</strong></h3>

		<table border="1">
			<tr>
				<th>공지번호</th>
				<th>내용</th>
				<th>날짜</th>
				<th>편집</th>
			</tr>
			<%
				for(Notice n : list){
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">수정</a>
							<a href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">삭제</a>
						</td>
					</tr>
			<%
				}
			%>

		</table>
		
		<!-- 공지사항 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
		
		
		
		
		
		
		<div>
			<a href = "<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력하기</a>
		</div>
	</div>
</body>
</html>