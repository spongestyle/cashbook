<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	


	//로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	System.out.println(loginMember.getMemberId()+"<--중간확인");
	System.out.println(loginMember.getMemberLevel()+"<--중간확인");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
 


	request.setCharacterEncoding("UTF-8");
	int memberNo = 0;
	String msg = null;

	//방어코드
	if(request.getParameter("memberNo")== null || request.getParameter("memberNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList?msg="+msg);
		return;
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);

	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member = memberDao.selectMember(paramMember);


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
		<form action = "<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp?memberNo=<%=memberNo%>" method ="post">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">	
			<table border= "1">
				<tr>
					<td>회원번호</td>
					<td><input type = "number" name = "memberNo" value="<%=member.getMemberNo()%>" readonly = "readonly"></td>
	
				</tr>
				<tr>
					<td>회원ID</td>
					<td><input type = "text" name = "memberId" value = "<%=member.getMemberId()%>" readonly = "readonly"></td>
	
				</tr>
				<tr>
					<td>회원이름</td>
					<td><input type = "text" name = "memberName" value = "<%=member.getMemberName()%>" readonly = "readonly"></td>
	
				</tr>
				<tr>
					<td>생성날짜</td>
					<td><input type = "text" name = "createdate" value = "<%=member.getCreatedate()%>" readonly = "readonly"></td>
	
				</tr>
				<tr>
					<td>수정날짜</td>
					<td><input type = "text" name = "updatedate" value = "<%=member.getUpdatedate()%>" readonly = "readonly"></td>
	
				</tr>
				<tr>
					<td>회원레벨</td>
					<td>
						<select name = "memberLevel">
						<%
							if ((Integer)(member.getMemberLevel()) == 1) {
							
						%>
							<option value = "<%=1%>">관리자</option>
						
						<%
							} else {
						
						%>
							<option value = "<%=0%>">일반회원</option>
						<%
							}
							
						%>
						<%
							if((Integer)(member.getMemberLevel()) != 1){
						%>
								<option value="<%=1%>">
								관리자
								</option>
						<%
							} else {
						%>
								<option value="<%=0%>">
								일반회원
								</option>
						<%
							}
						%>
						</select>					
					</td>
				</tr>

			</table>
			<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">이전</a>

			<button type = "submit">수정</button>
		</form>
	</div>


</body>
</html>