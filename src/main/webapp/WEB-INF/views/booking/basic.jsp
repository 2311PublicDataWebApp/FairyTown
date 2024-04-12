<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 기본예약</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%-- 	기구 이미지 : ${rideList. } <br> --%>
	
	<c:forEach items="${rideList}" var="ride">
		예약 날짜 : ${tingOne.reservationDate } <br>
    	기구 이름: ${ride.rideName} <br>
    	<button>개별 예약하기</button> <br>
    	<button onclick="deleteThis('${ride.rideId}')">개별 예약 삭제</button> <br><br>
	</c:forEach>
	<br><br>
	
	<div>
		<label for="total" class="form-label">예약 인원수 : </label>
		<input type="number" class="form-control" id="total" name="total" value="${tingOne.adult + tingOne.teenager + tingOne.child}" oninput="onInputChanged(this)">
	</div>
	<br><br>
	초기화 <br>
	예약목록 <br>
	전체예약
	<script>
	// 입력란의 값을 제한하는 함수
	function limitInputValue(input) {
	    // 입력된 값이 특정 범위를 벗어나는지 확인
	    if (input.value < 0 || input.value > ${tingOne.adult + tingOne.teenager + tingOne.child}) {
	        alert("티켓 예약 인원만 예약할 수 있습니다!");
	        input.value = input.defaultValue;
	    }
	}
	function onInputChanged(input) {
	    limitInputValue(input);
	}
	// 개별 삭제
	// 개별 예약 삭제
	function deleteThis(rideId) {
	    var confirmDelete = confirm("이 예약을 삭제하시겠습니까?");
	    if (confirmDelete) {
	        $.ajax({
	            url: '/booking/basic/delete.ft',
	            type: 'POST',
	            data: { 
	                rideId: rideId, // 삭제할 rideId
	            },
	            success: function(response) {
	                alert("예약이 성공적으로 삭제되었습니다.");
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	                alert("예약 삭제 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	            }
	        });
	    }
	}

	</script>
</body>
</html>