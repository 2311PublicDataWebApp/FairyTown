<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
		<style type="text/css">
			.hide {
				display: none;
			}
			#main{
				position: relative;
    			width: 60%;
    			margin-left:38%;
    			top:-150px;
			}
			#footer{
    			top:-350px;
			}
			
		</style>
	</head>
	<body>
	<header>
		<jsp:include page="../inc/header.jsp"></jsp:include>	
	</header>
		<main class="container regist_form mt-5" id="main">
			<form action="/user/register.ft" method="post">
				<h1 class="mb-4" style="margin-left:13%">회원가입</h1>	
				<div class="mb-3 col-sm-5">
					<label for="realName" class="form-label">이름</label>
					<input type="text" class="form-control" id="realName" name="realName">
				</div>
				<div class="mb-3 col-sm-5">
					<label for="username" class="form-label">아이디</label>
					<input type="text" class="form-control" id="username" name="userId">
					<div class="form-text success-message hide">사용할 수 있는 아이디입니다.</div>
					<div class="form-text failure-message hide">아이디는 4~12글자이어야 합니다.</div>
					<div class="form-text failure-message2 hide">영어 또는 숫자만 가능합니다.</div>
				</div>
				<div class="mb-3 col-sm-5">
					<label for="password" class="form-label">비밀번호</label>
					<input type="password" class="form-control" id="password" name="userPw">
					<div class="form-text strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요.</div>
				</div>
				<div class="mb-3 col-sm-5">
					<label for="password-retype" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-control" id="password-retype">
					<div class="form-text mismatch-message hide">비밀번호가 일치하지 않습니다.</div>
				</div>
				<div class="mb-3 col-sm-5">
					<label for="userPhone" class="form-label">전화번호</label>
					<input type="text" class="form-control" id="userPhone" name="userPhone">
				</div>
				<div class="mb-3 col-sm-5">
					<label for="sample6_postcode" style="display:inline-block"class="form-label">우편번호</label>
					<button type="button" class="btn btn-secondary" style="display:inline; margin-left:220px; margin-bottom:8px;"onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
					<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="zipCode">
				</div>
				<div class="mb-3 col-sm-5">
					<label for="sample6_address" class="form-label">주소</label>
					<input type="text" class="form-control" id="sample6_address" placeholder="도로명주소" name="userAddress">
				</div>
				<div class="mb-3 col-sm-5">
					<label for="sample6_detailAddress" class="form-label">상세주소</label>
					<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="detailAddress">
				</div>
				<div class="mb-3 col-sm-3">
					<label for="userBirthDate" class="form-label">생년월일</label>
					<input type="date" class="form-control" name="userBirthDate">
				</div>
				<div class="mb-3 col-sm-7">
					<input type="hidden" value="false" id="email-auth">
					<input type="hidden" id="user-email" name="userEmail">
					<label for="userEmail1" class="form-label">이메일</label>
					<div class="input-group">
						<input type="text" class="form-control" id="userEmail1" placeholder="이메일">
						<select class="form-select" id="userEmail2">
							<option>@naver.com</option>
							<option>@daum.net</option>
							<option>@gmail.com</option>
							<option>@hanmail.com</option>
							<option>@yahoo.co.kr</option>
						</select>
						<button type="button" class="btn btn-primary" id="mail-Check-Btn">인증번호 전송</button>
					</div>
				</div>
				<div class="mb-3 col-sm-5">
					<label for="verificationCode" class="form-label">인증번호</label>
					<div class="input-group">
						<input type="text" class="form-control mail-check-input" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
						<button type="button" class="btn btn-success" id="verify-Code-Btn" disabled="disabled">인증번호 확인</button>
					</div>
				</div>
				<button type="submit" class="btn btn-primary" id="signup-btn" style="margin-top:12px; margin-left:15%;"disabled="disabled">회원가입</button>
			</form>
		</main>
		<footer style="margin-top:-10%;" id="footer">
			<jsp:include page="../inc/footer.jsp"></jsp:include>		
		</footer>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		<script>
		 	var emailAuth = document.getElementById('email-auth');
			document.addEventListener("DOMContentLoaded", function() {
			    var userId = document.getElementById('username');
			    var userPw = document.getElementById('password');
			    var userPwRetype = document.getElementById('password-retype');
			    var signupBtn = document.getElementById('signup-btn');
			    
			    function validateForm() {
			        var isValidUserId = userId.value.length >= 4 && userId.value.length <= 12 && /^[a-zA-Z0-9]*$/.test(userId.value);
			        var isValidUserPw = userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value);
			        var isPwMatch = userPw.value === userPwRetype.value;
			        var isEmailAuth = emailAuth.value === 'true';

			        if(!(isValidUserId && isValidUserPw && isPwMatch && isEmailAuth)){
			        	signupBtn.disabled = true;
			        } else{
			        	signupBtn.disabled = false;
			        }
			    }
			    userId.addEventListener('keyup', function() {
			        var successMessage = document.querySelector('.success-message');
			        var failureMessage = document.querySelector('.failure-message');
			        var failureMessage2 = document.querySelector('.failure-message2');
	
			        if(userId.value.length >= 4 && userId.value.length <= 12 && /^[a-zA-Z0-9]*$/.test(userId.value)) {
			            successMessage.classList.remove('hide');
			            failureMessage.classList.add('hide');
			            failureMessage2.classList.add('hide');
			        } else {
			            successMessage.classList.add('hide');
			            if(!/^[a-zA-Z0-9]*$/.test(userId.value)) {
			                failureMessage2.classList.remove('hide');
			            } else {
			                failureMessage2.classList.add('hide');
			            }
			            if(!(userId.value.length >= 4 && userId.value.length <= 12)) {
			                failureMessage.classList.remove('hide');
			            } else {
			                failureMessage.classList.add('hide');
			            }
			        }
			    });
	
			    userPw.addEventListener('keyup', function() {
			        var strongPasswordMessage = document.querySelector('.strongPassword-message');
			        if(userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value)) {
			        	strongPasswordMessage.classList.add('hide');
			        } else {
			            strongPasswordMessage.classList.remove('hide');
			        }
			    });
	
			    userPwRetype.addEventListener('keyup', function() {
			        var mismatchMessage = document.querySelector('.mismatch-message');
			        if(userPw.value === userPwRetype.value) {
			            mismatchMessage.classList.add('hide');
			        } else {
			            mismatchMessage.classList.remove('hide');
			        }
			    });
			    
			  //이메일 인증 기능
				document.getElementById("mail-Check-Btn").onclick = function() {
				    var emailPart1 = document.getElementById("userEmail1").value;
				    var emailPart2 = document.getElementById("userEmail2").value;
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
				        document.querySelector(".mail-check-input").disabled = false;
				        document.getElementById("verify-Code-Btn").disabled = false;
				    })
				    .catch((error) => {
				        console.error('Error:', error);
				        alert('이메일 전송에 실패했습니다. 다시 시도해주세요.');
				    });
				};
		
				// 인증번호 확인 기능
				document.getElementById("verify-Code-Btn").onclick = function() {
				    var verificationCode = document.querySelector(".mail-check-input").value;
				    var emailPart1 = document.getElementById("userEmail1").value;
				    var emailPart2 = document.getElementById("userEmail2").value;
				    var completeEmail = emailPart1 + emailPart2; // 이메일 주소 조합 시 @ 기호를 추가합니다.
		
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
				            emailAuth.value = 'true';
				            console.log("성공");
				            $('#user-email').val(completeEmail);
				            validateForm();
				         // 인증 성공 시 회원가입 버튼을 활성화
				            
				        } else {
				            alert(data.message); // 백엔드에서 보낸 오류 메시지를 사용자에게 표시
				        }
				    })
				    .catch((error) => {
				        console.error('Error:', error);
				        alert('인증번호 검증에 실패했습니다. 다시 시도해주세요.');
				    });
				};
			});	
		    
			//주소API
		    function sample6_execDaumPostcode() {
			    new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분.
			
			            var addr = ''; // 주소 변수
			
			            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                addr = data.roadAddress;
			            } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                addr = data.jibunAddress;
			            }
			
			            // 우편번호와 주소 정보를 해당 필드에 넣는다.
			            document.getElementById('sample6_postcode').value = data.zonecode;
			            document.getElementById("sample6_address").value = addr;
			
			            // 커서를 상세주소 필드로 이동한다.
			            document.getElementById("sample6_detailAddress").focus();
			        }
			    }).open();
			}
		</script>
	</body>
</html>