<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓결제 - 목록</title>
</head>
<body>
    <c:choose>
        <c:when test="${tingList eq null}">
            주문하신 내역이 없습니다.
        </c:when>
        <c:otherwise>
			티켓이름 : <br>
			티켓 이미지 : <br>
            <c:forEach items="${tingList}" var="ting">
                예약일 : ${ting.reservationDate } <br>
                어른 : ${ting.adult } <br>
                청소년 : ${ting.teenager } <br>
                어린이 : ${ting.child } <br>
                결제일 : ${ting.purchaseDate } <br>
                결제 금액 : ${ting.purchasePrice } <br>
                결제 상태 : ${ting.purchaseSuccess } <br>
                <br><br>
            </c:forEach>
        </c:otherwise>
    </c:choose>
	<button onclick="goBack()">뒤로가기</button><br>
	<button onclick="window.location.href = '/ticket/list.ft'">다른 티켓 구매</button>
	<script>
	function goBack() {
	  window.history.back();
	}
</script>
</body>

</html>