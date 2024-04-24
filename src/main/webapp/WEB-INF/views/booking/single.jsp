<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 개별예약</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/dist/css/booking.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<form action="/booking/single.ft" method="post">
	<div class="container mt-4 mb-4">
	    <div class="d-flex justify-content-center row booking-main">
	        <div class="col-md-10">	
				<div class="col-md-3 mb-3 text-center">
				    <h1>개별 예약하기</h1>
				</div>
				<input type="hidden" name="userId" value="${user.userId }">
				<input type="hidden" name="rideId" value="${ride.rideId }">
				
					<div class="row p-2 bg-white border rounded">
			        	<div class="col-md-3 mt-1"><img class="img-fluid img-responsive rounded product-image" src="https://i.imgur.com/QpjAiHq.jpg"></div>
						<div class="col-md-6 mt-1">
							<h4>기구 이름: ${ride.rideName}</h4>
							<div class="mt-1 mb-4 spec-1"><span>놀이기구 상세화면<br></span></div>
							<h5>예약 날짜 : ${tingOne.reservationDate }</h5>
						</div>
			            <div class="col-md-3 border-left mt-4">
			                <h6 class="text-success">탑승제한 : ${ride.rideLimit}</h6>
			            </div>
					</div>
				
	
	        </div>
	    </div>
	</div>
		
<div style="width:56%; display:flex; margin-left:22%;">
    <div style="flex:1;">
		<p>* 기구마다 이용 인원이 다를 경우<br>&nbsp;&nbsp;&nbsp;&nbsp;개별 예약하기를 이용해 주세요.</p>
    </div>
    <div style="flex-shrink:0; width:100px;">
		<label for="total" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;예약 인원수 <input type="number" class="form-control" id="total" name="total" value="${tingOne.adult + tingOne.teenager + tingOne.child}" oninput="onInputChanged(this)"></label>
    </div>
</div>
	
	<div class="d-flex justify-content-center mt-4" style="margin-right: 20px;">
	    <div class="booking-button mr-2 flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="goBack()">뒤로가기</button>
	    </div>
	    <div class="booking-button flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="submit">예약</button>
	    </div>
	</div>
	</form>

	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>	
	<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>