<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- import.payment.js -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
var IMP = window.IMP;
IMP.init('imp11650867');

var today = new Date();
var hours = today.getHours();
var minutes = today.getMinutes();  
var seconds = today.getSeconds(); 
var milliseconds = today.getMilliseconds();

// 시, 분, 초, 밀리초를 각각 두 자리 문자열로 만듭니다.
hours = ("0" + hours).slice(-2);
minutes = ("0" + minutes).slice(-2);
seconds = ("0" + seconds).slice(-2);
milliseconds = ("00" + milliseconds).slice(-3);
var makeMerchantUid = hours + minutes + seconds + "-" + milliseconds;

function requestPay() {
	var purchasePrice = ${tingOne.purchasePrice};
    // purchasePrice가 0이 아닌 경우에만 결제 요청을 수행합니다.
    if (purchasePrice !== 0) {
		IMP.request_pay(
	        {
	            pg: "html5_inicis.INIpayTest",
	            pay_method: "card",
	            merchant_uid: makeMerchantUid,
	            name: "${ticketOne.ticketName }",
	            amount: 100,
	            buyer_email: "Iamport@chai.finance",
	            buyer_name: "바이킹 기술지원팀",
	            buyer_tel: "010-1234-5678",
	            buyer_addr: "서울특별시 중구",
	            buyer_postcode: "123-456",
	        },
	        function (rsp) {
	            if (rsp.success) {
	                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 전달하기
	                jQuery.ajax({
	                    url: "/ticketing/paymentRegist.ft", //cross-domain error가 발생하지 않도록 주의해주세요
	                    method: "POST",
	                    data: {
	                    	ticketNumber : ${ticketOne.ticketNo },
	                    	userId : '${user.userId }',
	                    	reservationDateStr : '${tingOne.reservationDate }',
	                    	adult : ${tingOne.adult },
	                    	teenager : ${tingOne.teenager },
	                    	child : ${tingOne.child },
	                    	purchasePrice : ${tingOne.purchasePrice },
	                    	impUid: rsp.imp_uid,
	                    	merchantUid: rsp.merchant_uid
	                    }
	                }).done(function (data) {
	                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	                    var msg = '결제가 완료되었습니다.';
	                    msg += '\n고유ID : ' + rsp.imp_uid;
	                    msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	                    msg += '\결제 금액 : ' + rsp.paid_amount;
	                    msg += '카드 승인번호 : ' + rsp.apply_num;
	                    alert(msg);
	                    window.location.href = '/ticketing/list.ft';
	                 }).fail(function (jqXHR, textStatus, errorThrown) {
	                 alert("결제 정보 전송 중 오류가 발생했습니다: " + errorThrown);
                	});
	            } else {
	                alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
	            }
        });
   	} else {
        alert('구매 금액이 0원입니다. 결제를 진행할 수 없습니다.');
    }
}
</script>
<meta charset="UTF-8">
	<title>티켓결제-확인</title>
	<link rel="stylesheet" href="../resources/dist/css/confirm.css">
