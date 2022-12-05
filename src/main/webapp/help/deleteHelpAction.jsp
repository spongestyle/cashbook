<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller : session, request
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	int helpNo = 0;
	
	// 방어코드
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?helpNo="+helpNo+"&msg="+msg);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	
	String redirectUrl = "/help/helpList.jsp";
	
	// 2. Model 호출
	// 공지사항 입력
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(help);
	// 디버깅 코드
	System.out.println(row + "<-- deleteHelpAction.jsp");
	if(row == 1){
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("문의가 삭제되었습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(helpNo + "<-- deleteHelpAction.jsp");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	} else {
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("문의 삭제에 실패하였습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(helpNo + "<-- deleteHelpAction.jsp");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
