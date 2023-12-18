<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.project.wsch.vo.BoardDAO"%>
<%@page import="com.project.wsch.vo.BoardVO"%>
<%@page import="com.project.wsch.vo.UserVO"%>
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
<link rel="stylesheet" href="/wsch/resources/css/board_view.css"/>
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
<%
    UserVO user = (UserVO) session.getAttribute("user");
%>
<body>   
  <div class="event_list_page">
    <div class="event_list_img">
      <div class="text">행사 살펴보기</div>
    </div>
    <%
    int no = Integer.parseInt(request.getParameter("no"));

    BoardDAO dao = new BoardDAO();
    dao.hitCount(no); // 조회수 증가
    BoardVO vo = dao.boardView(no); // 레코드 선택
    if (vo == null) { // vo가 null인지 확인
        out.print("해당하는 게시글을 찾을 수 없습니다."); // 적절한 메시지 출력
        return; // 페이지 처리 종료
    }
    %>

<script type="text/javascript">
   function delCheck() {
      // confirm 대화상자는 확인을 : true, 취소 : false
      if(confirm("현재 글을 삭제하시겠습니까?")) {
         location.href = "<%= request.getContextPath() %>/board/board_del?no=<%=vo.getNo()%>";
      }
   }
</script>

<table summary="행사게시판 상세정보">   
   <colgroup>
      <col style="width:14%;" />
      <col />
      <col style="width:14%;" />
      <col style="width:14%;" />
   </colgroup>
   <tbody>
      <tr>
         <th scope="row" class="subject">제목</th>
         <td class="subject" colspan="5"><%=vo.getSubject() %></td>
      </tr>
      <tr>
         <th scope="row" class="date">시작날짜</th>
         <td class="date"><%=vo.getStartDate() %></td>
         <th scope="row" class="date">종료날짜</th>
         <td class="date"><%=vo.getEndDate() %></td>
         <th scope="row">조회수</th>
         <td><%=vo.getHit() %></td>
      </tr>
      <tr>
         <th scope="row">참가비용</th>
         <td><%=vo.getFee() %></td>
         <th scope="row">장소</th>
         <td><%=vo.getLocation() %></td>         
         <th scope="row" class="no">게시글 번호</th>
         <td class="no"><%=vo.getNo() %></td>
      </tr>
      <tr>
         <th scope="row">내용</th>
         <td colspan="5"><%=vo.getContent() %></td>
      </tr>
      <tr>
            <th scope="row">첨부파일</th>
                <td colspan="5">
                    <img src="<%= request.getContextPath() %>/<%= vo.getPoster() %>" alt="포스터 이미지" style="width: 500px; height: 500px;">
                   </td>
        </tr>
   </tbody>
</table>
   <div>
      <c:if test="${logStatus == 'Y' && logId eq 'admin'}"> 
           <a href="<%=request.getContextPath()%>/board/board_edit?no=<%=vo.getNo()%>"><input class="rewrite" type="button" value="수정"/></a>
           <a href="javascript:delCheck()"><input class="del" type="button" value="삭제"/></a>
      </c:if>
   </div>
</div>
</body>
</html>