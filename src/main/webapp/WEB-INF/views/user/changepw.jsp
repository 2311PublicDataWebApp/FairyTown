<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
			.hide {
				display: none;
			}
</style>
</head>
<body>
	<form action="/user/changepw.ft" method="post">
		<h2>비밀번호 변경</h2>
		<ul>
			<li>
				<label>새 비밀번호</label>
				<input type="password" id="password" placeholder="Password" name="userPw">
				<div class="strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요</div>
			</li>
			<li>
				<label>비밀번호 확인</label>
				<input type="password" id="password-retype" placeholder="Retype Password">
				<div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>
			</li>
			<li>
				<input type="submit" value="비밀번호 변경" id="change-btn" disabled="disabled">
			</li>
		</ul>
	</form>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var userPw = document.getElementById('password');
	    var userPwRetype = document.getElementById('password-retype');
	    var changeBtn = document.getElementById('change-btn'); // 수정: 변수명 변경

	    function validateForm() {
	        var isValidUserPw = userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value);
	        var isPwMatch = userPw.value === userPwRetype.value;

	        changeBtn.disabled = !(isValidUserPw && isPwMatch); // 수정: 변수명 변경
	    }
	    userPw.addEventListener('keyup', function() {
	        var strongPasswordMessage = document.querySelector('.strongPassword-message');
	        if(userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value)) {
	            strongPasswordMessage.classList.add('hide');
	            validateForm()
	        } else {
	            strongPasswordMessage.classList.remove('hide');
	            validateForm()
	        }
	    });

	    userPwRetype.addEventListener('keyup', function() {
	        var mismatchMessage = document.querySelector('.mismatch-message');
	        if(userPw.value === userPwRetype.value) {
	            mismatchMessage.classList.add('hide');
	            validateForm()
	        } else {
	            mismatchMessage.classList.remove('hide');
	            validateForm()
	        }
	    });
	});
	</script>
</body>
</html>