<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<h3> ${user.realName }님 환영합니다. </h3>
 	<ul>
 		<li>
 			<label>아이디</label>
 			${user.userId}
 		</li>
 		<li>
 			<label>이메일</label>
 			${user.userEmail}
 		</li>
 		<li>
 			<label>연락처</label>
 			${user.userPhone}
 		</li>
 		<li>
 			<label>우편 번호</label>
 			<c:if test="${user.zipCode lt 10000}">0</c:if>${user.zipCode}
 		</li>
 		<li>
 			<label>주소</label>
 			${user.userAddress} ${user.detailAddress}
 		</li>
 		<li>
 			<label>생년월일</label>
 			${user.userDate}
 		</li>
 	</ul>
 	<hr>
 	<form action="/user/logout.ft" method="post">
 	<table style="border: 1px solid black;">
 		<tr>
 			<th style="border: 1px solid black;"><a href="/user/modify.ft">내 정보 수정</a></th>
 			<th style="border: 1px solid black;"><a href="/user/quit.ft">회원 탈퇴</a></th>
 			<th style="border: 1px solid black;">나의 코스 보기</th>
 		</tr>
 		<tr>
 			<th style="border: 1px solid black;">주문 내역</th>
 			<th style="border: 1px solid black;">고객센터</th>
 			<th style="border: 1px solid black;">
 				<button type="submit" style="background: none; border: none; cursor: pointer; font-family: inherit; font-size: inherit; color: inherit;">
                    로그아웃
                </button>
 			</th>
 		</tr>
 	</table>
 	</form>
</body>
</html>