<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import=  "vo.*" %>
<%@ page import = "java.util.*" %>
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
	
	String categoryKind = null;
	String categoryName = null;

	// 방어코드
	if(request.getParameter("categoryKind")== null || request.getParameter("categoryKind").equals("")){
		msg = URLEncoder.encode("항목을 체크해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp?msg="+msg);
		return;
	} else {
		categoryKind = request.getParameter("categoryKind");
	}
	if(request.getParameter("categoryName")== null || request.getParameter("categoryName").equals("")){
		msg = URLEncoder.encode("빈칸을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp?msg="+msg);
		return;
	} else {
		categoryName = request.getParameter("categoryName");
	}

	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);

	String redirectUrl = "/admin/category/categoryList.jsp";
	
	// 2. Model 호출
		CategoryDao categoryDao = new CategoryDao();
		int row = categoryDao.insertCategory(category);
		if(row == 1){
			System.out.println("카테고리 추가 성공");
			msg = URLEncoder.encode("카테고리가 추가되었습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(categoryKind + "<-- insertCategoryAction.jsp");
			System.out.println(categoryName + "<-- insertCategoryAction.jsp");
			redirectUrl = "/admin/category/categoryList.jsp?msg="+msg;
		} else {
			System.out.println("카테고리 추가 실패");
			msg = URLEncoder.encode("카테고리 추가에 실패하였습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(categoryKind + "<-- insertCategoryAction.jsp");
			System.out.println(categoryName + "<-- insertCategoryAction.jsp");
			redirectUrl = "/admin/category/insertCategoryForm.jsp?msg="+msg;
	}
		
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);


%>