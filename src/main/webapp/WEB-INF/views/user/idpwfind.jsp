<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h2>아이디찾기</h2>
		<form action="/user/idfind.ft" method="post" id="find-id-form">
			<ul>
				<li>
					<input type="hidden" id="email-id" name="userEmailId">
					<label>이메일</label>
					<input type="text" class="form-control" name="userEmail1-id" id="userEmail1-id" placeholder="이메일" >
					<select class="form-control" name="userEmail2-id" id="userEmail2-id" >
						<option>@naver.com</option>
						<option>@daum.net</option>
						<option>@gmail.com</option>
						<option>@hanmail.com</option>
						<option>@yahoo.co.kr</option>
					</select>
					<button type="button" class="btn btn-primary" id="mail-Check-Btn-id">인증번호 전송</button>
				</li>
				<li>
					<label>인증번호</label>
					<input class="form-control mail-check-input-id" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
					<button type="button" class="btn btn-success" id="verify-Code-Btn-id" disabled="disabled">인증번호 확인</button>
				</li>
				<li>
					<input type="submit" value="아이디 찾기" id="id-find" disabled>
				</li>
			</ul>
		</form>
		<h2>비밀번호 찾기</h2>
		<form action="/user/pwfind.ft" method="post" id="find-id-form">
			<ul>
				<li>
					<label>아이디</label>
					<input type="text" id="find-id" name="userId">
				</li>
				<li>
					<input type="hidden" id="email-pw" name="userEmail">
					<label>이메일</label>
					<input type="text" class="form-control" name="userEmail1-pw" id="userEmail1-pw" placeholder="이메일" >
					<select class="form-control" name="userEmail2-pw" id="userEmail2-pw" >
						<option>@naver.com</option>
						<option>@daum.net</option>
						<option>@gmail.com</option>
						<option>@hanmail.com</option>
						<option>@yahoo.co.kr</option>
					</select>
					<button type="button" class="btn btn-primary" id="mail-Check-Btn-pw">인증번호 전송</button>
				</li>
				<li>
					<label>인증번호</label>
					<input class="form-control mail-check-input-pw" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
					<button type="button" class="btn btn-success" id="verify-Code-Btn-pw" disabled="disabled">인증번호 확인</button>
				</li>
				<li>
					<input type="submit" value="비밀번호 찾기" id="pw-find" disabled>
				</li>
			</ul>
		</form>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
			//아아디 찾기 결과 창
			document.getElementById('find-id-form').addEventListener('submit', function(e) {
			    e.preventDefault(); // 폼 기본 제출 막기
			    
			    var email = document.getElementById('email-id').value;
			    
			    fetch('/user/idfind.ft', {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json',
			        },
			        body: JSON.stringify({ userEmail: email }),
			    })
			    .then(response => response.json())
			    .then(data => {
			        if (data.success) {
			            // 새 창 열기
			        	var popupWindow = window.open('', 'popupWindow', 'width=400,height=200');
			            newWindow.document.write("<h1>아이디 찾기</h1>");
			            newWindow.document.write("<p>결과 : " + data.message + "</p>");
			        } else {
			            alert("아이디를 찾을 수 없습니다.");
			        }
			    })
			    .catch((error) => {
			        console.error('Error:', error);
			    });
			});
		
			//이메일 인증 기능-아이디
			document.getElementById("mail-Check-Btn-id").onclick = function() {
			    var emailPart1 = document.getElementById("userEmail1-id").value;
			    var emailPart2 = document.getElementById("userEmail2-id").value;
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
			
			//이메일 인증 기능-비밀번호
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