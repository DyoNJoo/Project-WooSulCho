<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
 <link rel="stylesheet" href="/wsch/resources/css/pw_searchOk.css"/>
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
    <div class="container">
        <article id="mainContent" class="content-article">
            <div class="user_inf">
                <h1 style="text-align: center;">비밀번호 찾기</h1>
                <div class="br">
                    <div class="result" style="text-align: center">
                      <p class="find_pw">${uservo.userid}님의 <br/><br/> 비밀번호는 ****${uservo.userpwd.substring(4)}입니다.<p>

                    </div>
                </div>
                <div class="br">
                    <div class="log_start">
                        <a href="<%= request.getContextPath() %>/users/login"> <input type="button" id="log_start" value="로그인 하기"></a>
                    </div>
                </div>
                </div>
        </article>
    </div>
    <script>
        var button = document.getElementById("log_start");

        button.addEventListener("click", function () {
            window.location.href = "/wsch/login"; // 원하는 링크로 수정
        });
    </script>
</body>

</html>