<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// controller : session, request
	
		// 로그인 x -> 로그인창으로 돌려보냄
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	

	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	// request 년 + 월
	
	int year = 0;
	int month = 0;
	
	// 둘 중 하나라도 지정되지 않으면 오늘 날짜 출력
	if(request.getParameter("year") == null || request.getParameter("month") == null){
		Calendar today = Calendar.getInstance();	//오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);	// 0 ~ 11
	}else{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// 이전달 클릭 -> year, month-1 / 다음달 클릭 -> year, month+1
		// month == -1 or 12 라면
		if(month == -1){	// 1월에서 이전 누르면
			month = 11;		// 12월
			year--;			// 작년
		}
		if(month == 12){	// 12월에서 다음 누르면
			month = 0;		// 1월
			year++;			// 내년
		}
	}
		

	
	// 출력하고자 하는 년,월과 월의 1일의 요일(1 일, 2 월, 3 화, 4 수,... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
	
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
	
	// begin blank개수는 firstDay - 1
	int beginBlank = firstDay-1;
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int endBlank = 0;	// 7로 나누어 떨어지게끔
	if((beginBlank + lastDate) % 7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);	
	}
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;

	
	// 2. Model 호출
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);	
												

	//view : 달력출력 + 일별 cash 목록출력

 %>





<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>
	<div>
		<a href = "<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
	</div>	


	<div>
	   <!-- 로그인 정보(세션 loginMember 변수) 출력 -->
	   <span><%=loginMemberName%>님의 가계부</span>
	   <a href = "<%=request.getContextPath()%>/updateMemberPw.jsp">비밀번호 수정</a>
	</div>
	
	<div>
		<%=year%>년 <%=month+1%> 월
	</div>
	<div>
			<!-- 달력 -->
		<table border="1">
			<tr>
				<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
			</tr>
			<tr>
				<%
					for(int i=1; i<=totalTd; i++) {
				%>
						<td>
				<%
							int date = i-beginBlank;
							if(date > 0 && date <= lastDate) {
				%>
								<div><a href = "<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>%date<%=date%>">
										<%=date %>
									</a></div>
								<div>
								<%
									for (HashMap<String, Object> m :list) {
										String cashDate = (String)(m.get("cashDate"));
										if(Integer.parseInt(cashDate.substring(8)) == date ){
								%>
										[<%=(String)(m.get("categoryKind"))%>]																
										<%=(String)(m.get("categoryName"))%>
										&nbsp;
										<%=(long)(m.get("cashPrice"))%>원	
										<br>
								<%
										}
									}
								%>
								
								
								</div>
				<%            
					}
				%>
						</td>
				<%
				
				if(i % 7 == 0 && i != lastDate){
				%>
						</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
				<%         
						}
					}
				%>
				
			</tr>
		   

		</table>
		<div>
			 <a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
			 <%=year%>년 <%=month+1%> 월
			 <a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
		</div>
		<div>
			<a href = "<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			<%
				if(loginMember.getMemberLevel() > 0 ) {
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
			<%
			
				}
			%>
		</div>
	</div>
	<div>
		<jsp:include page = "/inc/footer.jsp" ></jsp:include>
	
	</div>
</body>
</html>
