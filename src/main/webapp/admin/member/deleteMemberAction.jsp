<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
	//로그인 세션
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	System.out.println(loginMember.getMemberId()+"<--중간확인");
	System.out.println(loginMember.getMemberLevel()+"<--중간확인");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}


	request.setCharacterEncoding("UTF-8");
	
	String msg = null;
	int memberNo = 0;
	String adminPw = null;
	
	// 방어코드
	if(request.getParameter("memberNo")== null || request.getParameter("memberNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/deleteMemberForm.jsp?memberNo="+memberNo+"&msg="+msg);
		return;
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	if(request.getParameter("adminPw")== null || request.getParameter("adminPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/deleteMemberForm.jsp?memberNo="+memberNo+"&msg="+msg);
		return;
	} else {
		adminPw = request.getParameter("adminPw");
	}


	Member member = new Member();
	member.setMemberNo(memberNo);
	
	// 디버깅 코드
	System.out.println(memberNo);
	
	Member adminMember = new Member();
	adminMember.setMemberId(loginMember.getMemberId());
	adminMember.setMemberPw(adminPw);

		
	// 디버깅 코드
	System.out.println(loginMember.getMemberId());
	System.out.println(adminPw);
	
	
String redirectUrl = "/admin/member/memberList.jsp";
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	
	if(memberDao.memberPwck(adminMember)){
		System.out.println("비밀번호 확인 성공");
		// 내역 삭제
		int row = memberDao.deleteMemberByAdmin(member);
		// 디버깅 코드
		System.out.println(row + "<-- deleteMemberAction.jsp");
		if(row == 1){
			System.out.println("회원 탈퇴 성공");
			msg = URLEncoder.encode("회원이 강제 탈퇴되었습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(memberNo + "<-- deleteMemberAction.jsp");
			redirectUrl = "/admin/member/memberList.jsp?msg="+msg;
		} else {
			System.out.println("회원 탈퇴 실패");
			msg = URLEncoder.encode("회원 강제 탈퇴에 실패하였습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(memberNo + "<-- deleteMemberAction.jsp");
			redirectUrl = "/admin/member/deleteMemberForm.jsp?memberNo="+memberNo+"&msg="+msg;
		}
	} else {
		System.out.println("비밀번호 확인 실패");	
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		redirectUrl = "/admin/member/deleteMemberForm.jsp?memberNo="+memberNo+"&msg="+msg;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);

	
%>