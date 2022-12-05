<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller : session, request
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}

	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	int helpNo = 0;
	String helpMemo = null;
	
	// 방어코드
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?helpNo="+helpNo+"&msg="+msg);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}
	if(request.getParameter("helpMemo")== null || request.getParameter("helpMemo").equals("")){
		msg = URLEncoder.encode("문의를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?helpNo="+helpNo+"&msg="+msg);
		return;
	} else {
		helpMemo = request.getParameter("helpMemo");
	}
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	
	String redirectUrl = "/help/helpList.jsp";
	
	// 2. Model 호출
	// 공지사항 입력
	HelpDao helpDao = new HelpDao();
	int row = helpDao.updateHelp(help);
	// 디버깅 코드
	System.out.println(row + "<-- updateHelpAction.jsp");
	if(row == 1){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("문의가 수정되었습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(helpNo + "<-- updateHelpAction.jsp");
		System.out.println(helpMemo + "<-- updateHelpAction.jsp");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("문의 수정에 실패하였습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(helpNo + "<-- updateHelpAction.jsp");
		System.out.println(helpMemo + "<-- updateHelpAction.jsp");
		redirectUrl = "/help/updateHelpForm.jsp?helpNo="+helpNo+"&msg="+msg;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
