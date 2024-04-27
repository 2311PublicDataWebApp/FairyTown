<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 - 예약조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/dist/css/booking.css">
<style>
/* 모달 스타일 */
.modal {
    display: none; 
    position: fixed; 
    z-index: 1; 
    right: 0; 
    top: 0;
    width: 16.666%; 
    height: 100%; 
    background-color: rgba(0,0,0,0.4); 
}

/* 모달 내용 */
.modal-content-list {
    background-color: #fefefe; 
    position: fixed; 
    right: 0; 
    top: 0;
    margin: 20%; 
    padding: 20px;
    border: 1px solid #888;
}


</style>
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
		                	<h4>놀이기구 이름 : ${booking.ride.rideName }</h4>
							<div class="mt-1 mb-4 spec-1"><span>놀이기구 상세화면<br></span></div>
							<h5>예약 인원 : ${booking.bookingPeople }</h5>
		                    <h5>예약 날짜 : ${booking.bookingDate }</h5>
		                    <div class="mt-1 mb-1 spec-1"><span class="dot"></span><span>예약하신날 : ${booking.bookingTime }<br></span></div>
		                    <div class="d-flex flex-row mt-5">
		                        <div class="ratings mr-2"></div><span>예약 번호 : ${booking.bookingNumber }</span>
		                    </div>
		                </div>
		                <div class="col-md-3 border-left mt-5">
		                    <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="deleteBookingOne(${booking.bookingNumber })">취소</button></div>
		                    <div class="d-flex flex-column mt-4 booking-button">
								<button class="btn btn-primary btn-sm" type="button" onclick="openModal('${booking.bookingNumber}', '${booking.bookingPeople}')">인원 변경</button>
							</div>
		                </div>
		            </div>
		            
		        	</c:forEach>
					</c:otherwise>
				</c:choose>
				
				<div class="row mt-3 mb-5" style="margin-top:300px;">
				<div class="col-md-12">
					<nav aria-label="Page navigation example">					
						<ul class="pagination justify-content-center" style="font-weight: 600; ">
							<c:if test="${pi.startNavi ne '1' }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/booking/list.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a class="page-link rounded-circle mx-2" href="/booking/list.ft?page=${p }" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/booking/list.ft?page=${pi.endNavi + 1 }" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>
				</div>
				
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
  
  	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	
	<div id="myModal" class="modal">
	  <div class="modal-content-list">
	    <p id="bookingInfo"></p>
	    <script>
	      var bookingInfo = document.getElementById("bookingInfo");
	      bookingInfo.innerHTML = '<input type="hidden" id="bookingNumberInput" readonly> 예약 인원: <input type="text" id="bookingPeopleInput">';
	    </script>
	    <button onclick="updateBooking()">변경</button>
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
    	// 모달 창 열기
		function openModal(bookingNumber, bookingPeople) {
		  // 모달 요소 가져오기
		  var modal = document.getElementById("myModal");
		  // 예약 번호와 예약 인원 input 박스에 값 설정
		  document.getElementById("bookingNumberInput").value = bookingNumber;
		  document.getElementById("bookingPeopleInput").value = bookingPeople;
		  // 모달 열기
		  modal.style.display = "block";
		}

    	// 모달 창 닫기
    	function closeModal() {
    	    var modal = document.getElementById("myModal");
    	    modal.style.display = "none";
    	}
    	// 모달 영역 외부를 클릭했을 때 모달을 닫는 이벤트 처리
    	window.onclick = function(event) {
    	    var modal = document.getElementById('myModal');
    	    if (event.target == modal) {
    	        modal.style.display = "none";
    	    }
    	}

    	function updateBooking() {
   		  // 변경된 예약 번호와 예약 인원 가져오기
   		  var bookingNumber = document.getElementById("bookingNumberInput").value;
   		  var bookingPeople = document.getElementById("bookingPeopleInput").value;

   		  // AJAX를 사용하여 변경된 값을 서버에 전달
   		  $.ajax({
   		    url: '/booking/update.ft',
   		    type: 'POST',
   		    data: { bookingNumber: bookingNumber, bookingPeople: bookingPeople },
   		    success: function(response) {
   		      alert(response);
   		      location.reload(); // 페이지 새로고침
   		    },
   		    error: function(xhr, status, error) {
   		      console.error('Error:', error);
   		    }
   		  });
   		}

    </script>

</body>
</html>