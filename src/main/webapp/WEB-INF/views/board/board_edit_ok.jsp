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

	// 이전페이지 폼의 값을 request
	BoardVO vo = new BoardVO();
	vo.setNo(Integer.parseInt(request.getParameter("no")));	// 수정할 글 번호
	vo.setSubject(request.getParameter("subject"));	// 제목
	vo.setContent(request.getParameter("content"));	// 글 내용
	
	// DB 업데이트
	BoardDAO dao = new BoardDAO();
	int result = dao.boardEditOk(vo);
	
	// 결과에 따른 실행
	// 0 : 수정 실패, 1 : 수정 성공
	if(result > 0) {		// 수정 성공
		response.sendRedirect(request.getContextPath()+"/board/board_view?no="+vo.getNo());
	} else {	// 수정 실패
		%>
			<script>
				alert("글 수정 실패하였습니다.");
				history.go(-1);	// hitory.back();
			</script>
		<%
	}
%>
</body>
</html>