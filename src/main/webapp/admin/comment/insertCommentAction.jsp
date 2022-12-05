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
	
	
	
	int helpNo = 0;
	String commentMemo = null;
	String memberId = null;
	
	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}
	if(request.getParameter("commentMemo")== null || request.getParameter("commentMemo").equals("")){
		msg = URLEncoder.encode("답변을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		commentMemo = request.getParameter("commentMemo");
	}
	if(request.getParameter("memberId")== null || request.getParameter("memberId").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		memberId = request.getParameter("memberId");
	}
	
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	
	String redirectUrl = "/help/helpList.jsp";
	
	// 2. Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.insertComment(comment);
	// 디버깅 코드
	if(row == 1){
		System.out.println("입력성공");
		msg = URLEncoder.encode("답변이 입력되었습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	} else {
		System.out.println("입력실패");
		msg = URLEncoder.encode("답변 입력이 실패하였습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	}
	
	
	// 3. View
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
