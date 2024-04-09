<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>티켓결제-입력</title>
</head>
<body>
	<form action="/ticketing/regist.ft" method="post"><br>
		<input type="hidden" name="userId" value="${user.userId }">
		<input type="hidden" name="ticketNumber" value="${ticketOne.ticketNumber }">
		<input type="hidden" name="ticketName" value="${ticketOne.ticketName }">
		<input type="hidden" name="ticketDetail" value="${ticketOne.ticketDetail }">
		<input type="hidden" name="ticketAdult" value="${ticketOne.ticketAdult }">
		<input type="hidden" name="ticketTeen" value="${ticketOne.ticketTeen }">
		<input type="hidden" name="ticketChild" value="${ticketOne.ticketChild }">
		<div>
			<label for="ticketName" class="form-label">티켓이름 : </label>
			${ticketOne.ticketName }
		</div>
		<div>
			<label for="reservationDate" class="form-label">예약일 선택</label>
			<input type="date" class="form-control" id="reservationDate" name="reservationDate">
		</div>
		<div>
			<label for="adult" class="form-label">성인</label>
			<input type="number" class="form-control" id="adult" name="adult">
		</div>
		<div>
			<label for="teenager" class="form-label">청소년</label>
			<input type="number" class="form-control" id="teenager" name="teenager">
		</div>
		<div>
			<label for="child" class="form-label">어린이</label>
			<input type="number" class="form-control" id="child" name="child">
		</div>
		<button type="submit">결제화면으로</button>
	</form>
</body>
</html>