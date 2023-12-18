<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"  %>
<%@ page import="com.project.wsch.vo.UserDAO" %>
<%@ page import="com.project.wsch.vo.UserVO" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/wsch/resources/css/mypage.css"/>
<title>회원정보 수정</title>
<script>
 document.addEventListener("DOMContentLoaded", function () {
     // 푸터 숨기기
     var footer = document.querySelector("footer");
     if (footer) {
         footer.style.display = "none";
     }
 });
 
 $(document).ready(function() {
	    $("#form").submit(function(e) {
	        e.preventDefault();

	        var formData = {
	            userpwd: $("input[name='userpwd']").val(),
	            email: $("input[name='email']").val(),
	            addr: $("input[name='addr']").val(),
	            phonenum: $("input[name='phonenum']").val()
	        };

	        $.ajax({
	            type: "POST",
	            contentType: "application/json; charset=utf-8",
	            url: "<%=request.getContextPath()%>/editOk",
	            data: JSON.stringify(formData),
	            success: function(response) {
	                alert('회원 정보가 성공적으로 수정되었습니다.');
	                window.location.href = "<%=request.getContextPath()%>/mypage";
	            },
	            error: function(xhr, status, error) {
	                alert('회원 정보 수정에 실패하였습니다. 에러 메시지: ' + xhr.responseText);
	            }
	        });
	    });
	});
</script>
</head>
<body>
<%
	session = request.getSession();
	UserDAO dao = new UserDAO();
	UserVO vo = dao.selectAll(session);
%>
<div class="mypage">
	<form method="post" id="form" action="<%=request.getContextPath()%>/editOk">
		<div class="myinfo">
			<h3>내 정보 수정</h3>
				<table>
					<tbody>
						<tr>
						<td>아이디 : </td>
						<td><input class="change" type="text" name="userid" value="<%= vo.getUserid() %>" readonly="readonly"/></td>			
						</tr>
						<tr>
						<td>비밀번호 : </td>
						<td><input class="change" type="text" name="userpwd" value="<%= vo.getUserpwd() %>"/></td>
						</tr>
						<tr>
						<td>이메일 : </td>
						<td><input class="change" type="email" name="email" value="<%= vo.getEmail() %> " readonly="readonly"/></td>
						</tr>
						<tr>
						<td>주 소 : </td>
						<td><input class="change" type="text" name="addr" value="<%= vo.getAddr() %>"/></td>
						</tr>
						<tr>
						<td>전화번호 : </td>
						<td><input class="change" type="text" name="phonenum" value="<%= vo.getPhonenum() %>"/></td>
						</tr>
					</tbody>
				</table>
			<button class="savebtn">회원정보 변경 저장</button>
		</div>
	</form>
</div>
</body>
</html>