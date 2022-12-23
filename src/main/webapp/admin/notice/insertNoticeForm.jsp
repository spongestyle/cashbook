<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "dao.*" %>
<%



	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
 



%>



<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>insert Notice Form</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../../assets/css/tailwind.output.css" />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
      defer
    ></script>
    <script src="../../assets/js/init-alpine.js"></script>
    <link.
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
      defer
    ></script>
    <script src="../../assets/js/charts-lines.js" defer></script>
    <script src="../../assets/js/charts-pie.js" defer></script>
    
    <style>
    
    .button {
   	 float : right;
    }
    
    </style>
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
						👑관리자 페이지
					</h2>
				<jsp:include page = "/inc/main.jsp" ></jsp:include>
				
				<div
               		class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                	<div
                  		class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
                 	 	<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    	<path
	                      fill-rule="evenodd"
	                      d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z"
	                      clip-rule="evenodd"
	                    ></path>
                  		</svg>
                	</div>
	                <div>
	                 
	                  <p  class="text-lg font-semibold text-gray-700 dark:text-gray-200">
	                    공지사항
	                  </p>
	                </div>
              	</div>
				</div>
			</main>
		</div>
	</div>
              
              	
              	
              	
              	
              	
</body>
</html>