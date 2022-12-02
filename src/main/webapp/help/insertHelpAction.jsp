<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder" %>


<%
	//로그인 세션
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되어 있지않다면
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String msg = null;
	String memberId = null;
	String helpMemo = null;
	

	//방어코드
	if (request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
	|| request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		msg = URLEncoder.encode("내용을 입력하세요", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg="+msg);
		return;
	} else {
		memberId = request.getParameter("memberId");
		helpMemo = request.getParameter("helpMemo");
	}
	
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpMemo(helpMemo);
	
	String redirectUrl = "/help/helpList.jsp";
	
	// m호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	
	
	if (row ==1 ){
		msg = URLEncoder.encode("문의가 등록되었습니다.","UTF-8");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	} else {
		System.out.println("입력실패");
		msg = URLEncoder.encode("문의등록에 실패하였습니다.", "utf-8");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
	

%>