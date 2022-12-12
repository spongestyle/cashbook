<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%

	// Controller
	// 로긴메서드에서 회원불러오기
	//로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	
	
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	
	//한글
	request.setCharacterEncoding("UTF-8");

	Member member = new Member();

	// model
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	MemberDao memberDao = new MemberDao();
	count = memberDao.selectMemberCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE);
	
	// 멤버 목록 출력
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);


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
	
	<div>
		<table border= "1">
			<tr>
				<th>멤버번호</th>
				<th>멤버아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막 수정일</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list){
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">강제탈퇴</a></td>
					</tr>
			<%				
				}
			%>

		</table>
	
	<!--  멤버 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage+1%>" >다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
		<br>
		<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">이전</a>

	
	
	</div>







</body>
</html>