<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션 초기화
	session.invalidate(); 

	//로그인 폼으로 돌아가기
	response.sendRedirect(request.getContextPath()+"/index.jsp");	
%>
​
