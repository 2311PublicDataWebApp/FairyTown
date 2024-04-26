<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유저 정보 상세 조회</title>
    <!-- 부트스트랩 CSS 추가 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">유저 정보</h2>
    <ul class="list-group">
        <li class="list-group-item">이름 : ${user.realName}</li>
        <li class="list-group-item" id="user-id">아이디 : ${user.userId}</li>
        <li class="list-group-item">이메일 : ${user.userEmail}</li>
        <li class="list-group-item">전화번호 : ${user.userPhone}</li>
        <li class="list-group-item">
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
        <li class="list-group-item">생년월일 : ${user.userBirthDate}</li>
        <li class="list-group-item">활동상태 : ${user.userSt}</li>
        <li class="list-group-item">
            우편번호 : <c:if test="${user.zipCode < 10000}">0</c:if>${user.zipCode}
        </li>
        <li class="list-group-item">주소 : ${user.userAddress} ${user.detailAddress}</li>
        <li class="list-group-item">권한 : ${user.userAdmin}</li>
        <li class="list-group-item">가입일 : ${user.userDate}</li>
    </ul>
    <a href="/admin/blackreason.ft?blackUser=${user.userId}" class="btn btn-dark mt-3">블랙리스트 등록</a>
    <button type="button" class="btn btn-secondary mt-3" onclick="window.close();">닫기</button>
</div>
<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
