<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<title>전통주 추천</title>
<link rel="stylesheet" href="/wsch/resources/css/recmndStyle.css">
<link rel="stylesheet" href="/wsch/resources/css/sakura.css">
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 푸터 숨기기
    var footer = document.querySelector("footer");
    if (footer) {
        footer.style.display = "none";
    }
});

</script>
<script>
	$(window).load(function() {
		$('body').sakura();
	});
</script>
<script>
	var result = [];
	
	$(function() {
		$(".first_page").hide();
		$(".recmnd").hide();
		$("#AI").hide();
		$("#next")
				.click(
						function() {
							var name = $("#question").attr('name');

							if (name == 'q1') {
								$("#img").attr("src","/wsch/resources/img/recmnd/sugar_1.png");
								$("#question").text("#2 : 어느정도 단맛을 원하시나요?");
								$("#question").attr('name', 'q2');
								result[0] = $("#answer_in").val();

								$("#answer_in").val("1");

							} else if (name == 'q2') {
								$("#img").attr("src","/wsch/resources/img/recmnd/lemon_1.png");
								$("#question").text("#3 : 어느정도 신맛을 원하시나요?");
								$("#question").attr('name', 'q3');
								result[1] = $("#answer_in").val();

								$("#next-a").attr('value', '결과 보기');

								$("#answer_in").val("1");

							} else if (name == 'q3') {
								result[2] = $("#answer_in").val();
								$("#next").hide();
								$("#img").css({
											width : '50%', // 원하는 너비
											height : '50%' // 원하는 높이
										}).attr("src", "/wsch/resources/img/recmnd/AI_searching.webp");
								$("#question").text("결과를 가져오는중입니다...");
								$("#AI").show();
								$("#answer_in").hide();
								setTimeout(function() {
									$("#AI").hide();
									$("#question").text("결과가 나왔습니다!");
									$("#img").attr("src", "/wsch/resources/img/recmnd/banging-tom-and-jerry.gif");
									$("#result").text( "답변한 값들 : 바디감 " + result[0] + ", 단맛 " + result[1] + ", 신맛 " + result[2]);
									setTimeout(function() {
										$(".first_page").fadeIn(2000, function() {
											$(this).prop('disabled',false);
										});
										$("#result_go").fadeIn(2000,function() {
											$(this).prop('disabled',false);
										});
											}, 1000);
								}, 3000);
							}
						});
		
		$("#result_go").click(function() {
            var body = result[0];
            var sweet = result[1];
            var sour = result[2];
            console.log(body, sweet, sour);
            // Ajax를 사용하여 서버에 필터링된 아이템을 요청
            $.ajax({
                type: "GET",
                async : false,
                url: "${pageContext.servletContext.contextPath}/items/recmnd/result",
                data: { body: body, sweet: sweet, sour: sour },
                dataType: 'json', // JSON으로 데이터를 받아올 것이므로 추가
                success: function(data) {
                    // 서버에서 받아온 데이터를 화면에 표시
                    $("#question").text("결과!");
                    $(".recmnd").show();
                    $("#img, #result, #next, #result_go").hide();
                    $(".first_page").show();
                    $(this).hide();
                    $(".recmnd").fadeIn(2000);
                    
                    //////
                   var tag = "" 
                   $(data).each(function(index, item) {
                	   tag +=  `<div class="item">
								<div class="image">
									<a href="/wsch/items/detail/`+item.id+`">
										<img class="soolimg" referrerpolicy="no-referrer" src="`+item.img_prod+`" alt="`+item.name+`">
									</a>
								</div>
								<div class="inf">
									<div class="title"><h2>`+item.name+`</h2></div>
								</div>
						    </div>`;                	   
                   });
                   $("#recmnd").append(tag);
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });
	});
</script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}</style>
</head>

<body>
	<div class="bg">
		<main>
			<div class="wrap" style="text-align: center;">
				<div
					style="width: 100%; max-width: 1080px; margin: 0 auto; padding: 150px 0 0 0; text-align: center;">
					<p style="font-size: 30px; font-weight:bold; font-family: 'GmarketSansMedium';">나만의 전통주 찾아보기</p>
					<div id="question" name="q1" style="font-size: 30px;">#1 어느정도
						바디감을 원하시나요?</div>
					<div id="answer">
						<input id="answer_in" type="range" value="1" min="1" max="5"
							list="tickmarks" />
						<datalist id="tickmarks">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</datalist>
					</div>
					<img src="/wsch/resources/img/recmnd/wine.png" id="img"
						style="padding: 20px;">
					<p style="font-size: 15px;" id="AI">(여러분의 관심사와 흥미를 빅데이터로 분석하여 가장 높은 관심도를 이끌어낼 만한 전통주를 도출하는 중입니다.)</p>
					<div id="result" style="margin-bottom: 25px;"></div>
					<input type="button" id="next" value="다음" /> <input type="button"
						id="result_go" value="결과확인" style="display: none;" />
					<div class="result2">
						<div class="recmnd" id="recmnd">	
							</div>
						<button class="first_page" onclick='location.reload();'>처음으로</button>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script src="/wsch/resources/js/recmnd/sakura.js"></script>
</body>