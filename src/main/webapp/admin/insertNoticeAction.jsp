<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%
	//한글
	
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		msg = URLEncoder.encode("항목을 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+msg);
		return;
	}

	
	Notice notice = new Notice();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	
	int row = noticeDao.insertNotice(notice);
	if(row != 1)
	{
		System.out.println(row + "<===insertNoticeAction 성공");
	}
	else
	{
		System.out.println(row + "<===insertNoticeAction 실패");
		
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
%>
