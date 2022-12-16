<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
			
	//로그인 세션
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되어 있지않다면
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	System.out.println(loginMember);
	
	String memberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	// 2. Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);

	
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
		            <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
		              <div class="w-full overflow-x-auto">
		                <table class="w-full whitespace-no-wrap">
		                  <thead>
		                    <tr
		                      class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800"
		                    >
		                      <th class="px-4 py-3">문의자</th>
		                      <th class="px-4 py-3">문의내용</th>
		                      <th class="px-4 py-3">생성날짜</th>
		                      <th class="px-4 py-3">답변자</th>
		                      <th class="px-4 py-3">답변내용</th>
		                      <th class="px-4 py-3">답변생성날짜</th>
		                      <th class="px-4 py-3">action</th>
		                 
		                    </tr>
		                  </thead>
		                  <tbody
		                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800"
		                  >
		                   
		              

                   
                    
		                    <!-- 문의 -->
		                    <%
		                    	for(HashMap<String, Object> m : list) {
		                    		int helpNo = (Integer)m.get("helpNo");                    	
		                    %>
		                     <tr class="text-gray-700 dark:text-gray-400">
		                      <td class="px-4 py-3">
		                        <div class="flex items-center text-sm">
		                          <!-- Avatar with inset shadow -->
		                          <div
		                            class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
		                          >
		                            <img
		                              class="object-cover w-full h-full rounded-full"
		                              src="<%=request.getContextPath()%>/img/login.png"
		                              alt=""
		                            />
		                            <div
		                              class="absolute inset-0 rounded-full shadow-inner"
		                              aria-hidden="true"
		                            ></div>
		                          </div>
		                          <div>
		                            <p class="font-semibold"><%=(String)m.get("helpMemberId") %></p>
		                           
		                          </div>
		                        </div>
		                      </td>
		                      <td class="px-4 py-3 text-sm">
		                        <%=(String)m.get("helpMemo")%>
		                      </td>
		                      <td class="px-4 py-3 text-xs">
		                        <span
		                          class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700"
		                        >
		                          <%=(String)m.get("helpCreatedate")%>
		                        </span>
		                      </td>
		                      
		                      
		                      <!-- comment  -->
		                      
		                      <td class="px-4 py-3">
		                        <div class="flex items-center text-sm">
		                          <!-- Avatar with inset shadow -->
		                          <div
		                            class="relative hidden w-8 h-8 mr-3 rounded-full md:block"
		                          >
		                            <img
		                              class="object-cover w-full h-full rounded-full"
		                              src="<%=request.getContextPath()%>/img/login.png"
		                              alt=""
		                            />
		                            <div
		                              class="absolute inset-0 rounded-full shadow-inner"
		                              aria-hidden="true"
		                            ></div>
		                          </div>
		                          <div>
		                          <%
		                          	if(m.get("commentMemo") == null){
		                          %>
		                          	<p class="font-semibold">&nbsp</p>
		                          <%
		                          	} else {
		                          %>
		                            <p class="font-semibold"><%=(String)m.get("commentMemberId")%></p>
		                          <%
		                          	}
		                          %>
		                          </div>
		                        </div>
		                      </td>
		                      <td class="px-4 py-3 text-sm">
		                      	<%
		                      		if(m.get("commentMemo") == null){
		                      	%>
		                        	&nbsp
		                        <%
		                      		} else {
		                        %>
		                        	<%=(String)m.get("commentMemo")%>
		                        <%
		                      		}
		                        %>
		                      </td>
		                      <td class="px-4 py-3 text-xs">
		                       
		                          <%
									if(m.get("commentCreatedate") == null){
								  %>
								  		&nbsp
								  <%		
									} else {
								  %>
								   <span
		                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
		                       		 >
										<%=(String)m.get("commentCreatedate")%>
								  <%
									}
								  %>
								<td class="px-4 py-3">
		                        <div class="flex items-center space-x-4 text-sm">
		                          <button
		                            class="flex items-center justify-between px-2 py-2 text-sm font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray"
		                            aria-label="Edit"
		                            onclick = "location.href='<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=helpNo%>'"
		                          >
		                            <svg
		                              class="w-5 h-5"
		                              aria-hidden="true"
		                              fill="currentColor"
		                              viewBox="0 0 20 20"
		                            >
		                              <path
		                                d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"
		                              ></path>
		                            </svg>
		                          </button>
		                          <button
		                            class="flex items-center justify-between px-2 py-2 text-sm font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray"
		                            aria-label="Delete"
		                            onclick = "location.href='<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=helpNo%>'"
		                          >
		                            <svg
		                              class="w-5 h-5"
		                              aria-hidden="true"
		                              fill="currentColor"
		                              viewBox="0 0 20 20"
		                            >
		                              <path
		                                fill-rule="evenodd"
		                                d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
		                                clip-rule="evenodd"
		                              ></path>
		                            </svg>
		                          </button>
		                        </div>
		                        </td>	
		                        </span>
		                      </td>
		
		                    </tr>
  
					<% 
						}
					%>


                  </tbody>
                </table>
              </div>
              <div
                class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800"
              >
    
              </div>
              
            </div>
			<div  >
                <button
                  class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple
                  button"
                  onclick = "location.href='<%=request.getContextPath()%>/help/insertHelpForm.jsp'"
                >
                  문의하기
                </button>
              </div>
          </div>
		</main>
	
	  </div>
		
	</div>
	

</body>
</html>