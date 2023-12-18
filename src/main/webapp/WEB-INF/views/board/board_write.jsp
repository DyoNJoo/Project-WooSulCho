<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
<link rel="stylesheet" href="/wsch/resources/css/board_write.css"/>
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
    <div class="event_list_img">
      <div class="text">행사 등록하기</div>
    </div>
    
    <div class="write_form">
      <form method="post" action="<%=request.getContextPath()%>/board/board_write_ok" enctype="multipart/form-data">
      
        <ul>
          <li>
            <label class="title" for="subject">제목</label>
            <input type="text" name="subject" id="subject" />
          </li>
          <li>
            <label class="title" for="start_date">시작 날짜</label>
            <input type="date" name="start_date" />
          </li>
          <li>
            <label class="title" for="end_date">종료 날짜</label>
            <input type="date" name="end_date" />
          </li>
          <li>
            <label class="title" for="location">장소</label>
            <input type="text" name="location" />
          </li>
          <li>
            <label class="title" for="fee">참가비용</label>
            <input type="text" name="fee" />
          </li>
          <li>
		    <label class="title" for="poster">포스터</label>
		    <input type="file" name="poster"/>		    
		  </li>          
          <li>
            <label class="title" for="content">내용</label>
            <textarea name="content" id="content"></textarea>
          </li>
          <li class="button_group">             
            <input class="rewrite" type="reset" value="다시쓰기" />    
            <input class="register" type="submit" value="글 등록" />                                   
          </li>
          
        </ul>
      </form>
      <script>
        CKEDITOR.replace('content');
      </script>
    </div>
  </div>
</body>
</html>