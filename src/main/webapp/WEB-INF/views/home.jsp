<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<%@page import="com.project.wsch.vo.BoardDAO"%>
<%@page import="com.project.wsch.vo.BoardVO"%>
<%@page import="java.util.List"%>
<head>
<meta charset="UTF-8">
<title>woosulcho</title>
<link href="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11.0.4/swiper-bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/wsch/resources/css/home.css"/>
</head>
<body>
<a href="/wsch/wsch_intro" target="_blank">
    <img src="resources/img/chaticon1.png" class="chat-icon" id="chaticon" alt="Chat Icon">
  </a>
<script>
  window.addEventListener('scroll', function() {
    var scrollPosition = window.scrollY || document.documentElement.scrollTop;
    var chatIcon = document.getElementById('chaticon');

    // 예제: 스크롤 위치가 200px 이하이면 chaticon2를, 그렇지 않으면 chaticon1을 사용
    if (scrollPosition >= 200) {
      chatIcon.src = 'resources/img/chaticon1.png';
    } else {
      chatIcon.src = 'resources/img/chaticon2.png';
      chatIcon.style.backgroundColor = 'transparent';
    }
  });
</script>
<div class="container">
 	<section class="content1">	
	<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img src="resources/img/main-swiper-img1.jpg">
									
						<div class="woosulcho">WooSulCho</div>
				</div>
				<div class="swiper-slide">
					<img src="resources/img/main-swiper-img2.png">
						<div class="img-blur-right"></div>
						<div class="main-text-right7">"우술초"</div>
						<div class="main-text-right4">우리들의</div>
						<div class="main-text-right5">술이야기,</div>
						<div class="main-text-right6">당신을 초대합니다.</div>
				</div>
				<div class="swiper-slide">
					<img
						src="resources/img/main-swiper-img3.jpg">
						<div class="img-blur-left"></div>
						<div class="main-text-left1">우술초에게</div>
						<div class="main-text-left2">궁금한 것이 있다면?</div>
						<a href="<%= request.getContextPath() %>/wsch_intro">
				<button type="button" class="recommend-btn-left" >질문하기				
				</button></a>
				</div>
				<div class="swiper-slide">
					<img src="resources/img/main-swiper-img4.png">
						<div class="img-blur-right"></div>						
						<div class="main-text-right1">어떤 전통주가 취향에 맞을지 잘 모르겠다면?</div>
						<div class="main-text-right2">나의 취향에 맞는 전통주</div>
						<div class="main-text-right3">추천 테스트</div>
						<a href="<%= request.getContextPath() %>/items/recmnd">
				<button type="button" class="recommend-btn-right" >바로가기			
				</button></a>
				</div>				
			</div>
		</div>		
	</section>
	<section>
		<div class="Recommend" >전통주 추천</div>
	</section>
	<section class="wsch-recommend fade-class" id="wsch-recommend">
			<div class="recommend-text3">어떤 전통주가 취향에 맞을지 잘 모르겠다면?</div>   
         	<!-- <div class="recomend-text1">나에게 잘 맞는 우리술</div><br/> -->
         	<div class="recommend-text1">나만의 전통주</div><br/>
         	<div class="recommend-text2">추천 테스트</div>
			<a href="<%= request.getContextPath() %>/items/recmnd">
				<button type="button" class="testbtn" >테스트 시작하기
					<img class="testimg3" src="resources/img/click.png" />
				</button></a>
			<img class="testimg1" src="https://contents.lotteon.com/display/dshoplnk/48028/58/C001391/282292/PA37E52FFC34E1FD40468BBEF766A53AC568C9BE97A455CEFA44E85B69D9BFB0C/file" />
			
			
 	</section>
 	<div style="width:10%; height:70vh; background-color:#b0a695; position:absolute; left:0; top:230%;"></div>
	<div style="width:90%; height:70vh; border:4px solid #b0a695; position:absolute; right:0; top:230%;"></div>
