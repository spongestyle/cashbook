<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>


<%
	//한글
	request.setCharacterEncoding("UTF-8");	

	//로그인 x -> 로그인창으로 돌려보냄
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

	//날짜 넣기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	

	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	CashDao cashDao = new CashDao();
	int check = cashDao.insertCashList(loginMemberId, categoryNo, cashPrice, cashDate, cashMemo);
	System.out.println(check);	//1 == 성공, 0 == 실패

	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	// 3


	
%>