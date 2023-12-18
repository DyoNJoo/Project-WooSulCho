<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/wsch/resources/css/login.css">
<script>
	function loginCheck() {
		if (document.getElementById("userid").value == "") {
			alert("아이디 입력 후 로그인 하세요..");
			return false;
		}
		if (document.getElementById("userpwd").value == "") {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		return true;
	}
</script>
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
		<form method="post"
			action="${pageContext.servletContext.contextPath}/users/loginOk"
			onsubmit="return loginCheck()">
			<div class="login">
				<div class="login_dic">
					<div class="title">
						<a href="<%= request.getContextPath() %>/wsch/home"><img src="/wsch/resources/img/logo.png" id="title"></a>
					</div>
				</div>
				<div class="id">
					<h4 style="font-family: G마켓 산스;">사용자 ID</h4>
					<input type="text" name="userid" id="userid" placeholder="아이디">
				</div>
				<div class="pw">
					<h4 style="font-family: G마켓 산스;">비밀번호</h4>
					<input type="password" name="userpwd" id="userpwd"
						placeholder="비밀번호">
				</div>
				<div class="login_etc">
					<div class="auto_login">
						
					</div>
					<div class="forgot">
						<a href="/wsch/users/idpw_search">아이디/비밀번호 찾기</a><br>
					</div>
				</div>
				<div class="submit">
					<input type="submit" id="login_button" value="로그인">
				</div>
				<div class="sign_up">
					<a href="/wsch/usersForm">회원가입</a>
				</div>
			</div>
		</form>
	</div>
</body>

</html>

