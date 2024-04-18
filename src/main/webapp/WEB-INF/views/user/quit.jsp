<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<form action="/user/quit.ft" method="post">
			<p>
				회원탈퇴<br>
				<br>
				<br>
				탈퇴 시 주의사항<br>
				<br>
				회원 탈퇴 시 즉시 주문 내역, 회원 정보가 삭제되며<br>
				이후 복구할 수 없습니다.<br><br>
				<input type="checkbox" id="check">주의사항을 모두 이해했으며, 이에 동의합니다.
			</p>
			비밀번호 <input type="password" name="userPw" id="password"><br>
			비밀번호 확인 <input type="password" id="password-retype"><br>
			<input type="submit" value="회원 탈퇴" id="quit-btn" disabled="disabled">
			<a href="/user/mypage.ft">취소</a>
		</form>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			document.addEventListener('DOMContentLoaded', function() {
		        var userPw = document.getElementById('password');
		        var userPwRetype = document.getElementById('password-retype');
		        var check = document.getElementById('check');
		        var quitBtn = document.getElementById('quit-btn');
		        var passwordFeedback = document.getElementById('password-feedback'); // 비밀번호 피드백을 위한 요소
	
		        function validateForm() {
		            var isCheck = check.checked;
		            var isPwMatch = userPw.value === userPwRetype.value && userPw.value !== '';
		            
		            quitBtn.disabled = !(isPwMatch && isCheck);
		            
		            // 비밀번호 일치 여부에 따라 피드백 제공
		            if(userPw.value !== userPwRetype.value) {
		                passwordFeedback.textContent = '비밀번호가 일치하지 않습니다.';
		            } else {
		                passwordFeedback.textContent = '';
		            }
		        }
		        
		        // 입력 시 실시간으로 검증
		        userPw.addEventListener('input', validateForm);
		        userPwRetype.addEventListener('input', validateForm);
		        check.addEventListener('change', validateForm);
		    });
		</script>
	</body>
</html>