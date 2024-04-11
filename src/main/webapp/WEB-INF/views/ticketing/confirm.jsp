<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

// ---------------------------------- 테스트모듈
// var IMP = window.IMP;
// IMP.init('imp11650867');

// function requestPay() {
//     var simulatePayment = confirm("결제를 시뮬레이션 하시겠습니까?");
//     if (simulatePayment) {
//         var simulatedResponse = {
//             success: true,
//             imp_uid: "simulation_imp_uid",
//             merchant_uid: "simulation_merchant_uid",
//             paid_amount: ${tingOne.purchasePrice},
//             apply_num: "simulation_apply_num"
//         };
//         processPaymentResponse(simulatedResponse);
//     } else {
//         IMP.request_pay({
//             pg: "html5_inicis",
//             pay_method: "card",
//             merchant_uid: "57008833-33004",
//             name: "${ticketOne.ticketName }",
//             amount: ${tingOne.purchasePrice},
//             buyer_email: "Iamport@chai.finance",
//             buyer_name: "바이킹 기술지원팀",
//             buyer_tel: "010-1234-5678",
//             buyer_addr: "서울특별시 중구",
//             buyer_postcode: "123-456",
//         }, processPaymentResponse);
//     }
// }

// function processPaymentResponse(rsp) {
//     if (rsp.success) {
//         jQuery.ajax({
//             url: "/ticketing/paymentRegist.ft",
//             type: 'POST',
//             data: {
//             	userId : '${user.userId }',
//             	reservationDateStr : '${tingOne.reservationDate }',
//             	adult : ${tingOne.adult },
//             	teenager : ${tingOne.teenager },
//             	child : ${tingOne.child },
//             	purchasePrice : ${tingOne.purchasePrice },
//             	impUid: rsp.imp_uid,
//             	merchantUid: rsp.merchant_uid
//             }
//         }).done(function (data) {
//             var msg = '결제가 완료되었습니다.';
//             msg += '\n고유ID : ' + rsp.imp_uid;
//             msg += '\n상점 거래ID : ' + rsp.merchant_uid;
//             msg += '\결제 금액 : ' + rsp.paid_amount;
//             msg += '카드 승인번호 : ' + rsp.apply_num;
//             alert(msg);
//             window.location.href = '/ticketing/list.ft';
//         }).fail(function (jqXHR, textStatus, errorThrown) {
//             // 오류가 발생한 경우 사용자에게 알림
//             alert("결제 정보 전송 중 오류가 발생했습니다: " + errorThrown);
//         });
//     } else {
//         alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
//     }
// }
// ---------------------------------- 테스트모듈
</script>
<meta charset="UTF-8">
	<title>티켓결제-확인</title>
</head>
<body>
	<form action="/ticketing/confirm.ft" method="post">
		<input type="hidden" name="userId" value="${user.userId }">
		<input type="hidden" name="ticketNo" value="${ticketOne.ticketNo }">
		<div>
		    <label for="ticketName" class="form-label">티켓이름 : </label>
		    <span class="form-control" id="ticketName">${ticketOne.ticketName }</span>
		</div>
		<div>
		    <label for="ticketDetail" class="form-label">상품 설명 : </label>
		    <span class="form-control" id="ticketDetail">${ticketOne.ticketDetail }</span>
		</div>
		<div>
		    <label for="reservationDate" class="form-label">예약일 : </label>
		    <span class="form-control" id="reservationDate">${tingOne.reservationDate }</span>
		</div>
		<div>
		    <label for="adult" class="form-label">성인 : </label>
		    <span class="form-control" id="adult">${tingOne.adult }</span>
		</div>
		<div>
		    <label for="teenager" class="form-label">청소년 : </label>
		    <span class="form-control" id="teenager">${tingOne.teenager }</span>
		</div>
		<div>
		    <label for="child" class="form-label">어린이 : </label>
		    <span class="form-control" id="child">${tingOne.child }</span>
		</div>
		<div>
		    <label for="total" class="form-label">총 인원수 : </label>
		    <span class="form-control" id="total">${tingOne.adult + tingOne.teenager + tingOne.child }</span>
		</div>
		<div>
		    <label for=purchasePrice class="form-label">결제 예정 금액 : </label>
		    <span class="form-control" id="purchasePrice">${tingOne.purchasePrice}</span>
		</div>
		<br>
	</form>
<button onclick="goBack()">이전 페이지로 이동</button><br>
*테스트 100원 고정
<button onclick="requestPay()">결제하기</button><br>
안내 / 주의사항<br>
취소 / 환불<br>
상품 세부 사항<br>
<script>
function goBack() {
  window.history.back();
}
</script>
</body>
</html>