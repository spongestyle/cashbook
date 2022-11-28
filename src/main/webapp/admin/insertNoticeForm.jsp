<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



		<h3>공지 입력하기</h3>
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
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