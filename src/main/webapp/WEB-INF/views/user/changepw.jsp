<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<!-- 부트스트랩 CDN 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">
    /* 커스텀 스타일은 여기에 작성합니다. */
    .strongPassword-message,
    .mismatch-message {
        color: red;
    }
    .hide {
		display: none;
	}
	#main{
		position: relative;
		bottom: 100px;
	}
	#footer{
		position: relative;
		bottom: 100px;
	}
   	main#main {
   		width: 30%;
	}
</style>
</head>
<body>
	<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
    <main id="main" class="container">
        <form action="/user/changepw.ft" method="post">
            <h2 class="mb-4">비밀번호 변경</h2>
            <div class="form-group">
                <label for="password">새 비밀번호</label>
                <input type="password" class="form-control" id="password" placeholder="Password" name="userPw">
                <div class="strongPassword-message hide mt-1">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요</div>
            </div>
            <div class="form-group">
                <label for="password-retype">비밀번호 확인</label>
                <input type="password" class="form-control" id="password-retype" placeholder="Retype Password">
                <div class="mismatch-message hide mt-1">비밀번호가 일치하지 않습니다</div>
            </div>
            <button type="submit" class="btn btn-primary" id="change-btn" disabled>비밀번호 변경</button>
        </form>
    </main>
    <footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>

<!-- 부트스트랩 및 jQuery CDN 추가 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var userPw = document.getElementById('password');
    var userPwRetype = document.getElementById('password-retype');
    var changeBtn = document.getElementById('change-btn');

    function validateForm() {
        var isValidUserPw = userPw.value.length >= 8 && /[a-zA-Z]/.test(userPw.value) && /\d/.test(userPw.value) && /[@$!%*#?&]/.test(userPw.value);
        var isPwMatch = userPw.value === userPwRetype.value;

        changeBtn.disabled = !(isValidUserPw && isPwMatch);
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