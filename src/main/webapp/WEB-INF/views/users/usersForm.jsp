<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/wsch/resources/css/usersForm.css"/>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    	$(function(){
    		
    		var header = document.querySelector("header");
    	     if (header) {
    	         header.style.display = "none";
    	     }

    	     // 푸터 숨기기
    	     var footer = document.querySelector("footer");
    	     if (footer) {
    	         footer.style.display = "none";
    	     }
    		
    		
    		var form = document.getElementById("form");
            var idInput = document.getElementById("userid");
            var idCheckButton = document.getElementById("idCheck");
            var idCheckHiddenInput = document.getElementById("chk");
            var passwordInput = document.getElementById("userpwd");
            var confirmPasswordInput = document.getElementById("pw_confirm");
            var emailInput = document.getElementById("email");
            var addressInput = document.getElementById("addr");
            var phoneInput = document.getElementById("phonenum");
			
			
            form.addEventListener("submit", function (event) {
                if (!validateForm()) {
                    event.preventDefault();
                }
            });

            idCheckButton.addEventListener("click", function () {
                // 여기에서 아이디 중복 확인을 위한 로직을 추가할 수 있습니다.
                // 서버에 아이디 중복 여부를 확인하는 AJAX 요청 등을 수행합니다.
                // 확인이 완료되면 idCheckHiddenInput 값을 'Y'로 변경합니다.
                
                // 위 내용들을 아래 함수에 넣었음
                idCheck();
                
            });

            function validateForm() {
                var isValid = true;

                // 아이디 유효성 검사
                if (idInput.value.trim() === "") {
                    setError(idInput, "아이디를 입력하세요.");
                    isValid = false;
                } else {
                	// 아이디 중복 체크 여부 검사
                    if(idCheckHiddenInput.value === "N"){
                    	setError(idInput, "아이디 중복 체크를 해야합니다.")
                    	isValid = false;
                    }else if(idCheckHiddenInput.value === "Y"){
                        clearError(idInput);
                    }
                }
                
                // 비밀번호 유효성 검사
                if (passwordInput.value.trim() === "") {
                    setError(passwordInput, "비밀번호를 입력하세요.");
                    isValid = false;
                } else {
                    clearError(passwordInput);
                }

                // 비밀번호 확인 유효성 검사
                if (confirmPasswordInput.value.trim() === "") {
                    setError(confirmPasswordInput, "비밀번호 확인을 입력하세요.");
                    isValid = false;
                } else if (passwordInput.value !== confirmPasswordInput.value) {
                    setError(confirmPasswordInput, "비밀번호가 일치하지 않습니다.");
                    isValid = false;
                } else {
                    clearError(confirmPasswordInput);
                }

                // 이메일 유효성 검사 (간단한 형식 확인)
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailInput.value.trim())) {
                    setError(emailInput, "올바른 이메일 형식이 아닙니다.");
                    isValid = false;
                } else {
                    clearError(emailInput);
                }             
				
                // 전화번호 유효성 검사 (숫자만 허용)
                var phoneRegex = /^[0-9]+$/;
                if (!phoneRegex.test(phoneInput.value.trim())) {
                    setError(phoneInput, "숫자만 입력하세요.");
                    isValid = false;
                } else {
                    clearError(phoneInput);
                }

                return isValid;
            }

            function setError(input, message) {
                var errorDiv = input.nextElementSibling;
                errorDiv.innerHTML = message;
                input.parentNode.classList.add("error");
            }

            function clearError(input) {
                var errorDiv = input.nextElementSibling;
                errorDiv.innerHTML = "";
                input.parentNode.classList.remove("error");
            }

    		
    		function idCheck(){
             	var userid = idInput.value.trim();
				
            	if(userid === ""){
                	alert("이이디를입력하세요...");
            		return false;
            	}
            	 $.ajax({
            		type: "POST",
            		url: "users/idCheck_ok",
            		data: {inputId:userid},
            		success: function(result){
            			if(result == "0"){
            				//에러div에 에러 대신 사용가능하다는 메세지를 표시
            				idInput.parentNode.classList.remove("error");
            				idInput.nextElementSibling.innerHTML = "사용 가능한 아이디입니다.";
            				//사용가능할때 값을 Y로 바꿔준다.
                            idCheckHiddenInput.value = "Y";

            			}else {
            				//에러div에 이미 사용중이라는 메세지를 표시
            				idInput.parentNode.classList.add("error");
            				idInput.nextElementSibling.innerHTML = "이미 사용중인 아이디입니다.";
            				idCheckHiddenInput.value = "N";
            			}
            		},
            		error: function(error){
            			console.log("Error:",error);
            		}
            	}); 
            	
            }
			//이메일이벤트
    	    $(function () {
    	        // 이메일 인증 번호를 서버에 요청하는 함수
    	        function requestEmailVerification() {
    	            var email = $("#email").val();
    	            
    	            // 이메일이 입력되지 않은 경우 예외 처리
    	            if (!email) {
    	                alert("이메일을 입력하세요.");
    	                return;
    	            }

    	            // 서버에 이메일 인증 번호를 요청
    	            $.ajax({
    	                type: "POST",
    	                url: "${pageContext.servletContext.contextPath}/sendEMail",
    	                data: { email: email },
    	                success: function (response) {
    	                    alert("인증번호를 발송했습니다.");
    	                    emailcode = response;
    	                    console.log(response);
    	                },
    	                error: function (error) {
    	                    console.error(error);
    	                }
    	            });
    	        }

    	        // 인증번호 받기 버튼 클릭 시 이벤트 처리
    	        $("#email-num-btn").on("click", function () {
    	            requestEmailVerification();
    	        });
					
    	     // 인증번호 확인 버튼 클릭 시 이벤트 처리
    	        $("#emailcode-chk").on("click", function () {
    	            verifyEmailCode();
    	        });

    	        // 이메일 코드 확인 함수
    	        function verifyEmailCode() {
    	            // 입력된 인증번호
    	            var enteredCode = $(".Certification-Number").val().trim();

    	            // 기대값 (예: 서버에서 받은 인증번호)
    	           var emailchk = document.getElementById("emailchk");

    	            // 입력된 코드와 기대값 비교
    	            if (enteredCode === emailcode) {
    	                // 인증번호 확인 성공
    	                alert("인증번호 확인 성공!");
    	                $("#emailchk").val("Y"); // 인증 성공 시 emailchk 값을 'Y'로 설정
    	            } else {
    	                // 인증번호 확인 실패
    	                alert("인증번호 확인 실패. 다시 시도하세요.");
    	            }
    	        }
    	        // 폼 제출 시 이벤트 처리
    	       $("#form").on("submit", function (event) {
    	             //이메일 인증 여부 체크
    	            var isEmailVerified = ($("#emailchk").val() === "Y");
					
    	            if (!isEmailVerified) {
    	                alert("이메일 인증을 먼저 완료하세요.");
    	                //event.preventDefault(); // 폼 제출 중지
    	            }
    	        });

    	    });

    	});
    </script>
