<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>유저 정보 상세 조회</title>
	</head>
	<body>
		<h2>유저 정보</h2>
		<ul>
			<li>이름 : ${user.realName }</li>
			<li>아이디 : ${user.userId }</li>
			<li>이메일 : ${user.userEmail }</li>
			<li>전화번호 : ${user.userPhone }</li>
			<li>
					세션 연동 상태 : 
					<c:if test="${user.loginSt == 'K'}">
	               		Kakao
	                </c:if>
	                <c:if test="${user.loginSt == 'B'}">
	                    Normal
	                </c:if>
	                <c:if test="${user.loginSt == 'N'}">
	                    Naver
	                </c:if>
	                <c:if test="${user.loginSt == 'G'}">
	                    Google
	                </c:if>
			</li>
			<li>생년월일 : ${user.userBirthDate }</li>
			<li>활동상태 : ${user.userSt }</li>
			<li>
				우편번호 : <c:if test="${user.zipCode < 10000}">0</c:if>${user.zipCode }
			</li>
			<li>주소 : ${user.userAddress } ${user.detailAddress }</li>
			<li>권한 : ${user.userAdmin }</li>
			<li>가입일 : ${user.userDate }</li>
		</ul>
		<button type="button" onclick="window.close();">닫기</button>
	</body>
</html>