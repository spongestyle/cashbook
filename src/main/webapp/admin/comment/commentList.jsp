<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%

	//로그인 세션
	request.setCharacterEncoding("UTF-8");

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	//알림 메시지
	String msg = null;
	

	// 2. Model 호출
	// 공지사항 목록 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	CommentDao commentDao = new CommentDao();
	count = commentDao.selectCommentCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 공지사항 목록 출력
	ArrayList<HashMap<String, Object>> list = commentDao.selectCommentList(beginRow, ROW_PER_PAGE);
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page = "/inc/adminUrl.jsp" ></jsp:include>
	
	</div>

	<!-- 고객센터 문의 목록 -->
	<div>
		<h1>고객센터</h1>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			msg = request.getParameter("msg");
			if(request.getParameter("msg") != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<table border="1">
			<tr>
				<th>문의번호</th>
				<th>문의</th>
				<th>문의ID</th>
				<th>문의수정날짜</th>
				<th>문의생성날짜</th>
				<th>답변번호</th>
				<th>답변</th>
				<th>답변ID</th>
				<th>답변수정날짜</th>
				<th>답변생성날짜</th>
				<th>답변 추가 / 수정 /삭제</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
			%>		
				<tr>
					<td><%=(Integer)m.get("helpNo")%></td>
					<td><%=(String)m.get("helpMemo")%></td>
					<td><%=(String)m.get("helpMemberId")%></td>
					<td><%=(String)m.get("helpUpdatedate")%></td>
					<td><%=(String)m.get("helpCreatedate")%></td>
					<td>
						<%
							if((Integer)m.get("commentNo") == 0){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(Integer)m.get("commentNo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentMemo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemberId") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentMemberId")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentUpdatedate") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentUpdatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentCreatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								<a href="<%=request.getContextPath()%>/admin/comment/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&currentPage=<%=currentPage%>">
									답변 입력
								</a>	
						<%		
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/comment/updateCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>&currentPage=<%=currentPage%>">
									답변 수정
								</a>
								<a href="<%=request.getContextPath()%>/admin/comment/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&currentPage=<%=currentPage%>">
									답변 삭제
								</a>		
						<%
							}
						%>
					</td>
				</tr>
			<%
				}
			%>
		</table>
	<!-- 문의사항 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
		<br>
		<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">이전</a>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>



</body>
</html>