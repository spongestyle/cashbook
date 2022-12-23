<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.*" %>



<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
 
	
	//페이징
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10; // 한 페이지당 보여주는 게시글(행) 수
	int beginRow = (currentPage-1)*ROW_PER_PAGE; //쿼리에 작성할 게시글(행)시작 값
	
	int count = 0;
	NoticeDao noticeDao = new NoticeDao();
	count = noticeDao.selectNoticeCount(); // -> lastPage
	
	final int pageCount = 10;
	int beginPage = (currentPage-1)/pageCount*pageCount+1;
	int endPage = beginPage+pageCount-1;
	
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	if(lastPage%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
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

	
	<!-- 어드민관리목록 -->
	<div>
		<jsp:include page = "/inc/adminUrl.jsp" ></jsp:include>
	
	</div>
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
							<a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">수정</a>
							<a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">삭제</a>
						</td>
					</tr>
			<%
				}
			%>

		</table>
		
		<!-- 공지사항 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
			<%
				}
			
				for(int i = beginPage; i<=endPage; i++){
			%>
					<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=i%>"><%=i%></a>
			
			<%
				}
				if (currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
		
		
		
		
		
		
		<div>
			<a href = "<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지입력하기</a>
		</div>
	</div>
</body>
</html>