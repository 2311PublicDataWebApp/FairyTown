<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 예약조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../../../../resources/dist/css/booking.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<div class="container mt-4 mb-4">
	    <div class="d-flex justify-content-center row booking-main">
	        <div class="col-md-10">
				<c:choose>
					<c:when test="${empty bList}">
						<div class="col-md-3 mb-3 text-center">
						    <h1>예약 내역</h1>
						</div>
						<div class="row p-2 bg-white border rounded" style="height: 200px; display: flex; align-items: center; justify-content: center; text-align: center;">
						    <div class="col-md-6 mt-1">
						        <h3>주문하신 내역이 없습니다.</h3>
						    </div>
						</div>
					</c:when>
					<c:otherwise>
					<div class="col-md-3 mb-3 text-center">
					    <h1>예약 내역</h1>
					</div>
		        	<c:forEach items="${bList}" var="booking">
		        	
		            <div class="row p-2 bg-white border rounded">
		                <div class="col-md-3 mt-1"><img class="img-fluid img-responsive rounded product-image" src="https://i.imgur.com/QpjAiHq.jpg"></div>
		                <div class="col-md-6 mt-1">
		                	<h4>놀이기구 이름 : 아직안나와 아직안나와</h4>
							<div class="mt-1 mb-4 spec-1"><span>놀이기구 상세화면<br></span></div>
							<h5>예약 인원 : ${booking.bookingPeople }</h5>
		                    <h5>예약 날짜 : ${booking.bookingDate }</h5>
		                    <div class="mt-1 mb-1 spec-1"><span class="dot"></span><span>예약하신날 : ${booking.bookingTime }<br></span></div>
		                    <div class="d-flex flex-row mt-5">
		                        <div class="ratings mr-2"></div><span>예약 번호 : ${booking.bookingNumber }</span>
		                    </div>
		                </div>
		                <div class="col-md-3 border-left mt-5">
		                    <h6 class="text-success">탑승제한 : 아직안나와 아직안나와</h6>
		                    <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="deleteBookingOne(${booking.bookingNumber })">취소</button></div>
		                    <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button">인원 변경</button></div>
		                </div>
		            </div>
		            
		        	</c:forEach>
					</c:otherwise>
				</c:choose>
	        </div>
	    </div>
	</div>
	
	<div class="d-flex justify-content-center mt-4">
	    <div class="booking-button mr-2 flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="deleteBooking('${user.userId}')">전체 취소</button>
	    </div>
	    <div class="booking-button flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="window.location.href = '/ride/list.ft'">다른 놀이기구 예약</button>
	    </div>
	</div>
  
    <script>
    	// 예약 개별 삭제
    	function deleteBookingOne(bookingNumber) {
    	    var confirmDelete = confirm("해당 예약을 취소하시겠습니까?");
    	    if (confirmDelete) {
	    		$.ajax({
	    	        url: '/booking/deleteOne.ft',
	    	        type: 'POST',
	    	        data: { bookingNumber: bookingNumber },
	    	        success: function(response) {
	    	        	 alert(response);
	    	             location.reload();
	    	        },
	    	        error: function(xhr, status, error) {
	    	            console.error('Error:', error);
	    	        }
	    	    });
    	    }
    	}
    	// 예약 전체 삭제
    	function deleteBooking(userId) {
    		var confirmDelete = confirm("정말 모든 예약을 취소하시겠습니까?");
    		if (confirmDelete) {
	    		$.ajax({
	    	        url: '/booking/delete.ft',
	    	        type: 'POST',
	    	        data: { userId: userId },
	    	        success: function(response) {
	    	        	 alert(response);
	    	             location.reload();
	    	        },
	    	        error: function(xhr, status, error) {
	    	            console.error('Error:', error);
	    	        }
	    	    });
    		}
    	}
    </script>
	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>