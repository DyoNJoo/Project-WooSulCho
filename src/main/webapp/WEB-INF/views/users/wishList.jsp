<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"  %>
<%@ page import="com.project.wsch.vo.UserDAO" %>
<%@ page import="com.project.wsch.vo.UserVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="styleSheet" href="/wsch/resources/css/listanddetail.css">
<link rel="styleSheet" href="/wsch/resources/css/detailPage.css">
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
	main *{
		 font-family: 'GmarketSansMedium'; 
	}
	.infor{
		justify-content: center;
	}
	.infor > *{
		margin: 0px 30px;
	}
	h1{
		float: none;
		margin: 30px;
		text-align: center;
	}
	.go_back{
		margin-left: 100px;
		font-size: 22px;
		margin-bottom: 10px;
	}
</style>
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
<div id="headerImg">
		<img src="https://img.freepik.com/premium-photo/boozy-makgeolli-korean-rice-wine-generative-ai_786587-12725.jpg">
</div>
<main>
<div class="mypage">
	<div class="myinfo">
		<h1>Wish List</h1>
			<div class="rowStart">
				<div class="page_back">
    				<a href="javascript:history.back();" class="go_back"> < 뒤로가기</a>
				</div>
			</div>
				<c:forEach var="wish" items="${wishList }" varStatus="status">
				<c:forEach var="item" items="${items }">			
					<c:if test="${item.id eq wish.id }">
						<div class="infor">
					        <div class="left">
					        <a href="${pageContext.servletContext.contextPath }/items/detail/${item.id}">
					            <img class="image-thumbnail" src="${item.img_prod }" referrerpolicy="no-referrer"/>
					            </a>
					        </div>
					        
					        <div class="right">
					            <div class="row">
					            	<a href="${pageContext.servletContext.contextPath }/items/detail/${item.id}">					            
					        			<h2> ${item.name }</h2>
					        		</a>
					        		<svg id="id_${item.id }" class="wish wished" xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>        						        		                		
						        </div>
					            <h3>| 주원료 |  </h3>
					            <p>${item.materials }</p>
					            <h3>| 규격/도수 |  </h3>
					            <p>${item.amount } / ${item.abv }</p>            
					            <h3>| 제품 설명 |</h3>
					            <p>${item.desc }</p>
					            <br>
					        </div>
					    </div>
					    <br/>
			    	</c:if>
			    	</c:forEach>
		    	</c:forEach>
	</div>
</div>
</main>
<script>
$(document).ready(function(){
	//위시리스트 버튼 클릭시
	$(".wish").click(function(e){
		//로그인하지 않았을 경우
		<c:if test="${logStatus ne 'Y'}">
			alert("회원만 가능합니다.");
			return false;
		</c:if>
		
		//클릭당한놈의 아이디 가져오기
		var clickedId = $(this).attr('id');		
		
		//wish -> 이미 체크되어있으면 "on", 체크 안되어있으면 "off"
		var wish = "";
		if($(this).hasClass("wished")){
			wish = "on";
		}else {
			wish = "off";
		}
		
		var id = clickedId.substr(3);
		
		//ajax 요청 보내기
		$.ajax({
			url: "items/detail/wish",
			type: "POST",
			data: {
				id: id,
				wish: wish
			},
			success: function(data){
				console.log(wish);

				if(wish == "on"){
					console.log(wish);

					$("[id='"+clickedId+"']").removeClass("wished");
				}else if(wish == "off"){

					$("[id='"+clickedId+"']").addClass("wished");
				}
			},
			error: function(error){
				console.log(error);
			}
		});
		
	});
});
</script>
</body>
</html>