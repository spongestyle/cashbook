<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import = "dao.*" %>
<%@ page import="vo.*"%>
<%
	// 1 Controller
	// 로긴메서드에서 회원불러오기
	 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	 
	
	
	//한글
	request.setCharacterEncoding("UTF-8");
	String msg = null;
	int noticeNo = 0;
	
	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("noticeNo")== null || request.getParameter("noticeNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList?msg="+msg);
		return;
	} else {
		noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	}
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList?msg="+msg);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	// 2. Model 호출
	NoticeDao noticeDao = new NoticeDao();
	notice = noticeDao.selectNotice(notice);
	
	

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

	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<div>
		<!-- notice 정보 출력 -->
		<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post">
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<table border="1">
			<tr>
				<th>공지 번호</th>
				<td>
					<input type="number" name="noticeNo" value="<%=notice.getNoticeNo()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>공지 생성일자</th>
				<td>
					<input type="text" name="createdate" value="<%=notice.getCreatedate()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>공지 최종 수정일</th>
				<td>
					<input type="text" name="updatedate" value="<%=notice.getUpdatedate()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>공지 내용</th>
				<td>
					<textarea name="noticeMemo"><%=notice.getNoticeMemo()%></textarea>
				</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage%>">이전</a>
		<button type="submit">수정</button>
		</form>
	</div>
</body>
</html>