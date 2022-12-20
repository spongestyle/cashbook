<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder" %>



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
	int helpNo = 0;
	
	// 방어코드
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/helpList?msg="+msg);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}

	Help help = new Help();
	help.setHelpNo(helpNo);
	
	// 2. Model 호출	
	HelpDao helpDao = new HelpDao();
	help = helpDao.selectHelp(help);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- help 입력 폼 -->
	<h5 style="float:left;">내역 입력</h5><br><br><br>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>문의 번호</td>
				<td>
					<input type="number" name="helpNo" value="<%=help.getHelpNo()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의 ID</td>
				<td>
					<input type="text" name="memberId" value="<%=help.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의 닉네임</td>
				<td>
					<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의</td>
				<td>
					<textarea rows="3" cols="50" name="helpMemo"><%=help.getHelpMemo()%></textarea>
				</td>
			</tr>
			<tr>
				<td>문의 생성날짜</td>
				<td>
					<input type="text" name="createdate" value="<%=help.getCreatedate()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의 수정날짜</td>
				<td>
					<input type="text" name="updatedate" value="<%=help.getUpdatedate()%>" readonly="readonly">
				</td>
			</tr>
		</table>			
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">이전</a>
		<button type="submit">수정</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>


</body>
</html>