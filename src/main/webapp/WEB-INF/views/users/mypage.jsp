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
<link rel="stylesheet" href="/wsch/resources/css/mypage.css"/>
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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
<%
	session = request.getSession();
	UserDAO dao = new UserDAO();
	UserVO vo = dao.selectAll(session);
%>
<div class="mypage">
<div class="myinfo">
<h3>내 정보</h3>
	<table>
		<tbody>
			<tr>
			<td>아이디 : </td>
			<td><%= vo.getUserid() %></td>
			</tr>
			<tr>
			<td>비밀번호 : </td>
			<td><%= vo.getUserpwd() %></td>
			</tr>
			<tr>
			<td>이메일 : </td>
			<td><%= vo.getEmail() %></td>
			</tr>
			<tr>
			<td>주 소 : </td>
			<td><%= vo.getAddr() %></td>
			</tr>
			<tr>
			<td>전화번호 : </td>
			<td><%= vo.getPhonenum() %></td>
			</tr>
		</tbody>
	</table>
	<div>
	<button class="saveitems" onclick="location.href='wishList'">위시리스트</button>
	<button class="editbtn" onclick="location.href='edit'">회원정보 변경</button>
	</div>
</div>
</div>
</body>
</html>