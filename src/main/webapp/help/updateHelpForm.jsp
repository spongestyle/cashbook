<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder" %>



<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되어 있지않다면
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	String loginMemberName = loginMember.getMemberName();
	System.out.println(loginMember);
	
	String msg = null;
	int helpNo = 0;
	
	// 방어코드
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/helpList?msg="+msg);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}

	Help help = new Help();
	help.setHelpNo(helpNo);
	
	// 2. Model 호출	
	HelpDao helpDao = new HelpDao();
	help = helpDao.selectHelp(help);



%>
<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>update help form</title>
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
    
    <style>
    
    .button {
   	 float : right;
    }
    
    </style>
<title>고객센터</title>
</head>
<body>

	<div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
    	<!--  aside.jsp -->
		
		<jsp:include page = "/inc/asideHelp.jsp" ></jsp:include>
		
		
		<!-- backdrop -->
		<div class="flex flex-col flex-1 w-full">
		
			<!--  header.jsp  -->
		
			<jsp:include page = "/inc/header.jsp" ></jsp:include>
			
			<!-- 알맹이 -->
			<main class="h-full overflow-y-auto">
				<div class="container px-6 mx-auto grid">
          		<!-- main.jsp -->
          			<h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">
						고객센터
					</h2>
				<jsp:include page = "/inc/main.jsp" ></jsp:include>
				
				
				
				
				<!-- TABLE -->
				
				
				
				<h4 class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">
             	 <%=loginMemberName %>님의 문의사항
           		 </h4>
					 <div
		              class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800"
		             >
			             <form  action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
			             	<table class="w-full whitespace-no-wrap">
			             		<tr>
								<td  class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
									<label class="block text-sm">
				              			 <span class="text-gray-700 dark:text-gray-400">No</span>
							                <input
							                  class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
							                  name = "memberId" 
							                  value="<%=help.getHelpNo()%>" 
							                  readonly="readonly"
							                /> 						                
				              		</label>
								
								</td>
								</tr>
		             		    <tr>
		             		    <td class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
				              		<label class="block text-sm">
						                <span class="text-gray-700 dark:text-gray-400">ID</span>
						                <!-- focus-within sets the color for the icon when input is focused -->
						                <div
						                  class="relative text-gray-500 focus-within:text-purple-600 dark:focus-within:text-purple-400"
						                >
						                  <input
						                    class="block w-full pl-10 mt-1 text-sm text-black dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray form-input"
						                    name = "memberId" 
						                    value="<%=help.getMemberId()%>" 
						                    readonly="readonly"
						                  />
						                  <div
						                    class="absolute inset-y-0 flex items-center ml-3 pointer-events-none"
						                  >
						                    <svg
						                      class="w-5 h-5"
						                      aria-hidden="true"
						                      fill="none"
						                      stroke-linecap="round"
						                      stroke-linejoin="round"
						                      stroke-width="2"
						                      viewBox="0 0 24 24"
						                      stroke="currentColor"
						                    >
						                      <path
						                        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
						                      ></path>
						                    </svg>
						                  </div>
						                </div>
						              </label>
								</td>
								</tr>
								<tr>
								<td  class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
									<label class="block text-sm">
				              			 <span class="text-gray-700 dark:text-gray-400">Name</span>
							                <input
							                  class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
							                  name = "memberId" 
							                  value="<%=loginMember.getMemberName()%>" 
							                  readonly="readonly"
							                /> 						                
				              		</label>
								
								</td>
								</tr>
								<tr>
								<td class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
									<label class="block text-sm">
				              			 <span class="text-gray-700 dark:text-gray-400">문의내용</span>
						                 <textarea
						                  class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-textarea focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray"
						                  rows="5"
						                  placeholder="Enter some long form content."
						               	  name = "helpMemo"
						                ><%=help.getHelpMemo()%></textarea> 						                
				              		</label>
								
								</td>
								</tr>
							</table>
							<br>
							<button 
								class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple button"
								type="submit">
								<svg
			                      class="w-5 h-5"
			                      aria-hidden="true"
			                      fill="none"
			                      stroke-linecap="round"
			                      stroke-linejoin="round"
			                      stroke-width="2"
			                      viewBox="0 0 24 24"
			                      stroke="currentColor"
			                    >
			                      <path
			                        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
			                      ></path>
			                    </svg>
							</button>
						 </form>
						 
					 </div>
					 
				</div>

			</main>
		</div>
	</div>
	




</body>
</html>