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
	
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Windmill Dashboard</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
      defer
    ></script>
    <script src="../assets/js/init-alpine.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
      defer
    ></script>
    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>
    <script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
	</script>
	<style>
		
	</style>
  </head>
<body>
   <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
    	<!--  aside.jsp -->
		
		<jsp:include page = "/inc/aside.jsp" ></jsp:include>
		
		
		<!-- backdrop -->
		<div class="flex flex-col flex-1 w-full">
		
			<!--  header.jsp  -->
		
			<jsp:include page = "/inc/header.jsp" ></jsp:include>
			
			<!-- 알맹이 -->
			<main class="h-full overflow-y-auto">
				<div class="container px-6 mx-auto grid">
          		<!-- main.jsp -->
          			<h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">
						<%=loginMemberName%>님의 가계부
					</h2>
				<jsp:include page = "/inc/main.jsp" ></jsp:include>
				
          	
          		<!--  table  -->
          		<!--  달력  -->
          			<div class="w-full overflow-hidden rounded-lg shadow-xs">
          				<table>
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
			          	
          	
          	
          			</div>
          		</div>
			</main>
	
		</div>
	</div>
	

</body>
</html>
