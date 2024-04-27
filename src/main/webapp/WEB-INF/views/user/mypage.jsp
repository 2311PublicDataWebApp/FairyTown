<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	main#main {
    	width: 50%;
	}
</style>
</head>
<body>
	<header><jsp:include page="../inc/header.jsp"></jsp:include></header>
 	<main id="main" class="container">
	    <h3 class="text-center">${user.realName }님 환영합니다.</h3>
	    <ul class="list-group mt-3">
	        <li class="list-group-item"><strong>아이디:</strong> ${user.userId}</li>
	        <li class="list-group-item"><strong>이메일:</strong> ${user.userEmail}</li>
	        <li class="list-group-item"><strong>연락처:</strong> ${user.userPhone}</li>
	        <li class="list-group-item"><strong>우편 번호:</strong> <c:if test="${user.zipCode lt 10000}">0</c:if>${user.zipCode}</li>
	        <li class="list-group-item"><strong>주소:</strong> ${user.userAddress} ${user.detailAddress}</li>
	        <li class="list-group-item"><strong>생년월일:</strong> ${user.userDate}</li>
	    </ul>
	    <hr>
	    <div class="row mt-3">
	        <div class="col text-center">
	            <a href="/user/modify.ft" class="btn btn-primary btn-lg">내 정보 수정</a>
	        </div>
	        <div class="col text-center">
	            <a href="/user/quit.ft" class="btn btn-danger btn-lg">회원 탈퇴</a>
	        </div>
	        <div class="col text-center">
	            <a href="/ride/course.ft" class="btn btn-secondary btn-lg">나의 코스 보기</a>
	        </div>
	    </div>
	    <div class="row mt-3">
	        <div class="col text-center">
	            <a href="/goods/orderList.ft" class="btn btn-info btn-lg">주문 내역</a>
	        </div>
	        <div class="col text-center">
	            <a href="/qna/list.ft" class="btn btn-warning btn-lg">고객센터</a>
	        </div>
	        <div class="col text-center">
	            <c:choose>
	                <c:when test="${user.loginSt == 'K'}">
	                    <a href="https://kauth.kakao.com/oauth/logout?client_id=14b775c94ce2cca9ae295f299b970238&logout_redirect_uri=http://127.0.0.1:8899/user/logout.ft" class="btn btn-primary btn-lg">로그아웃</a>
	                </c:when>
	                <c:when test="${user.loginSt == 'B'}">
	                    <a href="/user/logout.ft" class="btn btn-primary btn-lg">로그아웃</a>
	                </c:when>
	            </c:choose>
	        </div>
	    </div>
	</main>
	<footer><jsp:include page="../inc/footer.jsp"></jsp:include></footer>
</body>
</html>