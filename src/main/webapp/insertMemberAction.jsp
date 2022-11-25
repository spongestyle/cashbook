<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	
	// 1. C
	
	//한글처리
	request.setCharacterEncoding("utf-8");
	
	String memberId=request.getParameter("memberId");
	String memberPw=request.getParameter("memberPw");
	String memberName=request.getParameter("memberName");
	
	// inserMemberForm.jsp에서 받아온 값이 null 또는 ""일때
	if(request.getParameter("memberName")==null||request.getParameter("memberName").equals("")||request.getParameter("memberId")==null
		||request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){
		
		String msg = URLEncoder.encode("회원가입에 필요한 정보를 모두 입력해주세요", "utf-8");
	
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// 2. Model 호출
	
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println(memberId + "중복된ID");
		
		String msg = URLEncoder.encode("중복된ID가 있습니다", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;	
	}
	
	int row = memberDao.insertMember(member);
	System.out.println(row + "<--insetMemberAction.jsp row값 디버깅");
	
	String msg2 = URLEncoder.encode("회원가입에 성공하였습니다.", "UTF-8");	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg2="+msg2);
	
		

	/*
	// insertMemberForm.에서 받아온 값을 inserMember에 저장하기.
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberId(request.getParameter("memberPw"));
	insertMember.setMemberId(request.getParameter("memberName"));
	System.out.println(request.getParameter("memberId"));
	System.out.println(request.getParameter("memberPw"));
	System.out.println(request.getParameter("memberName"));
	
	MemberDao memberDao = new MemberDao();
	
	// insertmemberForm에서 받아온 memberPw와 memberPwCheck 값이 일치하지 않을 때
	if(memberDao.passwordCheck(request.getParameter("memberPw"), request.getParameter("memberPwCheck"))== false) {
		
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다", "UTF-8");
		
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 회원가입 전 id중복 확인하기
	
	
	if(memberDao.memberIdCheck(insertMember.getMemberId())) {
		System.out.println("중복확인성공");
		String msg = URLEncoder.encode("중복된 ID가 있습니다", "UTF-8");
		
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;	
		
	} else {
		
		// 중복되는 id가 db에 없을경우 - > 회원가입 진행하기
		if(memberDao.insertMember(insertMember)) {
			System.out.println("회원가입성공");
			String msg = URLEncoder.encode("회원가입이 성공되었습니다", "UTF-8");
			
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
			return;	
			
		} else { //회원가입 실패
			
			String msg = URLEncoder.encode("회원가입 실패", "UTF-8");
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
			return;
		}
		
		
		
	}
	*/
	
	
	
	
	
	
	
	


%>