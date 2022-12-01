<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="java.util.*"%>
<%
	//Controller
	// 로긴메서드에서 회원불러오기
	/*
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember ==null || loginMember.getMemberLevel() <1 ) {
		
		String msg = URLEncoder.encode("관리자만 접속가능한 페이지입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	*/
	
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?");
		return;
	}


	// M호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectCategoryListByAdmin();


%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>category list</title>
</head>
<body>
	<div>
		<jsp:include page = "/inc/adminUrl.jsp" ></jsp:include>
	
	</div>
	
		<!-- 카테고리 목록 -->
		<div>
			<h3><strong>카테고리 목록</strong></h3>
			<table border="1">
				<tr>
					<th>카테고리 번호</th>
					<th>구분</th>
					<th>이름</th>
					<th>생성일</th>
					<th>수정일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<%
					for(Category c : list ){
				%>
						<tr>
							<td><%=c.getCategoryNo()%></td>
							<td><%=c.getCategoryKind()%></td>
							<td><%=c.getCategoryName()%></td>
							<td><%=c.getCreatedate()%></td>
							<td><%=c.getUpdatedate()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
			</div>
		</div>

</body>
</html>