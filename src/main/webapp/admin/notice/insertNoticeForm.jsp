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



		<h3>공지 입력하기</h3>
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp">
			<textarea rows="3" cols="30" name="noticeMemo"></textarea>
			<button type="submit">입력</button>		
		</form>
		<%
			if(request.getParameter("msg") != null)
			{
		%>
				<span><%=request.getParameter("msg") %></span>
		<%		
			}
		%>
</body>
</html>