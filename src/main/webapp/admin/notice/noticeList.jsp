<%@page import="java.util.ArrayList"%>
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
 
	
	//페이징
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10; // 한 페이지당 보여주는 게시글(행) 수
	int beginRow = (currentPage-1)*ROW_PER_PAGE; //쿼리에 작성할 게시글(행)시작 값
	
	int count = 0;
	NoticeDao noticeDao = new NoticeDao();
	count = noticeDao.selectNoticeCount(); // -> lastPage
	
	final int pageCount = 10;
	int beginPage = (currentPage-1)/pageCount*pageCount+1;
	int endPage = beginPage+pageCount-1;
	
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	if(lastPage%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
	// 공지사항 목록 출력
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);


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
				
					<div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
		              <div class="w-full overflow-x-auto">
		                <table class="w-full whitespace-no-wrap">
		                  <thead>
							 <tr
		                      class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
								<th class="px-4 py-3">공지번호</th>
		                      	<th class="px-4 py-3">문의내용</th>
		                      	<th class="px-4 py-3">생성날짜</th>
		                      	<th class="px-4 py-3">action</th>
							 </tr>
						  </thead>
						  <tbody
		                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
						    <%
								for(Notice n : list){
							%>
									<tr class="text-gray-700 dark:text-gray-400">
										<td class="px-4 py-3">
											<span
					                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">
											  <%=n.getNoticeNo()%>
											</span>
											</td>
										<td class="px-4 py-3"><%=n.getNoticeMemo()%></td>
										<td class="px-4 py-3">
										 	<span
					                          class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">
											  <%=n.getCreatedate()%>
										 	</span>
										 </td>
										<td class="px-4 py-3">
											<div class="flex items-center space-x-4 text-sm">
					                          <button
					                            class="flex items-center justify-between px-2 py-2 text-sm font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray"
					                            aria-label="Edit"
					                            onclick = "location.href='<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>'"
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
					                            onclick = "location.href='<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>'"
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
									</tr>
							<%
								}
							%>
							</tbody>
						</table>
					</div>
				  </div>
						
				  <!-- 공지사항 페이징 -->		
	              <div
	                class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800"
	              >
	               
	                <span class="col-span-2"></span>
	                
	                <!-- 공지사항 페이징 -->
	                
	                
	                <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
	                  <nav aria-label="Table navigation">
	                    <ul class="inline-flex items-center">
	                    
	               		<!-- 처음 -->
	               		
	                      <li>
	                      	<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1">
	                        <button
	                          class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
	                          aria-label="Previous"
	                        >
	                          <svg
	                            aria-hidden="true"
	                            class="w-4 h-4 fill-current"
	                            viewBox="0 0 20 20"
	                          >
	                            <path
	                              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
	                              clip-rule="evenodd"
	                              fill-rule="evenodd"                             
	                            ></path>
	                          </svg>
	                        </button>
	                        </a>
	                      </li>
	                      
	                      <!-- 이전 -->
							<%
								if(currentPage > 1){
							%>
	                      <li>
	                      	<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-1%>">	
		                        <button
		                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
		                        >
		                          이전
		                        </button>
		                    </a>
	                      </li>
	                      	<%
								}
								for(int i = beginPage; i<=endPage; i++){
							%>
							
						<!--  숫자 -->	
	                      <li>
	                      	<a href="<%=request.getContextPath()%>//admin/notice/noticeList.jsp?currentPage=<%=i%>">
		                        <%
		                      		if (currentPage != i) {
		                      	%>
		                      		<button
			                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
			                        >
			                          <%=i%>
		                        	</button>
		                      	<%
		                      		} else{
		                      	%>
		                      		<button
			                          class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple"
			                        >
			                          <%=i%>
		                        	</button>
		                      	<%
		                      		}
		                      	%>
     
	                        </a>	
	                      </li>
	                      
	                      <!-- 다음 -->
	                     	 <%	
								}
								if(currentPage < lastPage){
							%>
							<li>
								<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+1%>">
									<button
		                          		class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
		                        	>
		                        	다음
		                        	</button>
		                        </a>	
	                    	</li>
	                    	<%
								}
							%>
							
							<!--  마지막 -->
							<li>
								<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>">
			                        <button
			                          class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
			                          aria-label="Next"
			                         >
			                          <svg
			                            class="w-4 h-4 fill-current"
			                            aria-hidden="true"
			                            viewBox="0 0 20 20"
			                          >
			                            <path
			                              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
			                              clip-rule="evenodd"
			                              fill-rule="evenodd"
			                              
			                            ></path>
			                          </svg>		                         
	                       		 	</button>
	                       		</a> 
	                      	</li>
	                    </ul>
	                  </nav>
	                </span>
	                <div >
		                <button
		                  class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple
		                  button"
		                  onclick = "location.href='<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp'"
		                >
		                  공지입력
		                </button>
	            	</div>
	                
	              </div>
	              							 

				</div>
				
			</main>
		</div>
	</div>
				
</body>
</html>