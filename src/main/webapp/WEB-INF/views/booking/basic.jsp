<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 기본예약</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/dist/css/booking.css">
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
<c:if test="${user ne null && tingOne eq null}">
    <script>
        if (confirm('티켓 구입 후 이용 가능한 서비스입니다. 이동하시겠습니까?')) {
            window.location.href = '/ticketing/list.ft';
        } else {
            history.back();
        }
    </script>
</c:if>

	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<form action="/booking/basic.ft" method="post">
	<div class="container mt-4 mb-4">
	    <div class="d-flex justify-content-center row booking-main">
	        <div class="col-md-10">	
				<div class="col-md-3 mb-3 text-center">
				    <h1>기구 예약하기</h1>
				</div>
				<input type="hidden" name="userId" value="${user.userId }">
				<c:forEach items="${rideList}" var="ride">
				
					<div class="row p-2 bg-white border rounded">
			        	<div class="col-md-3 mt-1"><img class="img-fluid img-responsive rounded product-image" src="https://i.imgur.com/QpjAiHq.jpg"></div>
						<div class="col-md-6 mt-1">
							<h4>기구 이름: ${ride.rideName}</h4>
							<div class="mt-1 mb-4 spec-1"><span>놀이기구 상세화면<br></span></div>
							<h5>예약 날짜 : ${tingOne.reservationDate }</h5>
						</div>
			            <div class="col-md-3 border-left mt-4">
			                <h6 class="text-success">탑승제한 : ${ride.rideLimit}</h6>
			                <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="single('${ride.rideId}')">개별 예약하기</button></div>
			                <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="deleteThis('${ride.rideId}')">삭제</button></div>
			            </div>
					</div>
				
				</c:forEach>
	
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
	
	<div class="d-flex justify-content-center mt-5" style="margin-right: 120px;">
	    <div class="booking-button mr-2 flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="deleteAll()">초기화</button>
	    </div>
	    <div class="booking-button flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="window.location.href='/booking/list.ft'">예약목록</button>
	    </div>
		<div class="booking-button flex-grow-1">
		    <button class="btn btn-primary btn-sm w-100" type="submit">전체예약</button>
		</div>
	</div>
	</form>

	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<script>
	// 입력란의 값을 제한하는 함수
	function limitInputValue(input) {
	    // 입력된 값이 특정 범위를 벗어나는지 확인
	    if (input.value < 1 || input.value > ${tingOne.adult + tingOne.teenager + tingOne.child}) {
	        alert("티켓 예약 인원을 초과해 예약할 수 없습니다!");
	        input.value = input.defaultValue;
	    }
	}
	function onInputChanged(input) {
	    limitInputValue(input);
	}
	// 예약하기 개별삭제
	function deleteThis(rideId) {
	    var confirmDelete = confirm("이 예약을 삭제하시겠습니까?");
	    if (confirmDelete) {
	        $.ajax({
	            url: '/booking/basic/delete.ft',
	            type: 'POST',
	            data: { 
	                rideId: rideId,
	            },
	            success: function(response) {
	                alert("예약이 성공적으로 삭제되었습니다.");
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	                alert("예약 삭제 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	            }
	        });
	    }
	}
	// 예약하기 개별등록
	function single(rideId) {
    var url = "/booking/single.ft?rideId=" + rideId;
    window.location.href = url;
	}
	
	// 예약하기 전체삭제
	function deleteAll() {
	    var confirmDelete = confirm("예약하기를 전체 삭제하시겠습니까?");
	    if (confirmDelete) {
	        $.ajax({
	            url: '/booking/basic/deleteAll.ft',
	            type: 'POST',
	            success: function(response) {
	                alert("예약이 성공적으로 초기화 되었습니다.");
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	                alert("예약 삭제 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	            }
	        });
	    }
	}
	// 기본예약 예약
// 	function bookingAll() {
// 		var confirmDelete = confirm("모든 놀이기구를 예약하시겠습니까?");
// 	    if (confirmDelete) {
// 	        $.ajax({
// 	            url: '/booking/basic.ft',
// 	            type: 'POST',
// 	            success: function(response) {
// 	                alert("모든 예약이 완료되었습니다!");
// 	                location.reload();
// 	            },
// 	            error: function(xhr, status, error) {
// 	                console.error('Error:', error);
// 	                alert("예약 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
// 	                location.reload();
// 	            }
// 	        });
// 	    }
// 	}
	</script>
</body>
</html>