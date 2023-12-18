<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>챗봇 test</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
   <link rel="stylesheet" href="/wsch/resources/css/wsch_intro.css"/>
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
    $(function () {
        $("#queryBtn").click(function () {
            //질문입력유무
            if ($("#queryin").val() == '') {
                alert("질문을 입력하세요.");
                return false;
            }
            //ajax로 서버에 보내 결과받기
            $.ajax({
                url: 'chatbotMessage',
                data: {
                    queryin: $("#queryin").val(),
                },
                type: 'post',
                success: function (r) {
                    console.log(r);
                    var jsonChat = JSON.parse(r);
                    console.log(jsonChat);

                    var now = new Date(jsonChat.timestamp);
                    //질문을 뷰에 출력하고, queryin은 초기화
                    var queTag = "<div class='queRight'>" + $("#queryin").val() + "<br/><span style='font-size:10px;color:black;'>" + now + "</span></div><br/>";
                    $("#content").append(queTag);
                    $("#queryin").val("");

                  //답변처리
                    if (jsonChat.bubbles[0].type == "text") {
                        var txtAnswer = jsonChat.bubbles[0].data.description.replaceAll('\n', '<br/>');
                        txtAnswer = "<div class='queLeft'>" + txtAnswer + "<br/><span style='font-size:10px;color:black;'>" + now + "</span></div><br/>";
                        $("#content").append(txtAnswer);
                    } else if (jsonChat.bubbles[0].type == 'template') {//답변이 버튼으로 온 경우
                        var btnAnswer = "<div class='queLeft'><br/>";
                        //안내메시지
                        btnAnswer += jsonChat.bubbles[0].data.cover.data.description + "<br>";

                        btnAnswer += "<div class='d-grid gap-1'>";
                        jsonChat.bubbles[0].data.contentTable.map(function (value, i) {
                            btnAnswer += "<input type='button' value='" + value[0].data.title + "' class='btn btn-outline-danger btn-block'";
                            btnAnswer += "onclick='location.href=\"" + value[0].data.data.action.data.url + "\"'/>";
                        });

                        btnAnswer += "</div></div><br/>";
                        $("#content").append(btnAnswer);
                    } else if (jsonChat.bubbles[0].type == 'carousel') {
                        var imageJson = jsonChat.bubbles[0].data;

                        var imageAnswer = '<div class="queLeft" style="width:300px">';
                        imageAnswer += '<div id="demo" class="carousel slide" data-bs-ride="carousel" style="width:270px">';
                        imageAnswer += '<div class="carousel-inner">';
                    }//if

                    //스크롤바를 맨 아래로 보내기
                    var div = document.getElementById("content");
                    div.scrollTop = div.scrollHeight;
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });
        });
    });
    </script>
</head>

<body>
<div id="headerImg">
      <img src="https://img.freepik.com/premium-photo/boozy-makgeolli-korean-rice-wine-generative-ai_786587-12725.jpg">
   </div>
    <div class="container">
        <div class="chatbotMain">
            <div class="chatbot_header">
                <h5>Chatbot</h5>
                <h6>무엇을 도와드릴까요?</h6>
            </div>
            <div id="content">
            </div>
            <!-- 질문을 입력하는 곳 -->
            <div class="input-group">
                <input type="text" class="form-control" placeholder="질문을 입력하세요" name="queryin" id="queryin" />
                <button id="queryBtn" class="btn btn-success" style="background-color:#776B5D; border-color: #776B5D">보내기</button>
            </div>
        </div>
    </div>
</body>

</html>