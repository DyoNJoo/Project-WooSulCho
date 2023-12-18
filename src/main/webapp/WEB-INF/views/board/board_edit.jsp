<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.project.wsch.vo.BoardDAO"%>
<%@page import="com.project.wsch.vo.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/wsch/resources/css/board_edit.css"/>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 푸터 숨기기
    var footer = document.querySelector("footer");
    if (footer) {
        footer.style.display = "none";
    }
});

</script>
</head>
<body>
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
<%
  int no = Integer.parseInt(request.getParameter("no"));
  BoardDAO dao = new BoardDAO();
  BoardVO vo = dao.boardView(no);
%>
<div class="event_list_page">
  <div class="event_list_img">
    <div class="text">행사 수정하기</div>
  </div>
  <div class="write_form">    
    <form method="post" action="<%=request.getContextPath()%>/board/board_edit_ok">
      <input type="hidden" name="no" value="<%=vo.getNo() %>" />
      <ul>
        <li>
          <label class="title" for="subject">제목</label>
          <input type="text" name="subject" id="subject" value="<%=vo.getSubject() %>" />
        </li>
        <li>
          <label class="title" for="start_date">시작 날짜</label>
          <input type="date" name="start_date" value="<%=vo.getStartDate() %>" />
        </li>
        <li>
          <label class="title" for="end_date">종료 날짜</label>
          <input type="date" name="end_date" value="<%=vo.getEndDate() %>" />
        </li>
        <li>
          <label class="title" for="location">장소</label>
          <input type="text" name="location" value="<%=vo.getLocation() %>" />
        </li>
        <li>
          <label class="title" for="fee">참가비용</label>
          <input type="text" name="fee" value="<%=vo.getFee() %>" />
        </li>
        <li>
		    <label class="title" for="poster">포스터</label>
		    <input type="file" name="poster" value="<%=vo.getPoster() %>"/>		    
		  </li>    
        <li>
          <label class="title" for="content">내용</label>
          <textarea name="content" id="content"><%=vo.getContent() %></textarea>
        </li>
        <li class="button_group">
          <input class="rewrite" type="reset" value="다시쓰기" />    
          <input class="register" type="submit" value="글 수정" />                                   
        </li>
      </ul>
    </form>
  </div>
</div>
<script>
  CKEDITOR.replace('content');
</script>
</body>
</html>