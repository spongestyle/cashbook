<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1. 컨트롤러
	// 방어코드
	if(request.getParameter("memberId")==null || request.getParameter("memberPw")==null || request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	// 디버깅
	System.out.println(memberId);	

	Member paramMember = new Member();	// 모델 호출 시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	//디버깅
	System.out.println(paramMember.getMemberId());
	

	// 모델호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);	
	
	String redirectUrl = "/loginForm.jsp";
	if(resultMember != null){
		//디버깅
		System.out.println("로그인 성공");	
		//session에 ID, 이름을 저장
		session.setAttribute("loginMember", resultMember);
		redirectUrl = "/cash/cashList.jsp";
	} else {
		System.out.println("로그인 실패");
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
	
	// 3. 뷰
%>