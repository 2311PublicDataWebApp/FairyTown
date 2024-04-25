<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>티켓결제-입력</title>
</head>
<body>
<c:if test="${user eq null}">
    <script>
        if (confirm('로그인 후 이용 가능한 서비스입니다. 이동하시겠습니까?')) {
            window.location.href = '/user/login.ft';
        } else {
            history.back();
        }
    </script>
</c:if>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<div class="regist-container">
		<div class="calendar">
			<jsp:include page="calendar.jsp"></jsp:include>	
		</div>
		<div class="register">
			<form action="/ticketing/regist.ft" method="post"><br>
				<input type="hidden" name="userId" value="${user.userId }">
				<input type="hidden" name="ticketNo" value="${ticketOne.ticketNo }">
				<input type="hidden" name="ticketName" value="${ticketOne.ticketName }">
				<input type="hidden" name="ticketDetail" value="${ticketOne.ticketDetail }">
				<input type="hidden" name="ticketAdult" value="${ticketOne.ticketAdult }">
				<input type="hidden" name="ticketTeen" value="${ticketOne.ticketTeen }">
				<input type="hidden" name="ticketChild" value="${ticketOne.ticketChild }">
				<input type="hidden" name="ticketImgRename" value="${ticketOne.ticketImgRename }">
			    <input type="hidden" class="form-control" id="reservationDate" name="reservationDate" value="" readonly>
				<div>
					<label for="ticketName" class="form-label regist-main-text">${ticketOne.ticketName }</label>
				</div>	
				<div>
					<label for="adult" class="form-label">성인</label>
					<input type="number" class="form-control" id="adult" name="adult" value="0">
				</div><br>
				<div>
					<label for="teenager" class="form-label">청소년</label>
					<input type="number" class="form-control" id="teenager" name="teenager" value="0">
				</div><br>
				<div>
					<label for="child" class="form-label">어린이</label>
					<input type="number" class="form-control" id="child" name="child" value="0">
				</div>
				<br><p>30명 이상의 단체 예약은<br>고객센터에 문의해주세요.</p>
				<button type="submit" class="regist-submit-btn">결제화면으로</button>
			</form>
		</div>
	</div>
	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<script>
	document.addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault(); // 기본 동작 차단
        }
    });
	// 인원 제한
    var adultInput = document.getElementById("adult");
    var teenagerInput = document.getElementById("teenager");
    var childInput = document.getElementById("child");

    var prevAdultValue = 0;
    var prevTeenagerValue = 0;
    var prevChildValue = 0;

    adultInput.addEventListener("change", checkValue);
    teenagerInput.addEventListener("change", checkValue);
    childInput.addEventListener("change", checkValue);

    function checkValue() {
        var adultValue = parseInt(adultInput.value);
        var teenagerValue = parseInt(teenagerInput.value);
        var childValue = parseInt(childInput.value);

        // 각 입력값이 0보다 작으면 0으로 설정
        if (adultValue < 0) {
            adultInput.value = 0;
        }
        if (teenagerValue < 0) {
            teenagerInput.value = 0;
        }
        if (childValue < 0) {
            childInput.value = 0;
        }

        // 총합이 30을 넘으면 이전 값으로 되돌림
        var total = adultValue + teenagerValue + childValue;
        if (total > 30) {
            adultInput.value = prevAdultValue;
            teenagerInput.value = prevTeenagerValue;
            childInput.value = prevChildValue;

        } else {
            prevAdultValue = adultValue;
            prevTeenagerValue = teenagerValue;
            prevChildValue = childValue;
        }
    }
	
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1; 
	var day = today.getDate();

	// 월과 일이 한 자리 수일 경우 앞에 0을 붙입니다.
	if (month < 10) {
	    month = '0' + month;
	}
	if (day < 10) {
	    day = '0' + day;
	}

	// 'YYYY-MM-DD' 형식의 문자열로 날짜를 변환합니다.
	var formattedDate = year + '-' + month + '-' + day;

	var reservationDateInput = document.getElementById('reservationDate');
	if (reservationDateInput) {
	    reservationDateInput.value = formattedDate;
	}

	// 날짜를 가져옵니다
	document.addEventListener('DOMContentLoaded', function() {
	    var headInfo = document.querySelector('.head-info');

	    // MutationObserver 콜백 함수 내에서 사용될 함수
	    function convertToDateString(monthYearText, dayText) {
	        var parts = monthYearText.split(' - ');
	        var year = parts[1];
	        var month = parts[0].replace('월', '');
	        var day = dayText;
	        if (month.length === 1) {
	            month = '0' + month;
	        }
	        if (day.length === 1) {
	            day = '0' + day;
	        }
	        return year + '-' + month + '-' + day;
	    }

	    // MutationObserver 설정
	    var observer = new MutationObserver(function(mutationsList, observer) {
	        // head-month와 head-day 요소를 다시 선택하고 텍스트를 가져옴
	        var headMonth = headInfo.querySelector('.head-month');
	        var headDay = headInfo.querySelector('.head-day');
	        var monthYearText = headMonth.textContent.trim();
	        var dayText = headDay.textContent.trim();

	        // 가져온 텍스트를 원하는 형식으로 조합합니다.
	        var dateString = convertToDateString(monthYearText, dayText);

	        var reservationDateInput = document.getElementById('reservationDate');
	        if (reservationDateInput) {
	            // 입력 요소의 값을 변경합니다.
	            reservationDateInput.value = dateString;
	        }
	    });

	    // MutationObserver 설정
	    var config = { childList: true, subtree: true };
	    observer.observe(headInfo, config);
	});

	</script>
</body>
</html>