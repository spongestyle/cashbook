<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>

<%
//1
	if(session.getAttribute("loginMember") != null) {
		// 로그인되어 있다면
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	//페이징
	NoticeDao noticeDao = new NoticeDao();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int rowPerPage = 5; // 한 페이지당 보여주는 게시글(행) 수
	int beginRow= (currentPage-1)*rowPerPage; //쿼리에 작성할 게시글(행)시작 값
	int cnt = noticeDao.selectNoticeCount(); //전체 행 구하기
	
	final int pageCount = 10; // 한 페이지당 보여줄 페이징 목록 수
	int beginPage = (currentPage-1)/pageCount*pageCount+1; //페이징 목록 시작값
	int endPage = beginPage+pageCount-1; // 페이징 목록 끝값
	
		
	int lastPage = cnt/rowPerPage; // 마지막 페이지
	if(lastPage%rowPerPage != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
	
	//디버깅
	System.out.println(lastPage);	
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);




%>
<!DOCTYPE html>
<html>
<head>
	
    
    <!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<script type="text/javascript">
	<%
		if(request.getParameter("msg") != null)
		{			
	%>	
			alert("<%=request.getParameter("msg")%>");
	<%	
		}
	%>
	</script>	
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

	<div>
		<a href = "<%=request.getContextPath()%>/admin/notice/noticeList.jsp">게시판관리자</a>
	</div>	

	
	<!-- 공지(5개) 페이징 -->
	<div class = >
		<table>
			<tr>
				<th>게시번호</th>
				<th>게시자</th>
				<th>공지내용</th>
				<th>공지날짜</th>
			</tr>
			<%
				for (Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
						<td><%=n.getMemberName() %></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
					 
			<%
				}
			%>
			
		</table>
		
		<!--  페이징  -->
		
		<ul style="list-style: none;">				
			<li>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1){
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
				for(int i=beginPage; i<=endPage; i++){
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>"><%=i%></a>
			<%	
				}
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>	
			</li>
		</ul>

	</div>



	<!-- 로그인 폼 -->
	<div class = "container mt-3" style= "width:400px;">
	<div>
		<%
			if(request.getParameter("msg2") != null){
		%>
			<span><%=request.getParameter("msg2") %></span>
		<%
			}
		%>
	
	</div>

		<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
			<h2>로그인하기</h2>
			<table class = "table">					
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" placeholder="ID">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw" placeholder="PASSWORD">
					</td>
				</tr>				
			</table>
			<button type="submit">로그인</button>
		</form>
	
		<div>
			<span>회원가입 하러가기 &#8702;</span>
			<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		</div>
	</div>
	
</body>
</html>