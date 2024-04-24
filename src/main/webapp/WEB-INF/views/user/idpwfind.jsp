<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디/비밀번호 찾기</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
		#main{
			position: relative;
	    	bottom: 200px;
		}
		#footer{
			position: relative;
	    	bottom: 200px;
		}
    	main#main {
    		width: 30%;
		}
	</style>
</head>
<body>
	<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
    <main id="main" class="container mt-5">
        <!-- 아이디 찾기 폼 -->
        <form id="find-id-form">
            <h2>아이디 찾기</h2>
            <div class="mb-3">
                <input type="hidden" id="email-id" name="userEmailId">
                <label for="userEmail1-id" class="form-label">이메일</label>
                <div class="input-group">
                    <input type="text" class="form-control" name="userEmail1-id" id="userEmail1-id" placeholder="이메일">
                    <select class="form-select" name="userEmail2-id" id="userEmail2-id">
                        <option>@naver.com</option>
                        <option>@daum.net</option>
                        <option>@gmail.com</option>
                        <option>@hanmail.com</option>
                        <option>@yahoo.co.kr</option>
                    </select>
                    <button type="button" class="btn btn-primary" id="mail-Check-Btn-id">인증번호 전송</button>
                </div>
            </div>
            <div class="mb-3">
                <label for="mail-check-input-id" class="form-label">인증번호</label>
                <div class="input-group">
                    <input class="form-control mail-check-input-id" id="mail-check-input-id" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
                    <button type="button" class="btn btn-success" id="verify-Code-Btn-id" disabled="disabled">인증번호 확인</button>
                </div>
            </div>
            <input type="button" value="아이디 찾기" id="id-find" class="btn btn-primary" disabled onclick="pop();">
        </form>
        <hr>
        <!-- 비밀번호 찾기 폼 -->
        <form action="/user/pwfind.ft" method="post" id="find-pw-form">
            <h2>비밀번호 찾기</h2>
            <div class="mb-3">
                <label for="find-id" class="form-label">아이디</label>
                <input type="text" id="find-id" name="userId" class="form-control">
            </div>
            <div class="mb-3">
                <input type="hidden" id="email-pw" name="userEmail">
                <label for="userEmail1-pw" class="form-label">이메일</label>
                <div class="input-group">
                    <input type="text" class="form-control" name="userEmail1-pw" id="userEmail1-pw" placeholder="이메일">
                    <select class="form-select" name="userEmail2-pw" id="userEmail2-pw">
                        <option>@naver.com</option>
                        <option>@daum.net</option>
                        <option>@gmail.com</option>
                        <option>@hanmail.com</option>
                        <option>@yahoo.co.kr</option>
                    </select>
                    <button type="button" class="btn btn-primary" id="mail-Check-Btn-pw">인증번호 전송</button>
                </div>
            </div>
            <div class="mb-3">
                <label for="mail-check-input-pw" class="form-label">인증번호</label>
                <div class="input-group">
                    <input class="form-control mail-check-input-pw" id="mail-check-input-pw" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
                    <button type="button" class="btn btn-success" id="verify-Code-Btn-pw" disabled="disabled">인증번호 확인</button>
                </div>
            </div>
            <input type="submit" value="비밀번호 찾기" id="pw-find" class="btn btn-primary" disabled>
        </form>
    </main>
	<footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>
    <!-- jQuery 스크립트 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    	//아이디 찾기 결과 창
	    function pop()
		{
    		var userEmail = document.getElementById("email-id").value;
	    	window.open("/user/idfind.ft?userEmail=" + userEmail, "pop", "width=400,height=230,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
		}

        // 이메일 인증 기능-아이디
        document.getElementById("mail-Check-Btn-id").onclick = function() {
            var emailPart1 = document.getElementById("userEmail1-id").value;
            var emailPart2 = document.getElementById("userEmail2-id").value;
            var completeEmail = emailPart1 + emailPart2;
            
            // AJAX 요청을 사용하여 백엔드에 이메일 주소 전송
            fetch('/verify/email.ft', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email: completeEmail }),
            })
            .then(response => response.json())
            .then(data => {
                console.log('Success:'+ data);
                // 성공적으로 이메일을 전송했다면, 사용자에게 이메일을 확인하라는 안내와 함께 인증번호 입력 필드를 활성화
                alert(data.message); // 백엔드에서 보낸 메시지를 사용자에게 표시
                document.querySelector(".mail-check-input-id").disabled = false;
                document.getElementById("verify-Code-Btn-id").disabled = false;
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('이메일 전송에 실패했습니다. 다시 시도해주세요.');
            });
        };

        // 인증번호 확인 기능-아이디
        document.getElementById("verify-Code-Btn-id").onclick = function() {
            var verificationCode = document.querySelector(".mail-check-input-id").value;
            var emailPart1 = document.getElementById("userEmail1-id").value;
            var emailPart2 = document.getElementById("userEmail2-id").value;
            var completeEmail = emailPart1 + emailPart2;
            
            // AJAX 요청을 사용하여 백엔드에 인증번호 검증 요청
            fetch('/verify/code.ft', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email: completeEmail, verificationCode: verificationCode }),
            })
            .then(response => response.json())
            .then(data => {
                if(data.ok) { // HTTP 상태 코드가 200-299인 경우
                    alert('인증에 성공하였습니다.');
                    document.getElementById('email-id').value = completeEmail;
                    // 인증 성공 시 회원가입 버튼을 활성화
                    $('#id-find').prop('disabled', false);
                } else {
                    alert(data.message); // 백엔드에서 보낸 오류 메시지를 사용자에게 표시
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('인증번호 검증에 실패했습니다. 다시 시도해주세요.');
            });
        };

        // 이메일 인증 기능-비밀번호
        document.getElementById("mail-Check-Btn-pw").onclick = function() {
            var emailPart1 = document.getElementById("userEmail1-pw").value;
            var emailPart2 = document.getElementById("userEmail2-pw").value;
            var completeEmail = emailPart1 + emailPart2; // 이메일 주소 조합 시 @ 기호가 필요합니다.
            
            // AJAX 요청을 사용하여 백엔드에 이메일 주소 전송
            fetch('/verify/email.ft', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email: completeEmail }),
            })
            .then(response => response.json())
            .then(data => {
                console.log('Success:'+ data);
                // 성공적으로 이메일을 전송했다면, 사용자에게 이메일을 확인하라는 안내와 함께 인증번호 입력 필드를 활성화
                alert(data.message); // 백엔드에서 보낸 메시지를 사용자에게 표시
                document.querySelector(".mail-check-input-pw").disabled = false;
                document.getElementById("verify-Code-Btn-pw").disabled = false;
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('이메일 전송에 실패했습니다. 다시 시도해주세요.');
            });
        };

        // 인증번호 확인 기능-비밀번호
        document.getElementById("verify-Code-Btn-pw").onclick = function() {
            var verificationCode = document.querySelector(".mail-check-input-pw").value;
            var emailPart1 = document.getElementById("userEmail1-pw").value;
            var emailPart2 = document.getElementById("userEmail2-pw").value;
            var completeEmail = emailPart1 + emailPart2;
            
            // AJAX 요청을 사용하여 백엔드에 인증번호 검증 요청
            fetch('/verify/code.ft', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email: completeEmail, verificationCode: verificationCode }),
            })
            .then(response => response.json())
            .then(data => {
                if(data.ok) { // HTTP 상태 코드가 200-299인 경우
                    alert('인증에 성공하였습니다.');
                    document.getElementById('email-pw').value = completeEmail;
                    // 인증 성공 시 회원가입 버튼을 활성화
                    $('#pw-find').prop('disabled', false);
                } else {
                    alert(data.message); // 백엔드에서 보낸 오류 메시지를 사용자에게 표시
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('인증번호 검증에 실패했습니다. 다시 시도해주세요.');
            });
        };
    </script>
</body>
</html>