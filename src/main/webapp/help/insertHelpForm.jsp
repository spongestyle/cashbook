<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%
	
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되어 있지않다면
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	System.out.println(loginMember);

	String msg = null;
		
	request.setCharacterEncoding("UTF-8");
	
	String memberId = loginMember.getMemberId();
	

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<form action = "<%=request.getContextPath()%>/help/insertHelpAction.jsp" method = "post">
			<table>
				<tr>
					<td>문의ID</td>
					<td>
						<input type = "text" name = "memberId" value="<%=memberId%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>회원이름</td>
					<td>
						<input type = "text" name = "memberName" value="<%=loginMember.getMemberName()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>문의내용</td>
					<td>
						<textarea rows="3" cols= "50" name = "helpMemo" ></textarea>
					</td>
				</tr>
	
			</table>
			<button type="submit">입력</button>
		</form>
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">취소</a>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>


</body>
</html>