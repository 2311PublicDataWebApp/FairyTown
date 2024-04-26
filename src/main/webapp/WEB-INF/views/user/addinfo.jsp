<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가 정보 입력</title>
<style type="text/css">
	.hide {
		display: none;
	}
	#main{
		position: relative;
		bottom: 170px;
	}
	#footer{
		position: relative;
	    bottom: 200px;
	}
	.strongPassword-message,
    .mismatch-message {
        color: red;
    }
    main#main {
    	width: 50%;
	}
</style>
</head>
<body>
	<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
	<main id="main" class="container mt-5">
		<form action="/user/addinfo.ft" method="post" class="needs-validation" novalidate>
			<h1 class="mb-4">회원가입</h1>
			<div class="row justify-content-center">
				<div class="mb-3">
                    <label for="realName" class="form-label">이름</label>
                    <input type="text" class="form-control" id="realName" name="realName" value="${nickname}" readonly>
                </div>
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="userId" name="userId" value="${kakaoId}" readonly>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="userPw">
                    <div class="strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요</div>
                </div>
                <div class="mb-3">
                    <label for="password-retype" class="form-label">비밀번호 확인</label>
                    <input type="password" class="form-control" id="password-retype">
                    <div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>
                </div>
                <div class="mb-3">
                    <label for="userPhone" class="form-label">전화번호</label>
                    <input type="text" class="form-control" id="userPhone" name="userPhone">
                </div>
				<div class="mb-3">
					<label for="sample6_postcode">우편번호</label>
					<div class="input-group">
						<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="zipCode" required>
						<div class="input-group-append">
							<button type="button" class="btn btn-primary" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
						</div>
					</div>
					<small id="guide" class="form-text text-muted"></small>
				</div>
				<div class="mb-3">
					<label for="sample6_address">주소</label>
					<input type="text" class="form-control" id="sample6_address" placeholder="도로명주소" name="userAddress">
				</div>
				<div class="mb-3">
					<label for="sample6_detailAddress">상세주소</label>
					<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="detailAddress">
				</div>
				<div class="mb-3">
					<label for="userBirthDate">생년월일</label>
					<input type="date" class="form-control" id="userBirthDate" name="userBirthDate">
				</div>
				<div class="mb-3">
					<label for="userEmail">이메일</label>
					<input type="text" class="form-control" id="userEmail" name="userEmail" value="${email}" readonly="readonly" placeholder="이메일">
				</div>
			</div>
			<br>
			<input type="submit" class="btn btn-primary" value="회원가입" id="signup-btn" disabled>
		</form>
	</main>
	<footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
			    var userPw = document.getElementById('password');
			    var userPwRetype = document.getElementById('password-retype');
			    var signupBtn = document.getElementById('signup-btn');
			    
			    function validateForm() {
			        var isValidUserPw = userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value);
			        var isPwMatch = userPw.value === userPwRetype.value;

			        signupBtn.disabled = !(isValidUserPw && isPwMatch);
			    }
	
			    userPw.addEventListener('keyup', function() {
			    	validateForm();
			        var strongPasswordMessage = document.querySelector('.strongPassword-message');
			        if(userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value)) {
			        	strongPasswordMessage.classList.add('hide');
			        } else {
			            strongPasswordMessage.classList.remove('hide');
			        }
			    });
	
			    userPwRetype.addEventListener('keyup', function() {
			    	validateForm();
			        var mismatchMessage = document.querySelector('.mismatch-message');
			        if(userPw.value === userPwRetype.value) {
			            mismatchMessage.classList.add('hide');
			        } else {
			            mismatchMessage.classList.remove('hide');
			        }
			    });
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