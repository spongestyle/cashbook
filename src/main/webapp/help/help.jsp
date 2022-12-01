<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%



	int currentpage = 1;
	//request.getParameter("currentPage")
	int rowPerPage = 10;
	int beginRow = (1- currentpage) *rowPerPage;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap <String, Object>> list = helpDao.selectHelpList(beginRow , rowPerPage);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--  header include -->
	
	<!-- 고객센터 문의 목록출력 -->
	<div>
		<table>
			<tr>
				<th>문의내용</th>
				<th>회원ID</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
				<th>답변추가 / 수정 / 삭제</th>
			</tr>
			<%
				for(HashMap <String, Object>m : list) {
						
			%>
					<tr>
						<td><%=m.get("helpMemo") %></td>
						<td><%=m.get("memberId") %></td>
						<td><%=m.get("helpCreatedate") %></td>
						<td><%=m.get("commentMemo") %></td>
						<td><%=m.get("commentCreatedate") %></td>
						<td>
							<%
								if(m.get("helpMemo") == null ) {
							%>
									<a herf = "<%=request.getContextPath() %>/help/insertCommentForm.jsp?helpNo=<%=m.get(helpNo)%>">
									답변입력</a>
							<%
								} else {
							
							%>
									<a herf = "<%=request.getContextPath() %>/help/updateComment.jsp?helpNo=<%=m.get(commentNo)%>">
									수정</a>
									<a herf = "<%=request.getContextPath() %>/help/deleteComment.jsp?helpNo=<%=m.get(commentNo)%>">
									삭제</a>
							<%
								}
							%>
						</td>
						
					</tr>
			<%
				}
			%>
		
		</table>
	
	</div>
	
	
	
	
	
	<!--  footer include -->



</body>
</html>