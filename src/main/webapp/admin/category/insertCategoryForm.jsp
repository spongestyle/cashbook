<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	//로그인 세션
	request.setCharacterEncoding("UTF-8");
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
	<!-- if msg -->
	<%
		String msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
		<div><%=msg %></div>
	<%
		}
	%>

	<div>
		<form action = "<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method = "post">
			<table border="1">
				<tr>
					<th>구분</th>
					<td>
						<input type = "radio" name = "categoryKind" value="수입">수입
						<input type = "radio" name = "categoryKind" value="지출">지출
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type ="text" name = "categoryName"></td>
				</tr>
					
			</table>
			<div>
				<button type = "submit">추가하기</button>
			</div>

		</form>

	</div>


</body>
</html>