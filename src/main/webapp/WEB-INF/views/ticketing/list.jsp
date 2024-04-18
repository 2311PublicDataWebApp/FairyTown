<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓결제 - 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <c:choose>
        <c:when test="${tingList eq null}">
            주문하신 내역이 없습니다.
        </c:when>
        <c:otherwise>
            <c:forEach items="${tingList}" var="ting">
				티켓이름 : ${ting.ticket.ticketName }<br>
				<img src="../resources/nuploadFiles/${ting.ticket.ticketImgRename }" alt="티켓이미지"><br>
            	티켓 코드 : ${ting.ticketingCode } <br>
                예약일 : ${ting.reservationDate } <br>
                어른 : ${ting.adult } <br>
                청소년 : ${ting.teenager } <br>
                어린이 : ${ting.child } <br>
                결제일 : ${ting.purchaseDate } <br>
                결제 금액 : ${ting.purchasePrice } <br>
				결제 상태 : ${ting.purchaseSuccess == 'C' ? '취소됨' : '결제됨'} <br>
				<c:if test="${ting.purchaseSuccess == 'Y'}">
	                <button onclick="cancleTicketingCode(${ting.ticketingCode })">취소하기</button>
				</c:if>
				<c:if test="${ting.purchaseSuccess == 'Y'}">
				    <button onclick="sendTicketingCode(${ting.ticketingCode})">예약하기</button> 
				</c:if>

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
	// 예약할 티켓을 변경합니다
	function sendTicketingCode(ticketingCode) {
	    $.ajax({
	        url: '/ticketing/sendCode.ft',
	        type: 'POST',
	        data: { ticketingCode: ticketingCode },
	        success: function(response) {
	        	 alert(response);
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	}
	// 티켓을 취소합니다. (값 변경)
	function cancleTicketingCode(ticketingCode) {
	    var confirmDelete = confirm("이 티켓을 취소하시겠습니까?");
		$.ajax({
	        url: '/ticketing/cancle.ft',
	        type: 'POST',
	        data: { ticketingCode: ticketingCode },
	        success: function(response) {
	        	 alert(response);
	             location.reload();
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	}
	</script>
</body>
</html>