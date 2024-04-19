<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 로그인</title>
</head>
<body>
	<h2>Login page</h2>
	
	<form action="/user/login.ft" method="post" name="loginForm">
		<input type="text" name="userId" placeholder="ID를 입력하세요">
		<input type="password" name="userPw"  placeholder="PW를 입력하세요">
		<input type="submit" name="login" value="login">
	</form>
	<br>
	<a href="javascript:kakaoLogin()"><img src="../../../img/kakao_login_medium_narrow.png"></a>
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		Kakao.init('93b765088f9b1873fdd384cc50625402');//JavaScript API KEY
		function kakaoLogin() {
			Kakao.Auth.authorize({
			      redirectUri: 'http://127.0.0.1:8899/user/login.ft',
		    });
// 			Kakao.Auth.login({
// 	            success: function(authObj) {
// 	                // 로그인 성공 후 인증 코드를 서버로 전송
// 	                $.ajax({
// 	                    url: '/user/kakaoLogin.ft',
// 	                    type: 'POST',
// 	                    contentType: 'application/json',
// 	                    data: JSON.stringify({code: authObj.access_token}), // 액세스 토큰을 사용
// 	                    success: function(response) {
// 	                        // 서버로부터의 응답 처리
// 	                        console.log(response);
// 	                    },
// 	                    error: function(xhr, status, error) {
// 	                        // 오류 처리
// 	                        console.error(status, error);
// 	                    }
// 	                });
// 	            },
// 	            fail: function(err) {
// 	                alert(JSON.stringify(err));
// 	            }
// 	        });
		  }
	</script>

</body>
</html>