</head>
<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<div class="main-form">
		<section class="ticketing-form">
			<form action="/ticketing/confirm.ft" method="post">
				<input type="hidden" name="userId" value="${user.userId }">
				<input type="hidden" name="ticketNo" value="${ticketOne.ticketNo }">
				<div class="ticket-image">
					<img src="../resources/nuploadFiles/${ticketOne.ticketImgRename }" alt="티켓이미지"><br>
				</div><br>
				<div class="ticketName">
				    <label for="ticketName" class="form-label">${ticketOne.ticketName }</label>
				</div><br>
				<div class="ticketDetail">
				    <label for="ticketDetail" class="form-label">[상품 설명]</label>
				    <br><br>${ticketOne.ticketDetail }
				</div>
			</form>
			<div class="goBackBtn">	
				<button onclick="goBack()" class="back-btn">이전 페이지로</button>
			</div>
		</section>
		
		<section class="payment-form dark">
			<div class="container check">
				<div class="block-heading">
					<h2>결제하실 내역</h2>
					<p>변경을 원하시면 예약 취소 후 재예약 하셔야 하며, 예약 취소 후 환불까지는 영업일 기준 최대 7일이 소요될 수 있으니, 예약하시는 내용을 다시 한 번 확인해 주세요.</p>
				</div>
				<div class="products">
					<h3 class="title">결제 확인</h3>
					<h4 class="title">예약일 : ${tingOne.reservationDate }</h4>
					<div class="item">
						<p class="item-name">총 ${tingOne.adult + tingOne.teenager + tingOne.child } 명</p>
					</div>
					<div class="item">
						<span class="price"><fmt:formatNumber value="${ticketOne.ticketAdult * tingOne.adult}" pattern="###,### 원"/></span>
						<p class="item-name">성인 : ${tingOne.adult } 명</p>
						<p class="item-description"><fmt:formatNumber value="${ticketOne.ticketAdult }" pattern="###,###원"/> / 명</p>
					</div>
					<div class="item">
						<span class="price"><fmt:formatNumber value="${tingOne.teenager * ticketOne.ticketTeen}" pattern="###,### 원"/></span>
						<p class="item-name">청소년 : ${tingOne.teenager } 명</p>
						<p class="item-description"><fmt:formatNumber value="${ticketOne.ticketTeen }" pattern="###,###원"/> / 명</p>
					</div>
					<div class="item">
						<span class="price"><fmt:formatNumber value="${tingOne.child * ticketOne.ticketChild}" pattern="###,### 원"/></span>
						<p class="item-name">어린이 : ${tingOne.child } 명</p>
						<p class="item-description"><fmt:formatNumber value="${ticketOne.ticketChild }" pattern="###,###원"/> / 명</p>
					</div>
					<div class="total">합계<span class="price"><fmt:formatNumber value="${tingOne.purchasePrice}" pattern="###,### 원"/></span></div>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*테스트 100원 고정<br>
				<button onclick="requestPay()" class="confrom-btn">결제하기</button><br>
			</div>
		</section>	
	</div>	
	<div>
		<div class="container mt-6 info d-flex justify-content-around">
			<a href="#hiddenContent1" data-toggle="collapse" aria-expanded="false" aria-controls="hiddenContent">
			  안내 / 주의사항
			</a>
			<a href="#hiddenContent2" data-toggle="collapse" aria-expanded="false" aria-controls="hiddenContent">
			  취소 / 환불
			</a>
			<a href="#hiddenContent3" data-toggle="collapse" aria-expanded="false" aria-controls="hiddenContent">
			  상품 세부 사항
			</a>
		</div>
		
		<!-- 숨겨진 요소 -->
		<div class="hiddenContainer">
			<div class="collapse hiddenContent" id="hiddenContent1">
			  <div class="card card-body">
				- 방문예정일 기준 30일 전부터 당일까지 예약 가능합니다.<br>
				- 본인(대인)에 한하여 할인 적용됩니다.<br>
				- 1회 예약 시 최대 2매까지 구매 가능합니다.<br>
				- 예약 알림톡(문자)을 받지 못한 경우, 스마트예약 예약내역 화면에서 QR 코드와 이용안내/유의사항을 확인하실 수 있습니다.
			  </div>
			</div>
			<div class="collapse hiddenContent" id="hiddenContent2">
			  <div class="card card-body">
				- 방문예정일/인원/결제수단 변경은 예약 취소 후 재예약하여 주십시오.(변경 및 부분 취소 불가)<br>
				- 구성 상품은 당일에만 사용 가능하며, 부분 사용 및 부분 환불 불가합니다.<br>
				- 방문예정일까지 미사용 시 익일 자동 취소 됩니다.(신용카드 최종 환불까지 영업일 기준 3~5일 소요)<br>
				※ 온라인(스마트예약) 구매 상품은, 카드사별 정책에 따라 청구할인 혜택에서 제외될수 있습니다.<br>
				※ 스마트예약 상품은 구매 시점에 솜이 적립되지 않고, 해당 상품을 사용 완료한 익일 새벽에 솜사탕 등급별 적립율에 따라 솜이 적립됩니다.<br>
			  </div>
			</div>
			<div class="collapse hiddenContent" id="hiddenContent3">
			  <div class="card card-body">
			    방문 예정일에만 사용 가능하며 예약 완료 후에는 날짜/인원/결제수단 등 예약사항 변경 불가<br>
 				방문 전날까지 홈페이지를 통하여 취소수수료 없이 결제취소 가능 (방문예정일이 지난 경우 익일자동 취소됨)<br>
				단, 계좌이체/체크카드로 구매 시,금융사별 정산시간에 따라 23:30 ~ 01:00 사이에는 예약 및 취소가 불가할 수 있습니다.
			  </div>
			</div>
		</div>

	</div>
	<!-- 공통 / 풋터 -->	
	<jsp:include page="../inc/footer.jsp"></jsp:include>

<script>
function goBack() {
  window.history.back();
}

</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>