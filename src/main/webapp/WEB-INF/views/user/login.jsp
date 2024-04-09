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
	

</body>
</html>