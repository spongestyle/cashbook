<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	//한글
	request.setCharacterEncoding("UTF-8");

	// 로그인 x -> 로그인창으로 돌려보냄
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");


	
	// 날짜넣기
	int year = 0;
	int month = 0;
	int date = 0;
	

	
	// Model 호출
	
	// category 정보 list에 저장하기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash정보 list에 저장하기
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
	= cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);




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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!--  cash 입력폼 -->
	<div class = "container mt-3" style= "width:400px;">
		<h2>가계부 상세보기</h2>
		
		<form action= "<%=request.getContextPath() %>/cash/insertCashAction.jsp" method = "post" >
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<table border ="1">
				<tr>
					<td>categoryNo</td>
					<td>
						<select name = "categoryNo">
						<%
							//category 목록출력
							for(Category c : categoryList) {
						%>
							<option value = "<%=c.getCategoryNo()%>">
								[<%=c.getCategoryKind() %>] <%=c.getCategoryName() %>
							</option>
						<%
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td>
						<input type="text" name ="cashDate" value ="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name ="cashPrice" value ="" >
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type ="submit">입력</button>
		</form>
		
		
		
		<!--  cash 목록폼 -->
		
		<table class = "table">
			<tr>
				<th>수입/지출</th>
				<th>항목</th>
				<th>금액</th>
				<th>내용</th>
				<th>수정</th> <!-- request.getContextPath()/cash/deleteCash.jsp?cashNo= 를넘겨줌 -->
				<th>삭제</th>	 <!-- /cash/updateCashForm.jsp?cashNo= -->
			</tr>
			<%
				for(HashMap<String, Object> m : list) {
					String cashDate = (String)(m.get("cashDate"));
					//디버깅
					System.out.println(cashDate.substring(0,4));
					System.out.println(cashDate.substring(5,7));
					if(Integer.parseInt(cashDate.substring(0,4)) == year && Integer.parseInt(cashDate.substring(5,7)) == month && Integer.parseInt(cashDate.substring(8)) == date ) {
				%>
					<tr>
						<td><%=m.get("categoryKind") %></td>
						<td><%=m.get("categoryName") %></td>
						<td><%=m.get("cashPrice") %></td>
						<td><%=m.get("cashMemo") %></td>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCashForm.jsp">삭제</a></td>
					</tr>
					<%
					}
				}		
			%>
		</table>
	</div>

</body>
</html>