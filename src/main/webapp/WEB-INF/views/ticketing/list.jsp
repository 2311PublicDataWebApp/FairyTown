<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓결제 - 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/dist/css/ticketinglist.css">
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
        			<c:when test="${tingList eq null}">
						<div class="col-md-3 mb-3 text-center">
						    <h1>예매 내역</h1>
						</div>
						<div class="row p-2 bg-white border rounded" style="height: 200px; display: flex; align-items: center; justify-content: center; text-align: center;">
						    <div class="col-md-6 mt-1">
						        <h3>주문하신 내역이 없습니다.</h3>
						    </div>
						</div>
					</c:when>
					<c:otherwise>
					<div class="col-md-3 mb-3 text-center">
					    <h1>예매 내역</h1>
					</div>
           			<c:forEach items="${tingList}" var="ting">
		        	
		            <div class="row p-2 bg-white border rounded">
		                <div class="col-md-3 mt-1"><img src="../resources/nuploadFiles/${ting.ticket.ticketImgRename }" alt="티켓이미지"></div>
		                <div class="col-md-6 mt-1">
		                	<h4>티켓이름 : ${ting.ticket.ticketName }</h4>
							<div class="mt-1 mb-3 spec-1"><span>티켓 코드 : ${ting.ticketingCode }<br></span></div>
							<h5>예약일 : ${ting.reservationDate }</h5>
		                    <h5>결제 금액 : ${ting.purchasePrice }</h5>
		                    <div class="mt-1 mb-1 spec-1"><span class="dot"></span><span>어른 : ${ting.adult }</span></div>
		                    <div class="mt-1 mb-1 spec-1"><span class="dot"></span><span>청소년 : ${ting.teenager }</span></div>
		                    <div class="mt-1 mb-1 spec-1"><span class="dot"></span><span>어린이 : ${ting.child }</span></div>
		                    <div class="d-flex flex-row mt-3">
		                        <div class="ratings mr-2"></div><span>결제일 : ${ting.purchaseDate }</span>
		                    </div>
		                </div>
		                <div class="col-md-3 border-left mt-4" style="padding-left: 10%;">
		                    <h6 class="text-success">결제 상태 : ${ting.purchaseSuccess == 'C' ? '취소됨' : '결제됨'} </h6>
							<c:if test="${ting.purchaseSuccess == 'Y'}">
			                    <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="cancleTicketingCode(${ting.ticketingCode })">취소하기</button></div>
			                    <div class="d-flex flex-column mt-4 booking-button"><button class="btn btn-primary btn-sm" type="button" onclick="sendTicketingCode(${ting.ticketingCode})">예약하기</button></div>
							</c:if>
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
									<a class="page-link rounded-circle" href="/ticketing/list.ft?page=${pi.startNavi - 1 }" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pi.startNavi }" end="${pi.endNavi }" var="p">
								<li class="page-item">
									<a class="page-link rounded-circle mx-2" href="/ticketing/list.ft?page=${p }" style="border: none; color: #313131;">
									${p }
									</a>
								</li>
							</c:forEach>
							<c:if test="${pi.endNavi ne pi.naviTotalCount }">
								<li class="page-item">
									<a class="page-link rounded-circle" href="/ticketing/list.ft?page=${pi.endNavi + 1 }" aria-label="Next">
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
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="goBack()">뒤로가기</button>
	    </div>
	    <div class="booking-button flex-grow-1">
	        <button class="btn btn-primary btn-sm w-100" type="button" onclick="window.location.href = '/ticket/list.ft'">다른 티켓 구매</button>
	    </div>
	</div>
	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	
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
	    if (confirmDelete) {
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
	}
	</script>
</body>
</html>