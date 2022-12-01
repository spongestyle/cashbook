<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
	// 로그인 세션
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?");
		return;
	}

	// 알림 메시지
	String msg = null;
	
	int categoryNo = 0;
	String categoryName = null;
	String categoryKind = null;
	
	// 방어코드
	if(request.getParameter("categoryNo")== null || request.getParameter("categoryNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/updateCategoryForm.jsp?categoryNo="+categoryNo+"&msg="+msg);
		return;
	} else {
		categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	}
	if(request.getParameter("categoryKind")== null || request.getParameter("categoryKind").equals("")){
		msg = URLEncoder.encode("항목을 선택하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/updateCategoryForm.jsp?categoryNo="+categoryNo+"&msg="+msg);
		return;
	} else {
		categoryKind = request.getParameter("categoryKind");
	}
	if(request.getParameter("categoryName")== null || request.getParameter("categoryName").equals("")){
		msg = URLEncoder.encode("빈칸을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/updateCategoryForm.jsp?categoryNo="+categoryNo+"&msg="+msg);
		return;
	} else {
		categoryName = request.getParameter("categoryName");
	}

	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	// 디버깅
	System.out.println(" 번호 "+categoryNo +" 항목 "+categoryKind + " 이름 "+categoryName );
	
String redirectUrl = "/admin/category/categoryList.jsp";
	
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	if(row == 1){
		System.out.println("카테고리 수정 성공");
		msg = URLEncoder.encode("카테고리가 수정되었습니다.", "utf-8");

		redirectUrl = "/admin/category/categoryList.jsp?msg="+msg;
	} else {
		System.out.println("카테고리 수정 실패");
		msg = URLEncoder.encode("카테고리 수정에 실패하였습니다.", "utf-8");

		redirectUrl = "/admin/category/updateCategoryForm.jsp?categoryNo="+categoryNo+"&msg="+msg;
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
	

%>