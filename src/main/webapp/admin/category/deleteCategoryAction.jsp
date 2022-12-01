<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//로그인 세션
	request.setCharacterEncoding("UTF-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	// 알림 메시지
	String msg = null;
	
	int categoryNo = 0;
	
	// 방어코드
	if(request.getParameter("categoryNo")== null || request.getParameter("categoryNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp?msg"+msg);
		return;
	} else {
		categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	}
	
	// 디버깅 코드
	System.out.println(categoryNo);
	
	String redirectUrl = "/admin/category/categoryList.jsp";
	
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	if(row == 1){
		msg = URLEncoder.encode("카테고리가 삭제되었습니다.", "utf-8");
		redirectUrl = "/admin/category/categoryList.jsp?msg="+msg;
	} else {
		msg = URLEncoder.encode("카테고리 삭제에 실패하였습니다.", "utf-8");
		redirectUrl = "/admin/category/categoryList.jsp?msg"+msg;
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
