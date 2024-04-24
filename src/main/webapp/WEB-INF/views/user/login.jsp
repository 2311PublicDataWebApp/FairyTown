<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 로그인</title>
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
		
		.login-form {
        	margin: 0 auto;
        	text-align: center;
    	}
    	main#main {
    		width: 30%;
		}
	</style>
</head>
<body>
	<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
	<main id="main" class="login-form container">
        <h2 class="mt-5">Login page</h2>

        <form action="/user/login.ft" method="post" name="loginForm" class="mt-3">
            <div class="mb-3">
                <input type="text" name="userId" class="form-control" placeholder="ID를 입력하세요">
            </div>
            <div class="mb-3">
                <input type="password" name="userPw" class="form-control" placeholder="PW를 입력하세요">
            </div>
            <div class="mt-3">
            	<a href="/user/idpwfind.ft" class="btn btn-link">아이디/비밀번호 찾기</a> <!-- 아이디/비밀번호 찾기 버튼 -->
        	</div>
            <button type="submit" name="login" class="btn btn-primary btn-lg">Login</button>
        </form>
        <div class="mt-3">
            <a href="javascript:kakaoLogin()"><img src="../../../img/kakao_login_medium_narrow.png" class="img-fluid"></a>
        </div>
    </main>
    <footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		Kakao.init('93b765088f9b1873fdd384cc50625402');//JavaScript API KEY
		function kakaoLogin() {
			Kakao.Auth.authorize({
			      redirectUri: 'http://127.0.0.1:8899/user/login.ft',
		    });
		  }
	</script>

</body>
</html>