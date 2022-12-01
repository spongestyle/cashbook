<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
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
	int memberLevel = 0;

	//방어코드
	if(request.getParameter("memberNo")== null || request.getParameter("memberNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberForm.jsp?memberNo="+memberNo+"&msg="+msg);
		return;
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	if(request.getParameter("memberLevel")== null || request.getParameter("memberLevel").equals("")){
		msg = URLEncoder.encode("사용할수 없는 레벨값입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/updateMemberForm.jsp?memberNo="+memberNo+"&msg="+msg);
		return;
	} else {
		memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	}

	Member member = new Member();
	member.setMemberNo(memberNo);

	
	// 디버깅 코드
	System.out.println(memberNo);
	System.out.println(memberLevel);

	String redirectUrl = "/admin/member/memberList.jsp";
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 내역 삭제
	int row = memberDao.updateMemberLevel(member, memberLevel);
	// 디버깅 코드
	System.out.println(row + "<-- updateMemberAction.jsp");
	if(row == 1){
		System.out.println("회원 등급 변경 성공");
		msg = URLEncoder.encode("회원 등급이 변경되었습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(memberNo + "<-- updateMemberAction.jsp");
		System.out.println(memberLevel + "<-- updateMemberAction.jsp");
		redirectUrl = "/admin/member/memberList.jsp?msg="+msg;
	} else {
		System.out.println("회원 등급 변경 실패");
		msg = URLEncoder.encode("회원 등급 변경에 실패하였습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(memberNo + "<-- updateMemberAction.jsp");
		System.out.println(memberLevel + "<-- updateMemberAction.jsp");
		redirectUrl = "/admin/member/updateMemberForm.jsp?memberNo="+memberNo+"&msg="+msg;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);

%>