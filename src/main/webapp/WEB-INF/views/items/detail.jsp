<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    
    <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
    <link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <title>product_detail</title>
    <link rel="styleSheet" href="/wsch/resources/css/detailPage.css">
    <link rel="styleSheet" href="/wsch/resources/css/listanddetail.css">
    
    <style>
        @font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
        .content2 {
            display: flex;
            align-items: center;
            justify-content: center;
        }
.slide-container {
    max-width: 1120px;
            width: 100%;
            padding: 40px 0;
}
.slide-content {
	margin: 0 40px;
	overflow: hidden;
	border-radius: 25px;
}
.card {
	width: 320px;
	border-radius: 25px;
	background-color: #fff;
}
.image-content, .card-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 10px 14px;
}
.image-content {
	position: relative;
	row-gap: 5px;
	padding: 25px 0;
}

.overlay {
	position: absolute;
	left: 0;
	top: 0;
	height: 100%;
	width: 100%;
	background-color: #E2DED5;
	border-radius: 25px 25px 0 25px;
}

.overlay::before, .overlay::after {
	content: '';
	position: absolute;
	right: 0;
	bottom: -40px;
	height: 40px;
	width: 40px;
	background-color: #E2DED5;
}

.overlay::after {
	border-radius: 0 25px 0 0;
	background-color: #fff;
}

.card-image {
	position: relative;
	height: 150px;
	width: 150px;
	border-radius: 50%;
	background: #fff;
	padding: 3px;
}

.card-image .card-img {
	height: 100%;
	width: 100%;
	object-fit: cover;
	border-radius: 50%;
/* 	border: 4px solid #E2DED5; */
}

.name {
	font-size: 18px;
	font-weight: 500;
	color: #333;
}

.description {
	height: 150px;
	font-size: 14px;
	color: #707070;
	text-align: center;
}

.button {
	border: none;
	font-size: 16px;
	color: #fff;
	padding: 8px 16px;
	background-color:   #776B5D;
	border-radius: 6px;
	margin: 14px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.button:hover {
	background: #B0A695;
}

.swiper-navBtn {
	color:   #E2DED5;
	transition: color 0.3s ease;
}

.swiper-navBtn:hover {
	color: #776B5D;
}

.swiper-navBtn::before, .swiper-navBtn::after {
	font-size: 40px;
}

.swiper-button-next {
	right: 0;
}

.swiper-button-prev {
	left: 0;
}
.swiper-pagination-bullet {
	
	background: transparent;
	border: 1px solid  #E2DED5;
	opacity: 1;
}

.swiper-pagination-bullet-active {

	transition: width .5s;
	border-radius: 5px;
	background: #E2DED5;
	border: 1px solid transparent;
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
	<div id="headerImg">
		<img src="https://img.freepik.com/premium-photo/boozy-makgeolli-korean-rice-wine-generative-ai_786587-12725.jpg">
	</div>
    <main>
    <div id="topWrap">
	    <div id="navBar">
            <ul id="nav">
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=all">전체(${total })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=탁주">탁주(${total1 })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=청주">청주(${total2 })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=약주">약주(${total3 })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=과실주">과실주(${total4 })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=증류주">증류주(${total5 })</a></li>
                <li class=""><a href="${pageContext.request.contextPath }/items/list?type=리큐르">리큐르/기타(${total6 })</a></li>
            </ul>
		</div>
	</div>
	<div class="page_back">
    	<a href="javascript:history.back();" class="go_back"> < 뒤로가기</a>
       	<!-- 조건 추가하기...이전 페이지가 list페이지면 뒤로 가고, 아니면 리스트 페이지로 보내주기 -->
       	<a href="javascript:history.back();" class="go_back">목록보기</a>
    </div>
    <div class="page">
       <p class="page_inf">상세 페이지</p>
    </div>   
    <div class="infor">
        <div class="left">
            <img class="image-thumbnail" src="${item.img_prod }" referrerpolicy="no-referrer"/>
        </div>
        
        <div class="right">
            <div class="row">
        		<h2> ${item.name }</h2>
        	
        	<c:if test="${wishvo.userid eq null }">
        		<svg class="wish" xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>        	
        	</c:if>
        	<c:if test="${wishvo.userid ne null }">
        	    <svg class="wish wished" xmlns="http://www.w3.org/2000/svg" height="24" width="24" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>        	        	
        	</c:if>        
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
    <div class="line"></div>
    <div class="infor_2">
        <div class="detail">
            <h3>| 맛 그래프 |</h3>
            <img src="${item.img_taste }" referrerpolicy="no-referrer" />            
        </div>
        <div class="line"></div> 
    </div>
    <div id="searchTrendView">
        <br>
        <h2 style="text-align: center;">서치트랜드</h2>
        <h3 style="text-align: center;">${item.name }와 연관된 추천 상품 더보기</h3>
        <section class="content2">
<div class="slide-container swiper">
    <div class="slide-content">
        <div class="card-wrapper swiper-wrapper">
            <c:forEach var="item" items="${bestList }">
 					<div class="card swiper-slide">
	 					<div class="image-content">
	 						<span class="overlay"></span>
	 						<div class="card-image">
	 							<a href="${pageContext.servletContext.contextPath }/items/detail/${item.id}">
	 								<img src="${item.img_prod }" class="card-img" referrerpolicy="no-referrer">
	 							</a>
	 						</div>
	 					</div>
	 					
	 					<div class="card-content">
	 						<h2 class="name">${item.name } </h2>
	 						<p class="description">${item.desc }</p>
	 					
	 						<button class="button" onclick="location.href='${pageContext.servletContext.contextPath }/items/detail/${item.id}'">View detail</button>
	
	 					</div>
 					</div>
 			</c:forEach>
   
            
        </div>
    </div>	
    <div class="swiper-button-next swiper-navBtn"></div>
    <div class="swiper-button-prev swiper-navBtn"></div>
    <div class="swiper-pagination "></div>
    </main>
    <script src="
https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.js
">
</script>

<script>
$(document).ready(function() {
	//위시리스트 버튼 클릭시
	$(".wish").click(function(e){
		//로그인하지 않았을 경우
		<c:if test="${logStatus ne 'Y'}">
			alert("회원만 가능합니다.");
			return false;
		</c:if>
		
		//wish -> 이미 체크되어있으면 "on", 체크 안되어있으면 "off"
		var wish = "";
		if($(this).hasClass("wished")){
			wish = "on";
		}else {
			wish = "off";
		}
		
		var id = "${item.id}";
		
		//ajax 요청 보내기
		$.ajax({
			url: "wish",
			type: "POST",
			data: {
				id: id,
				wish: wish
			},
			success: function(data){
				console.log(wish);

				if(wish == "on"){
					console.log(wish);

					$(".wish").removeClass("wished");
				}else if(wish == "off"){

					$(".wish").addClass("wished");
				}
			},
			error: function(error){
				console.log(error);
			}
		});
		
		
		
	});
});
</script>

<script>
var swiper = new Swiper(".slide-content", {
    slidesPerView: 3,
    spaceBetween: 25,
    loop: true,
    centeredSlides: true, // 'true' 대신에 'centeredSlides'로 수정
    fade: true,
    grabCursor: true,
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
        dynamicBullets: true,
    },
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    breakpoints: {
        0: {
            slidesPerView: 1,
        },
        520: {
            slidesPerView: 2,
        },
        950: {
            slidesPerView: 3,
        },
    },
});
</script>
</body>
</html>