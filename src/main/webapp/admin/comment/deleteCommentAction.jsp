<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller
	request.setCharacterEncoding("UTF-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	
	int commentNo = 0;
	
	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if(request.getParameter("commentNo")== null || request.getParameter("commentNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		commentNo = Integer.parseInt(request.getParameter("commentNo"));
	}
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	String redirectUrl = "/admin/comment/commentList.jsp";
	
	// 2. Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(comment);
	// 디버깅 코드
	if(row == 1){
		System.out.println("삭제성공");
		msg = URLEncoder.encode("답변이 삭제되었습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	} else {
		System.out.println("삭제실패");
		msg = URLEncoder.encode("답변 삭제에 실패하였습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	}
	
	
	// 3. View
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
