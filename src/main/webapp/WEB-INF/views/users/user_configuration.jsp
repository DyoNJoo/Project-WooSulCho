<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @charset "UTF-8";
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .container-fluid {
            width: 1080px;
            margin-top: 80px;
        }

        .row {
            margin-top: 60px;
            height: 100vh;
        }

        .active {
            color: white;
            background-color: #776B5D;
            padding: 15px;
            font-size: 1em;
            border-radius: 4px;
        }

        .well {
            min-height: 20px;
            padding: 20px;
            background-color: #E2DED5;
            border-radius: 4px;
            text-align: center;
        }

        .member ul,
        .member_inf ul {
            display: flex;
            padding: 0;
        }

        .member ul li,
        .member_inf ul li {
            list-style-type: none;
            margin: 0 auto;
            text-align: center;
            flex: 1;
        }

        .line {
            border: 1px solid #afafaf;
            margin: 10px 0 10px 0;
        }

        .member_inf ul li:last-child {
            flex: 1;
        }

        .member_inf a {
            display: block;
            /* Make the link a block element */
            text-align: center;
            /* Center text */
            color: red;
            /* Change link color */
        }

        .but {
            display: flex;
            justify-content: space-between;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#member_del").click(function (event) {
                event.preventDefault();
                var checkedUsers = [];

                $(".member_chk:checked").each(function () {
                    checkedUsers.push($(this).val());
                });

                if (checkedUsers.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "${pageContext.servletContext.contextPath}/users/deleteUsers",
                        contentType: "application/json",  // 추가
                        data: JSON.stringify(checkedUsers),  // 변경
                        success: function (response) {
                            alert("선택된 사용자가 탈퇴되었습니다.");
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            alert("회원 탈퇴에 실패했습니다.");
                        }
                    });
                } else {
                    alert("선택된 사용자가 없습니다.");
                }
            });
        });
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
    <div class="container-fluid">
        <div class="well" style="background-color: #776B5D; color:#fff;">
            <h4>Administrator Page</h4>
            <p>회원 관리 페이지</p>
        </div>
        <div class="well">
            <div class="member">
                <ul>
                    <li>선택</li>
                    <li>아이디</li>
                    <li>이메일</li>
                    <li>주소</li>
                    <li>휴대폰 번호</li>
                </ul>
            </div>
            <div class="line"></div>
            <c:forEach var="row" items="${list}">
                <c:if test="${row.userid ne 'admin'}">
                    <div class="member_inf">
                        <ul>
                            <li><input type="checkbox" name="checkedUsers" value="${row.userid}" class="member_chk">
                            </li>
                            <li>${row.userid}</li>
                            <li>${row.email}</li>
                            <li>${row.addr}</li>
                            <li>${row.phonenum}</li>
                        </ul>
                        <div class="line"></div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="but" style="font-size: 20px;">
            <a href="/wsch/home">메인화면으로 돌아가기</a>
            <a href="/users/deleteUsers" id="member_del" style="color:red;">회원탈퇴</a>
        </div>
    </div>
</body>

</html>