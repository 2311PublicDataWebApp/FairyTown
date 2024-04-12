<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>

</head>
<body>

		<div class="container">
			${userId }
			<c:if test="${user eq null }">
				<form action="/user/login.ft" method="post" name="loginForm">
					<input type="text" name="userId" placeholder="ID를 입력하세요">
					<input type="password" name="userPw"  placeholder="PW를 입력하세요">
					<input type="submit" name="login" value="login">
				</form>
			</c:if>
			<c:if test="${user ne null }">
				<form action="/user/logout.ft" method="post">
					<button type="submit">로그아웃</button>							
				</form>
			</c:if>
		</div>
<%-- 		<jsp:include page="./inc/footer.jsp"></jsp:include> --%>
		<script>
			function userLogin() {
				location.href="/user/login.ft";
			}
		</script>

	<!-- 공통 / 풋터 -->
</body>
</html>