<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.project.wsch.vo.BoardDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 삭제할 레코드 번호
	int no = Integer.parseInt(request.getParameter("no"));
	
	// DB삭제
	BoardDAO dao = new BoardDAO();
	int result = dao.boardDelete(no);
	
	// 삭제
	if(result > 0) {		// 삭제 성공
		response.sendRedirect(request.getContextPath()+"/board/board_list");
	} else {	// 삭제 실패
		%>
			<script>
				alert("해당 레코드를 삭제하지 못했습니다.");
				location.href = "<%=request.getContextPath()%>/board/board_view?no=<%=no%>";
			</script>
		<%
	}
%>
</body>
</html>