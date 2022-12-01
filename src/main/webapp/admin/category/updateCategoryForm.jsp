<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*" %>

<%

	//로그인 세션
	request.setCharacterEncoding("UTF-8");
	Member loginMember = (Member)session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 알림 메시지
	String msg = null;
	
	int categoryNo = 0;
	
	// 방어코드
	if(request.getParameter("categoryNo")== null || request.getParameter("categoryNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp?msg"+msg);
		return;
	} else {
		categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	}
	
	// 2. Model 호출
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	category = categoryDao.selectCategoryOne(categoryNo);
	


	
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
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>

	<div>
		<form action ="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method = "post">
		
			<table>
				<tr>
					<th>번호</th>
					<td>
						<input type = "text" name = "categoryNo" value="<%=category.getCategoryNo()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>구분</th>					
					<%
						String categoryKind = (String)(category.getCategoryKind());
						if(categoryKind.equals("수입")){
					%>
							<td>
								<input type="radio" name="categoryKind" value="수입" checked="checked">수입
								<input type="radio" name="categoryKind" value="지출">지출
							</td>
					<%
						} else {
					%>
							<td>
								<input type="radio" name="categoryKind" value="수입">수입
								<input type="radio" name="categoryKind" value="지출" checked="checked">지출
							</td>
					<%		
						}
					%>				
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type = "text" name = "categoryName" value="<%=category.getCategoryName()%>">
					</td>
				</tr>
			
			</table>
			<button type = "submit">수정</button>
			<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">이전</a>
		
		</form>
	
	
	</div>




</body>
</html>