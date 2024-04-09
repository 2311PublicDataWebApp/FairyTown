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
			<c:if test="${userId eq null }">
				<form action="/user/login.ft" method="post" name="loginForm">
					<input type="text" name="userId" placeholder="ID를 입력하세요">
					<input type="password" name="userPw"  placeholder="PW를 입력하세요">
					<input type="submit" name="login" value="login">
						
				</form>
			</c:if>
			<c:if test="${userId ne null }">
				<button type="button" onclick="userLogout();">로그아웃</button>				
			</c:if>
		</div>
<%-- 		<jsp:include page="./inc/footer.jsp"></jsp:include> --%>
		<script>
			function userLogin() {
				location.href="/user/login.ft";
			}
			function userLogout() {
				location.href="/user/logout.ft";
			}
		</script>

	<!-- 공통 / 풋터 -->
</body>
</html>