<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/wsch/resources/css/idpw_search.css">
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
    <div class="wrap">
        <div class="search">
            <div class="id_search" id="id_search" onclick="goToIdSearch()">
                <h1>아이디 찾기</h1>
                <br><br>
                <p>아이디를 잊어버리셨나요?</p>
                <img src="/wsch/resources/img/id-card.png" id="img">
            </div>
        </div>
        <div class="search">
            <div class="pw_search" id="pw_search" onclick="goToPasswordSearch()">
                <h1>비밀번호 찾기</h1>
                <br><br>
                <p>비밀번호를 잊어버리셨나요?</p>
                <img src="/wsch/resources/img/password.png" id="img">
            </div>
        </div>
    </div>
    <div class="back">
        <input type="button" value="뒤로 가기" id="go_back" onclick="goBack()">
    </div>
    <script>
        function goBack() {
            window.location.href = "/wsch/users/login";
        }
        function goToIdSearch() {
            window.location.href = "/wsch/users/id_search";
        }
        function goToPasswordSearch() {
            window.location.href = "/wsch/users/pw_search";
        }
    </script>
</body>

</html>