<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
    <!-- 부트스트랩 링크 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- 스타일 -->
    <style>
        body {
            padding: 20px;
        }
        .form-container {
            max-width: 400px;
            margin: auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-cancel {
            margin-right: 10px;
        }
        #warning {
        	background-color: gray;
        }
        #main{
			position: relative;
	    	bottom: 150px;
		}
		#footer{
			position: relative;
	    	bottom: 200px;
		}
    </style>
</head>
<body>
<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
<main id="main" class="container">
    <div class="form-container">
        <form action="/user/quit.ft" method="post">
            <h2>회원탈퇴</h2>
            <div class="card mb-3">
			    <div class="card-body">
			        <h5 class="card-title">탈퇴 시 주의사항</h5>
			        <p class="card-text">회원 탈퇴 시 즉시 주문 내역, 회원 정보가 삭제되며 이후 복구할 수 없습니다.</p>
			        <div class="form-group form-check">
			            <input type="checkbox" id="check" class="form-check-input">
			            <label for="check" class="form-check-label">주의사항을 모두 이해했으며, 이에 동의합니다.</label>
			        </div>
			    </div>
			</div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="userPw" id="password" class="form-control">
            </div>
            <div class="form-group">
                <label for="password-retype">비밀번호 확인</label>
                <input type="password" id="password-retype" class="form-control">
                <small id="password-feedback" class="form-text text-danger"></small>
            </div>
            <button type="submit" class="btn btn-danger" id="quit-btn" disabled>회원 탈퇴</button>
            <a href="/user/mypage.ft" class="btn btn-secondary btn-cancel">취소</a>
        </form>
    </div>
</main>
<footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>
<!-- 부트스트랩 자바스크립트 및 제이쿼리 링크 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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