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
	
	
	// 현재 로그인한 사람 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	// 방어코드 - 일자 안 눌렀으면 오늘 날짜가 있는 가계부로
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	System.out.println("중간 확인");
	
	//날짜넣기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// 디버깅
	System.out.println(year+"년");
	System.out.println(month+"월");
	System.out.println(date+"일");

	
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

	<!--  insert cash 입력폼 -->
	
	<div class = "container mt-3" style= "width:400px;">
		<h2>가계부 상세보기</h2>
		
		<form action= "<%=request.getContextPath() %>/cash/insertCashAction.jsp" method = "post" >
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<!-- 입력 후 해당 날짜 상세페이지로 가려고 -->
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
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
						<td><%=(String)m.get("categoryKind")%></td>
						<td><%=(String)m.get("categoryName") %></td>
						<td><%=(String)m.get("cashPrice") %></td>
						<td><%=(String)m.get("cashMemo") %></td>
						<%
							int cashNo = (Integer)m.get("cashNo");
						System.out.println(cashNo + "<--캐시번호");
						%>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
					</tr>
					<%
					}
				}		
			%>
		</table>
	</div>

</body>
</html>