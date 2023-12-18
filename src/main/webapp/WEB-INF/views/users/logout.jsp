<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/wsch/resources/css/logout.css"/>
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
<div class="logout">
<div class="logout-white">
<p>로그아웃하시겠습니까?</p>
<button class="yes" onclick="location.href='${pageContext.servletContext.contextPath}/users/logoutOk'">네</button>
<button class="no"onclick="history.go(-1)">아니오</button>
</div>
</div>
</body>
</html>