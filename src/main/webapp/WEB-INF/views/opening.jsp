<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WooSulCho</title>
<link rel="stylesheet" href="/wsch/resources/css/home.css"/>
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
<section class="video" id="video">
<div id="video_area" onclick="location.href='home'">
 <img class="click" src="resources/img/click.png" onclick="location.href='home'"/>
 <a onclick="location.href='home'" class="click-me">아무곳이나 클릭해보세요</a>
          <video src="resources/img/etc/showreel.mp4" id="background_video" 
          preload="auto" autoplay="autoplay" loop="loop" muted="muted" volume="0">
         </video></div>
<div class="wrap"></div>
</section>
</body>
</html>
