<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  <link rel="stylesheet" href="/wsch/resources/css/pw_search.css"/>
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
	<form method="post" action="/wsch/users/pw_search" id="pwForm">
    <div class="container">
        <article id="mainContent" class="content-article">
            <div class="user_inf">
                <h1 style="text-align: center;">비밀번호 찾기</h1>
                
                <div class="br">
                    <div class="user_id">
                    <br/>
                        <h1>아이디</h1>
                        <input type="text" id="userid" name="id">
                    </div>
                </div>
                <div class="br">
                    <div class="user_email">
                        <h1>이메일</h1>
                        <input type="text" id="user_email" name="email">
                    </div>
                </div>
                <div class="br">
                    <div class="search_start">
                        <button id="sea_sta">비밀번호 찾기</button>
                        <br>
                       <a href="<%= request.getContextPath() %>/users/login" style="text-decoration-line: none; color: #000;">뒤로가기</a>
                    </div>
                </div>
               </div>
        </article>
    </div>
    </form>
  <script>
        var button = document.getElementById("sea_sta");

        button.addEventListener("click", function (event) {
            var userId = document.getElementById("userid").value;
            var userEmail = document.getElementById("user_email").value;

            if (!userId || !userEmail) {
                alert('아이디와 이메일을 모두 입력해주세요.');
                event.preventDefault(); // 폼 제출 방지
            } else {
                window.location.href = "/wsch/pw_searchOk"; // 원하는 링크로 수정
            }
        });
    </script>
</body>
</html>