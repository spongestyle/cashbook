<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String msg = null;

	int helpNo = 0;
	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage);
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
<title>InsertCommentForm</title>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page = "/inc/adminUrl.jsp" ></jsp:include>
	</div>

	<!-- comment 입력 폼 -->
	<h5 style="float:left;">답변 입력</h5><br><br><br>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/comment/insertCommentAction.jsp" method="post">
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<input type="hidden" name="memberId" value=<%=loginMember.getMemberId()%>>
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
					<input type="text" name="helpMemberId" value="<%=help.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의</td>
				<td>
					<textarea rows="3" cols="50" name="helpMemo" readonly="readonly"><%=help.getHelpMemo()%></textarea>
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
			<tr>
				<td>답변</td>
				<td>
					<textarea rows="3" cols="50" name="commentMemo"></textarea>
				</td>
			</tr>
		</table>			
		<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=currentPage%>">이전</a>
		<button type="submit">입력</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>


