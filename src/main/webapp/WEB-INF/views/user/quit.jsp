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
				<input type="checkbox">주의사항을 모두 이해했으며, 이에 동의합니다.
			</p>
			비밀번호 <input type="password" name="userPw"><br>
			비밀번호 확인 <input type="password"><br>
			<input type="submit" value="회원 탈퇴">
			<a href="/user/mypage.ft">취소</a>
		</form>
	</body>
</html>