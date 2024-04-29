<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<style type="text/css">
		#main{
			position: relative;
	    	bottom: 100px;
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
        <h2 class="mt-5">LOGIN</h2>

        <form action="/user/login.ft" style="" method="post" name="loginForm" class="mt-3">
            <div class="mb-3">
                <input type="text" style="width:260px; margin-top:60px; margin-left:30%;"name="userId" class="form-control" placeholder="ID를 입력하세요">
            </div>
            <div class="mb-3">
                <input type="password" style="width:260px; margin-left:30%; margin-top:20px; " name="userPw" class="form-control" placeholder="PW를 입력하세요">
            </div>
            <div class="mt-3">
            	<a href="/user/idpwfind.ft" style="color:black; margin-left:10%; text-decoration:none;"class="btn btn-link">아이디/비밀번호 찾기</a> <!-- 아이디/비밀번호 찾기 버튼 -->
            	<a href="/user/register.ft" style="color:black; margin-left:1%; text-decoration:none;" class="btn btn-link">회원가입</a> <!-- 아이디/비밀번호 찾기 버튼 -->
        	</div>
            <button type="submit" name="login" style="margin-top:50px; margin-left:80px;"class="btn btn-primary btn-lg">LOGIN</button>
        </form>
        <div class="mt-3">
            <a href="javascript:kakaoLogin()"><img src="../../../img/kakao_login_medium_narrow.png" style="margin-left:13%; margin-top:20px;"class="img-fluid"></a>
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