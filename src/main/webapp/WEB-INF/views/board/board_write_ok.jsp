<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.project.wsch.vo.BoardDAO"%>
<%@page import="com.project.wsch.vo.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");

	// 1. 전페이지(글등록폼)에 입력한 값을 서버로 가져온다.(request)
	BoardVO vo = new BoardVO();

	// form 데이터
	vo.setSubject(request.getParameter("subject"));
	vo.setContent(request.getParameter("content"));
	
	// session 글쓴이
	vo.setUserid((String)session.getAttribute("logId"));
	
	// 클라이언트 ip
	vo.setIp(request.getRemoteAddr());
	
	// 2. DB에 insert한다.
	BoardDAO dao = new BoardDAO();
	int result = dao.boardInsert(vo);
	
	// 3. insert 결과에 따른 실행이동한다.
	// 성공시 : 글등록, 게시판 목록으로 이동
	// 실패시 : 글 등록 폼으로 이동
	
	// 0 : 등록 실패, 1 : 등록 성공
	if(result > 0) {
		response.sendRedirect("/board/board_list");
	} else {
		%>
		<script>
			alert("게시글 등록에 실패하였습니다.");
			history.back();	// history.go(-1);
		</script>
		<%
	}
%>
</body>
</html>