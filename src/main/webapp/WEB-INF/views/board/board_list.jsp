<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.project.wsch.vo.BoardDAO"%>
<%@page import="com.project.wsch.vo.BoardVO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/wsch/resources/css/board_list.css"/>
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
<div class="event_list_page">

<!-- 
   <div>      
      <% 
         String log = (String)session.getAttribute("logStatus");
         if(log != null && log.equals("Y")) { 
      %>
         <a href="<%= request.getContextPath() %>/board/board_write">글쓰기</a>
      <% } %>
   </div>
 -->

<%
    BoardDAO dao = new BoardDAO();
    List<BoardVO> lst = dao.boardSelectAll();     
%>
<div class="event_list_img">
<div class="text">행사 목록관리</div></div>

<table class="boardList">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>시작날짜</th>
        <th>종료날짜</th>
        <th>장소</th>
        <th>내용</th>
        <th>조회수</th>
    </tr>

    <% for (BoardVO vo : lst) { %>
    <tr>
        <td><%= vo.getNo() %></td>
        <td><a class="board_title" href="<%= request.getContextPath() %>/board/board_view?no=<%= vo.getNo() %>"><%= vo.getSubject() %></a></td>
        <td><%= vo.getStartDate() %></td>
        <td><%= vo.getEndDate() %></td>
        <td><%= vo.getLocation() %></td>
        <td><%= vo.getContent() %></td>
        <td><%= vo.getHit() %></td>
    </tr>
    <% } %>
</table>
<div class="write-link">
    <a href="<%= request.getContextPath() %>/board/board_write">글쓰기</a>
</div>
</div>
</body>
</html>