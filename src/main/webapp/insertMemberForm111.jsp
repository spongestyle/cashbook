<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//1
	if(session.getAttribute("loginMember") != null) {
		// 로그인되어 있다면
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}


%>


<!DOCTYPE html>
<html>
<head>
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		th.green { background: rgba(0, 128, 0, 0.1); }
		
		td.green { background: rgba(0, 128, 0, 0.1); }
		
		table { background: rgb(238, 238, 255);}
	</style>
<meta charset="UTF-8">
	<script type="text/javascript">
	<%
		if(request.getParameter("msg") != null)
		{			
	%>	
			alert("<%=request.getParameter("msg")%>");
	<%	
		}
	%>
	</script>	
<title>회원가입 페이지</title>
</head>
<body>
	<div class = "container mt-3" style= "width:400px;">
		<h2>회원가입 하기</h2>
		<br>
		<form action = "<%=request.getContextPath()%>/insertMemberAction.jsp" method = "post">
			<table class = "table">
				<tr>
					<th class = "text center">이름</th>
					<td>
						<input type = "text" name = "memberName">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type = "text" name = "memberId">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type = "password" name = "memberPw">
					</td>				
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
						<input type = "password" name = "memberPwCheck">
					</td>				
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">회원가입</button>
					</td>
				</tr>
			
			</table>
			
		
		</form>


</body>
</html>