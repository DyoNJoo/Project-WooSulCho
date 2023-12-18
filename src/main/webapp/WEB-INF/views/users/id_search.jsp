<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
   <link rel="stylesheet" href="/wsch/resources/css/id_search.css"> 
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
 <form method="post" action="/wsch/users/id_searchOk" id="emailForm">
  <div class="container">
    <article id="mainContent" class="content-article">
        <div class="user_inf">
            <h1 style="text-align: center; margin-left: 140px;">아이디 찾기</h1>
            <br/>
            <br/><br/>
            <div class="br">
                <div class="user_email">
                    <h1>이메일</h1>
                    <input type="text" id="user_email" name="userEmail">
                </div>
            </div>
            <div class="br">
                <div class="search_start">
                    <button id="sea_sta" onclick="checkEmail(event)">아이디 찾기</button>
                </div>
            </div>

            <div class="br">
                <br>
                <a href="<%= request.getContextPath() %>/users/pw_search" style="text-decoration-line: none; color: #000;">비밀번호를 잊으셨나요?</a>
                <br>
                <a href="<%= request.getContextPath() %>/users/idpw_search" style="text-decoration-line: none; color: #000;">뒤로가기</a>
            </div>
        </div>
    </article>
</div>
</form>  
</body>
 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
 <script>
         function checkEmail(event) {
             var useremail = $("#user_email").val();
             if (!useremail) {
                 alert('이메일을 입력해주세요.');
                 event.preventDefault(); // 기본 동작 중단
             } else {
                 $("#emailForm").submit();
             }
         }
 </script>
</html>