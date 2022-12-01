<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	/*
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
	*/

	String memberId = "goodee";
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>
	<h1>고객센터</h1>
	<div>
		<a href="">문의추가</a>
	</div>
	<table border="1">
		<tr>
			<th>문의내용</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								답변전
						<%		
							} else {
						%>
								<%=m.get("commentMemo")%>
						<%	
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null) {
						%>
								답변전	
						<%		
							} else {
						%>
								<%=m.get("commentCreatedate")%>
						<%	
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="">수정</a>	
						<%		
							} else {
						%>
								&nbsp;
						<%	
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="">삭제</a>	
						<%		
							} else {
						%>
								&nbsp;
						<%	
							}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>