</head>
<body>
    <div class="container">
        <form method= "post" id="form" action="<%=request.getContextPath()%>/users/usersForm_ok">
            <div id="register-title">회원가입</div><br/><br/>
            <div class="input-control">
                <label for="userid">아이디</label>
                <input id="userid" name="userid" type="text">
                <div class="error"></div>
                <input type="hidden" name="chk" id="chk" value="N"/>
                
                <a><button type="button" id="idCheck" name="idCheck" >중복확인</button></a>
                
            </div>
            <div class="input-control">
                <label for="userpwd">비밀번호</label>
                <input id="userpwd" name="userpwd" type="password">
                <div class="error"></div>
            </div>
            <div class="input-control">
                <label for="pw_confirm">비밀번호 확인</label>
                <input id="pw_confirm" name="pw_confirm" type="password">
                <div class="error"></div>
            </div>
            <div class="input-control">
                <label for="email">이메일</label>
                <input id="email" name="email" type="text">
                <div class="error"></div>
                 <button type="button" id="email-num-btn" name="email-num-btn">인증번호 받기</button>
                 <input class="Certification-Number" type="text" value="인증번호를 적어주세요"/>
                 <button type="button" id="emailcode-chk" name="emailcode-chk">인증번호 확인</button>
                 <input type="hidden" name="emailchk" id="emailchk" value="N"/>
            </div>
            <div class="input-control">
                <label for="addr">주소</label>
                <input id="addr" name="addr" type="text">
                <div class="error"></div>
            </div>
            <div class="input-control">
                <label for="phonenum">전화번호</label>
                <input id="phonenum" name="phonenum" type="text">
                <div class="error"></div>
            </div>
            <button type="submit" id="register-submit">가입하기</button>
        </form>
    </div>
</body>
</html>