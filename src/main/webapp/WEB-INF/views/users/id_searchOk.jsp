<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
     <link rel="stylesheet" href="/wsch/resources/css/id_searchOk.css">
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
        <h1 class="title">ID 찾기 결과</h1>
        	<div class="idsearchbox">
        <%-- 아이디가 없는 경우의 처리 --%>
       <c:if test="${empty uVO}">
            <p class="find_id">해당 이메일로 <br/><br/><br/>등록된 아이디가 없습니다.</p>
        </c:if>
        <%-- 아이디가 있는 경우의 처리 --%>
        <c:if test="${not empty uVO}">
        	<c:forEach var="uvo" items="${uVO}">
            	<p class="find_id">찾은 아이디: ${uvo.userid}</p> 
            </c:forEach>           
        </c:if>
       <a href="<%= request.getContextPath() %>/users/login"> <button class="searchok"  id="searchok">확인</button></a>
        </div>
    </div>
</body>
</html>