<section class="best-item fade-class" id="best-item">
<div class="best">Best</div>
 	 <div class="slide-container swiper">
 		<div class="slide-content">
 			<div class="card-wrapper swiper-wrapper">
 				<c:forEach var="item" items="${bestList }" varStatus="status" >
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
	 						<h2 class="name"> ${status.count }. ${item.name } </h2>
	 						<p class="description">${item.desc }</p>
	 					
	 						<button class="button" onclick="location.href='${pageContext.servletContext.contextPath }/items/detail/${item.id}'">View detail</button>
	
	 					</div>
 					</div>
 				</c:forEach>
 			</div>
 		</div>	
  		<div class="swiper-button-next swiper-navBtn"></div>
 		<div class="swiper-button-prev swiper-navBtn"></div>
 		<div class="swiper-pagination"></div>
 	</div> 
</section>
<section>
		<div class="Recommend" >우리의 전통주</div>
	</section>
<section class="main-video" id="video">
<div id="main_video_area">
<div class="video-text">WooSulCho</div>
<div class="video-text-2">우리들의 술이야기</div>
          <video src="resources/img/etc/mainvideo.mp4" id="main_video" 
          preload="auto" autoplay="autoplay" loop="loop" muted="muted" volume="0">
         </video></div>
</section>

 <%
    BoardDAO dao = new BoardDAO();
    List<BoardVO> lst = dao.boardSelectAll();  
%>

<section class="event-list" id="event-list">
    <h1 class="event">전통주 행사일정</h1>
    <div class="event-list-wrap">
        <ul class="poster-list" id="imgList">
        </ul>
    </div>
</section>
</div>
<!-- 1번section이미지 swiper -->
 <script>
    var swiper1 = new Swiper('.swiper-container', {
            slidesPerView: 1,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            loop: true,
            speed: 2800,
            autoplay: {
                delay: 4500,
                disableOnInteraction: false,
            },
            on: {
                slideChangeTransitionStart: function () {
                    $(".woosulcho").fadeOut(300); // 텍스트 숨기기
                },
                slideChangeTransitionEnd: function () {
                    $(".woosulcho").fadeIn(300); // 텍스트 나타내기
                }
            },
        });
</script> 
<!-- 3번section slide content -->
<script>
var swiper2 = new Swiper(".slide-content", {
    slidesPerView: 3,
    spaceBetween: 25,
    loop: true,
    centeredSlides: true,
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

<script>
const targets = document.querySelectorAll(".fade-class");
const options = { root: null, threshold: 0.1, rootMargin: "-0px" };
const observer = new IntersectionObserver(function (entries, observer) {
  entries.forEach((entry) => {
    const container = entry.target;
    if (entry.isIntersecting) {
      container.classList.add("fade-in");
    } else {
      container.classList.remove("fade-in");
    }
  });
}, options);

targets.forEach((target) => {
  observer.observe(target);
});
</script>

<script>
    // 포스트 목록 셋팅하기
   function setPosterList() {
    var imgList = document.getElementById("imgList");

    <% for (BoardVO vo : lst) { %>
        if ("<%= vo.getPoster() %>" !== null) {
            var listItem = document.createElement("li");
            listItem.className = "poster-item";

            var link = document.createElement("a");
            link.href = "<%= request.getContextPath() %>/board/board_view?no=<%= vo.getNo() %>";

            var img = document.createElement("img");
            img.src = "<%= request.getContextPath() %>/<%= vo.getPoster() %>";
            img.alt = "포스터 이미지";
            img.style.width = "430px";
            img.style.height = "500px";

            link.appendChild(img);
            listItem.appendChild(link);
            imgList.appendChild(listItem);
        }
    <% } %>
}


    var xStep = -1;
    var x = 0;

    function posterMove() {
        x += xStep;
        var imgList = document.getElementById("imgList");
        var imgCount = imgList.querySelectorAll(".poster-item").length;
        if (x <= - (500 * imgCount)) {
            xStep = 1;
        }
        if (x > 0) {
            xStep = -1;
        }
        imgList.style.left = x + "px";
    }

    window.onload = function () {
        setPosterList();
        timer = setInterval(posterMove, 0);

        document.getElementById("imgList").onmouseover = function () {
            clearInterval(timer);
        };

        document.getElementById("imgList").onmouseout = function () {
            timer = setInterval(posterMove, 0);
        };
    }
</script>